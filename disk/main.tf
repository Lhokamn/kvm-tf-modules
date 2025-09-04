terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable "name" {
  description = "Name of the volume to be created"
  type        = string
}

variable "pool" {
  description = "Name of the libvirt storage pool"
  type        = string
  default     = "default"
}

variable "base_volume_id" {
  description = "ID of the base image volume used as a source"
  type        = string
}

variable "size" {
  description = "Size of the new volume (in gigabytes)"
  type        = number
}

locals {
  size = var.size * 1024 * 1024 * 1024
}

resource "libvirt_volume" "this" {
  name           = var.name
  pool           = var.pool
  base_volume_id = var.base_volume_id
  size           = local.size
}

output "id" {
  description = "ID of the created libvirt volume"
  value       = libvirt_volume.this.id
}
