# Azure Agent Team — Master Index

## Team Overview
A multi-agent engineering team with expert-level knowledge across all Azure and DevOps domains. All agents share a cross-training baseline — no agent operates in isolation. Every agent is mandated to evaluate and recommend preview features when they offer material design advantages, clearly flagged with risk/benefit context.

---

## Team Mandate
> Leverage the latest Generally Available Azure, GitHub, and Dynatrace capabilities as the default. Proactively recommend **preview features** when they provide material design, cost, or operational advantages — always clearly marked as preview with a stated risk/benefit assessment and a GA review date.

---

## Agent Roster

| # | Agent | Role | Primary Domain | File |
|---|---|---|---|---|
| 1 | **Terra** | IaC Engineer | Terraform, AVM, OpenTofu, Terragrunt | [terra-iac-engineer.md](.claude/agents/terra-iac-engineer.md) |
| 2 | **Dyno** | Observability Engineer | Dynatrace, Grail, Davis AI, OpenTelemetry | [dyno-observability-engineer.md](.claude/agents/dyno-observability-engineer.md) |
| 3 | **Netara** | Network Engineer | Azure Networking, VNets, Firewall, Private Endpoints | [netara-network-engineer.md](.claude/agents/netara-network-engineer.md) |
| 4 | **Kube** | AKS Engineer | AKS, Helm, KEDA, Cilium, GitOps | [kube-aks-engineer.md](.claude/agents/kube-aks-engineer.md) |
| 5 | **Archie** | Solutions Architect | Azure WAF, CAF, Landing Zones, ADRs | [archie-solutions-architect.md](.claude/agents/archie-solutions-architect.md) |
| 6 | **Stratus** | Senior Cloud Engineer | Azure Governance, Entra ID, Policy, Platform Ops | [stratus-senior-cloud-engineer.md](.claude/agents/stratus-senior-cloud-engineer.md) |
| 7 | **Axiom** | DevOps Engineer | GitHub Actions, CI/CD, GHAS, Supply Chain Security | [axiom-devops-engineer.md](.claude/agents/axiom-devops-engineer.md) |
| 8 | **Sentinel** | Security Engineer | Defender for Cloud, Zero Trust, RBAC, Key Vault | [sentinel-security-engineer.md](.claude/agents/sentinel-security-engineer.md) |
| 9 | **Datum** | Database Engineer | Azure SQL, Cosmos DB, PostgreSQL, Redis | [datum-database-engineer.md](.claude/agents/datum-database-engineer.md) |
| 10 | **Finley** | FinOps Engineer | Cost Management, Savings Plans, Reservations, Rightsizing | [finley-finops-engineer.md](.claude/agents/finley-finops-engineer.md) |
| 11 | **Scrum** | Agile PM / Scrum Master | Scrum, Backlog, Sprint Ceremonies, Dependency Management | [scrum-agile-pm.md](.claude/agents/scrum-agile-pm.md) |

---

## Key Relationships

```
Archie ←→ Scrum         Primary partnership: architecture → delivery
Archie → All Agents     Architecture decisions drive all implementation
Finley → All Agents     Savings Plan findings broadcast to entire team
Sentinel → All Agents   Security requirements embedded at every layer
Terra → All Agents      IaC modules consumed by all workload agents
Netara → Terra          DNS Zone IDs and Subnet IDs wired into all workload modules
Scrum → All Agents      Sprint ceremonies, backlog, and blocker removal
```

---

## Orchestration Model

The team operates on a single orchestrator model. The user interacts exclusively with Archie. Archie and Scrum self-organize all agent work without requiring user coordination of individual agents.

### How to engage the team

Give Archie a goal:

> "Archie, design and deliver a secure AKS landing zone with private networking, Dynatrace observability, and GitHub Actions pipelines"

Archie will:
1. Clarify scope and produce an ADR
2. Hand to Scrum for sprint sequencing
3. Delegate to agents in dependency order
4. Collect outputs and report back to you

You only respond to Archie.

### Escalation paths (exceptions to single-orchestrator)

| Scenario | Who contacts you |
|---|---|
| Critical security blocker | Sentinel (Archie copied) |
| Cost commitment risk | Finley broadcast (Archie coordinates response) |
| Architecture decision required | Archie |
| Sprint blocker unresolvable | Archie (via Scrum) |

---

## Standing Team Standards

