# `network` module

This module creates a **Libvirt virtual network**, supporting NAT or isolated modes, with optional DHCP.

## 📦 Inputs

| Variable       | Type         | Description                                                  | Default   | Required |
|----------------|--------------|--------------------------------------------------------------|-----------|----------|
| `name`         | `string`     | Name of the network                                           |           | ✅       |
| `mode`         | `string`     | Network mode (`nat`, `isolated`, etc.)                       | `"nat"`   | ❌       |
| `addresses`    | `list(string)` | List of address ranges in CIDR format                      |           | ✅       |
| `dhcp_enabled` | `bool`       | Whether to enable DHCP                                       | `true`    | ❌       |
| `autostart`    | `bool`       | Whether the network autostarts with the host                 | `true`    | ❌       |

## 📤 Output

| Name        | Description                      |
|-------------|----------------------------------|
| `network_id` | ID of the created libvirt network |

## 🧪 Example usage

```hcl
module "isolated_network" {
  source       = "git::https://github.com/Lhokamn/kvm-tf-modules.git//network?ref=main"
  name         = "isolated-network"
  mode         = "none"
  addresses    = ["192.168.10.0/24"]
  dhcp_enabled = false
}
```