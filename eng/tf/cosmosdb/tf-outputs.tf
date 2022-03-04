output "cosmosdb_account" {
  value = {
    name = azurerm_cosmosdb_account.cosmos_account.name
    key  = azurerm_cosmosdb_account.cosmos_account.primary_key
  }
}
