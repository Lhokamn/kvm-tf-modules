resource "libvirt_domain" "vm" {
  name   = var.vm_name
  memory = var.memory
  vcpu   = var.vcpu

  disk {
    volume_id = var.storage_volume_id
  }

  cloudinit = var.cloudinit_id

  network_interface {
    network_id = var.network_mgmt_id
  }

  network_interface {
    network_id = var.network_provider_id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type       = "vnc"
    listen_type = "address"
    autoport   = true
  }
}
