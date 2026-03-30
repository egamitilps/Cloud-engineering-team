# Tagging Taxonomy Standard

> **Status:** Active — v0.2 (sourced from `naming-and-tagging-conventions-tracking_v0.2.xlsx`)
> **Owner:** Finley (FinOps Engineer) + Stratus (Senior Cloud Engineer)
> **Review Cadence:** Quarterly, or when FinOps cost allocation requirements change

---

## Governing Principles

- All required tags are enforced via **Azure Policy** at the subscription or management group level
- All Terraform modules expose a `tags` variable — tags are never hardcoded inside modules
- Tags are always merged at the root configuration level: `merge(local.common_tags, var.tags)`
- Untagged resources are flagged immediately by Finley and blocked by Azure Policy where enforcement mode is enabled
- Tag keys use **PascalCase** (e.g. `Environment`, `TechnicalOwner`)
- Primary scope is **Resource Group** — resources inherit tags from their resource group via Azure Policy

---

## Mandatory Tags

| Tag Key | Description | Example Values | Scope |
|---|---|---|---|
| `Environment` | Lifecycle stage of the workload | `Prod`, `NonProd`, `Dev`, `UAT` | Resource Group |
| `Purpose` | Functional role within the platform | `Platform`, `Workload` | Resource Group |
| `Layer` | Terraform deployment layer — reflects infrastructure dependency order | `Level0`, `Level1`, `Level2`, `Level3` | Resource Group |
| `TechnicalOwner` | Email of the engineer or team responsible for the resource | `platform-team@ncontracts.com` | Resource Group |
| `Deployment` | Indicates how the resource was provisioned — used to audit for clickops | `devops`, `clickops` | Resource Group |
| `System` | The named system that owns this resource — reflects accountability, not consumption. Applications use their product name; shared platform services use a platform service identity. | `Ncomply`, `Auth`, `CorePlatform`, `Observability`, `IdentityServices` | Resource Group |
| `GitRepository` | GitHub repository containing the IaC that provisioned this resource | `NetworkContractSolutions/Ncontracts.Infrastructure` | Resource Group |

---

## Optional Tags

| Tag Key | Description | Example Values | Scope |
|---|---|---|---|
| `Consumers` | Comma-separated list of systems that consume this shared resource. Required when `System` is a platform service identity (e.g. `CorePlatform`). Drives cost allocation analysis for TCO reporting. | `Ncomply,Auth` | Resource Group |
| `Service` | Technical role of the resource within the workload | `Firewall`, `AKS`, `Networking`, `SQL Database`, `DNS` | Resource Group |
| `Domain` | Business unit or product domain | `Ncomply`, `Shared Services` | Resource Group |
| `Classification` | Data sensitivity classification | `Public`, `Private`, `Restricted` | Resource Group |
| `Criticality` | Business criticality of the workload | `High`, `Medium`, `Low` | Resource Group |
| `BusinessOwner` | Email of the business owner accountable for the workload | `product-owner@ncontracts.com` | Resource Group |
| `CostCenter` | Accounting cost centre for chargeback | `{cost-centre-number}` | Resource Group |
| `MonitorDisable` | Suppresses monitoring alerts on a VM | `true`, `Test`, `Dev`, `Sandbox` | VM |
| `BackupLevel` | Configures backup policy tier on a VM | `silver-lrs`, `gold-lrs`, `silver-grs`, `gold-grs` | VM |

---

## Layer Tag Reference

The `Layer` tag maps to Terraform deployment layers and reflects the infrastructure dependency order:

| Value | Layer | Typical Contents |
|---|---|---|
| `Level0` | Bootstrap / Identity | Management Groups, subscriptions, Entra ID, OIDC federation |
| `Level1` | Platform Foundation | Hub VNet, Firewall, DNS, Log Analytics, Key Vault |
| `Level2` | Shared Services | Spoke VNets, ACR, shared AKS, shared databases |
| `Level3` | System | Application-specific resources (AKS workloads, databases, app services) |

---

## Terraform Implementation Pattern

```hcl
# locals.tf — root configuration

locals {
  common_tags = {
    Environment    = var.environment        # e.g. "Dev"
    Purpose        = var.purpose            # e.g. "Workload"
    Layer          = var.layer              # e.g. "Level2"
    TechnicalOwner = var.technical_owner    # e.g. "platform-team@ncontracts.com"
    Deployment     = "devops"
    System         = var.system             # e.g. "Ncomply" or "CorePlatform"
    GitRepository  = var.git_repository     # e.g. "NetworkContractSolutions/Ncontracts.Infrastructure"
  }
}
```

```hcl
# Module call in main.tf

module "example" {
  source = "..."
  tags   = merge(local.common_tags, var.additional_tags)
}
```

---

## Azure Policy Enforcement

- Mandatory tags are enforced via **Deny** policy in production management groups
- Non-production environments use **Audit** mode to allow development velocity without hard blocks
- Tag compliance is reported via **Azure Resource Graph** queries maintained by Stratus
- Non-compliant resources are surfaced in Finley's sprint cost reports
- `Deployment = "clickops"` resources are flagged in the weekly governance report for remediation or approval

---

## Related Standards

- [Naming Conventions](naming-conventions.md)
- [Private Endpoint Standard](private-endpoint-standard.md)
- [AVM Module Standard](avm-module-standard.md)
