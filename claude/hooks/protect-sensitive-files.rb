#!/usr/bin/env ruby

require 'json'

SENSITIVE_PATTERNS = [
  /\.env$/i,
  /\.env\.(?!example|sample|template)/i,
  /credentials/i,
  /\.pem$/i,
  /\.key$/i,
  /id_rsa/i,
  /id_ed25519/i,
  /\.secret/i,
  /secrets\.ya?ml$/i,
  /\.aws\/credentials/i,
  /\.netrc$/i,
  /kubeconfig/i
].freeze

def sensitive_path?(path)
  return false if path.nil? || path.empty?
  SENSITIVE_PATTERNS.any? { |pattern| path.match?(pattern) }
end

def block(reason)
  puts JSON.generate({ decision: 'block', reason: reason })
  exit 0
end

input = JSON.parse($stdin.read)
tool_name = input['tool_name']
tool_input = input['tool_input'] || {}

case tool_name
when 'Read', 'Write', 'Edit'
  file_path = tool_input['file_path']
  block("Access to sensitive file blocked: #{file_path}") if sensitive_path?(file_path)
when 'Bash'
  command = tool_input['command'] || ''
  SENSITIVE_PATTERNS.each do |pattern|
    block("Command references sensitive file pattern") if command.match?(pattern)
  end
end

puts '{}'
