# Module `cloudinit`

Ce module permet de créer un **disque ISO cloud-init** pour des machines virtuelles utilisant `libvirt_domain`.

Il injecte :
- un fichier **user-data**, rendu à partir d’un template contenant ta clé SSH
- un fichier de **configuration réseau**, généralement au format netplan YAML

## 📦 Entrées

| Variable               | Type     | Description                                                     | Obligatoire |
|------------------------|----------|------------------------------------------------------------------|-------------|
| `name`                 | `string` | Nom du disque cloud-init (ex: `ubuntu-cloudinit.iso`)            | ✅          |
| `ssh_key`              | `string` | Contenu de la clé publique SSH à injecter                        | ✅          |
| `user_data_template`   | `string` | Chemin vers le template `user-data` cloud-init                   | ✅          |
| `network_config_file`  | `string` | Chemin vers le fichier YAML de configuration réseau (netplan)    | ✅          |
| `pool`                 | `string` | Pool de stockage Libvirt dans lequel créer le disque (défaut: `default`) | ❌          |

## 📤 Sorties

| Nom  | Description                        |
|------|------------------------------------|
| `id` | ID du disque cloud-init généré     |

## 🧪 Exemple d’utilisation

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
