resource "azurerm_user_assigned_identity" "logic_apps" {
  resource_group_name = var.rg_name
  location            = var.location
  name                = "msi-${var.project}-logic-apps"
}
