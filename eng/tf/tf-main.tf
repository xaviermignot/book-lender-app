resource "random_pet" "suffix" {
  length = 1
}

locals {
  project = "book-lender-${random_pet.suffix.id}"

  logic_apps = {
    "get-book-by-isbn" = "getBookByIsbnArm.json",
    "post-book"        = "postBookArm.json",
    "lend-book"        = "lendBookArm.json"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.project}"
  location = var.location
}

module "cosmosdb" {
  source = "./cosmosdb"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  project  = local.project
}

module "logic_app_base" {
  source = "./logic_app_base"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  project  = local.project

  cosmosdb_account = {
    name = module.cosmosdb.cosmosdb_account.name
    key  = module.cosmosdb.cosmosdb_account.key
  }
}

module "logic_app" {
  for_each = local.logic_apps
  source   = "./logic_app"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  project  = local.project

  name                = each.key
  msi_id              = module.logic_app_base.msi.id
  cosmosdb_connection = module.logic_app_base.cosmosdb_connection

  logic_app_workflow_arm = file("${path.module}/logic_apps/${each.value}")
}

module "cdn" {
  source = "./cdn"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  project  = local.project

  cdn_location     = var.cdn_location
  dns_zone_name    = var.dns_config.zone_name
  dns_zone_rg_name = var.dns_config.zone_rg_name
  dns_cname_record = var.dns_config.cname_record
}
