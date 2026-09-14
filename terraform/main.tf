variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "ssh_key" {
  description = "Fingerprint or ID of an SSH key already uploaded to DigitalOcean"
  type        = string
}

terraform {
  required_version = ">= 1.7.0"

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

resource "digitalocean_droplet" "mern_todo" {
  name     = "mern-todo-vps"
  region   = "sgp1"
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-24-04-x64"
  ssh_keys = [var.ssh_key]
}

output "droplet_ip" {
  description = "Public IP used by Ansible"
  value       = digitalocean_droplet.mern_todo.ipv4_address
}
