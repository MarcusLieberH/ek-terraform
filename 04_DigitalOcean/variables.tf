variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "droplet_name" {
  description = "Navn på droplet"
  type        = string
  default     = "main-droplet"
}