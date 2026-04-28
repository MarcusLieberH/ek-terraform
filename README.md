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

## Krav

### Installation (Windows)

**Terraform**
```powershell
winget install HashiCorp.Terraform
```
Eller manuel download fra https://developer.hashicorp.com/terraform/downloads — udpak `terraform.exe` til `C:\terraform` og tilføj mappen til PATH.

**Azure CLI**
```powershell
winget install Microsoft.AzureCLI
```

**Git**
```powershell
winget install Git.Git
```

**VS Code**
```powershell
winget install Microsoft.VisualStudioCode
```
Installer HashiCorp Terraform extension for syntax highlighting og autocomplete.

### PATH fix
Winget opdaterer ikke PATH i aktive terminaler. Genstart terminalen efter installation, eller kør dette i den aktive session:
```powershell
$env:Path += ";C:\terraform;C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin"
```

### Azure login
```powershell
az login
```

## Kom i gang

```bash
cd 01_Setup_And_Basics
terraform init
terraform apply
```

## Ryd op

```bash
terraform destroy
```

## Sikkerhed

`terraform.tfvars` indeholder sensitive værdier (passwords, subscription ID) og er tilføjet til `.gitignore` — den committes aldrig til git.
