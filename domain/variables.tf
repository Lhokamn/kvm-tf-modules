variable "vm_name" {
  type = string
}

variable "memory" {
  type = number
}

variable "vcpu" {
  type = number
}

variable "storage_volume_id" {
  type = string
}

variable "cloudinit_id" {
  type = string
}

variable "network_mgmt_id" {
  type = string
}

variable "network_provider_id" {
  type = string
}