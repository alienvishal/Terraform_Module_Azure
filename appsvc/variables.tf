variable "name" {
  type        = string
  description = "Provide the App Service Name"
}

variable "os_type" {
  type = string
  description = "Provide the OS Type i.e. Linux or Windows"
  default = "Windows"
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be either 'Windows' or 'Linux'."
  }
}

variable "app_command_line" {
  type = string
  default = null
  description = "(Optional) Provide the app command line"
}

variable "rg_name" {
  type        = string
  description = "Provide the Resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "app_svc_plan_id" {
  type        = string
  description = "Provide the App Service Plan ID."
}

variable "subnet_id" {
  type        = string
  description = "(Optional)Provide the Subnet ID."
  default     = null
}

variable "is_https_only" {
  type        = bool
  description = "(Optional)Is your https only enabled ? Default is True"
  default     = true
}

variable "system_identity" {
  type        = bool
  description = "(Optional)Is your System Managed Identity enabled ? Default is False"
  default     = false
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

variable "current_stack" {
  type        = string
  description = "Provide the Current Stack"
}

variable "dotnet_version" {
  type        = string
  description = "(Optional)Provide the Dotnet Version"
  default     = null
}

variable "dotnet_core_version" {
  type        = string
  description = "(Optional)Provide the Dotnet Core Version"
  default     = null
}

variable "tomcat_version" {
  type        = string
  description = "(Optional) Provide the Tomcat Version"
  default     = null
}

variable "java_version" {
  type        = string
  description = "(Optional) Provide the Java Version"
  default     = null
}

variable "node_version" {
  type        = string
  description = "(Optional) Provide the Node Version"
  default     = null
}

variable "php_version" {
  type        = string
  description = "(Optional) Provide the PHP Version"
  default     = null
}

variable "python" {
  type        = bool
  description = "(Optional) Do you want Python ? Default is False"
  default     = false
}

variable "python_version" {
  type = string
  description = "(Optional) Provide the Python Version"
  default = null
}

variable "app_insight_instrument_key" {
  type        = string
  description = "(Optional) Provide the App insight Instrumentation key"
  default = null
}

variable "product_owner" {
  type        = string
  description = "Provide the Product Owner name"
}

variable "project_name" {
  type        = string
  description = "Provide the project name"
}

variable "app_settings" {
  type        = map(any)
  description = "(Optional) Provide the App Settings"
  default     = {}
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
  type        = map(any)
  description = "Provide the additional tags"
  default     = {}
}

variable "connection_string" {
  type = map(any)
  description = "(Optional) Provide the connection string for app service"
  default = {}
}

variable "enable_app_insights" {
  description = "(Optional) Whether to enable Application Insights"
  type        = bool
  default     = true
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