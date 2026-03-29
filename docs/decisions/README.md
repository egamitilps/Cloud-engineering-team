# Architecture Decision Records

## Scope

ADRs are split by audience:

| Location | Scope |
|---|---|
| **This folder** (`docs/decisions/`) | Team-wide decisions that apply across all projects — standards, toolchain choices, platform patterns, non-negotiables |
| **`docs/decisions/` in each project repo** | Project-specific decisions — service selection, data models, deployment topology, trade-offs unique to that workload |

When in doubt: if a decision would change how *any* agent on the team behaves or what *any* project must comply with, it belongs here. If it only affects one workload, it belongs in that project's repo.

---

## Template

Use [`ADR-template.md`](ADR-template.md) for all new ADRs in this repo and in project repos.

---

## Naming Convention

```
NNNN-short-hyphenated-title.md
```

- `NNNN` — zero-padded sequence number (e.g. `0001`, `0012`)
- Title — lowercase, hyphen-separated, descriptive (e.g. `0001-avm-first-module-standard.md`)

---

## Status Definitions

| Status | Meaning |
|---|---|
| **Proposed** | Under discussion — not yet adopted |
| **Accepted** | Adopted and active |
| **Superseded** | Replaced by a newer ADR (link to replacement) |
| **Deprecated** | No longer applicable; retained for historical context |

---

## Index

| # | Title | Status | Date | Owner |
|---|---|---|---|---|
| — | _No decisions recorded yet_ | — | — | — |
