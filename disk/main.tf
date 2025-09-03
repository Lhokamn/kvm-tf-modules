terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}


variable "name" {
  description = "Nom du disque à créer"
  type        = string
}

variable "pool" {
  description = "Nom du pool libvirt"
  type        = string
  default     = "default"
}

variable "base_volume_id" {
  description = "ID de l'image source utilisée comme base"
  type        = string
}

variable "size" {
  description = "Taille du disque en octets"
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
  description = "ID du disque créé"
  value       = libvirt_volume.this.id
}
