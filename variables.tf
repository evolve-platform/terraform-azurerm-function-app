variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location in which the resources will be created"
}

variable "name" {
  description = "The name of the function app"
}

variable "app_scale_limit" {
  description = "The maximum number of instances that the function app can scale to (40-1000)"
  default     = 100
}

variable "memory" {
  description = "The instance memory for the instances of the app: 2048 or 4096"
  default     = 2048
}

variable "runtime" {
  description = "The runtime for your app. One of the following: 'dotnet-isolated', 'python', 'java', 'node', 'powershell'"
  default     = "node"
}

variable "runtime_version" {
  default     = "20"
  description = "The runtime and version for your app. One of the following: '3.10', '3.11', '7.4', '8.0', '10', '11', '17', '20'"
}

variable "storage_account_resource_group" {
  description = "The name of the resource group in which the storage account is located"
}

variable "storage_account_name" {
  description = "The name of the storage account to be used by the function app"
}


variable "package_url" {
  description = "The package to be deployed to the function app"
}


variable "environment" {
  description = "Environment variables to be set on the function app"
  type        = map(string)
  default     = {}
}

variable "azure_log_workspace_id" {
  description = "The ID of the Azure Log Analytics workspace to be used by the application insights instance"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}