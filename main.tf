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
  sku_name            = var.service_plan_sku_name
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
