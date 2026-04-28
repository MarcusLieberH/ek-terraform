# KEA Terraform

Terraform opgaver fra DevOps kurset på KEA. Projektet demonstrerer Infrastructure as Code (IaC) med Azure som cloud provider.

## Hvad er Terraform?

Terraform er et Infrastructure as Code værktøj der lader dig beskrive og oprette cloud infrastruktur via kode frem for at klikke i en portal. Infrastrukturen versionstyres i git og kan reproduceres præcist på tværs af miljøer.

## Mappestruktur

| Mappe | Indhold |
|---|---|
| `01_Setup_And_Basics` | Installation, init, workspaces og Azure provider |
| `02_Basic_VM` | Komplet VM infrastruktur med variabler og sikre passwords |
| `03_VM_With_SSH` | VM med SSH key authentication |

## Kom i gang

### Krav
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Et Azure subscription

### Login
```bash
az login
```

### Deploy
```bash
cd 01_Setup_And_Basics
terraform init
terraform apply
```

### Ryd op
```bash
terraform destroy
```

## Sikkerhed

`terraform.tfvars` indeholder sensitive værdier (passwords, subscription ID) og er tilføjet til `.gitignore` — den committes aldrig til git.
