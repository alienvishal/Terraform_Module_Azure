variable "name" {
  type        = string
  description = "Provide the name of App Service Plan"
}

variable "rg_name" {
  type        = string
  description = "Provide the resource group name"
}

variable "rg_location" {
  type        = string
  description = "Provide the resource group location"
}

variable "ase_id" {
  type        = string
  description = "(Optional) Provide the App Service Environment ID"
  default     = null
}

variable "os_type" {
  type        = string
  description = "Provide the OS Type."

  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"], var.os_type)
    error_message = "Allowed values are [Windows, Linux, WindowsContainer]"
  }
}

variable "sku_name" {
  type        = string
  description = "Provide the SKU"

  validation {
    condition = contains(
      ["B1", "B2", "B3", "D1", "F1", "I1", "I2", "I3", "I1v2", "I1mv2", "I2v2", "I2mv2", "I3v2", "I3mv2", "I4v2",
        "I4mv2", "I5v2", "I5mv2", "I6v2", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3", "P1mv3",
      "P2mv3", "P3mv3", "P4mv3", "P5mv3", "S1", "S2", "S3", "SHARED", "EP1", "EP2", "EP3", "FC1", "WS1", "WS2", "WS3", "Y1"],
      var.sku_name
    )
    error_message = "Allowed values are [B1, B2, B3, D1, F1, I1, I2, I3, I1v2, I1mv2, I2v2, I2mv2, I3v2, I3mv2, I4v2, I4mv2, I5v2, I5mv2, I6v2, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3, P1mv3, P2mv3, P3mv3, P4mv3, P5mv3, S1, S2, S3, SHARED, EP1, EP2, EP3, FC1, WS1, WS2, WS3, and Y1]"
  }
}

variable "product_owner" {
  type        = string
  description = "Provide the Product Owner name"
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
  type    = map(any)
  default = {}
}