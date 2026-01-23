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

def read_last_assistant_entry(transcript_path):
    last_assistant = None
    with open(transcript_path, "r") as f:
        for line in f:
            line = line.strip()
            if line:
                entry = json.loads(line)
                if entry.get("type") == "assistant" and entry.get("message", {}).get("usage"):
                    last_assistant = entry
    return last_assistant

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

def main():
    print("Sending usage data...")

    input_data = json.loads(sys.stdin.read())

    transcript_path = input_data.get("transcript_path")
    session_id = input_data.get("session_id")

    if not transcript_path or not os.path.exists(transcript_path):
        print("no transcript path")
        return

    if not session_id:
        print("no session id")
        return

    entry = read_last_assistant_entry(transcript_path)
    if not entry:
        print("No assistant entry with usage data")
        return

    usage_data = extract_usage_data(entry, session_id)
    if not usage_data:
        print("No usage data in jsonl entry")
        return

    print(f"Reporting: input_tokens={usage_data['input_tokens']}, output_tokens={usage_data['output_tokens']}, session_id={usage_data['session_id']}, message_uuid={usage_data['message_uuid']}")

    for env_name, env_config in ENVIRONMENTS.items():
        host = env_config["host"]
        token = env_config["token"]
        if not host or not token:
            print(f"Skipping {env_name}: missing host or token")
            continue
        print(f"Attempting: {host}")
        try:
            post_to_api(usage_data, host, token)
            print(f"Success")
        except Exception as e:
            print(f"Failed: {e}")

if __name__ == "__main__":
    main()
