variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "name" {
  description = "The name of the Azure Cognitive Search service."
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]{2,60}$", var.name))
    error_message = "Search service name must be 2–60 characters, lowercase letters, numbers, or hyphens."
  }
}

variable "sku" {
  type        = string
  description = "SKU of the search service (basic, standard, standard2, etc.)."
  default     = "basic"

  validation {
    condition     = contains(["basic", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], lower(var.sku))
    error_message = "SKU must be one of: basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  }
}

variable "partition_count" {
  description = "Number of partitions (1, 2, 3, or 12)."
  type        = number
  default     = 1

  validation {
    condition     = contains([1, 2, 3, 12], var.partition_count)
    error_message = "Partition count must be 1, 2, 3, or 12."
  }
}

variable "replica_count" {
  description = "Number of replicas (1 to 12)."
  type        = number
  default     = 1

  validation {
    condition     = var.replica_count >= 1 && var.replica_count <= 12
    error_message = "Replica count must be between 1 and 12."
  }
}

variable "product_owner" {
  type        = string
  description = "Provide the Product Owner Name"
}

variable "project_name" {
  type        = string
  description = "Provide the Project Name"
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
  description = "Provide the tags"
  default     = {}
}