#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
[[ "$FILE" =~ \.(ts|tsx|js|jsx)$ ]] || exit 0
deno lint "$FILE"
