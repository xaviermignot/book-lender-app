resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}"
  location = var.location
}

module "book_lender" {
  source = "./book_lender"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  project  = var.project
}
