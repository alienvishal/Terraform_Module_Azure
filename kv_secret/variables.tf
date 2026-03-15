variable "secret_name" {
  description = "Name of the secret in Key Vault"
  type        = string
}

variable "secret_value" {
  description = "Value of the secret"
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "content_type" {
  description = "Optional content type of the secret"
  type        = string
  default     = null
}

variable "tags" {
  description = "Optional tags to assign to the secret"
  type        = map(any)
  default     = {}
}