#!/bin/bash
FILES=$(find . \( -name "*.ts" -o -name "*.tsx" \) \
  -not -path "*/node_modules/*" \
  -not -path "*/.deno/*" \
  2>/dev/null | head -100)
[ -z "$FILES" ] && exit 0
echo "$FILES" | xargs deno check 2>&1
