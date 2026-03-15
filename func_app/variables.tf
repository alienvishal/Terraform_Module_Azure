variable "name" {
  description = "Name of the Function App"
  type        = string
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "os_type" {
  description = "(Optional) OS type: linux or windows"
  type        = string
  default     = "windows"
}

variable "runtime" {
  description = "(Optional) Function runtime (dotnet, node, python)"
  type        = string
  default     = "dotnet"
}

variable "node_version" {
  description = "(Optional) Node.js version"
  type        = string
  default     = null
}

variable "python_version" {
  description = "(Optional) Python version"
  type        = string
  default     = null
}

variable "dotnet_version" {
  description = "(Optional) DotNet version"
  type        = string
  default     = null
}

variable "app_settings" {
  description = "(Optional) Additional app settings for Function App"
  type        = map(string)
  default     = {}
}

variable "enable_app_insights" {
  description = "(Optional) Whether to enable Application Insights"
  type        = bool
  default     = true
}

variable "app_svc_plan_id" {
  type        = string
  description = "Provide the App Service Plan ID."
}

variable "app_insight_instrument_key" {
  type        = string
  description = "(Optional) Provide the App insight Instrumentation key"
  default = null
}

variable "product_owner" {
  type = string
}

variable "project_name" {
  type = string
}

variable "department" {
  type        = string
  description = "Provide the Department name"
}

variable "cost_center" {
  type        = string
  description = "Provide the Cost Center"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "is_always_on" {
  type        = bool
  description = "(Optional)Is your Always On enabled ? Default is True"
  default     = true
}

variable "vnet_route_all_enabled" {
  type        = bool
  description = "(Optional)Is your VNet Route enabled ? Default is False"
  default     = false
}

variable "allowed_origins" {
  type = list(string)
  default = []
  description = "(Optional) Provide the Allowed Origins"
}

variable "support_credentials" {
  type = bool
  default = false
  description = "(Optional) Provide Support Credentials"
}

variable "storage_account_name" {
  type        = string
  description = "Provide the storage account name"
}

variable "vnet_image_pull_enabled" {
  type = bool
  description = "(Optional) Is Vnet Image Pull enabled ? Default is false"
  default = false
}

variable "storage_account_primary_access_key" {
  type        = string
  description = "Provide the Storage Account Primary Access Key"
}

variable "system_identity" {
  type        = bool
  description = "(Optional)Is your System Managed Identity enabled ? Default is False"
  default     = false
}

variable "connection_string" {
  type = map(any)
  description = "(Optional) Provide the connection string"
  default = {}
}

variable "functions_extension_version" {
  type = string
  description = "(Optional) Provide the Function Extension Version"
  default = "~4"
}