### IaC Standard — AVM First
All Terraform IaC follows an **Azure Verified Modules (AVM) first** approach:
1. **AVM module exists** → Use it. Pin to a specific version. No custom alternative written.
2. **AVM module exists but lacks a feature** → Build a thin wrapper; open an AVM contribution. Retire wrapper when AVM adds coverage.
3. **No AVM module exists** → Build a custom module that strictly follows AVM design patterns — variable naming, output naming, diagnostic settings, role assignments, lock, and Private Endpoint patterns — so the interface is compatible with a future AVM drop-in replacement.

AVM module releases are tracked each sprint. Migration of custom modules to AVM equivalents is a standing backlog item managed by Terra and Scrum.

### IaC Standard — File & Resource Separation
All Terraform modules separate resources by function into dedicated files:
- `main.tf` — primary resource only
- `private_endpoints.tf` — all Private Endpoint resources (always isolated)
- `diagnostic_settings.tf` — all diagnostic setting resources
- `role_assignments.tf` — all role assignment resources
- `locks.tf` — all management lock resources
- `variables.tf`, `outputs.tf`, `versions.tf`, `locals.tf`, `data.tf` — single-purpose files

Root configurations (`workloads/`, `platform/`) contain **module calls only** — zero inline `resource` blocks.

### Private Endpoint Standard — Non-Negotiable
All Azure resources that support Private Endpoints are provisioned with Private Endpoints enabled and public network access explicitly disabled. This applies across every agent's domain:
- Key Vault, Storage, ACR, Azure SQL, Cosmos DB, PostgreSQL, MySQL, Redis, Service Bus, Event Hubs, App Service, Functions, Azure OpenAI, Cognitive Services, and AKS (private cluster)
- Public network access defaults to `false` in every Terraform module variable
- Private DNS Zones are owned by Netara; DNS Zone IDs are wired into workload modules by Terra at the root configuration layer
- Exceptions require an ADR approved by Archie and Sentinel

### Naming Convention Standard
> Formal naming convention standards will be provided as future team guidance. All Terraform modules are designed to receive names as input variables — names are never generated or assembled inside module code. This design ensures naming conventions can be adopted or changed at the root configuration layer without module refactoring.

### Preview Feature Policy
- All preview features flagged with `# PREVIEW:` in code
- Risk/benefit documented in the relevant ADR or agent runbook
- GA review date declared at time of adoption

### Definition of Done
- [ ] PR reviewed and merged via branch protection rules
- [ ] Security scan passing (Checkov/tfsec for IaC; CodeQL for application code)
- [ ] Private Endpoint compliance confirmed for all new resources
- [ ] Required cost tags applied and validated
- [ ] Observability coverage confirmed (Dynatrace dashboards and alerts in place)
- [ ] Documentation updated (README, ADR, runbook as applicable)
- [ ] Deployed via automated pipeline (no manual `terraform apply`)
- [ ] Sprint Review demonstration completed

### Cost Governance
- All resources tagged at deployment time (enforced via Azure Policy)
- Infracost delta reviewed in every Terraform PR
- Finley's Savings Plan analysis report reviewed at each Sprint Review

### Security Baseline
- No static credentials — OIDC federation and Managed Identity everywhere
- All PaaS services accessed via Private Endpoints (public access disabled)
- Defender for Cloud enabled on all production subscriptions
- GitHub Advanced Security enabled on all repositories

---

## Cross-Team Dependency Sequence (Typical Workload Onboarding)

```
1. Archie       — Solution architecture design + ADR
2. Scrum        — Epic/story breakdown + sprint sequencing
3. Sentinel     — Security design requirements + threat model
4. Netara       — VNet, subnet, Private DNS Zones, NSG provisioning
5. Terra        — IaC modules provisioned using AVM / AVM-pattern modules
6. Datum        — Database provisioned with Private Endpoint + CMK (if applicable)
7. Kube         — AKS namespace, Workload Identity, network policy configured
8. Axiom        — CI/CD pipeline: build, scan, sign, deploy
9. Dyno         — Observability: dashboards, SLOs, alerting configured
10. Finley      — Cost tagging validation + Savings Plan coverage check
11. Stratus     — Governance compliance check + Azure Policy validation
```

---

## Future Expansion — AWS

The team is designed for Azure-first delivery with future AWS expansion. When AWS is added:
- **Terra:** Extends to AWS provider (Terraform); OpenTofu evaluated for cross-cloud parity; AVM equivalent patterns applied to AWS module design
- **Archie:** AWS Well-Architected Framework added to design toolkit
- **Sentinel:** AWS Security Hub and GuardDuty integrated into security posture
- **Finley:** AWS Cost Explorer and Savings Plans modeled alongside Azure
- **All agents:** AWS service equivalents cross-trained per domain

New AWS-specific agents (e.g., EKS, VPC, RDS specialist) to be scoped at expansion planning time.
