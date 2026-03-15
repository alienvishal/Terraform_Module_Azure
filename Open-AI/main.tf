resource "azurerm_cognitive_account" "openai" {
  name                = var.openai_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  kind                = "OpenAI"
  sku_name            = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled = var.local_auth_enabled
  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : [var.network_acls]
    content {
      default_action = network_acls.value.default_action
      ip_rules = lookup(network_acls.value, "ip_rules", null)
      dynamic virtual_network_rules {
        for_each = network_acls.value.virtual_network_rules == null ? [] : [network_acls.value.virtual_network_rules]
        content {
          subnet_id = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = virtual_network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }
  
  tags                = merge({
    Owner         = var.product_owner,
    Department    = var.department
    "Cost Center" = var.cost_center
    ProjectName   = var.project_name,
    deployment    = "terraform"
}, var.tags)
   
  custom_subdomain_name = var.custom_subdomain_name
}

resource "azurerm_cognitive_deployment" "openai_deployment" {
  for_each = {for cognitive_deployment in var.cognitive_deployment : cognitive_deployment.name =>  cognitive_deployment }

  name                 = each.value.name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  rai_policy_name      = try(each.value.rai_policy_name, "Microsoft.Default")
  sku {
    name     = each.value.sku_name
    capacity = each.value.sku_capacity
  }
  model {
    format  = each.value.model_format
    name    = each.value.model_name
    version = each.value.model_version
  }
}

resource "azurerm_cognitive_account_rai_policy" "custom_content_filter" {
  for_each = {
    for content_filter in local.rai_policy_content_filter : "${content_filter.content_filter_key}.${content_filter.rai_policy_key}" => content_filter 
  }

  name                 = each.value.rai_policy.name
  cognitive_account_id = azurerm_cognitive_account.openai.id
  base_policy_name     = each.value.rai_policy.base_policy_name

  dynamic content_filter {
    for_each = each.value.rai_policy.content_filter != [] ? each.value.rai_policy.content_filter : {}
    content {
      name               = content_filter.value.name
      filter_enabled     = try(content_filter.value.filter_enabled, true)
      block_enabled      = try(content_filter.value.block_enabled, true)
      severity_threshold = try(content_filter.value.severity_threshold, "High")
      source             = content_filter.value.source   
    }
  }
}