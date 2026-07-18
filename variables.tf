variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for always-free resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone for the VM"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Minecraft VM name"
  type        = string
  default     = "minecraft-free"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB (always free includes up to 30GB standard persistent disk)"
  type        = number
  default     = 20
}

variable "minecraft_version" {
  description = "Minecraft version to install via PaperMC"
  type        = string
  default     = "1.21.1"
}

variable "xms_mb" {
  description = "Initial JVM heap size in MB"
  type        = number
  default     = 512
}

variable "xmx_mb" {
  description = "Maximum JVM heap size in MB"
  type        = number
  default     = 768
}
