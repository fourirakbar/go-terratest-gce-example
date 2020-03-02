variable "node_count" {
  default     = 1
  description = "Count of node to create"
}

variable "project" {
  description = "Project id to create the node on"
}

variable "shared_project" {
  description = "Location of shared project"
}

variable "instance_name" {
  description = "Instance name identifier, so everyone can recognise it easily"
}

variable "machine_type" {
  description = "Machine type of instance"
}

variable "zones" {
  type        = "list"
  description = "GCP zone to rollout the image"
}

variable "ip_forward" {
  description = "Enable or disable ip_forward"
  default     = false
}

variable "image_name" {
  description = "Name of base image to be reolled out for instance"
}

variable "disk_type" {
  description = "Disk type for root instance"
  default     = "pd-standard"
}

variable "disk_size" {
  description = "Disk size for root instance in GB"
  default     = "25"
}

variable "subnetwork" {
  description = "Subnetwork where VPC and networking related project run"
}

variable "subnetwork_project" {
  description = "ProjectID where the networking related resource running"
}

variable "environment" {
  description = "Identifier for environment, use for label and tag"
  default     = "dev"
}

variable "service_group" {
  description = "Identifier for service group, use for label and tag"
  default     = "terratest"
}

variable "service_type" {
  description = "Identifier for service type, use for label and tag"
  default     = "test"
}

variable "host_target" {
  description = "Identifier for host target (currently we use value of squad name), use for label and tag"
  default     = "devops"
}
