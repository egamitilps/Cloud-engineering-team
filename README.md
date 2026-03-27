# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for the Cloud Engineering team. ADRs are owned by **Archie** (Solutions Architect) and represent the authoritative record of significant technical decisions made by the team.

---

## What is an ADR?

An ADR documents a significant architecture or design decision — particularly where trade-offs exist, alternatives were considered, or the decision has long-term consequences. ADRs are immutable once accepted; superseded decisions are marked as such and a new ADR is created.

---

## ADR Status Values

| Status | Meaning |
|---|---|
| `Draft` | Under discussion — not yet accepted |
| `Accepted` | Decision is active and in effect |
| `Superseded` | Replaced by a newer ADR (link provided) |
| `Deprecated` | No longer relevant but kept for historical context |

---

## ADR Index

| ID | Title | Status | Date | Agents Involved |
|---|---|---|---|---|
| — | No ADRs yet — first ADR to be created when the first significant design decision is made | — | — | — |

---

## ADR Template

When creating a new ADR, use the following structure and save as `ADR-NNNN-short-title.md`:

```markdown
# ADR-NNNN: [Short Title]

## Status
[Draft | Accepted | Superseded by ADR-XXXX | Deprecated]

## Date
YYYY-MM-DD

## Context
What is the situation that requires a decision? What forces are at play?
What constraints exist?

## Decision
What was decided? State it clearly and directly.

## Alternatives Considered
What other options were evaluated and why were they not chosen?

## Consequences
What are the positive and negative outcomes of this decision?
What becomes easier or harder as a result?

## Preview Feature Note (if applicable)
If this decision involves a preview feature, document:
- Feature name and current status
- Risk assessment
- GA readiness criteria
- Review date

## Approvers
- Archie (Solutions Architect) — required
- [Additional agent] — required if decision affects their domain

## Related Standards
- Links to relevant standards documents
```

---

## When to Create an ADR

An ADR is required when:

- Selecting between two or more viable Azure services for a workload
- Adopting a preview feature in a design
- Granting an exception to a team standard (e.g. Private Endpoint exemption)
- Making a cross-cutting platform decision that affects multiple agents
- Changing or superseding a previous architecture decision

An ADR is **not** required for:

- Routine resource provisioning that follows established standards
- Bug fixes or minor configuration changes
- Decisions that are fully covered by an existing standard

---

> **Owner:** Archie (Solutions Architect)
> **Review Cadence:** ADR index reviewed at each Sprint Review
