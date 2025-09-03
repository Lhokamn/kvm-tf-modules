terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  domain = "${var.name}.net" 
}

resource "libvirt_network" "this" {
  name      = var.name
  mode      = var.mode
  domain    = local.domain
  addresses = var.addresses

  dhcp {
    enabled = var.dhcp_enabled
  }

  autostart = var.autostart
}


variable "name" {
  description = "Nom du réseau"
  type        = string
}

variable "mode" {
  description = "Mode du réseau (nat, isolated, etc.)"
  type        = string
  default     = "nat"
}

variable "addresses" {
  description = "Liste des plages d'adresses"
  type        = list(string)
}

variable "dhcp_enabled" {
  description = "Activer DHCP"
  type        = bool
  default     = true
}

variable "autostart" {
  description = "Démarrage automatique"
  type        = bool
  default     = true
}

output "network_id" {
  value = libvirt_network.this.id
}
