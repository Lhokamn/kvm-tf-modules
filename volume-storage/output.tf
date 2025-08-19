output "volume_id" {
  value = libvirt_volume.storage.id
}

output "volume_name"{
    value = libvirt_volume.storage.name
}