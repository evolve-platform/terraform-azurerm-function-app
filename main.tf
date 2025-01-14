

# resource "azapi_resource" "server_plan" {
#   type                      = "Microsoft.Web/serverfarms@2023-12-01"
#   schema_validation_enabled = false
#   location                  = var.location
#   name                      = var.name
#   parent_id                 = data.azurerm_resource_group.selected.id
#   body = jsonencode({
#     kind = "functionapp",
#     sku = {
#       tier = "FlexConsumption",
#       name = "FC1"
#     },
#     properties = {
#       reserved = true
#     }
#   })
# }


# resource "azapi_resource" "function_app" {
#   type                      = "Microsoft.Web/sites@2023-12-01"
#   schema_validation_enabled = false
#   name                      = var.name
#   location                  = var.location
#   parent_id                 = data.azurerm_resource_group.selected.id
#   body = jsonencode({
#     kind = "functionapp,linux",
#     identity = {
#       type : "SystemAssigned"
#     }
#     properties = {
#       serverFarmId = azapi_resource.server_plan.id,
#       functionAppConfig = {
#         deployment = {
#           storage = {
#             type  = "blobContainer",
#             value = var.storage_container
#             authentication = {
#               type = "SystemAssignedIdentity"
#             }
#           }
#         },
#         scaleAndConcurrency = {
#           maximumInstanceCount = var.app_scale_limit
#           instanceMemoryMB     = var.memory
#         },
#         runtime = {
#           name    = var.runtime
#           version = var.runtime_version
#         }
#       },
#       siteConfig = {
#         appSettings = [
#           {
#             name  = "AzureWebJobsStorage__accountName",
#             value = var.storage_account_name
#           },
#           {
#             name  = "APPLICATIONINSIGHTS_CONNECTION_STRING",
#             value = var.application_insights_connection_string
#           },
#           {
#             name  = "WEBSITE_RUN_FROM_ZIP",
#             value = var.package_url
#           }
#         ]
#       }
#     }
#   })
#   depends_on = [azapi_resource.server_plan]
# }


resource "azurerm_service_plan" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
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

resource "azurerm_linux_function_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  service_plan_id               = azurerm_service_plan.this.id
  storage_account_name          = var.storage_account_name
  storage_uses_managed_identity = true

  https_only = true

  app_settings = merge({
    WEBSITE_RUN_FROM_PACKAGE       = var.package_url
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.primary.instrumentation_key
    },
  var.environment)


  site_config {
    application_stack {
      node_version = 20
    }
    always_on = false
    # api_management_api_id = azurerm_api_management_api.main.id

    application_insights_connection_string = azurerm_application_insights.primary.connection_string
    application_insights_key               = azurerm_application_insights_api_key.write.api_key

    cors {
      allowed_origins = ["https://portal.azure.com"]
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
