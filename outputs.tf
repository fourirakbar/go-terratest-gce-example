output "rrdatas" {
  value = formatlist("%s.c.%s.internal.", google_compute_instance.tiket-compute-instance.*.name, var.project)
}

output "environment" {
  value = var.environment
}

output "service_type" {
  value = var.service_type
}

output "service_group" {
  value = var.service_group
}

output "host_target" {
  value = var.host_target
}
