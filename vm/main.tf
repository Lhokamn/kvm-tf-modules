terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable "name" {
  description = "Nom de la VM"
  type        = string
}

variable "vcpu" {
  description = "Nombre de vCPUs"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Mémoire en Mo"
  type        = number
  default     = 2048
}

variable "volume_id" {
  description = "ID du volume disque principal"
  type        = string
}

variable "cloudinit_id" {
  description = "ID du disque cloud-init"
  type        = string
  default     = null
}

variable "networks" {
  description = "Liste des network_ids à attacher"
  type        = list(string)
  default     = []
}

variable "autostart" {
  description = "Démarrage automatique de la VM"
  type        = bool
  default     = false
}

variable "graphics_enabled" {
  description = "Activer la console VNC (true/false)"
  type        = bool
  default     = true
}

resource "libvirt_domain" "this" {
  name   = var.name
  vcpu   = var.vcpu
  memory = var.memory

  disk {
    volume_id = var.volume_id
  }

  cloudinit = var.cloudinit_id


  dynamic "network_interface" {
    for_each = var.networks
    content {
      network_id     = network_interface.value
      wait_for_lease = false
    }
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  dynamic "graphics" {
    for_each = var.graphics_enabled ? [1] : []
    content {
      type        = "vnc"
      listen_type = "address"
      autoport    = true
    }
  }

  autostart = var.autostart
}

output "id" {
  description = "ID de la VM"
  value       = libvirt_domain.this.id
}
