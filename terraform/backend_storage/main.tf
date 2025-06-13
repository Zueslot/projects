# resource "aws_s3_bucket" "s3bucket" {
#   bucket = "ghdsdjdhjd" #has to be unique

#   tags = {
#     Name        = "ghdsdjdhjd"
#     Environment = "Dev"
#   }
# }

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}

resource "azurerm_resource_group" "RG" {
  name     = "Demo1_RG"
  location = var.location
}

resource "azurerm_storage_account" "StorageAccount" {
  name                     = "zeus123xyz"
  resource_group_name      = azurerm_resource_group.RG.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "testing"
  }
}

resource "azurerm_storage_container" "zeusCONTAINER" {
  name                  = "tfcontainer"
  storage_account_id    = azurerm_storage_account.StorageAccount.id
  container_access_type = "private"
}

# resource "azurerm_storage_blob" "bloooob" {
#   name                   = "statebackend"
#   storage_account_name   = azurerm_storage_account.StorageAccount.name
#   storage_container_name = azurerm_storage_container.zeusCONTAINER.name
#   type                   = "Block"
# }

resource "azurerm_role_assignment" "block_access" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
