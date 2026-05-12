locals {
  create_policy = var.firewall_policy_id == null
  policy_name   = var.firewall_policy_name != null ? var.firewall_policy_name : "${var.firewall_name}-policy"
}

resource "azurerm_firewall_policy" "firewall_policy" {
  count               = local.create_policy ? 1 : 0
  name                = local.policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_tier == "Premium" ? "Premium" : "Standard"
  tags                = var.tags
}

resource "azurerm_firewall_policy_rule_collection_group" "rule_groups" {
  for_each           = local.create_policy ? { for idx, group in var.rule_collection_groups : idx => group } : {}
  name               = each.value.name
  firewall_policy_id = azurerm_firewall_policy.firewall_policy[0].id
  priority           = each.value.priority

  dynamic "application_rule_collection" {
    for_each = coalesce(each.value.application_rule_collections, [])
    content {
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action

      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name = rule.value.name
          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              port = protocols.value.port
              type = protocols.value.type
            }
          }
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_fqdns     = rule.value.destination_fqdns
          destination_fqdn_tags = rule.value.destination_fqdn_tags
          destination_urls      = rule.value.destination_urls
          terminate_tls         = rule.value.terminate_tls
          web_categories        = rule.value.web_categories
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = coalesce(each.value.network_rule_collections, [])
    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action

      dynamic "rule" {
        for_each = network_rule_collection.value.rules
        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_ip_groups = rule.value.destination_ip_groups
          destination_fqdns     = rule.value.destination_fqdns
          destination_ports     = rule.value.destination_ports
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = coalesce(each.value.nat_rule_collections, [])
    content {
      name     = nat_rule_collection.value.name
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action

      dynamic "rule" {
        for_each = nat_rule_collection.value.rules
        content {
          name                = rule.value.name
          protocols           = rule.value.protocols
          source_addresses    = rule.value.source_addresses
          source_ip_groups    = rule.value.source_ip_groups
          destination_address = rule.value.destination_address
          destination_ports   = rule.value.destination_ports
          translated_address  = rule.value.translated_address
          translated_port     = rule.value.translated_port
          translated_fqdn     = rule.value.translated_fqdn
        }
      }
    }
  }
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }

  firewall_policy_id = local.create_policy ? azurerm_firewall_policy.firewall_policy[0].id : var.firewall_policy_id

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "firewall_diagnostics" {
  count                      = var.enable_diagnostics && (var.log_analytics_workspace_id != null || var.storage_account_id != null) ? 1 : 0
  name                       = "${var.firewall_name}-diagnostics"
  target_resource_id         = azurerm_firewall.firewall.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id

  enabled_log {
    category = "AzureFirewallApplicationRule"
  }

  enabled_log {
    category = "AzureFirewallNetworkRule"
  }

  enabled_log {
    category = "AzureFirewallDnsProxy"
  }

  enabled_log {
    category = "AZFWApplicationRuleAggregation"
  }

  enabled_log {
    category = "AZFWNetworkRuleAggregation"
  }

  enabled_log {
    category = "AZFWNatRuleAggregation"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}