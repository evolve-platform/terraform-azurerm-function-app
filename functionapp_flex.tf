moved {
  from = azurerm_function_app_flex_consumption.this
  to   = azurerm_function_app_flex_consumption.this[0]
}


resource "azurerm_function_app_flex_consumption" "this" {
  count = var.hosting_option == "flex" ? 1 : 0

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  service_plan_id = var.service_plan_id != null ? var.service_plan_id : azurerm_service_plan.this[0].id

  storage_container_type     = "blobContainer"
  storage_container_endpoint = "${data.azurerm_storage_account.artifacts.primary_blob_endpoint}${data.azurerm_storage_container.functions[0].name}"
  # storage_authentication_type       = length(var.identity_ids) > 0 ? "UserAssignedIdentity" : "StorageAccountConnectionString"
  # storage_access_key                = length(var.identity_ids) > 0 ? null : data.azurerm_storage_account.artifacts.primary_access_key
  # storage_user_assigned_identity_id = length(var.identity_ids) > 0 ? var.identity_ids[0] : null

  storage_authentication_type = "StorageAccountConnectionString"
  storage_access_key          = data.azurerm_storage_account.artifacts.primary_access_key

  runtime_name           = var.runtime
  runtime_version        = var.runtime_version
  maximum_instance_count = var.app_scale_limit
  instance_memory_in_mb  = var.memory

  app_settings = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.primary.instrumentation_key
    },

  var.environment)
  site_config {
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

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 ? [1] : []

    content {
      type = "SystemAssigned"
    }
  }

}
