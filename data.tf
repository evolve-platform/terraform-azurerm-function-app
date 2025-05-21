data "azurerm_storage_account" "artifacts" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group
}

data "azurerm_storage_container" "functions" {
  name               = var.storage_container_name
  storage_account_id = data.azurerm_storage_account.artifacts.id
}
