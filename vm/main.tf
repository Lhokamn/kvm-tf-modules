terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

variable "name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vcpu" {
  description = "Number of virtual CPUs"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of RAM in megabytes"
  type        = number
  default     = 2048
}

variable "volumes" {
  description = "List of disk volume IDs to attach"
  type        = list(string)
}

variable "cloudinit_id" {
  description = "ID of the cloud-init ISO disk"
  type        = string
  default     = null
}

variable "networks" {
  description = "List of network IDs to attach to the VM"
  type        = list(string)
  default     = []
}

variable "autostart" {
  description = "Whether to autostart the VM with the host"
  type        = bool
  default     = false
}

variable "graphics_enabled" {
  description = "Enable VNC graphics console (true/false)"
  type        = bool
  default     = true
}

resource "libvirt_domain" "this" {
  name   = var.name
  vcpu   = var.vcpu
  memory = var.memory

  dynamic "disk" {
    for_each = var.volumes
    content {
      volume_id = disk.value
    }
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
  description = "ID of the created VM"
  value       = libvirt_domain.this.id
}
