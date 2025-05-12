output "id" {
  description = "The ID of the function app"
  value       = var.hosting_option == "flex" ? azurerm_function_app_flex_consumption.this[0].id : azurerm_linux_function_app.this[0].id
}

output "principal_id" {
  description = "The principal ID of the function app"
  value       = var.hosting_option == "flex" ? azurerm_function_app_flex_consumption.this[0].identity[0].principal_id : azurerm_linux_function_app.this[0].identity[0].principal_id
}

output "default_hostname" {
  description = "The default hostname of the function app"
  value       = var.hosting_option == "flex" ? azurerm_function_app_flex_consumption.this[0].default_hostname : azurerm_linux_function_app.this[0].default_hostname
}
