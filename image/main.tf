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

variable "name" {
  description = "Nom de l'image (volume téléchargé)"
  type        = string
}

variable "pool" {
  description = "Nom du pool libvirt"
  type        = string
  default     = "default"
}

variable "source_url" {
  description = "URL distante de l'image (qcow2)"
  type        = string
}

variable "format" {
  description = "Format du volume (qcow2, raw, etc.)"
  type        = string
  default     = "qcow2"
}

resource "libvirt_volume" "this" {
  name   = var.name
  pool   = var.pool
  source = var.source_url
  format = var.format
}

output "id" {
  value = libvirt_volume.this.id
}
