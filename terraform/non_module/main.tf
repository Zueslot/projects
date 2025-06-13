resource "random_string" "naming" {
  length           = 7
  special          = false
  override_special = "/@£$"
}

# This get your current azure login info, helps to assign role
data "azurerm_client_config" "current" {}
data "azurerm_subscription" "primary" {}

resource "azurerm_resource_group" "RG" {
  name     = "Demo1_RG"
  location = var.location
}















