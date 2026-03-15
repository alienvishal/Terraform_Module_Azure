resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = var.allocation_method
  sku                 = var.sku

  zones               = var.zones
  tags = merge(
    {
      Owner         = var.product_owner,
      Department    = var.department
      "Cost Center" = var.cost_center
      ProjectName   = var.project_name,
      deployment    = "terraform"
    },
    var.tags
  )
}