# Production Ready Modular Azure Terraform Infrastructure

This repository contains modularized, production-level Terraform code designed for deploying Azure infrastructure with `for_each` resource loops and remote state management.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml          # GitHub Actions CI/CD pipeline
├── child/
│   ├── resource_group/            # Resource Group module
│   ├── Storage_account/           # Storage Account module
│   ├── vnet/                      # Virtual Network module
│   ├── subnet/                    # Subnet module
│   ├── nic/                       # Network Interface module
│   └── virtual_machine/           # Linux Virtual Machine module
├── Root/
│   ├── main.tf                    # Root module declarations
│   ├── variables.tf               # Root variable declarations
│   ├── outputs.tf                 # Root module outputs
│   ├── locals.tf                  # Environment & tagging local values
│   ├── providers.tf               # Azure provider settings
│   ├── versions.tf                # Required provider & Terraform constraints
│   ├── backend.tf                 # Remote Azure Storage backend config
│   ├── backend.hcl                # Remote backend configuration parameters
│   └── terraform.tfvars           # Environment variable values
├── .gitignore
└── README.md
```

## Remote State Backend

The state is securely stored in Azure Storage Container:
- **Resource Group**: `tfstate-rg`
- **Storage Account**: `ravitfstate2026`
- **Container**: `tfstate`
- **State Key**: `prod.terraform.tfstate`

## GitHub Actions Secrets

To enable CI/CD deployment via GitHub Actions, add the following secrets under **Repository Settings -> Secrets and variables -> Actions**:

| Secret Name | Description |
| :--- | :--- |
| `AZURE_CLIENT_ID` | Service Principal App ID |
| `AZURE_CLIENT_SECRET` | Service Principal Secret Password |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID |
| `AZURE_TENANT_ID` | Azure Active Directory Tenant ID |

## Local Execution Commands

```bash
cd Root
terraform init
terraform plan
terraform apply -auto-approve
```
