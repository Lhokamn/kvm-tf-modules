# Module `network`

Ce module permet de créer un **réseau virtuel Libvirt**, en mode NAT ou isolé, avec ou sans DHCP.

## 📦 Variables d’entrée

| Variable       | Type           | Description                                                    | Défaut   | Obligatoire |
|----------------|----------------|----------------------------------------------------------------|----------|-------------|
| `name`         | `string`       | Nom du réseau                                                  |          | ✅          |
| `mode`         | `string`       | Mode du réseau (`nat`, `isolated`, etc.)                       | `"nat"`  | ❌          |
| `addresses`    | `list(string)` | Liste des plages d’adresses au format CIDR                     |          | ✅          |
| `dhcp_enabled` | `bool`         | Active ou désactive le DHCP sur le réseau                      | `true`   | ❌          |
| `autostart`    | `bool`         | Lance le réseau automatiquement au démarrage de l’hôte        | `true`   | ❌          |

## 📤 Sortie

| Nom         | Description                          |
|-------------|--------------------------------------|
| `network_id` | ID du réseau Libvirt généré         |

## 🧪 Exemple d’utilisation

```hcl
module "isolated_network" {
  source       = "git::https://github.com/Lhokamn/kvm-tf-modules.git//network?ref=main"
  name         = "isolated-network"
  mode         = "none"
  addresses    = ["192.168.10.0/24"]
  dhcp_enabled = false
}
```