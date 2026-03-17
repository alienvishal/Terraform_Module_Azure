variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "tags" {
  type        = map(any)
  description = "Provide the tags"
  default     = {}
}