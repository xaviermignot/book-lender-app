resource "azurerm_dns_cname_record" "app" {
  name                = var.dns_cname_record
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_rg_name
  ttl                 = 3600
  record              = azurerm_cdn_endpoint.static_website.host_name
}

resource "azurerm_cdn_endpoint_custom_domain" "app" {
  name            = var.dns_cname_record
  cdn_endpoint_id = azurerm_cdn_endpoint.static_website.id
  host_name       = "${azurerm_dns_cname_record.app.name}.${var.dns_zone_name}"

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
  }
}
