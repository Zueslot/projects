resource "azurerm_linux_virtual_machine" "mainVM" {
  name                = "VM1"
  resource_group_name = var.azurerm_resource_group
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "ubuntu"
  network_interface_ids = [
    azurerm_network_interface.mainNIC.id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = tls_private_key.ssh_key_gen.public_key_openssh #picks the key from the saved file above
  }

  admin_ssh_key {
    username   = "ubuntu"
    public_key = azurerm_key_vault_secret.publicKEY.value #picks the key from the public keyvault saved below
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
