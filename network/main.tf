terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
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
  description = "Name of the network"
  type        = string
}

variable "mode" {
  description = "Mode of the network (e.g., nat, isolated)"
  type        = string
  default     = "nat"
}

variable "addresses" {
  description = "List of address ranges (CIDR format)"
  type        = list(string)
}

variable "dhcp_enabled" {
  description = "Enable DHCP on the network"
  type        = bool
  default     = true
}

variable "autostart" {
  description = "Start the network automatically on host boot"
  type        = bool
  default     = true
}

output "network_id" {
  description = "ID of the created libvirt network"
  value       = libvirt_network.this.id
}
