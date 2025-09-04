terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}

variable "name" {
  description = "Name of the cloud-init disk (e.g. debian-cloudinit.iso)"
  type        = string
}

variable "ssh_key" {
  description = "Content of the public SSH key to inject"
  type        = string
}

variable "user_data_template" {
  description = "Path to the user-data cloud-init template"
  type        = string
}

variable "network_config_file" {
  description = "Path to the network configuration file for cloud-init"
  type        = string
}

variable "pool" {
  description = "Libvirt pool where the cloud-init disk will be stored"
  type        = string
  default     = "default"
}

data "template_file" "user_data" {
  template = file(var.user_data_template)

  vars = {
    ssh_key = var.ssh_key
  }
}

resource "libvirt_cloudinit_disk" "this" {
  name           = var.name
  user_data      = data.template_file.user_data.rendered
  network_config = file(var.network_config_file)
  pool           = var.pool
}

output "id" {
  description = "ID of the generated cloud-init disk"
  value       = libvirt_cloudinit_disk.this.id
}
