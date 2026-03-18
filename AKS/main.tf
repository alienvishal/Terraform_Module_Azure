resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = var.dns_prefix

  kubernetes_version  = var.kubernetes_version != null ? var.kubernetes_version : null

  private_cluster_enabled = var.private_cluster_enabled

  identity {
    type = "SystemAssigned"
  }

  dynamic default_node_pool {
    for_each = [var.default_node_pool]
    content {
      name                = default_node_pool.value.name
      node_count          = default_node_pool.value.node_count
      vm_size             = default_node_pool.value.vm_size
      vnet_subnet_id      = default_node_pool.value.vnet_subnet_id
      auto_scaling_enabled = true
      min_count           = default_node_pool.value.min_count
      max_count           = default_node_pool.value.max_count
      temporary_name_for_rotation = default_node_pool.value.temporary_name_for_rotation
    }
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
      msi_auth_for_monitoring_enabled = var.msi_auth_for_monitoring_enabled
    }
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = var.secret_rotation_enabled
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  count = var.acr_id != null ? 1 : 0

  scope = var.acr_id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# SSL Key Vault Access
resource "azurerm_role_assignment" "ssl_key_vault_secrets_user" {
  count                = var.ssl_key_vault_id != null ? 1 : 0
  scope                = var.ssl_key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "ssl_key_vault_certificates_user" {
  count                = var.ssl_key_vault_id != null ? 1 : 0
  scope                = var.ssl_key_vault_id
  role_definition_name = "Key Vault Certificate User"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Secrets Key Vault Access
resource "azurerm_role_assignment" "secrets_key_vault_secrets_user" {
  count = var.secrets_key_vault_id != null ? 1 : 0
  scope                = var.secrets_key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Allow AKS to manage load balancer in frontend subnet
resource "azurerm_role_assignment" "frontend_subnet_network_contributor" {
  count = var.frontend_subnet_id != null ? 1 : 0
  scope                = var.frontend_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

# Need this so that LB can forward traffic to AKS subnet
resource "azurerm_role_assignment" "aks_subnet_network_contributor" {
  scope                = var.default_node_pool.vnet_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
