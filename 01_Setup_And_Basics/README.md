# 01 - Init & Workspaces

## Hvad gik det ud på?
Installerede Terraform og lærte de grundlæggende kommandoer. Initialiserede et Terraform projekt og udforskede workspaces og Azure provideren.

## Terraform installation
Terraform blev installeret manuelt ved at downloade `.zip` filen fra HashiCorp, udpakke `terraform.exe` til `C:\terraform` og tilføje mappen til PATH.

## Vigtige kommandoer
```bash
terraform init       # Initialiserer projektet og downloader providers
terraform fmt        # Formaterer koden til Terraform canonical style
terraform validate   # Validerer konfigurationen uden at tjekke state
terraform plan       # Preview af hvad Terraform vil gøre
terraform apply      # Opretter/opdaterer ressourcer
terraform destroy    # Sletter alle ressourcer
```

## Workspaces
Workspaces er isolerede environments i Terraform — sammenlignelige med git branches, men forskellen er at de isolerer **state**, ikke kode. Der er ingen merge eller reconciliation i Terraform workspaces.

```bash
terraform workspace list              # List alle workspaces (* = aktiv)
terraform workspace new <navn>        # Opret og skift til nyt workspace
terraform workspace select <navn>     # Skift workspace
terraform workspace delete <navn>     # Slet workspace (skal ikke være aktiv)
```

## Azure Provider (azurerm)
`azurerm` står for Azure Resource Manager og findes på [Terraform Registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs).

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

> `terraform init` skal køres igen hver gang provider eller version ændres.

## Læringspointer
- Terraform kræver en `main.tf` for at `terraform init` virker
- Stavefejl i `source` betyder at provideren ikke downloades — tjek altid outputtet af `terraform init`
- `terraform fmt` retter kun indentation, den validerer ikke logik
