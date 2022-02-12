variable "location" {
  type        = string
  description = "the location to use for all resources"
}

variable "project" {
  type        = string
  description = "the project name to use in all resource names"
}

variable "dns_config" {
  type = object({
    zone_name    = string
    zone_rg_name = string
  })
}
