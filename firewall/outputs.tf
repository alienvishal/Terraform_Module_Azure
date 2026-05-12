output "firewall_id" {
  description = "The ID of the Azure Firewall"
  value       = azurerm_firewall.firewall.id
}

output "firewall_name" {
  description = "The name of the Azure Firewall"
  value       = azurerm_firewall.firewall.name
}

output "firewall_private_ip" {
  description = "The private IP address of the Azure Firewall"
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

output "firewall_policy_id" {
  description = "The ID of the Firewall Policy"
  value       = local.create_policy ? azurerm_firewall_policy.firewall_policy[0].id : var.firewall_policy_id
}

output "rule_collection_group_ids" {
  description = "The IDs of the rule collection groups"
  value       = { for k, v in azurerm_firewall_policy_rule_collection_group.rule_groups : v.name => v.id }
}