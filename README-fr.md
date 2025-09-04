# 🧱 Modules Terraform pour KVM avec Libvirt

Composants **Terraform réutilisables et modulaires** permettant de créer, gérer et provisionner des **machines virtuelles KVM** à l’aide du provider `libvirt`.

> Créé avec ❤️ par [@Lhokamn](https://github.com/Lhokamn)

---

## 🧰 Modules disponibles

| Module      | Description |
|-------------|-------------|
| `network`   | Crée un réseau libvirt (NAT, isolé, etc.) |
| `pool`      | Déclare un pool de stockage libvirt |
| `image`     | Télécharge une image de base (ex : Ubuntu, Debian) |
| `disk`      | Crée un disque VM basé sur une image |
| `cloudinit` | Génère un ISO cloud-init à partir des fichiers user-data et network-data |
| `vm`        | Crée une machine virtuelle avec libvirt |

---

## 🚀 Exemple : Infrastructure complète

Cet exemple montre comment utiliser tous les modules ensemble pour déployer une machine virtuelle Ubuntu complète avec :

- Réseau NAT
- Pool de stockage personnalisé
- Image distante téléchargée
- Overlay disque
- Configuration cloud-init
- VM avec 4 vCPU et 8 Go de RAM

```hcl
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

module "nat_network" {
  source       = "git::https://github.com/Lhokamn/kvm-tf-modules.git//network?ref=main"
  providers    = { libvirt = libvirt }
  name         = "nat-network"
  mode         = "nat"
  addresses    = ["10.0.2.0/24"]
  dhcp_enabled = true
}

module "default_pool" {
  source    = "git::https://github.com/Lhokamn/kvm-tf-modules.git//pool?ref=main"
  providers = { libvirt = libvirt }
  name      = "prout"
  path      = "/tmp/images"
}

module "ubuntu_image" {
  source     = "git::https://github.com/Lhokamn/kvm-tf-modules.git//image?ref=main"
  providers  = { libvirt = libvirt }
  name       = "ubuntu24-base.qcow2"
  source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

module "ubuntu_disk" {
  source         = "git::https://github.com/Lhokamn/kvm-tf-modules.git//disk?ref=main"
  providers      = { libvirt = libvirt }
  name           = "ubuntu24-disk.qcow2"
  base_volume_id = module.ubuntu_image.id
  size           = 32

  depends_on = [module.ubuntu_image]
}

module "ubuntu_cloudinit" {
  source              = "git::https://github.com/Lhokamn/kvm-tf-modules.git//cloudinit?ref=main"
  providers           = { libvirt = libvirt }
  name                = "ubuntu24-cloudinit.iso"
  ssh_key             = file("~/.ssh/dev_key.pub")
  user_data_template  = "${path.module}/cloudinit/ubuntu-user-data.cfg"
  network_config_file = "${path.module}/cloudinit/ubuntu-net-data.cfg"

  depends_on = [module.ubuntu_disk]
}

module "ubuntu_vm" {
  source        = "git::https://github.com/Lhokamn/kvm-tf-modules.git//vm?ref=main"
  providers     = { libvirt = libvirt }
  name          = "ubuntu-vm"
  vcpu          = 4
  memory        = 8192
  volume_id     = module.ubuntu_disk.id
  cloudinit_id  = module.ubuntu_cloudinit.id
  networks      = [module.nat_network.network_id]
  depends_on    = [
    module.ubuntu_cloudinit,
    module.ubuntu_disk,
    module.ubuntu_image
  ]
}
```

# 📂 Structure des dossiers

```bash
.
├── network/       # Définition des réseaux
├── pool/          # Définition des pools de stockage
├── image/         # Téléchargement des images distantes
├── disk/          # Création de disques persistants
├── cloudinit/     # Génération d'ISO cloud-init
├── vm/            # Création de la VM finale
└── README.md      # Vous êtes ici !
```

# ☕ Soutenez mon travail
Si vous trouvez ce projet utile, vous pouvez me soutenir ici :

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/E1E61C7LNR)
