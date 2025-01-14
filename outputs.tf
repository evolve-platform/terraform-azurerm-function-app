output "id" {
  description = "The ID of the function app"
  value       = azurerm_linux_function_app.this.id
}

output "default_hostname" {
  description = "The default hostname of the function app"
  value       = azurerm_linux_function_app.this.default_hostname
}
