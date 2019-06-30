provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket = "indigo-medium-242214-tf-state-prod"
    prefix = "network"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-http"

  # name of net
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["test-app"]
}
