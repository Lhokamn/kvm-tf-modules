terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable "name" {
  description = "Name of the image volume to be created"
  type        = string
}

variable "pool" {
  description = "Name of the libvirt storage pool"
  type        = string
  default     = "default"
}

variable "source_url" {
  description = "Remote URL of the image to download (e.g. qcow2)"
  type        = string
}

variable "format" {
  description = "Format of the volume (e.g. qcow2, raw)"
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
  description = "ID of the created image volume"
  value       = libvirt_volume.this.id
}
