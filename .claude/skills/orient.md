# Orient

Generate a repo map of the current project and use it to orient yourself and brief the team.

## Steps

1. Run the repo map hook manually to get a fresh view of the project structure:
   ```bash
   CLAUDE_PROJECT_DIR=$(pwd) .claude/hooks/session-start.sh
   ```
   If the hook is not present in this repo, fall back to:
   ```bash
   npx --yes repomix --style markdown --no-file-summary 2>/dev/null \
     || find . -not -path '*/.git/*' -not -path '*/node_modules/*' | sort | head -300
   ```

2. Analyse the output and produce an orientation brief covering:
   - **Project type** — what is this repo? (workload, platform, library, config)
   - **Key entry points** — main files, root modules, pipeline definitions
   - **Active agents** — which team agents are relevant to this repo's domain
   - **Standards compliance** — does the structure align with team standards (AVM modules, file separation, PE pattern)?
   - **Obvious gaps or risks** — anything missing, unusual, or requiring attention before work begins

3. Present the brief to the user before taking any action.

## Usage

```
/orient
```

Invoke at the start of any session in an unfamiliar repo, or when context has been lost after a long session.
