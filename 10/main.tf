provider "google" {
  credentials = file("../../key.json")
  project = "terraform-348208"
  region = "asia-northeast3"
}

resource "google_compute_instance" "example" {
  name = "example3"
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
}