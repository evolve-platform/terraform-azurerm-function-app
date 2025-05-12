variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  type        = string
}

variable "location" {
  description = "The location in which the resources will be created"
  type        = string
}

variable "name" {
  description = "The name of the function app"
  type        = string
}

variable "app_scale_limit" {
  description = "The maximum number of instances that the function app can scale to (40-1000)"
  default     = 100
  type        = number
}

variable "memory" {
  description = "The instance memory for the instances of the app: 2048 or 4096"
  default     = 2048
  type        = number
}

variable "hosting_option" {
  description = "When you create a function app in Azure, you must choose a hosting option for your app."
  type        = string
  default     = "classic"

  validation {
    condition     = contains(["classic", "flex"], var.hosting_option)
    error_message = "The hosting option must be either 'fclassic' or 'flex'."
  }
}

variable "runtime" {
  description = "The runtime for your app. One of the following: 'dotnet-isolated', 'python', 'java', 'node', 'powershell'"
  default     = "node"
  type        = string
}

variable "runtime_version" {
  default     = "20"
  description = "The runtime and version for your app. One of the following: '3.10', '3.11', '7.4', '8.0', '10', '11', '17', '20'"
  type        = string
}

variable "storage_account_resource_group" {
  description = "The name of the resource group in which the storage account is located"
}

variable "storage_account_name" {
  description = "The name of the storage account to be used by the function app"
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container to be used by the function app"
  default     = "functions"
  type        = string
}

variable "package_url" {
  description = "The package to be deployed to the function app"
  type        = string
}


variable "environment" {
  description = "Environment variables to be set on the function app"
  type        = map(string)
  default     = {}
}

variable "azure_log_workspace_id" {
  description = "The ID of the Azure Log Analytics workspace to be used by the application insights instance"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "role_assignments" {
  description = "Role assignments to be applied to the function app"
  type = list(object({
    role  = string
    scope = string
  }))
  default = []
}

variable "identity_ids" {
  description = "The IDs of the managed identities to be assigned to the function app"
  type        = list(string)
  default     = []
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the managed identity to be used to access the key vault"
  type        = string
  default     = null
}

variable "service_plan_id" {
  description = "The ID of the service plan to be used by the function app"
  type        = string
  default     = null
}

variable "service_plan_sku_name" {
  description = "The SKU name of the service plan to be used by the function app"
  type        = string
  default     = "Y1"
}
