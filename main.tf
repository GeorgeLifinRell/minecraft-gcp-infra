provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_firewall" "minecraft" {
  name    = "${var.instance_name}-minecraft"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["25565"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["minecraft-server"]
}

resource "google_compute_instance" "minecraft" {
  name         = var.instance_name
  machine_type = "e2-micro"
  tags         = ["minecraft-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = var.boot_disk_size_gb
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/scripts/startup.sh.tftpl", {
    minecraft_version = var.minecraft_version
    xms_mb            = var.xms_mb
    xmx_mb            = var.xmx_mb
  })

  service_account {
    scopes = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write"]
  }
}

output "minecraft_server_ip" {
  description = "Public IP address of the Minecraft server"
  value       = google_compute_instance.minecraft.network_interface[0].access_config[0].nat_ip
}
