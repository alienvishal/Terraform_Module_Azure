variable "cluster_name" {
    type = string
    description = "Provide the Cluster Name"
}
variable "location" {
    type = string
    description = "Provide the Location for the Cluster"
}
variable "resource_group" {
    type = string
    description = "Provide the Resource Group Name for the Cluster"
}
variable "dns_prefix" {
    type = string
    description = "Provide the DNS Prefix for the Cluster"
}

variable "kubernetes_version" {
    type = string
    description = "Provide the Kubernetes Version for the Cluster (optional)"
    default = null
}

variable "tags" {
  type = map(string)
  description = "Provide the tags"
  default = {}
}

variable "default_node_pool" {
  type = object({
    name = string
    node_count = number
    vm_size = string
    vnet_subnet_id = optional(string, null)
    min_count = optional(number,1)
    max_count = optional(number,3)
    temporary_name_for_rotation = optional(string, null)
  })
  description = "Provide the Default Node Pool configuration"
}

variable "node_pools" {
  type = map(object({
    vm_size     = string
    min_count   = number
    max_count   = number
    subnet_id   = string
    node_labels = optional(map(string), {})
    node_taints = optional(list(string), [])
  }))
   description = "Provide the configuration for additional node pools (optional)"
   default = {}
    
}

variable "role_based_access_control_enabled" {
  type = bool
  description = "Is Role based access control enabled"
  default = true
}

variable "azure_active_directory_role_based_access_control" {
  type = object({
    azure_rbac_enabled = bool
    admin_group_object_ids = list(string)
  })
  description = "Provide the configuration for Azure Active Directory Role Based Access Control (optional)"
  default = null
}

variable "log_analytics_workspace_id" {
  type = string
  description = "Provide the Log Analytics Workspace ID for monitoring (optional)"
  default = null
}

variable "private_cluster_enabled" {
  type = bool
  description = "Do you want private cluster to be enabled"
  default = false
}