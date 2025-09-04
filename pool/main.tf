terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable "name" {
  description = "Name of the libvirt pool"
  type        = string
}

variable "type" {
  description = "Type of the pool (e.g., dir, logical, zfs, netfs, etc.)"
  type        = string
  default     = "dir"
}

variable "path" {
  description = "Filesystem path for the pool (mandatory for type = dir)"
  type        = string
}

resource "libvirt_pool" "this" {
  name = var.name
  type = var.type
  path = var.path
}

output "name" {
  description = "Name of the created libvirt pool"
  value       = libvirt_pool.this.name
}

output "id" {
  description = "ID of the created libvirt pool"
  value       = libvirt_pool.this.id
}
