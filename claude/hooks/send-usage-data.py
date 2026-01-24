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

ENVIRONMENTS = {
    "dev": {
        "host": os.environ.get("TOKEN_USAGE_API_HOST_DEV", ""),
        "token": os.environ.get("TOKEN_USAGE_API_TOKEN_DEV", ""),
    },
    "prod": {
        "host": os.environ.get("TOKEN_USAGE_API_HOST_PROD", ""),
        "token": os.environ.get("TOKEN_USAGE_API_TOKEN_PROD", ""),
    },
}

def get_latest_message_id(session_id, host, token):
    url = f"{host.rstrip('/')}/sessions/{session_id}/token_usages"
    headers = {
        "Authorization": f"Bearer {token}"
    }
    req = urllib.request.Request(url, headers=headers, method="GET")
    with urllib.request.urlopen(req, timeout=30) as response:
        data = json.loads(response.read().decode("utf-8"))
        if data and len(data) > 0:
            return data[0].get("message_id")
        return None

def read_unique_assistant_entries_after(transcript_path, after_message_id):
    entries = {}
    found_marker = (after_message_id is None)
    with open(transcript_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            entry = json.loads(line)
            msg_id = entry.get("message", {}).get("id")
            if not found_marker:
                if msg_id == after_message_id:
                    found_marker = True
                continue
            if entry.get("type") == "assistant" and msg_id and msg_id not in entries:
                if entry.get("message", {}).get("usage"):
                    entries[msg_id] = entry
    return list(entries.values())

def extract_usage_data(entry, session_id):
    message = entry.get("message", {})
    message_id = message.get("id")

    if not message_id:
        return None

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

def post_to_api(data, host, token):
    url = f"{host.rstrip('/')}/token_usage"
    payload = json.dumps({"token_usage": data}).encode("utf-8")
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}"
    }

    req = urllib.request.Request(url, data=payload, headers=headers, method="POST")

    with urllib.request.urlopen(req, timeout=30) as response:
        return response.status, response.read().decode("utf-8")

def send_entries_to_env(entries, session_id, env_name, host, token):
    print(f"Sending {host}", file=sys.stderr)

    latest_message_id = None
    try:
        latest_message_id = get_latest_message_id(session_id, host, token)
        print(f"Latest message_id on server: {latest_message_id}", file=sys.stderr)
    except Exception as e:
        print(f"Failed to get latest message_id: {e}", file=sys.stderr)
        return

    entries_to_send = [e for e in entries if extract_usage_data(e, session_id) and
                       (latest_message_id is None or should_send_entry(e, latest_message_id, entries))]

    if not entries_to_send:
        print(f"No new entries to send", file=sys.stderr)
        return

    for entry in entries_to_send:
        usage_data = extract_usage_data(entry, session_id)
        try:
            post_to_api(usage_data, host, token)
        except urllib.error.HTTPError as e:
            if e.code == 422:
                print(f"Duplicate (already exists): {usage_data['message_id'][:20]}...", file=sys.stderr)
            else:
                print(f"Failed: {e}", file=sys.stderr)
        except Exception as e:
            print(f"Failed: {e}", file=sys.stderr)

def should_send_entry(entry, latest_message_id, all_entries):
    entry_message_id = entry.get("message", {}).get("id")
    if latest_message_id is None:
        return True
    for e in all_entries:
        e_msg_id = e.get("message", {}).get("id")
        if e_msg_id == latest_message_id:
            return False
        if e_msg_id == entry_message_id:
            return True
    return True

def main():
    print("Sending usage data...", file=sys.stderr)

    input_data = json.loads(sys.stdin.read())

    transcript_path = input_data.get("transcript_path")
    session_id = input_data.get("session_id")

    if not transcript_path or not os.path.exists(transcript_path):
        print("no transcript path", file=sys.stderr)
        sys.exit(1)

    if not session_id:
        print("no session id", file=sys.stderr)
        sys.exit(1)

    all_entries = read_unique_assistant_entries_after(transcript_path, None)

    if not all_entries:
        print("No assistant entries with usage data", file=sys.stderr)
        sys.exit(1)

    total_input = sum(e.get("message", {}).get("usage", {}).get("input_tokens", 0) for e in all_entries)
    total_output = sum(e.get("message", {}).get("usage", {}).get("output_tokens", 0) for e in all_entries)
    print(f"Found {len(all_entries)} unique entries, total: input={total_input}, output={total_output}", file=sys.stderr)

    for env_name, env_config in ENVIRONMENTS.items():
        host = env_config["host"]
        token = env_config["token"]
        if not host or not token:
            print(f"Skipping {env_name}: missing host or token", file=sys.stderr)
            continue
        send_entries_to_env(all_entries, session_id, env_name, host, token)

    sys.exit(1)

if __name__ == "__main__":
    main()
