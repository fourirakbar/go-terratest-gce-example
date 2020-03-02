resource "google_compute_instance" "tiket-compute-instance" {
  count          = var.node_count
  project        = var.project
  name           = "vm-${var.project}-${var.instance_name}-${count.index + 1}"
  machine_type   = var.machine_type
  zone           = var.zones[count.index]
  can_ip_forward = var.ip_forward

  boot_disk {
    initialize_params {
      image = "projects/${var.shared_project}/global/images/${var.image_name}"
      size  = var.disk_size
      type  = var.disk_type
    }
  }

  lifecycle {
    ignore_changes = [
      "attached_disk",
    ]
  }

  network_interface {
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
  }

  labels = {
    environment   = var.environment
    service_group = var.service_group
    service_type  = var.service_type
    host_target   = var.host_target
    name          = "vm-${var.project}-${var.instance_name}-${count.index + 1}"
    created_by    = "terraform"
  }

  tags = [var.environment, var.service_group, var.service_type, "vm-${var.project}-${var.instance_name}-${count.index + 1}", "terraform"]

  allow_stopping_for_update = true
}
