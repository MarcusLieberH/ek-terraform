terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "main" {
  name = "Stationær Pc"
}

resource "digitalocean_droplet" "main" {
  name     = var.droplet_name
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-22-04-x64"
  ssh_keys = [data.digitalocean_ssh_key.main.id]
}