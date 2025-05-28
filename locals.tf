locals {
  default_app_settings = {
    WEBSITE_RUN_FROM_PACKAGE       = var.package_url
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.primary.instrumentation_key
  }
}
