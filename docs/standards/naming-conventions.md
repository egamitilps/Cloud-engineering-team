# Naming Conventions Standard

> **Status:** Active — v0.2 (sourced from `naming-and-tagging-conventions-tracking_v0.2.xlsx`)
> **Owner:** Terra (IaC Engineer) in collaboration with Stratus (Senior Cloud Engineer)
> **Review Cadence:** Quarterly, or when new resource types are onboarded

---

## Governing Principles

- All Terraform modules accept resource names as **input variables** — names are never generated or assembled inside module code
- No abbreviation logic, `random_string` suffixes, or naming interpolation inside modules
- Naming is always the responsibility of the **root configuration caller**, not the module
- All child resources (Private Endpoints, diagnostic settings, locks) accept dedicated `<sub_resource>_name` input variables
- Azure Naming Tool is the recommended generator for producing compliant names

---

## Master Pattern

```
<prefix>-<purpose>-<env>-<domain>[optional]-<svc>[optional]-<region>-<##>[optional]
```

**Example (Resource Group):**
```
rg-wld-dev-ncp-dns-use-01
```

---

## Naming Components

| Component | Token | Description | Examples |
|---|---|---|---|
| **Organization** | `org` | Owning organization — stable across all environments | `ncs` |
| **Purpose** | `purpose` | Functional or architectural role of the resource | `plt` (Platform), `wld` (Workload), `root`, `azroot`, `hub`, `spk` |
| **Domain** | `domain` | Business unit or product domain | `ncp` (Ncomply), `shs` (Shared Services) |
| **Environment** | `env` | Lifecycle stage | `f01`–`f11` (Feature), `dev`, `uat`, `prd`/`prod`, `nonprd`/`nonprod`, `poc` |
| **Service** | `svc` | Technical role of the resource | `dc`, `db`, `fw`, `ws`, `net`, `dns`, `app`, `aks`, `ids`, `sg` |
| **Region** | `region` | Azure region abbreviation | `usc` (centralus), `use` (eastus), `usw` (westus) |
| **Index** | `##` | Numeric suffix for multiple instances | `01`, `02`, `03` |

---

## Resource Type Prefixes

| Resource | Prefix | Notes |
|---|---|---|
| Action Groups | `ag` | |
| AKS Cluster | `aks` | |
| App Service Plan | `asp` | |
| Application Insights | `ain` | |
| Azure Application Gateway | `agw` | |
| Azure Cache for Redis / Managed Redis | `redis` | |
| Azure Container Instance | `ci` | |
| Azure Cosmos DB | `cosdb` | |
| Azure Data Factory | `df` | |
| Azure Data Lake Analytics | `dla` | |
| Azure Data Lake Storage | `dls` | |
| Azure Database for MySQL | `mysql` | |
| Azure Database for PostgreSQL | `psql` | |
| Azure DevOps Service Connection | `svcconn` | |
| Azure DNS Resolver | `dnsr` | |
| Azure Document Intelligence | `di` | |
| Azure Firewall | `afw` | |
| Azure Logic App | `logic` | |
| Azure Machine Learning Workspace | `aml` | |
| Azure OpenAI | `oai` | |
| Azure Search | `srch` | |
| Azure SQL Database | `sqldb` | |
| Azure SQL Logical Server | `sql` | |
| Azure Storage Account | `sa` | No hyphens; max 24 chars |
| Azure Virtual Desktop | `avd` | |
| Azure Virtual Desktop Host Pool | `hp` | |
| Azure Virtual Desktop Workspace | `ws` | |
| Cognitive Services | `cs` | |
| Container App Environment | `cae` | |
| Container Registry | `cr` | |
| Data Collection Rules | `dcr` | |
| Diagnostic Settings | `dx` | |
| Event Hub (Namespace) | `evh` | |
| Function App | `func` | |
| Gateway Connection | `cn` | |
| HDInsight — Hadoop | `hdihd` | |
| HDInsight — HBase | `hdihb` | |
| HDInsight — R Server | `hdir` | |
| HDInsight — Spark | `hdis` | |
| Key Vault | `kv` | 3–24 chars; globally unique |
| Load Balancer | `lb` | |
| Log Analytics Workspace | `law` | |
| Management Group | `mg` | |
| Managed Identity | `mi` | |
| NIC | `nic` | |
| Network Security Group | `nsg` | |
| Notification Hub | `anh` | |
| Notification Hub Namespace | `anhns` | |
| Power BI Embedded | `pbiemb` | |
| Private Endpoint | `pep` | Named after related resource |
| Public IP Address | `pip` | |
| Resource Group | `rg` | |
| Route Table | `rt` | |
| Service Bus (Namespace) | `sb` | |
| Service Bus Queue | `sbq` | |
| SQL Data Warehouse | `sqldw` | |
| Subnet | `snet` | |
| Virtual Machine | `vm` | Windows: max 15 chars |
| Virtual Machine Storage Account | `stvm` | |
| Virtual Network | `vnet` | |
| Virtual Network Gateway | `vnetgw` | |
| VNet Peering | — | `<source-vnet>_TO_<dest-vnet>` |
| Web App | `app` | |
| Web Application Firewall | `waf` | |

