variable "name" {
  type        = string
  description = "Provide the name of the storage account"
}

variable "rg_name" {
  type        = string
  description = "Provide the name of resource group"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "account_tier" {
  type        = string
  description = "Provide the Account Tier of storage account"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_kind" {
  type        = string
  description = "Provide the Account kind"

  validation {
    condition     = contains(["Storage", "StorageV2", "BlobStorage", "BlockBlobStorage", "FileStorage"], var.account_kind)
    error_message = "Invalid storage account kind."
  }
  default = "StorageV2"
}

variable "account_replication_type" {
  type        = string
  description = "Provide the Account Replication Type"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "The account tier must be either from this list [LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS]."
  }
}

variable "product_owner" {
  type        = string
  description = "Provide the Production Owner"
}

variable "department" {
  type        = string
  description = "Provide the Department name"
}

variable "cost_center" {
  type        = string
  description = "Provide the Cost Center"
}

variable "project_name" {
  type        = string
  description = "Provide the Project Name"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "blob" {
  type = list(object({
    name = string
    container_access_type = optional(string, "private")
  }))
  description = "Provide the blob details"
  default = []
}

variable "queue" {
  type = list(object({
    name = string
  }))
  description = "Provide the queue details"
  default = []
}

variable "table" {
  type = list(object({
    name = string
  }))
  description = "Provide the table details"
  default = []
}