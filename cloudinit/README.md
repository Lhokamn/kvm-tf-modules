# `cloudinit` module

This module creates a **cloud-init ISO disk** for use with `libvirt_domain` virtual machines.

It injects:
- a **user-data** file, rendered from a template and your SSH key
- a **network configuration file**, typically in netplan YAML format

## 📦 Inputs

| Variable               | Type     | Description                                                   | Required |
|------------------------|----------|---------------------------------------------------------------|----------|
| `name`                 | `string` | Name of the cloud-init disk (e.g. `ubuntu-cloudinit.iso`)     | ✅       |
| `ssh_key`              | `string` | Content of the public SSH key to inject                       | ✅       |
| `user_data_template`   | `string` | Path to your `user-data` cloud-init template                  | ✅       |
| `network_config_file`  | `string` | Path to the YAML file used to configure network (e.g. netplan)| ✅       |
| `pool`                 | `string` | Libvirt storage pool to create the disk in (default: `default`)| ❌       |

## 📤 Output

| Name | Description                       |
|------|-----------------------------------|
| `id` | ID of the generated cloud-init disk |

## 🧪 Example usage

```hcl
module "ubuntu_cloudinit" {
  source               = "git::https://github.com/Lhokamn/kvm-tf-modules.git//cloudinit?ref=main"
  name                 = "ubuntu24-cloudinit.iso"
  ssh_key              = file("~/.ssh/dev_key.pub")
  user_data_template   = "${path.module}/cloudinit/ubuntu-user-data.cfg"
  network_config_file  = "${path.module}/cloudinit/ubuntu-net-data.cfg"

  providers = {
    libvirt  = libvirt
    template = template
  }
}
```