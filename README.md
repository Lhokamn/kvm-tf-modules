# kvm-tf-modules
Store terraform modules link to KVM

# source Link

- network : ``git::https://github.com/Lhokamn/kvm-tf-modules.git//network?ref=main``

# How to use module

In your root file you need to add this provider
```tf
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
```