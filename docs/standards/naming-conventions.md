# Naming Conventions Standard

> **Status:** Pending — formal naming conventions to be provided by the team.
>
> This document will define the authoritative naming convention standard for all Azure resources, Terraform modules, and supporting infrastructure across the Cloud Engineering team.

---

## Scope

When defined, this standard will cover:

- Azure resource naming (all resource types)
- Resource group naming
- Subscription naming
- Management group naming
- Terraform module and variable naming
- GitHub repository and workflow naming
- AKS namespace and workload naming
- Tagging key naming (see also: `tagging-taxonomy.md`)

---

## Governing Principles (Interim)

Until formal conventions are defined, the following interim principles apply:

- All Terraform modules accept resource names as **input variables** — names are never generated or assembled inside module code
- No abbreviation logic, `random_string` suffixes, or naming interpolation inside modules
- Naming is always the responsibility of the **root configuration caller**, not the module
- All child resources (Private Endpoints, diagnostic settings, locks) accept dedicated `<sub_resource>_name` input variables

---

## Convention Table

> To be completed when naming standards are provided.

| Resource Type | Pattern | Example | Max Length | Notes |
|---|---|---|---|---|
| Resource Group | TBD | TBD | TBD | |
| Virtual Network | TBD | TBD | TBD | |
| Subnet | TBD | TBD | TBD | |
| AKS Cluster | TBD | TBD | TBD | |
| Key Vault | TBD | TBD | TBD | |
| Storage Account | TBD | TBD | TBD | |
| Azure SQL | TBD | TBD | TBD | |
| Private Endpoint | TBD | TBD | TBD | |
| Log Analytics Workspace | TBD | TBD | TBD | |
| Managed Identity | TBD | TBD | TBD | |

---

## Related Standards

- [Tagging Taxonomy](tagging-taxonomy.md)
- [AVM Module Standard](avm-module-standard.md)
- [Terraform File Structure](terraform-file-structure.md)

---

> **Owner:** Terra (IaC Engineer) in collaboration with Stratus (Senior Cloud Engineer)
> **Last Updated:** Pending
> **Review Cadence:** Updated when naming convention guidance is provided
