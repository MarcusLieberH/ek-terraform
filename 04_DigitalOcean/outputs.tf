output "droplet_ip" {
  value = digitalocean_droplet.main.ipv4_address
}

output "ssh_command" {
  value = "ssh root@${digitalocean_droplet.main.ipv4_address}"
}