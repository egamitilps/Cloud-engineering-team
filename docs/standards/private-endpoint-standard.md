# Private Endpoint Standard

> **Status:** Active — this standard is in effect for all new resource provisioning.

---

## Policy Statement

All Azure resources that support Private Endpoints **must** be provisioned with Private Endpoints enabled and public network access explicitly disabled. This is a non-negotiable team baseline.

Exceptions require a documented Architecture Decision Record (ADR) approved by **Archie** (Solutions Architect) and **Sentinel** (Security Engineer).

---

## Scope

Applies to all Azure resources provisioned across all environments (dev, staging, prod) and all subscriptions.

---

## Resources Requiring Private Endpoints

The following categories always use Private Endpoints. This list is not exhaustive — apply to any PE-capable resource:

| Category | Resources |
|---|---|
| Secrets & Certificates | Azure Key Vault |
| Storage | Azure Storage Accounts (blob, file, queue, table — separate PE per sub-resource) |
| Databases | Azure SQL, Cosmos DB, PostgreSQL Flexible Server, MySQL Flexible Server, Azure Managed Redis |
| Containers | Azure Container Registry (ACR) |
| Kubernetes | AKS API server (private cluster enabled) |
| Monitoring | Azure Monitor Private Link Scope (AMPLS) |
| Messaging | Azure Service Bus, Azure Event Hubs, Azure Event Grid |
| App Platform | Azure App Service, Azure Functions, Azure API Management |
| AI / Cognitive | Azure OpenAI, Azure Machine Learning Workspace, Azure Cognitive Services |

---

## Terraform Implementation

### Private Endpoint Resource Pattern

All Private Endpoint resources are defined in a dedicated `private_endpoints.tf` file — never in `main.tf`.

```hcl
# private_endpoints.tf

resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoints

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = each.value.private_service_connection_name
    private_connection_resource_id = azurerm_<resource>.this.id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = each.value.private_dns_zone_group_name
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

  tags = var.tags
}
```

### Public Network Access Variable Pattern

Every module must include this variable where the resource supports public network access control:

```hcl
# variables.tf

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled. Defaults to false. Requires Private Endpoint configuration when disabled."
  default     = false
}
```

---

## DNS Zone Ownership

- Private DNS Zones are owned and managed by **Netara** via the network platform module
- Terraform modules accept Private DNS Zone resource IDs as input variables — they never create DNS zones
- Root configurations wire Netara's DNS Zone output IDs into workload module Private Endpoint inputs

### Standard Private DNS Zone Names

| Resource | Private DNS Zone |
|---|---|
| Azure Key Vault | `privatelink.vaultcore.azure.net` |
| Azure Storage (blob) | `privatelink.blob.core.windows.net` |
| Azure Storage (file) | `privatelink.file.core.windows.net` |
| Azure Storage (queue) | `privatelink.queue.core.windows.net` |
| Azure Storage (table) | `privatelink.table.core.windows.net` |
| Azure SQL | `privatelink.database.windows.net` |
| Cosmos DB | `privatelink.documents.azure.com` |
| PostgreSQL Flexible Server | `privatelink.postgres.database.azure.com` |
| Azure Container Registry | `privatelink.azurecr.io` |
| Azure Service Bus | `privatelink.servicebus.windows.net` |
| Azure Event Hubs | `privatelink.servicebus.windows.net` |
| Azure Monitor (AMPLS) | `privatelink.monitor.azure.com` |
| Azure OpenAI | `privatelink.openai.azure.com` |

---

## Exception Process

If a resource cannot use a Private Endpoint (e.g. a service that does not support PE, or a specific justified use case):

1. Raise with **Archie** during architecture review
2. Document the exception in an ADR in `docs/decisions/`
3. Obtain approval from **Archie** and **Sentinel**
4. ADR must include: justification, compensating controls, and a review date

---

## Related Standards

- [AVM Module Standard](avm-module-standard.md)
- [Terraform File Structure](terraform-file-structure.md)
- [Naming Conventions](naming-conventions.md)

---

> **Owner:** Terra (IaC Engineer) + Netara (Network Engineer) + Sentinel (Security Engineer)
> **Status:** Active
> **Review Cadence:** Annually, or when new Azure services supporting Private Endpoints are onboarded
