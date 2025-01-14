# Azure Function App Terraform module

Terraform module to manage an Azure Function App.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_application_insights_api_key.write](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights_api_key) | resource |
| [azurerm_linux_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_role_assignment.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.artifacts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_scale_limit"></a> [app\_scale\_limit](#input\_app\_scale\_limit) | The maximum number of instances that the function app can scale to (40-1000) | `number` | `100` | no |
| <a name="input_azure_log_workspace_id"></a> [azure\_log\_workspace\_id](#input\_azure\_log\_workspace\_id) | The ID of the Azure Log Analytics workspace to be used by the application insights instance | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment variables to be set on the function app | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location in which the resources will be created | `any` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The instance memory for the instances of the app: 2048 or 4096 | `number` | `2048` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the function app | `any` | n/a | yes |
| <a name="input_package_url"></a> [package\_url](#input\_package\_url) | The package to be deployed to the function app | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the resources will be created | `any` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime for your app. One of the following: 'dotnet-isolated', 'python', 'java', 'node', 'powershell' | `string` | `"node"` | no |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | The runtime and version for your app. One of the following: '3.10', '3.11', '7.4', '8.0', '10', '11', '17', '20' | `string` | `"20"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account to be used by the function app | `any` | n/a | yes |
| <a name="input_storage_account_resource_group"></a> [storage\_account\_resource\_group](#input\_storage\_account\_resource\_group) | The name of the resource group in which the storage account is located | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->