---

## Naming Patterns by Category

### Identity & Access (Entra ID)

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Entra ID Group — Identity Roles | Entra ID | `SG-IDS-<purpose>[opt]-<env>[opt]-<domain>-<Role>` | `SG-IDS-GlobalAdmins` |
| Entra ID Group — Azure Roles | Entra ID | `SG-AZS-<env>[opt]-<purpose>[opt]-<domain>[opt]-<svc>[opt]-<Role>` | `SG-AZS-PLT-Contributors`<br>`SG-AZS-PROD-NCP-VDI-Admins` |
| App Registration | Entra ID | `app-<purpose>-<env>[opt]-<domain>-<svc>` | `app-wld-dev-ncp-api` |
| App Registration (GitHub OIDC) | Entra ID | `app-gh-<repo>-<env>` | `app-gh-infra-prod` |

### Management Groups

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Management Group | Root Tenant | `mg-<org>-<purpose>-<env>[opt]` | `mg-ncs-azroot`<br>`mg-ncs-plt`<br>`mg-ncs-wld-prod` |

### Subscriptions

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Subscription | EA / MCA | `<ORG>-<PURPOSE>-<ENV>-<##>` *(uppercase)* | `NCS-PLT-PROD-01`<br>`NCS-WLD-UAT-01` |

### Resource Groups

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Resource Group | Subscription | `rg-<purpose>-<env>-<domain>[opt]-<svc>[opt]-<region>-<##>` | `rg-wld-dev-ncp-dns-use-01` |

### Managed Identities

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Managed Identity | Resource Group | `mi-<purpose>-<env>-<domain>[opt]-<svc>[opt]-<region>-<##>[opt]` | `mi-tf-l0-dev-usc` |

### Networking

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Virtual Network | Resource Group | `vnet-<purpose>-<env>-<domain>[opt]-<region>-<##>` | `vnet-spk-dev-ncp-use-01`<br>`vnet-hub-prd-use-01` |
| VNet Peering | vNet | `<source-vnet>_TO_<dest-vnet>` | `vnet-spk-dev-ncp-use-01_TO_vnet-hub-prd-use-01` |
| Subnet | Virtual Network | `snet-<env>-<domain>[opt]-<svc>[opt]-<region>-<##>` | `snet-dev-ncp-aks-use-01` |
| Network Security Group | Subnet / NIC | `nsg-<env>-<domain>-<svc>[opt]-<region>-<##>` | `nsg-dev-ncp-aks-use-01` |
| Public IP Address | Resource Group | `pip-<env>-<domain>-<svc>[opt]-<region>-<##>[opt]` | `pip-dev-ncp-app-use-01` |
| Private Endpoint | Resource Group | `pep-<related-resource-name>` | `pep-sqlwlddevncpuse01` |
| Azure Firewall | Resource Group | `afw-<purpose>-<env>-<region>-<##>` | `afw-hub-prd-use-01` |
| Application Gateway | Resource Group | `agw-<purpose>-<env>-<domain>-<region>-<##>` | `agw-wld-dev-ncp-use-01` |
| Route Table | Resource Group | `rt-<env>-<domain>[opt]-<svc>[opt]-<region>-<##>` | `rt-dev-ncp-aks-use-01` |
| DNS Resolver | Resource Group | `dnsr-<purpose>-<env>-<region>-<##>` | `dnsr-plt-prd-use-01` |
| Load Balancer | Resource Group | `lb-<purpose>-<env>-<domain>[opt]-<svc>[opt]-<region>-<##>` | `lb-wld-dev-ncp-app-use-01` |

