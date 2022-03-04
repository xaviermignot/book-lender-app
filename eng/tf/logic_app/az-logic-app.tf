resource "azurerm_logic_app_workflow" "logic_app" {
  name                = "ala-${var.project}-${var.name}"
  resource_group_name = var.rg_name
  location            = var.location

  identity {
    type         = "UserAssigned"
    identity_ids = [var.msi_id]
  }
}

resource "azurerm_resource_group_template_deployment" "logic_app" {
  name                = azurerm_logic_app_workflow.logic_app.name
  resource_group_name = var.rg_name
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    "logicAppName" = {
      value = azurerm_logic_app_workflow.logic_app.name
    }
  })

  template_content = var.logic_app_workflow_arm
}
