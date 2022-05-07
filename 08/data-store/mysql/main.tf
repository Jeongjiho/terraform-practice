provider "google" {
  credentials = file("key.json")
  project = "terraform-348208"
  region = "asia-northeast3"
}

resource "google_sql_database_instance" "main" {
  name = "example-database6"
  database_version = "MYSQL_8_0"
  region = "asia-northeast3"
  root_password = "pass"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}

terraform {
  backend "gcs" {
    bucket = "terraform-up-and-running-state-0d9027ef04cb8b9b"
    credentials = "key.json"
    prefix = "terraform/stage/data-stores/mysql/"
  }
}

/*data "google_kms_key_ring" "my_key_ring" {
  name     = "test2"
  location = "asia-northeast3"
}

data "google_kms_crypto_key" "my_crypto_key" {
  name     = "my-crypto-key"
  key_ring = data.google_kms_key_ring.my_key_ring.id
}*/
