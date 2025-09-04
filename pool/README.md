# `pool` module

This module creates a **Libvirt storage pool**, typically of type `dir` to store volumes (images, disks, etc.).

## 📦 Inputs

| Variable | Type     | Description                                                    | Default | Required |
|----------|----------|----------------------------------------------------------------|---------|----------|
| `name`   | `string` | Name of the storage pool                                       |         | ✅       |
| `type`   | `string` | Type of pool (`dir`, `logical`, `zfs`, `netfs`, etc.)          | `dir`   | ❌       |
| `path`   | `string` | Path on the host filesystem (required for type `dir`)          |         | ✅       |

## 📤 Outputs

| Name  | Description                        |
|-------|------------------------------------|
| `name` | Name of the created libvirt pool   |
| `id`   | ID of the created libvirt pool     |

## 🧪 Example usage

```hcl
module "default_pool" {
  source = "git::https://github.com/Lhokamn/kvm-tf-modules.git//pool?ref=main"
  name   = "default"
  path   = "/var/lib/libvirt/images"
}
```