resource "azurerm_static_site" "static_app" {
  name                = "static-${var.project}"
  resource_group_name = var.rg_name
  location            = var.location
}
