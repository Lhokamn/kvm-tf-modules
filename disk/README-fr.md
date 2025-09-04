
---

## 📄 `modules/disk/README-fr.md` (🇫🇷 Version française)

```markdown
# Module `disk`

Ce module permet de créer un **volume libvirt** en clonant une image de base existante (`base_volume`).  
Il est généralement utilisé pour créer le disque principal d'une machine virtuelle.

## 📦 Entrées

| Variable         | Type     | Description                                                     | Obligatoire |
|------------------|----------|------------------------------------------------------------------|-------------|
| `name`           | `string` | Nom du disque à créer                                            | ✅          |
| `pool`           | `string` | Nom du pool de stockage Libvirt (défaut : `default`)             | ❌          |
| `base_volume_id` | `string` | ID de l’image de base à cloner                                   | ✅          |
| `size`           | `number` | Taille du disque en **gigaoctets**                               | ✅          |

## 📤 Sorties

| Nom  | Description                      |
|------|----------------------------------|
| `id` | ID du volume créé dans Libvirt   |

## 🧪 Exemple d’utilisation

```hcl
module "ubuntu_disk" {
  source         = "git::https://github.com/Lhokamn/kvm-tf-modules.git//disk?ref=main"
  name           = "ubuntu24-disk.qcow2"
  base_volume_id = module.ubuntu_image.id
  size           = 32
}
```