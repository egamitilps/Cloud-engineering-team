#!/bin/bash
# Session start hook — generates a repo map for Archie's orientation.
# Injects the map as additionalContext so it is available from the first message.

set -euo pipefail

TMPFILE=$(mktemp /tmp/repomap-XXXXXX.md)
trap 'rm -f "$TMPFILE"' EXIT

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
cd "$PROJECT_DIR"

# Attempt repomix via npx; fall back to a find-based directory tree
if npx --yes repomix \
     --output "$TMPFILE" \
     --style markdown \
     --no-file-summary \
     --ignore "**/.git/**,**/node_modules/**,**/.terraform/**,**/repomix-output.txt" \
     --quiet \
     2>/dev/null; then
  REPO_MAP=$(head -c 40000 "$TMPFILE")
else
  REPO_MAP=$(find . \
    -not -path '*/.git/*' \
    -not -path '*/node_modules/*' \
    -not -path '*/.terraform/*' \
    | sort \
    | head -300)
fi

jq -n --arg map "$REPO_MAP" '{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": ("## Repo Map — Session Orientation\n\nUse this to orient yourself before responding to the first user message.\n\n" + $map)
  }
}'
