resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
  tags = merge({
    Owner         = var.product_owner,
    Department    = var.department
    "Cost Center" = var.cost_center
    ProjectName   = var.project_name,
    deployment    = "terraform"
    },
  var.tags)
}