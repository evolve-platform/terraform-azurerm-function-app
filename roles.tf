locals {
  principal_id = var.hosting_option == "flex" ? azurerm_function_app_flex_consumption.this[0].identity[0].principal_id : azurerm_linux_function_app.this[0].identity[0].principal_id

}

# Allow the function app to access the storage account
resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_storage_account.artifacts.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = local.principal_id
}

# Add custom role assignments to the function app
resource "azurerm_role_assignment" "this" {
  for_each = {
    for i, role_assignment in var.role_assignments : i => role_assignment
  }

  scope                = each.value.scope
  role_definition_name = each.value.role
  principal_id         = local.principal_id
}
