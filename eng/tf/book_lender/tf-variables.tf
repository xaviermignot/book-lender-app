variable "rg_name" {
  type        = string
  description = "The name of the resource group to create all resources in"
}

variable "location" {
  type        = string
  description = "the location to use for all resources"
}

variable "project" {
  type        = string
  description = "the project name to use in all resource names"
}
