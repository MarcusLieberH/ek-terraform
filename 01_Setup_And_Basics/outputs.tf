output "public_ip_address" {
  value = azurerm_public_ip.static-public-ip-example.ip_address
}

output "ssh_command" {
  value = "ssh ${var.vm_username}@${azurerm_public_ip.static-public-ip-example.ip_address}"
}