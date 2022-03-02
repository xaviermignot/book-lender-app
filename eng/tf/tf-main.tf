resource "random_pet" "suffix" {
  length = 1
}

locals {
  project = "book-lender-${random_pet.suffix.id}"
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
