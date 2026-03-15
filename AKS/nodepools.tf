resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
    
  for_each = var.node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value.vm_size

  auto_scaling_enabled = true
  min_count            = each.value.min_count
  max_count            = each.value.max_count

  node_labels = each.value.node_labels
  node_taints = each.value.node_taints

  vnet_subnet_id = each.value.subnet_id

  mode = "User"

  tags = var.tags
}