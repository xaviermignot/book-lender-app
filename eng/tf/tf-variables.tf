variable "location" {
  type        = string
  description = "the location to use for all resources"
}

variable "dns_config" {
  type = object({
    zone_name    = string
    zone_rg_name = string
    cname_record = string
  })
}

variable "cdn_location" {
  type        = string
  description = "The location of the CDN endpoint (different from Azure regions)"
}
