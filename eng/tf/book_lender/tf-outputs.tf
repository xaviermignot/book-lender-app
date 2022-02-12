output "static_site_host_name" {
  value = azurerm_static_site.static_app.default_host_name
}

output "static_site_api_key" {
  value     = azurerm_static_site.static_app.api_key
  sensitive = true
}
