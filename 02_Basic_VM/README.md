# 02 - Basic VM

## Hvad gik det ud på?
Byggede en komplet Azure infrastruktur med Terraform og lærte at sikre følsomme værdier ved hjælp af variables og `.tfvars` filer.

## Infrastruktur der blev oprettet
| Ressource | Navn | Formål |
|---|---|---|
| Resource Group | terraform-introduction-resources | Container til alle ressourcer |
| Virtual Network | terraform-introduction-network | Privat netværk til VM'en |
| Subnet | terraform-introduction-subnet | Delsegment af netværket |
| Public IP | main-public-ip | Fast IP til adgang udefra |
| Network Interface | terraform-introduction-network-interface | VM'ens netkort |
| Network Security Group | example-nsg | Firewall regler |
| NSG Rule | SSH | Åbner port 22 for SSH |
| Linux VM | main-vm | Ubuntu 16.04 virtuel maskine |

## Dynamiske referencer
I stedet for at hardcode værdier refererer Terraform ressourcer til hinanden:
```hcl
location            = azurerm_resource_group.main.location
resource_group_name = azurerm_resource_group.main.name
subnet_id           = azurerm_subnet.main.id
```
Dette sikrer at værdier altid er konsistente og opdateres automatisk.

## Sikkerhedsproblem — hardcodet password
Den originale kode havde passwordet eksponeret direkte:
```hcl
admin_password = "Password1234!"  # ALDRIG gør dette!
```
Dette er et sikkerhedsproblem fordi det kan ende i git historikken.

## Løsningen — variables og tfvars
**variables.tf** definerer typerne:
```hcl
variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true  # Skjuler værdien i terminal output
}
```

**terraform.tfvars** indeholder de faktiske værdier:
```hcl
vm_name     = "main-vm"
vm_username = "azureuser"
vm_password = "SecurePassword123!"
```

> ⚠️ `terraform.tfvars` må **aldrig** committes til git — tilføj den til `.gitignore`

## SSH ind på VM'en
```bash
ssh azureuser@<public_ip>
```
IP adressen vises automatisk i outputtet efter `terraform apply`.

## Læringspointer
- `sensitive = true` på en variable skjuler værdien i `terraform plan` og `terraform apply` output
- KEA's Azure for Students subscription tillader kun bestemte regioner — brug `switzerlandnorth`
- NSG skal associeres til subnet eller NIC for at firewall reglerne har effekt
- `Standard_B2ats_v2` er den VM størrelse der virker på KEA subscriptionen
