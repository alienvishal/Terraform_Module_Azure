resource "azurerm_search_service" "search_service" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = var.sku

  partition_count = var.partition_count
  replica_count   = var.replica_count

  tags = merge({
    Owner         = var.product_owner,
    Department    = var.department
    "Cost Center" = var.cost_center
    ProjectName   = var.project_name,
    deployment    = "terraform"
    },
  var.tags)
}