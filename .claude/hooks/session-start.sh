#!/bin/bash
# Session start hook — generates a repo map + Terraform semantic analysis for Archie's orientation.
# Injects the combined output as additionalContext so it is available from the first message.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
cd "$PROJECT_DIR"

TMPFILE=$(mktemp /tmp/repomap-XXXXXX.md)
SEMFILE=$(mktemp /tmp/semmap-XXXXXX.md)
trap 'rm -f "$TMPFILE" "$SEMFILE"' EXIT

# ── 1. Content map ─────────────────────────────────────────────────────────────
# Attempt repomix via npx; fall back to a find-based directory tree.
if npx --yes repomix \
     --output "$TMPFILE" \
     --style markdown \
     --no-file-summary \
     --ignore "**/.git/**,**/node_modules/**,**/.terraform/**,**/repomix-output.txt" \
     --quiet \
     2>/dev/null; then
  REPO_MAP=$(head -c 30000 "$TMPFILE")
else
  REPO_MAP=$(find . \
    -not -path '*/.git/*' \
    -not -path '*/node_modules/*' \
    -not -path '*/.terraform/*' \
    | sort \
    | head -300)
fi

# ── 2. Terraform semantic analysis ─────────────────────────────────────────────
# Only runs when .tf files are present outside .terraform directories.
TF_FILES=$(find . -name "*.tf" -not -path '*/.terraform/*' 2>/dev/null | sort)

if [ -n "$TF_FILES" ]; then
  {
    echo "## Terraform Semantic Map"
    echo ""

    # -- Module dependency graph --
    # Extracts: <file> : <module-name> : <source> for every module block
    echo "### Module Dependency Graph"
    awk '
      /^\s*module\s+"[^"]*"/ {
        match($0, /module "([^"]*)"/, m); mod = m[1]; in_block = 1
      }
      in_block && /source\s*=\s*"/ {
        match($0, /source\s*=\s*"([^"]*)"/, s)
        printf "%s → module.%s  (%s)\n", FILENAME, mod, s[1]
        in_block = 0
      }
      /^\}/ { in_block = 0 }
    ' $TF_FILES 2>/dev/null \
      | sed 's|^\./||' \
      | sort \
      | sed 's/^/  /'
    echo ""

    # -- Variable & output interfaces per module directory --
    echo "### Module Interfaces"
    find . -name "variables.tf" -not -path '*/.terraform/*' | sort | while read -r vf; do
      dir=$(dirname "$vf" | sed 's|^\./||')
      inputs=$(grep -E '^\s*variable\s+"' "$vf" 2>/dev/null \
        | sed 's/.*variable "\([^"]*\)".*/    - \1/' || true)
      outputs_file="$(dirname "$vf")/outputs.tf"
      outputs=""
      if [ -f "$outputs_file" ]; then
        outputs=$(grep -E '^\s*output\s+"' "$outputs_file" 2>/dev/null \
          | sed 's/.*output "\([^"]*\)".*/    - \1/' || true)
      fi
      if [ -n "$inputs" ] || [ -n "$outputs" ]; then
        echo "  **${dir}**"
        if [ -n "$inputs" ]; then
          echo "  Inputs:"
          echo "$inputs"
        fi
        if [ -n "$outputs" ]; then
          echo "  Outputs:"
          echo "$outputs"
        fi
        echo ""
      fi
    done

    # -- Azure resource inventory --
    echo "### Azure Resource Inventory"
    grep -rh --include="*.tf" -E '^\s*resource\s+"azurerm_' . --exclude-dir='.terraform' 2>/dev/null \
      | sed 's/.*resource "\(azurerm_[^"]*\)".*/\1/' \
      | sort | uniq -c | sort -rn \
      | awk '{printf "  %s × %s\n", $1, $2}' \
      | head -40
    echo ""

  } > "$SEMFILE" 2>/dev/null

  SEMANTIC_SECTION=$(cat "$SEMFILE")
else
  SEMANTIC_SECTION=""
fi

# ── 3. Combine and emit ─────────────────────────────────────────────────────────
if [ -n "$SEMANTIC_SECTION" ]; then
  FULL_CONTEXT="${REPO_MAP}"$'\n\n'"${SEMANTIC_SECTION}"
else
  FULL_CONTEXT="${REPO_MAP}"
fi

jq -n --arg map "$FULL_CONTEXT" '{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": ("## Repo Map — Session Orientation\n\nUse this to orient yourself before responding to the first user message.\n\n" + $map)
  }
}'
