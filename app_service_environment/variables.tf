variable "rg_name" {
  type = string
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

variable "ase_name" {
  description = "Name of the App Service Environment"
  type        = string
}

variable "internal_load_balancing_mode" {
  description = "(Optional) Load balancing mode: None, Web, Publishing"
  type        = string
  default     = "Web, Publishing"
}

variable "zone_redundant" {
  description = "Whether ASE should be zone redundant"
  type        = bool
  default     = false
}

variable "subnet_id" {
  type        = string
  description = "(Optional)Provide the Subnet ID."
  default     = null
}

variable "allow_new_private_endpoint_connections" {
  type        = bool
  description = "(Optional) Do you want to allow new privae endpoint connection ? Default to false"
  default     = false
}