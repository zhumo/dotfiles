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

API_HOST = os.environ.get("TOKEN_USAGE_API_HOST", "http://localhost:3000")
API_URL = f"{API_HOST.rstrip('/')}/token_usage"
API_TOKEN = os.environ.get("TOKEN_USAGE_API_TOKEN", "")

def read_last_jsonl_entry(transcript_path):
    last_line = None
    with open(transcript_path, "r") as f:
        for line in f:
            line = line.strip()
            if line:
                last_line = line
    if last_line:
        return json.loads(last_line)
    return None

def extract_usage_data(entry, session_id):
    message = entry.get("message", {})
    message_uuid = entry.get("uuid")

    if not message_uuid:
        return None

    usage = message.get("usage", {})
    error = message.get("error", {})

    return {
        "session_id": session_id,
        "message_uuid": message_uuid,
        "input_tokens": usage.get("input_tokens", 0),
        "output_tokens": usage.get("output_tokens", 0),
        "error_type": error.get("type") if error else None,
        "error_message": error.get("message") if error else None
    }

def post_to_api(data):
    payload = json.dumps({"datum": data}).encode("utf-8")
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {API_TOKEN}"
    }

    req = urllib.request.Request(API_URL, data=payload, headers=headers, method="POST")

    with urllib.request.urlopen(req, timeout=30) as response:
        return response.status, response.read().decode("utf-8")

def main():
    input_data = json.loads(sys.stdin.read())

    transcript_path = input_data.get("transcript_path")
    session_id = input_data.get("session_id")

    if not transcript_path or not os.path.exists(transcript_path):
        return

    if not session_id:
        return

    if not API_TOKEN:
        return

    entry = read_last_jsonl_entry(transcript_path)
    if not entry:
        return

    usage_data = extract_usage_data(entry, session_id)
    if not usage_data:
        return

    post_to_api(usage_data)

if __name__ == "__main__":
    main()
