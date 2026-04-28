# 03 - Static IP Address

## Hvad gik det ud på?
Lærte forskellen på dynamic og static IP adresser i Azure, og hvordan man outputter IP adressen automatisk efter `terraform apply`.

## Dynamic vs Static IP

### Private IP (intern i Azure datacenter)
```hcl
private_ip_address_allocation = "Dynamic"
```
- Tildeles automatisk af Azure
- Kan skifte ved VM genstart eller redeployment
- Bruges til intern kommunikation mellem services i samme VNet

### Public IP (ekstern adgang)
```hcl
resource "azurerm_public_ip" "example" {
  name                = "example-publicip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
```
- `Static`: Fast IP der aldrig skifter — pålidelig for SSH og eksterne services
- `Dynamic`: Skifter ved genstart — billigere men upraktisk
- Static public IP koster lidt mere, men er ofte det værd

> ℹ️ KEA's Azure subscription kræver `sku = "Standard"` — Basic SKU er ikke tilladt

## Output af IP adresse
I stedet for at gå ind i Azure portalen kan Terraform outputte IP adressen direkte:

**outputs.tf:**
```hcl
output "public_ip_address" {
  value = azurerm_public_ip.example.ip_address
}

output "ssh_command" {
  value = "ssh azureuser@${azurerm_public_ip.example.ip_address}"
}
```

Output vises automatisk efter `terraform apply`:
```
Outputs:
public_ip_address = "20.203.141.46"
ssh_command = "ssh azureuser@20.203.141.46"
```

## Forklaring af output syntaks
```hcl
value = azurerm_public_ip.example.ip_address
#       ^               ^       ^
#       ressource type  navn    attribut
```
- `azurerm_public_ip` — ressource typen
- `example` — det navn du gav ressourcen i Terraform koden
- `ip_address` — den specifikke attribut du vil have fat i

## Læringspointer
- Brug altid static public IP når du skal SSH ind på en VM — ellers skifter adressen
- Outputs er en god måde at eksponere vigtige værdier uden at skulle gå i portalen
- `terraform output` kan bruges til at se outputs igen uden at køre apply
