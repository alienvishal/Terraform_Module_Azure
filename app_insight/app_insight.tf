resource "azurerm_application_insights" "appinsight" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  application_type    = "web"
  workspace_id        = var.law_id
  tags = merge(
    {
      Owner         = var.product_owner,
      Department    = var.department
      "Cost Center" = var.cost_center
      ProjectName   = var.project_name,
      deployment    = "terraform"
    },
  var.tags)
}
