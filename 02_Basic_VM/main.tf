terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}




resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
}

output "random_string" {
  value = random_string.name.result
}