### Compute

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| AKS Cluster | Resource Group | `aks-<purpose>-<env>-<region>-<##>` | `aks-wld-dev-usc-01` |
| Virtual Machine (Linux) | Resource Group | `vm-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `vm-plt-dev-shs-dc-use-01` |
| Virtual Machine (Windows) | Resource Group | `vm<env><domain><svc><##>` *(no hyphens; max 15 chars)* | `vmdevshsdc01` |
| NIC | Resource Group | `nic-<vm-name>-<##>` | `nic-vmdevshsdc01-01` |

### PaaS Services

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| App Service Plan | Resource Group | `asp-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `asp-wld-dev-ncp-app-use-01` |
| Web App | Global | `app-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `app-wld-dev-ncp-web-use-01` |
| Function App | Global | `func-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `func-wld-dev-ncp-proc-use-01` |
| Container App Environment | Resource Group | `cae-<purpose>-<env>-<domain>[opt]-<region>-<##>` | `cae-wld-dev-ncp-use-01` |
| Service Bus (Namespace) | Global | `sb-<purpose>-<env>-<domain>-<region>-<##>` | `sb-wld-dev-ncp-use-01` |
| Service Bus Queue | Service Bus | `sbq-<purpose>-<env>-<domain>-<name>` | `sbq-wld-dev-ncp-orders` |
| Azure Logic App | Resource Group | `logic-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `logic-wld-dev-ncp-int-use-01` |
| Event Hub (Namespace) | Global | `evh-<purpose>-<env>-<domain>-<region>-<##>` | `evh-wld-dev-ncp-use-01` |

### Databases

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Azure SQL Logical Server | Global | `sql-<purpose>-<env>-<domain>-<region>-<##>` | `sql-wld-dev-ncp-use-01` |
| Azure SQL Database | SQL Server | `sqldb-<purpose>-<env>-<domain>-<name>` | `sqldb-wld-dev-ncp-main` |
| Azure Cosmos DB | Global | `cosdb-<purpose>-<env>-<domain>-<region>-<##>` | `cosdb-wld-dev-ncp-use-01` |
| Azure Managed Redis | Global | `redis-<purpose>-<env>-<domain>-<region>-<##>` | `redis-wld-dev-ncp-use-01` |
| Azure Database for PostgreSQL | Global | `psql-<purpose>-<env>-<domain>-<region>-<##>` | `psql-wld-dev-ncp-use-01` |
| Azure Database for MySQL | Global | `mysql-<purpose>-<env>-<domain>-<region>-<##>` | `mysql-wld-dev-ncp-use-01` |
| SQL Data Warehouse | Global | `sqldw-<purpose>-<env>-<domain>-<region>-<##>` | `sqldw-plt-dev-shs-use-01` |

### Storage

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Storage Account | Global | `sa<purpose><env><domain>[opt]<svc>[opt]<region><##>` *(no hyphens; max 24 chars)* | `satflayer0devusc01` |
| VM Storage Account | Resource Group | `stvm<purpose><env><domain><region><##>` *(no hyphens)* | `stvmpltdevshsuse01` |

