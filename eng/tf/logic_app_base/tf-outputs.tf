output "msi" {
  value = {
    id           = azurerm_user_assigned_identity.logic_apps.id
    principal_id = azurerm_user_assigned_identity.logic_apps.principal_id
  }
}

output "cosmosdb_connection" {
  value = jsondecode(azurerm_resource_group_template_deployment.cosmosdb_connection.output_content).connection.value
}
