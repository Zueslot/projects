variable "filename" {
  default = "./goodboy.txt"
}

variable "content" {
  default = "zeus is a good boy"

}

variable "azurerm_virtual_network" {
  type    = string
  default = "Virtual_Network"
}

variable "location" {
  type    = string
  default = "Canada central"
}

variable "azurerm_resource_group" {
  type    = string
  default = "Demo1_RG"
}

variable "azurerm_network_security_group" {
  type    = string
  default = "Demo1_NSG"
}

variable "object_id" {
  default = "247b922d-d1d1-444d-b78a-1caac62a0d32"
}