### AI + Machine Learning

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Azure OpenAI | Resource Group | `oai-<purpose>-<env>-<domain>-<region>-<##>` | `oai-wld-dev-ncp-use-01` |
| Azure Search | Global | `srch-<purpose>-<env>-<domain>-<region>-<##>` | `srch-wld-dev-ncp-use-01` |
| Cognitive Services | Resource Group | `cs-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `cs-wld-dev-ncp-vision-use-01` |
| Machine Learning Workspace | Resource Group | `aml-<purpose>-<env>-<domain>-<region>-<##>` | `aml-wld-dev-ncp-use-01` |
| Document Intelligence | Resource Group | `di-<purpose>-<env>-<domain>-<region>-<##>` | `di-wld-dev-ncp-use-01` |

### Analytics

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Azure Data Factory | Global | `df-<purpose>-<env>-<domain>-<region>-<##>` | `df-wld-dev-ncp-use-01` |
| Azure Data Lake Storage | Global | `dls-<purpose>-<env>-<domain>-<region>-<##>` | `dls-wld-dev-ncp-use-01` |
| Azure Data Lake Analytics | Global | `dla-<purpose>-<env>-<domain>-<region>-<##>` | `dla-wld-dev-ncp-use-01` |
| HDInsight — Spark | Global | `hdis-<purpose>-<env>-<domain>-<region>-<##>` | `hdis-wld-dev-ncp-use-01` |
| HDInsight — Hadoop | Global | `hdihd-<purpose>-<env>-<domain>-<region>-<##>` | `hdihd-wld-dev-ncp-use-01` |
| HDInsight — HBase | Global | `hdihb-<purpose>-<env>-<domain>-<region>-<##>` | `hdihb-wld-dev-ncp-use-01` |
| HDInsight — R Server | Global | `hdir-<purpose>-<env>-<domain>-<region>-<##>` | `hdir-wld-dev-ncp-use-01` |
| Power BI Embedded | Global | `pbiemb-<purpose>-<env>-<domain>-<region>-<##>` | `pbiemb-wld-dev-ncp-use-01` |

### Monitoring

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Log Analytics Workspace | Resource Group | `law-<purpose>-<env>-<domain>[opt]-<region>-<##>` | `law-plt-prd-use-01` |
| Application Insights | Resource Group | `ain-<purpose>-<env>-<domain>-<svc>[opt]-<region>-<##>` | `ain-wld-dev-ncp-app-use-01` |
| Action Groups | Resource Group | `ag-<purpose>-<env>-<domain>[opt]-<svc>[opt]-<##>` | `ag-plt-prd-shs-critical-01` |
| Data Collection Rules | Resource Group | `dcr-<purpose>-<env>-<domain>[opt]-<svc>[opt]-<##>` | `dcr-plt-prd-vm-01` |

### Security

| Asset Type | Scope | Format | Example |
|---|---|---|---|
| Key Vault | Global | `kv-<purpose>-<env>-<domain>[opt]-<region>-<##>` *(3–24 chars; globally unique)* | `kv-plt-dev-use-01` |

---

## Special Constraints

| Resource | Constraint | Approach |
|---|---|---|
| Storage Account | No hyphens; max 24 chars; globally unique | Concatenate all components without separators |
| Windows VM | Max 15 chars (NetBIOS limit) | Concatenate without hyphens: `vm<env><domain><svc><##>` |
| Key Vault | 3–24 chars; alphanumeric + hyphens; globally unique | Omit domain component if needed to fit limit |
| Azure SQL Server | Globally unique; lowercase only | Ensure combined length fits within 63 chars |
| App Registration | No strict limit; Entra ID scoped | Use descriptive service identifier as suffix |
| Subscription | Uppercase by convention | Differs from all other resource naming — intentional |

---

## Related Standards

- [Tagging Taxonomy](tagging-taxonomy.md)
- [AVM Module Standard](avm-module-standard.md)
- [Terraform File Structure](terraform-file-structure.md)

---

## References

- [Azure Resource Abbreviations (CAF)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [CAF Naming Components](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming#choose-naming-components)
- [Existing Infrastructure Naming Reference](https://github.com/NetworkContractSolutions/Ncontracts.Infrastructure/blob/main/Docs/NamingConventions.md)
