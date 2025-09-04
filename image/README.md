# `image` module

This Terraform module downloads and registers an image in your **Libvirt** storage pool.  
It is typically used to import a base image like a cloud-ready `.qcow2` or `.img` file.

## 📦 Inputs

| Variable     | Type     | Description                                                   | Required |
|--------------|----------|---------------------------------------------------------------|----------|
| `name`       | `string` | Name of the volume to be created in the pool                  | ✅       |
| `pool`       | `string` | Name of the libvirt storage pool (default: `default`)         | ❌       |
| `source_url` | `string` | Remote URL to the image (must be accessible from the host)    | ✅       |
| `format`     | `string` | Volume format (`qcow2`, `raw`, etc.) (default: `qcow2`)       | ❌       |

## 📤 Output

| Name | Description                        |
|------|------------------------------------|
| `id` | ID of the created image volume     |

## 🧪 Example usage

```hcl
module "ubuntu_image" {
  source     = "git::https://github.com/Lhokamn/kvm-tf-modules.git//image?ref=main"
  name       = "ubuntu24-base.qcow2"
  source_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}
```