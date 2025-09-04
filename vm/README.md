# `vm` module

This module creates a **KVM/QEMU virtual machine** using Libvirt, with support for:
- Disk attachment
- Cloud-init ISO
- Multiple networks
- Optional graphics (VNC)
- Autostart on host boot

## 📥 Inputs

| Variable           | Type           | Description                                       | Default   | Required |
|--------------------|----------------|---------------------------------------------------|-----------|----------|
| `name`             | `string`       | Name of the VM                                    |           | ✅       |
| `vcpu`             | `number`       | Number of vCPUs                                   | `2`       | ❌       |
| `memory`           | `number`       | RAM in MB                                         | `2048`    | ❌       |
| `volume_id`        | `string`       | ID of the main disk volume                        |           | ✅       |
| `cloudinit_id`     | `string`       | ID of the cloud-init ISO                          | `null`    | ❌       |
| `networks`         | `list(string)` | List of `network_id` values to attach             | `[]`      | ❌       |
| `autostart`        | `bool`         | Whether the VM starts automatically with the host | `false`   | ❌       |
| `graphics_enabled` | `bool`         | Enable the VNC graphics console                   | `true`    | ❌       |

## 📤 Output

| Name  | Description      |
|-------|------------------|
| `id`  | ID of the domain |

## 🧪 Example usage

```hcl
module "ubuntu_vm" {
  source        = "git::https://github.com/Lhokamn/kvm-tf-modules.git//vm?ref=main"
  name          = "ubuntu-vm"
  vcpu          = 4
  memory        = 8192
  volume_id     = module.ubuntu_disk.id
  cloudinit_id  = module.ubuntu_cloudinit.id
  networks      = [module.nat_network.network_id, module.isolated_network.network_id]
  autostart     = true
  graphics_enabled = true
}
```