resource "azurerm_key_vault" "KEYvault" {
  name                        = "wow-${random_string.naming.result}" #Generated name from random resource
  location                    = var.location
  resource_group_name         = var.azurerm_resource_group
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

#Key Vault Policy
resource "azurerm_key_vault_access_policy" "principal" {
  key_vault_id = azurerm_key_vault.KEYvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "Get", "List", "Encrypt", "Decrypt"
  ]
  secret_permissions = [
    "Delete", "Get", "Backup", "List", "Purge", "Recover", "Restore", "Set"
  ]
}



# Create ssh keys in keyvault

resource "azurerm_key_vault_secret" "privateKEY" {
  name         = "private-SSH-key"
  value        = trimspace(tls_private_key.ssh_key_gen.private_key_pem)
  key_vault_id = azurerm_key_vault.KEYvault.id
}

resource "azurerm_key_vault_secret" "publicKEY" {
  name         = "public-key-pub"
  value        = trimspace(tls_private_key.ssh_key_gen.public_key_openssh)
  key_vault_id = azurerm_key_vault.KEYvault.id
}
