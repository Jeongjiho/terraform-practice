resource "random_id" "instance_id" {
  byte_length = 8
}

output "random_id" {
  value = random_id.instance_id.hex
}