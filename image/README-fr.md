
# Module `image`

Ce module Terraform télécharge et enregistre une image dans un **pool de stockage Libvirt**.  
Il est généralement utilisé pour importer une image `.qcow2` ou `.img` prête à l'emploi (type cloud-init).

## 📦 Entrées

| Variable     | Type     | Description                                                          | Obligatoire |
|--------------|----------|----------------------------------------------------------------------|-------------|
| `name`       | `string` | Nom du volume à créer dans le pool                                   | ✅          |
| `pool`       | `string` | Nom du pool de stockage Libvirt (défaut : `default`)                 | ❌          |
| `source_url` | `string` | URL distante de l’image (doit être accessible depuis la machine hôte) | ✅          |
| `format`     | `string` | Format du volume (`qcow2`, `raw`, etc.) (défaut : `qcow2`)           | ❌          |

## 📤 Sorties

| Nom  | Description                    |
|------|--------------------------------|
| `id` | ID du volume image créé        |

## 🧪 Exemple d’utilisation

```hcl
module "ubuntu_image" {
  source     = "git::https://github.com/Lhokamn/kvm-tf-modules.git//image?ref=main"
  name       = "ubuntu24-base.qcow2"
  source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}
```