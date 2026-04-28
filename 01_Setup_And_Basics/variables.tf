variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default     = "main-vm"
}

variable "vm_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}