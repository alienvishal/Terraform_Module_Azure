resource "azurerm_application_insights" "appinsight" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  application_type    = "web"
  workspace_id        = var.law_id
  tags = var.tags
}
