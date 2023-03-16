output "virtual_machine_private_key" {
  value     = tls_private_key.virtual_machine_keys.private_key_pem
  sensitive = true
}