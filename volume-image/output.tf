output "volume_id" {
  value = libvirt_volume.image.id
}

output "volume_name" {
  value = libvirt_volume.image.name
}