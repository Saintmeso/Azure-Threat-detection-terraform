##Resource group creation

resource "azurerm_resource_group" "yousif_soc_lab" {
  name     = "yousif_soc_lab"
  location = "East US"
}

resource "azurerm_virtual_network" "yousif_vnet" {
  name                = "yousif_vnet"
  location            = "East US"
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.yousif_soc_lab.name
  virtual_network_name = azurerm_virtual_network.yousif_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}