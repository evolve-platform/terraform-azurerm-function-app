resource "azurerm_linux_function_app" "this" {
  count = var.hosting_option == "classic" ? 1 : 0


  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  service_plan_id               = var.service_plan_id != null ? var.service_plan_id : azurerm_service_plan.this[0].id
  storage_account_name          = var.storage_account_name
  storage_uses_managed_identity = true

  https_only = true

  app_settings = merge(local.default_app_settings, var.environment)

  site_config {
    application_stack {
      node_version = 20
    }
    always_on = false

    app_scale_limit = var.app_scale_limit

    application_insights_connection_string = azurerm_application_insights.primary.connection_string
    application_insights_key               = azurerm_application_insights_api_key.write.api_key

    cors {
      allowed_origins = ["https://portal.azure.com"]
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 ? [1] : []

    content {
      type         = "SystemAssigned, UserAssigned"
      identity_ids = var.identity_ids
    }
  }

  key_vault_reference_identity_id = var.key_vault_reference_identity_id

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 ? [1] : []

    content {
      type = "SystemAssigned"
    }
  }
}
