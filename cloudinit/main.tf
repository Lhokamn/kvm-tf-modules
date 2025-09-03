terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable "name" {
  description = "Nom du disque cloud-init (ex: debian-cloudinit.iso)"
  type        = string
}

variable "ssh_key" {
  description = "Contenu de la clé publique SSH à injecter"
  type        = string
}

variable "user_data_template" {
  description = "Chemin vers le template user-data (cloud-init)"
  type        = string
}

variable "network_config_file" {
  description = "Chemin vers le fichier de configuration réseau (cloud-init)"
  type        = string
}

variable "pool" {
  description = "Nom du pool Libvirt pour stocker le disque"
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
  description = "ID du disque cloud-init généré"
  value       = libvirt_cloudinit_disk.this.id
}
