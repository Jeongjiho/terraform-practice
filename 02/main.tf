provider "google" {
  credentials = file("key.json")
  project = "terraform-348208"
  region = "asia-northeast3"
}

resource "google_compute_instance" "example" {
  name = "webserver"
  machine_type = "f1-micro"
  zone = "asia-northeast3-a"

  boot_disk {
    initialize_params {
      image = "gcr.io/google-containers/busybox"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  tags = ["web"]

  metadata_startup_script = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}

resource "google_compute_firewall" "default" {
  name    = "webserver-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["web"]
  target_tags = ["web"]
}