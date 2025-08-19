resource "libvirt_volume" "image" {
  name   = var.image_name
  pool   = var.libvirt_pool_name
  source = var.image_url
  format = "qcow2"
}