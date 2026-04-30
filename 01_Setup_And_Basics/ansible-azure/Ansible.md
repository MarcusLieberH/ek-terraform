# Ansible Setup

## Hvad gik det ud på?
Udvidede Terraform projektet med Ansible til automatisk konfiguration af VM'en efter den er oprettet. Kombinationen af Terraform + Ansible betyder at én kommando opretter og konfigurerer en komplet server.

## Nye filer der blev tilføjet
| Fil | Formål |
|---|---|
| `ansible-azure/deploy.sh` | Kører Terraform + Ansible automatisk |
| `ansible-azure/destroy.sh` | Sletter al infrastruktur |
| `ansible-azure/inventory.ini` | Genereres automatisk af Terraform med VM's IP |
| `ansible-azure/playbook.yml` | Beskriver hvad Ansible installerer på VM'en |

## Ændringer i eksisterende filer
| Fil | Hvad blev ændret |
|---|---|
| `main.tf` | Tilføjet `local_file` ressource der skriver inventory.ini automatisk |
| `main.tf` | Tilføjet HTTP firewall regel på port 80 |
| `outputs.tf` | Tilføjet SSH kommando output |

## Software der installeres på VM'en
| Software | Formål |
|---|---|
| nginx | Webserver — tilgængelig i browser på port 80 |
| fail2ban | Blokerer IP'er der forsøger brute force SSH |
| git | Versionsstyring |
| Docker | Container runtime |
| UFW | Firewall direkte på VM'en (port 22, 80, 443) |

## Terraform + Ansible — hvorfor begge?
| Terraform | Ansible |
|---|---|
| Opretter infrastruktur | Konfigurerer hvad der kører |
| VM, netværk, firewall | nginx, Docker, fail2ban |
| "Byg serveren" | "Sæt serveren op" |

## Krav
- Terraform installeret i WSL/Linux
- Ansible installeret i WSL/Linux (`sudo apt install ansible -y`)
- Azure CLI installeret og logget ind (`az login`)
- sshpass installeret (`sudo apt install sshpass -y`)

## Deploy
```bash
./deploy.sh
```

Scriptet gør automatisk:
1. `terraform init` — downloader providers
2. `terraform apply` — opretter VM og infrastruktur
3. `inventory.ini` opdateres automatisk med den nye IP
4. Venter 30 sekunder på at VM er klar til SSH
5. `ansible-playbook` — installerer alt software på VM'en

Output:
```
✅ Done!
IP: 20.203.134.122
SSH: ssh azureuser@20.203.134.122
🌐 Nginx: http://20.203.134.122
```

## Destroy
```bash
./destroy.sh
```

Sletter al infrastruktur i Azure — husk dette når du er færdig så du ikke bruger credits unødigt.
