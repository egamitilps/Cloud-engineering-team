# Tagging Taxonomy Standard

> **Status:** Pending — formal tagging taxonomy to be defined in collaboration with Finley (FinOps) and Stratus (Governance).
>
> This document defines the authoritative resource tagging standard for all Azure resources across the Cloud Engineering team estate.

---

## Scope

Applies to all Azure resources provisioned via Terraform across all environments (dev, staging, prod) and all subscriptions.

---

## Governing Principles

- All required tags are enforced via **Azure Policy** at the subscription or management group level
- All Terraform modules expose a `tags` variable — tags are never hardcoded inside modules
- Tags are always merged at the root configuration level: `merge(local.common_tags, var.tags)`
- Untagged resources are flagged immediately by Finley and blocked by Azure Policy where enforcement mode is enabled
- Tag keys use consistent casing (to be defined — e.g. PascalCase or lowercase-hyphenated)

---

## Required Tags

> To be completed when tagging standards are provided.

| Tag Key | Description | Example Value | Required | Enforced by Policy |
|---|---|---|---|---|
| TBD | Cost allocation / chargeback | TBD | Yes | TBD |
| TBD | Owning team or squad | TBD | Yes | TBD |
| TBD | Workload or application name | TBD | Yes | TBD |
| TBD | Environment | dev / staging / prod | Yes | TBD |
| TBD | Criticality tier | low / medium / high / critical | Yes | TBD |
| TBD | Data classification | public / internal / confidential | TBD | TBD |
| TBD | Provisioned by | terraform | Yes | TBD |

---

## Optional Tags

> To be completed when tagging standards are provided.

| Tag Key | Description | Example Value |
|---|---|---|
| TBD | | |

---

## Terraform Implementation Pattern

```hcl
# locals.tf — root configuration

locals {
  common_tags = {
    # Required tags applied to all resources
    # Keys and values defined when standard is provided
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

- Tag compliance is reported via **Azure Resource Graph** queries maintained by Stratus
- Non-compliant resources are surfaced in Finley's sprint cost reports
- Policy assignment scope and enforcement mode (Audit vs. Deny) to be defined when taxonomy is finalized

---

## Related Standards

- [Naming Conventions](naming-conventions.md)
- [Private Endpoint Standard](private-endpoint-standard.md)

---

> **Owner:** Finley (FinOps Engineer) + Stratus (Senior Cloud Engineer)
> **Last Updated:** Pending
> **Review Cadence:** Quarterly, or when FinOps cost allocation requirements change
