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

variable "name" {
  type        = string
  description = "The name of the Logic App (without any prefix or suffix)"
}

variable "msi_id" {
  type        = string
  description = "The id of the User Managed Identity to associate to the Logic App"
}

variable "cosmosdb_connection" {
  type = object({
    connectionId   = string
    connectionName = string
    id             = string
  })
}

variable "logic_app_workflow_arm" {
  type = string
  description = "The content of the ARM template to deploy"
}
