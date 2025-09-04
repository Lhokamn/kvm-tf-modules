# `disk` module

This module creates a **libvirt volume** by cloning an existing base image volume. It is commonly used to prepare the root disk of a virtual machine.

## 📦 Inputs

| Variable         | Type     | Description                                                | Required |
|------------------|----------|------------------------------------------------------------|----------|
| `name`           | `string` | Name of the new disk volume                                | ✅       |
| `pool`           | `string` | Name of the libvirt storage pool (default: `default`)      | ❌       |
| `base_volume_id` | `string` | ID of the base image volume to clone                       | ✅       |
| `size`           | `number` | Size of the new disk in **gigabytes**                      | ✅       |

## 📤 Output

| Name | Description                        |
|------|------------------------------------|
| `id` | ID of the created libvirt volume   |

## 🧪 Example usage

```hcl
module "ubuntu_disk" {
  source         = "git::https://github.com/Lhokamn/kvm-tf-modules.git//disk?ref=main"
  name           = "ubuntu24-disk.qcow2"
  base_volume_id = module.ubuntu_image.id
  size           = 32
}
```