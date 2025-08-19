output "user_data" {
  value = data.template_file.data.rendered
}