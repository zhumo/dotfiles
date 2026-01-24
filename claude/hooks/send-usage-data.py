#!/usr/bin/env python3

import json
import os
import sys
import urllib.request
import urllib.error

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ENV_FILE = os.path.join(SCRIPT_DIR, ".env")

def load_env():
    if os.path.exists(ENV_FILE):
        with open(ENV_FILE, "r") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    key, value = line.split("=", 1)
                    value = value.strip('"').strip("'")
                    os.environ.setdefault(key, value)

load_env()

def get_last_message_id(session_id, host, api_token):
    url = f"{host.rstrip('/')}/sessions/{session_id}/token_usages"
    headers = {
        "Authorization": f"Bearer {api_token}"
    }
    req = urllib.request.Request(url, headers=headers, method="GET")
    with urllib.request.urlopen(req, timeout=30) as response:
        data = json.loads(response.read().decode("utf-8"))
        if data and len(data) > 0:
            return data[0].get("message_id")
        return None

def get_usage_data(transcript_path, after_message_id, session_id):
    entries = {}
    found = (after_message_id is None)
    with open(transcript_path, "r") as f:
        for line in f:
            line = line.strip()
            entry = json.loads(line)
            msg_id = entry.get("message", {}).get("id")
            if found and entry.get("type") == "assistant":
                entries[msg_id] = extract_usage_data(entry, session_id)
            if msg_id == after_message_id:
                found = True

    # Doing this de-duplicates the entries. Clever!
    return list(entries.values())

def extract_usage_data(entry, session_id):
    message = entry.get("message", {})
    message_id = message.get("id")

    usage = message.get("usage", {})
    error = message.get("error", {})

    return {
        "session_id": session_id,
        "message_id": message_id,
        "input_tokens": usage.get("input_tokens", 0),
        "output_tokens": usage.get("output_tokens", 0),
        "error_type": error.get("type") if error else None,
        "error_message": error.get("message") if error else None
    }

def post_usage_datum(datum, host, token):
    url = f"{host.rstrip('/')}/token_usage"
    payload = json.dumps({"token_usage": datum}).encode("utf-8")
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}"
    }

    req = urllib.request.Request(url, data=payload, headers=headers, method="POST")

    with urllib.request.urlopen(req, timeout=30) as response:
        return response.status, response.read().decode("utf-8")

def send_usage_data(usage_data, host, token):
    for usage_datum in usage_data:
        try:
            post_usage_datum(usage_datum, host, token)
        except urllib.error.HTTPError as e:
            print(f"Failed: {e.url} {e.code} - {e.reason}", file=sys.stderr)

def extract_and_send_usage_data_for_env(transcript_path, session_id, host, api_token):
    try:
        last_message_id = get_last_message_id(session_id, host, api_token)
    except urllib.error.HTTPError as e:
        print(f"Failed: {e.url} {e.code} - {e.reason}", file=sys.stderr)
        return

    usage_data = get_usage_data(transcript_path, last_message_id, session_id)

    total_input = sum(e.get("input_tokens", 0) for e in usage_data)
    total_output = sum(e.get("output_tokens", 0) for e in usage_data)
    print(f"Found {len(usage_data)} unique usage data, total: input={total_input}, output={total_output}", file=sys.stderr)
    send_usage_data(usage_data, host, api_token)

def main():
    print("Sending usage data...", file=sys.stderr)

    input_data = json.loads(sys.stdin.read())

    transcript_path = input_data.get("transcript_path")
    session_id = input_data.get("session_id")

    dev_host = os.environ.get("TOKEN_USAGE_API_HOST_DEV", "")
    dev_api_token = os.environ.get("TOKEN_USAGE_API_TOKEN_DEV", "")
    if dev_host and dev_api_token:
        print(f"Sending to Dev: {dev_host}", file=sys.stderr)
        extract_and_send_usage_data_for_env(transcript_path, session_id, dev_host, dev_api_token)

    prod_host = os.environ.get("TOKEN_USAGE_API_HOST_PROD", "")
    prod_api_token = os.environ.get("TOKEN_USAGE_API_TOKEN_PROD", "")
    print(f"Sending to Prod: {prod_host}", file=sys.stderr)
    extract_and_send_usage_data_for_env(transcript_path, session_id, prod_host, prod_api_token)

    sys.exit(1)

if __name__ == "__main__":
    main()
