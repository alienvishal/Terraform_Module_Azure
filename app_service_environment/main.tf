resource "azurerm_app_service_environment_v3" "ase" {
  name                                   = var.ase_name
  resource_group_name                    = var.rg_name
  subnet_id                              = var.subnet_id
  internal_load_balancing_mode           = var.internal_load_balancing_mode
  allow_new_private_endpoint_connections = var.allow_new_private_endpoint_connections

  cluster_setting {
    name  = "FrontEndSSLCipherSuiteOrder"
    value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
  }

  zone_redundant = var.zone_redundant
  tags = var.tags
}