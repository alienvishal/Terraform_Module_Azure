resource "azurerm_servicebus_namespace" "sbus" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = var.sku
  tags = var.tags
}

resource "azurerm_servicebus_queue" "sbus_queue" {
  for_each              = { for q in var.queues : q.name => q }
  name                  = each.value.name
  namespace_id          = azurerm_servicebus_namespace.sbus.id
  max_delivery_count    = lookup(each.value, "max_delivery_count", 10)
  lock_duration         = lookup(each.value, "lock_duration", "PT1M")
  partitioning_enabled  = lookup(each.value, "enable_partitioning", false)
  max_size_in_megabytes = lookup(each.value, "max_size_in_megabytes", 1024)
  default_message_ttl   = lookup(each.value, "defaultMessageTimeToLive", "P14D")
  status                = lookup(each.value, "status", "Active")
}

resource "azurerm_servicebus_topic" "sbus_topic" {
  for_each             = { for t in var.topics : t.name => t }
  name                 = each.value.name
  namespace_id         = azurerm_servicebus_namespace.sbus.id
  partitioning_enabled = lookup(each.value, "enable_partitioning", true)
}

resource "azurerm_servicebus_subscription" "sbus_subscription" {
  for_each = try({
    for sbus in local.sbus_subscription : "${sbus.sub_key}.${sbus.topic_key}" => sbus
  }, {})

  name               = each.value.sub.name
  topic_id           = azurerm_servicebus_topic.sbus_topic[each.value.topic.name].id
  max_delivery_count = each.value.sub.max_delivery_count
  lock_duration      = each.value.sub.lock_duration
}