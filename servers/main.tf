provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket = "indigo-medium-242214-tf-state-prod"
    prefix = "servers"
  }
}

resource "google_compute_instance" "app" {
  count        = "${var.count_instance}"
  name         = "app-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone_instance}"
  tags         = data.terraform_remote_state.network.outputs.firewall_puma-tags

  # add image disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # add network
  network_interface {
    network = "default"
    access_config {
    }
  }
}
