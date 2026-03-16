resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = var.dns_prefix

  kubernetes_version  = var.kubernetes_version != null ? var.kubernetes_version : null

  private_cluster_enabled = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = var.default_node_pool_name
    node_count          = var.default_node_pool_node_count
    vm_size             = var.default_node_pool_vm_size
    vnet_subnet_id      = var.default_node_pool_vnet_subnet_id
    auto_scaling_enabled = true
    min_count           = var.default_node_pool_min_count
    max_count           = var.default_node_pool_max_count
  }

  role_based_access_control_enabled = var.role_based_access_control_enabled ? true : false

  dynamic azure_active_directory_role_based_access_control {
    for_each = var.azure_active_directory_role_based_access_control != null ? [var.azure_active_directory_role_based_access_control] : []
    content {
        azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_rbac_enabled
        admin_group_object_ids = azure_active_directory_role_based_access_control.value.admin_group_object_ids
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    load_balancer_sku = "standard"
  }

  dynamic oms_agent {
    for_each = var.log_analytics_workspace_id != null ? [var.log_analytics_workspace_id] : []
    content {
      log_analytics_workspace_id = oms_agent.value
    }
  }

  tags = var.tags
}
