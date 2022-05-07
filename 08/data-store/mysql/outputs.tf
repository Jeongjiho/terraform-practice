output "address" {
  value = google_sql_database_instance.main.public_ip_address
  description = "The public IPv4 address of the master instance."
}
