moved {
  from = azurerm_service_plan.this
  to   = azurerm_service_plan.this[0]
}

resource "azurerm_service_plan" "this" {
  count               = var.service_plan_id == null ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "FC1"
  tags                = var.tags
}

resource "azurerm_application_insights" "primary" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "Node.JS"
  workspace_id        = var.azure_log_workspace_id
  tags                = var.tags
}

resource "azurerm_application_insights_api_key" "write" {
  name                    = "${var.name}-insights-key"
  application_insights_id = azurerm_application_insights.primary.id
  write_permissions       = ["annotations"]
}

resource "azurerm_function_app_flex_consumption" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  service_plan_id = var.service_plan_id != null ? var.service_plan_id : azurerm_service_plan.this[0].id

  storage_container_type     = "blobContainer"
  storage_container_endpoint = "${data.azurerm_storage_account.artifacts.primary_blob_endpoint}${data.azurerm_storage_container.functions.name}"
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
