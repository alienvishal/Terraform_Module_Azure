output "route_table_id" {
  description = "The ID of the Route Table"
  value       = azurerm_route_table.route_table.id
}

output "route_table_name" {
  description = "The name of the Route Table"
  value       = azurerm_route_table.route_table.name
}

output "subnet_route_table_association_id" {
  description = "The ID of the subnet-route table association"
  value       = azurerm_subnet_route_table_association.subnet_association.id
}