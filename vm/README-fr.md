
---

## 📄 `modules/vm/README-fr.md` (🇫🇷 Français)

```markdown
# Module `vm`

Ce module crée une **machine virtuelle KVM/QEMU** via Libvirt avec :
- Disque principal
- Cloud-init ISO (facultatif)
- Connexion à un ou plusieurs réseaux
- Support de la console graphique VNC (facultatif)
- Démarrage automatique avec l'hôte (facultatif)

## 📥 Variables d’entrée

| Variable           | Type           | Description                                           | Défaut    | Obligatoire |
|--------------------|----------------|-------------------------------------------------------|-----------|-------------|
| `name`             | `string`       | Nom de la machine virtuelle                           |           | ✅          |
| `vcpu`             | `number`       | Nombre de CPU virtuels                                | `2`       | ❌          |
| `memory`           | `number`       | Mémoire en mégaoctets                                 | `2048`    | ❌          |
| `volume_id`        | `string`       | ID du volume disque principal                         |           | ✅          |
| `cloudinit_id`     | `string`       | ID du disque cloud-init (facultatif)                  | `null`    | ❌          |
| `networks`         | `list(string)` | Liste des `network_id` à connecter                    | `[]`      | ❌          |
| `autostart`        | `bool`         | Démarrage automatique de la VM avec l’hôte            | `false`   | ❌          |
| `graphics_enabled` | `bool`         | Active la console graphique VNC                       | `true`    | ❌          |

## 📤 Sortie

| Nom  | Description             |
|------|-------------------------|
| `id` | ID de la machine virtuelle créée |

## 🧪 Exemple d’utilisation

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