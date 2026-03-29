# Cloud Engineering Team

This repository contains the shared Claude Code configuration for the cloud engineering team — agents, skills, standards, and project settings.

For the full team reference, see **[TEAM-README.md](TEAM-README.md)**.

## Default Agent

**Archie** (`archie-solutions-architect`) is the default agent for this repository. Archie is the team's primary orchestrator — give Archie a goal and the team self-organises to deliver it. You only need to interact with Archie.

## Repository Structure

```
.claude/
  settings.json        # Project-wide Claude Code settings (Archie set as default agent)
  agents/              # 11 specialist agent definitions
    archie-solutions-architect.md   # Primary orchestrator — start here
    scrum-agile-pm.md
    terra-iac-engineer.md
    sentinel-security-engineer.md
    netara-network-engineer.md
    axiom-devops-engineer.md
    kube-aks-engineer.md
    dyno-observability-engineer.md
    datum-database-engineer.md
    finley-finops-engineer.md
    stratus-senior-cloud-engineer.md
  skills/              # Conversational prompt expansions — reasoning and analysis tasks (e.g. /orient)
  commands/            # Discrete executable actions — operational tasks that just run (e.g. /sync-agents)
  hooks/               # Automated session behaviours (e.g. repo map on session start)
docs/
  standards/           # Active team standards (AVM, file structure, private endpoints, naming, tagging)
  decisions/           # Architecture Decision Records (ADRs) — created as work progresses
TEAM-README.md         # Full team index: roster, standards, orchestration model, dependency sequence
```

## Key Standards

- **AVM first** — all Terraform uses Azure Verified Modules where available
- **Private Endpoints non-negotiable** — all PE-capable resources use PEs; public access disabled by default
- **No static credentials** — OIDC federation and Managed Identity everywhere
- **Preview features** — always flagged with `# PREVIEW:` in code and documented with a GA review date
