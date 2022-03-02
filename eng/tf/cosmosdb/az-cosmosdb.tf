resource "azurerm_cosmosdb_account" "cosmos_account" {
  name                = "cdb-${var.project}"
  location            = var.location
  resource_group_name = var.rg_name

  offer_type       = "Standard"
  kind             = "GlobalDocumentDB"
  enable_free_tier = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmos_database" {
  name                = "db-${var.project}"
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name
}

resource "azurerm_cosmosdb_sql_container" "cosmos_books" {
  name                = "books"
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_database.name
  partition_key_path  = "/id"
}

resource "azurerm_cosmosdb_sql_container" "cosmos_users" {
  name                = "users"
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name
  database_name       = azurerm_cosmosdb_sql_database.cosmos_database.name
  partition_key_path  = "/id"
}
