#!/bin/bash
# sync-agents.sh
# Copies agents, skills, commands, and hooks from this repo to ~/.claude/
# Run manually after pulling updates to this repo.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"

echo "Syncing from: $REPO_ROOT"
echo ""

# Agents
mkdir -p ~/.claude/agents
cp "$REPO_ROOT"/.claude/agents/*.md ~/.claude/agents/
echo "✓ Agents synced"

# Skills
mkdir -p ~/.claude/skills
if ls "$REPO_ROOT"/.claude/skills/*.md 2>/dev/null; then
  cp "$REPO_ROOT"/.claude/skills/*.md ~/.claude/skills/
  echo "✓ Skills synced"
else
  echo "  (no skills to sync)"
fi

# Commands
mkdir -p ~/.claude/commands
if ls "$REPO_ROOT"/.claude/commands/*.md 2>/dev/null; then
  cp "$REPO_ROOT"/.claude/commands/*.md ~/.claude/commands/
  echo "✓ Commands synced"
else
  echo "  (no commands to sync)"
fi

# Hooks
mkdir -p ~/.claude/hooks
if ls "$REPO_ROOT"/.claude/hooks/*.sh 2>/dev/null; then
  cp "$REPO_ROOT"/.claude/hooks/*.sh ~/.claude/hooks/
  chmod +x ~/.claude/hooks/*.sh
  echo "✓ Hooks synced"
else
  echo "  (no hooks to sync)"
fi

echo ""
echo "Done. Agents, skills, commands, and hooks are up to date in ~/.claude/"
echo "Re-run this script after pulling updates to this repo."
