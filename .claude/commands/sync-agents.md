# Sync Agents

Sync the team's agents, skills, and hooks from this repo to `~/.claude/` so they are available globally across all project repos.

## Steps

1. Confirm the user wants to proceed — this will overwrite any existing files in `~/.claude/agents/`, `~/.claude/skills/`, and `~/.claude/hooks/` that share the same name.

2. Run the sync:

```bash
REPO_ROOT=$(git rev-parse --show-toplevel)

# Agents
mkdir -p ~/.claude/agents
cp "$REPO_ROOT"/.claude/agents/*.md ~/.claude/agents/
echo "✓ Agents synced"

# Skills
mkdir -p ~/.claude/skills
cp "$REPO_ROOT"/.claude/skills/*.md ~/.claude/skills/ 2>/dev/null || echo "  (no skills to sync)"
echo "✓ Skills synced"

# Hooks
mkdir -p ~/.claude/hooks
cp "$REPO_ROOT"/.claude/hooks/*.sh ~/.claude/hooks/ 2>/dev/null || echo "  (no hooks to sync)"
chmod +x ~/.claude/hooks/*.sh 2>/dev/null || true
echo "✓ Hooks synced"
```

3. Report what was copied — list each file synced by category.

4. Remind the user:
   - Agents are now available globally in all project repos
   - To register the session-start hook globally, add it to `~/.claude/settings.json` under `SessionStart`
   - Re-run `/sync-agents` any time agents are updated in this repo

## Usage

```
/sync-agents
```

Run from anywhere inside this repo.
