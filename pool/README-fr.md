# Module `pool`

Ce module crée un **pool de stockage Libvirt**, généralement de type `dir` pour stocker des volumes (images, disques, etc.).

## 📦 Variables d’entrée

| Variable | Type     | Description                                                              | Défaut | Obligatoire |
|----------|----------|--------------------------------------------------------------------------|--------|-------------|
| `name`   | `string` | Nom du pool de stockage                                                  |        | ✅          |
| `type`   | `string` | Type du pool (`dir`, `logical`, `zfs`, `netfs`, etc.)                    | `dir`  | ❌          |
| `path`   | `string` | Chemin sur le système de fichiers hôte (obligatoire pour `type = dir`)   |        | ✅          |

## 📤 Sorties

| Nom   | Description                      |
|--------|----------------------------------|
| `name` | Nom du pool créé                 |
| `id`   | ID du pool créé                  |

## 🧪 Exemple d’utilisation

```hcl
module "default_pool" {
  source = "git::https://github.com/Lhokamn/kvm-tf-modules.git//pool?ref=main"
  name   = "default"
  path   = "/var/lib/libvirt/images"
}
```