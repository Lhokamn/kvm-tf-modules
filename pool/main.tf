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

variable "name" {
  description = "Nom du pool libvirt"
  type        = string
}

variable "type" {
  description = "Type du pool (ex: dir, logical, zfs, netfs...)"
  type        = string
  default     = "dir"
}

variable "path" {
  description = "Chemin sur le disque pour le pool (obligatoire pour type = dir)"
  type        = string
}

resource "libvirt_pool" "this" {
  name = var.name
  type = var.type
  path = var.path
}

output "name" {
  value       = libvirt_pool.this.name
  description = "Nom du pool créé"
}

output "id" {
  value       = libvirt_pool.this.id
  description = "ID du pool"
}
