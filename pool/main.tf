resource "libvirt_pool" "default" {
  name = "default"
  type = "dir"
  path = var.libvirt_path
}
