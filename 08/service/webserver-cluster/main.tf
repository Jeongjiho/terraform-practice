provider "google" {
  credentials = file("key.json")
  project = "terraform-348208"
  region = "asia-northeast3"
}

data "terraform_remote_state" "db" {
  backend = "gcs"

  config = {
    bucket      = "terraform-up-and-running-state-0d9027ef04cb8b9b"
    prefix      = "terraform/stage/data-stores/mysql/"
    credentials = "key.json"
  }
}

resource "google_compute_instance" "example" {
  name = "webserver"
  machine_type = "f1-micro"
  zone = "asia-northeast3-a"

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20220406"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["web"]

  metadata_startup_script = <<EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              echo "${data.terraform_remote_state.db.outputs.address}" > index.html
              EOF
}

resource "google_compute_firewall" "default" {
  name    = "webserver-firewall2"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["web"]
  target_tags = ["web"]
}