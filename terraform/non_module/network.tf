resource "azurerm_virtual_network" "mainVNET" {
  name                = "Virtual_Network"
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Test"
  }
}

resource "azurerm_subnet" "sub1" {
  name                 = "subnet1"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.mainVNET.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "sub2" {
  name                 = "subnet2"
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = azurerm_virtual_network.mainVNET.name
  address_prefixes     = ["10.0.2.0/24"]
}




resource "azurerm_network_security_group" "mainNSG" {
  name                = "Demo1_NSG"
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  security_rule {
    name                       = "AllowSSHInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "InBoundRule"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Test"
  }
}


resource "azurerm_public_ip" "Public_IP" {
  name                = "Public-IP"
  resource_group_name = var.azurerm_resource_group
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = "Test"
  }
}



resource "azurerm_network_interface" "mainNIC" {
  name                = "Demo_NIC"
  location            = var.location
  resource_group_name = var.azurerm_resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Public_IP.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.mainNIC.id
  network_security_group_id = azurerm_network_security_group.mainNSG.id
}