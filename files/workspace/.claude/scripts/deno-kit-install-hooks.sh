#!/bin/bash
# Merges deno kit hooks into .claude/settings.json.
# Safe to run multiple times (idempotent) and coexists with other kits'
# hooks because it appends rather than replaces.
#
# NOTE: This script is NOT called from spec.yaml during install — workspace
# files are copied AFTER install commands, so the script would not exist yet.
# The install command in spec.yaml inlines the same merge logic directly.
# Use this script to manually re-apply or update hooks after installation.
set -euo pipefail

SETTINGS_FILE=/home/agent/.claude/settings.json

[ -f "$SETTINGS_FILE" ] || echo '{}' > "$SETTINGS_FILE"

# Skip if already installed
if jq -e '[.hooks.PostToolUse[]?.hooks[]?.command] | any(test("deno-fmt-hook"))' \
    "$SETTINGS_FILE" 2>/dev/null | grep -q true; then
  echo "Deno kit hooks already present, skipping."
  exit 0
fi

DENO_HOOKS=$(cat <<'EOF'
{
  "PostToolUse": [
    {
      "matcher": "Write|Edit",
      "hooks": [
        {"type": "command", "command": "bash .claude/hooks/deno-fmt-hook.sh"},
        {"type": "command", "command": "bash .claude/hooks/deno-lint-hook.sh"}
      ]
    }
  ],
  "Stop": [
    {
      "hooks": [
        {"type": "command", "command": "bash .claude/hooks/deno-check-hook.sh"}
      ]
    }
  ]
}
EOF
)

jq --argjson h "$DENO_HOOKS" '
  .hooks.PostToolUse = ((.hooks.PostToolUse // []) + $h.PostToolUse) |
  .hooks.Stop       = ((.hooks.Stop       // []) + $h.Stop)
' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" \
  && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"

echo "Deno kit hooks installed in $SETTINGS_FILE"
