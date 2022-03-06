resource "azurerm_resource_group_template_deployment" "cosmosdb_connection" {
  name                = "logic-apps-cosmos-api-connection"
  resource_group_name = var.rg_name
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    "accountName" = {
      value = var.cosmosdb_account.name
    }
  })

  template_content = file("${path.module}/arm-templates/cosmosdb-connection.json")
}