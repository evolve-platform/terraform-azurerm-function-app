output "id" {
  description = "The ID of the function app"
  value       = azurerm_function_app_flex_consumption.this.id
}

output "principal_id" {
  description = "The principal ID of the function app"
  value       = azurerm_linux_function_app.this.identity[0].principal_id
}

output "default_hostname" {
  description = "The default hostname of the function app"
  value       = azurerm_function_app_flex_consumption.this.default_hostname
}
