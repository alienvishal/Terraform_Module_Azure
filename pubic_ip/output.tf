output "public_ip_id" {
  description = "The ID of the Public IP."
  value       = azurerm_public_ip.public_ip.id
}

output "public_ip_address" {
  description = "The actual IP address allocated."
  value       = azurerm_public_ip.public_ip.ip_address
}