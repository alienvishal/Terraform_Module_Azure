output "namespace_id" {
  value = azurerm_servicebus_namespace.sbus.id
}

output "queue_ids" {
  value = { for k, q in azurerm_servicebus_queue.sbus_queue : k => q.id }
}

output "topic_ids" {
  value = { for k, t in azurerm_servicebus_topic.sbus_topic : k => t.id }
}

output "subscription_ids" {
  value = { for k, s in azurerm_servicebus_subscription.sbus_subscription : k => s.id }
}

output "sbus_connection_string" {
  value = azurerm_servicebus_namespace.sbus.default_primary_connection_string
}