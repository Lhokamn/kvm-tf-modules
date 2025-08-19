data "template_file" "data" {
  template = var.cloudinit_template
  vars = {
    ssh_public_key = var.ssh_public_key
  }
}