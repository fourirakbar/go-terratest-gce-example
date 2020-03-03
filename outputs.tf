output "instance_name" {
  value       = google_compute_instance.example-compute-instance[0].name
  description = "Name of instance in GCE"
}

output "public_ip" {
  value       = google_compute_instance.example-compute-instance[0].network_interface[0].access_config[0].nat_ip
  description = "Public IP of instance in GCE"
}

output "rrdatas" {
  value = formatlist("%s.c.%s.internal.", google_compute_instance.example-compute-instance.*.name, var.project)
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
