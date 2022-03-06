variable "rg_name" {
  type        = string
  description = "The name of the resource group to create all resources in"
}

variable "location" {
  type        = string
  description = "The location to use for all resources"
}

variable "project" {
  type        = string
  description = "The project name to use in all resource names"
}

variable "cdn_location" {
  type        = string
  description = "The location of the CDN profile"
}

variable "dns_zone_name" {
  type        = string
  description = "The name of the DNS zone already created in Azure"
}

variable "dns_zone_rg_name" {
  type        = string
  description = "The name of the resource group containing the DNS zone"
}

variable "dns_cname_record" {
  type        = string
  description = "The CNAME record to create in the zone"
}