#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
[[ "$FILE" =~ \.(ts|tsx|js|jsx|json|md)$ ]] || exit 0
deno fmt "$FILE"
