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
