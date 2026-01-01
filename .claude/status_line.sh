#!/bin/bash

input=$(cat)

model_name=$(echo "$input" | jq -r '.model.display_name')
dir=$(basename "$(pwd)")
context_size=$(echo "$input" | jq -r '.context_window.context_window_size')
current_tokens=$(echo "$input" | jq -r '.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
usage_pct=$(( current_tokens * 100 / context_size ))%
current_time=$(date +"%I:%M %p" | sed 's/^0//')

if git rev-parse --git-dir >/dev/null 2>&1; then
    branch="$(git branch --show-current 2>/dev/null)"
    if git diff --quiet --exit-code 2>/dev/null && git diff --cached --quiet --exit-code 2>/dev/null; then
        dirty=""
    else
        dirty="(*)"
    fi
    git_info=".${branch} ${dirty}"
else
    git_info=""
fi

printf '\033[36m%s @ %s%s | %s \033[0m  ' "$model_name" "$dir" "$git_info" "$current_time"
