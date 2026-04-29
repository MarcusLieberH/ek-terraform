# 04 - DigitalOcean Droplet

## Hvad gik det ud på?
Oprettede en DigitalOcean Droplet (VM) med Terraform som alternativ til Azure. Demonstrerer at Terraform virker på tværs af cloud providers med samme struktur og kommandoer.

## Infrastruktur der blev oprettet
| Ressource | Detaljer |
|---|---|
| Droplet | Ubuntu 22.04, 1 vCPU, 1GB RAM |
| Region | Amsterdam 3 (ams3) |
| SSH Key | Hentet fra DigitalOcean via `data` blok |

## Forskel fra Azure
Terraform strukturen er den samme — kun provider og resource navne er anderledes:

| Azure | DigitalOcean |
|---|---|
| `azurerm` | `digitalocean` |
| `azurerm_linux_virtual_machine` | `digitalocean_droplet` |
| `azurerm_resource_group` | Ikke nødvendigt |
| `azurerm_network_security_group` | `digitalocean_firewall` |

DigitalOcean er simplere — ingen resource group, virtual network eller NIC. En droplet er klar med få linjer.

## SSH Key setup
DigitalOcean bruger SSH key authentication som standard — ingen passwords. SSH key hentes fra DigitalOcean via en `data` blok:

```hcl
data "digitalocean_ssh_key" "main" {
  name = "navn_på_dit_key_i_DO"
}

resource "digitalocean_droplet" "main" {
  name     = var.droplet_name
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  ssh_keys = [data.digitalocean_ssh_key.main.id]
}
```

> ⚠️ SSH key'et i DigitalOcean skal matche dit lokale key (`~/.ssh/id_ed25519.pub`)

## API Token
Terraform autentificerer mod DigitalOcean via et API token genereret under **Settings → API → Generate New Token**.

Token sættes i `terraform.tfvars` som aldrig committes til git:
```hcl
do_token     = "dit_token_her"
droplet_name = "main-droplet"
```

## Outputs
Efter `terraform apply` vises:
```
droplet_ip  = "164.92.150.251"
ssh_command = "ssh root@164.92.150.251"
```

## Vigtige kommandoer
```bash
terraform init      # Download DigitalOcean provider
terraform plan      # Preview
terraform apply     # Opret droplet
terraform destroy   # Slet droplet (vigtigt for at spare credits!)
```

## Læringspointer
- Terraform virker med næsten alle cloud providers — Azure, AWS, GCP, DigitalOcean, Hetzner osv.
- Strukturen er altid den samme: provider blok → resource blokke → outputs
- DigitalOcean er simplere end Azure — færre ressourcer kræves for en kørende VM
- Husk `terraform destroy` når du er færdig så du ikke bruger credits unødigt
