variable "location" {
  type        = string
  description = "the location to use for all resources"
}

variable "dns_config" {
  type = object({
    zone_name    = string
    zone_rg_name = string
  })
}
