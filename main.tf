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

resource "azurerm_network_interface" "yousif_nic" {
  name                = "yousif_nic"
  location            = azurerm_resource_group.yousif_soc_lab.location
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name

  ip_configuration {
    name                          = "Interal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "yousif_nsg" {
  name                = "yousif_nsg"
  location            = azurerm_resource_group.yousif_soc_lab.location
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name


  security_rule {
    name                       = "DANGER_RULE_ALLOW_ANY"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "yousif_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.yousif_nsg.id
}

resource "azurerm_public_ip" "public_ip" {
  name                = "yousif_public_ip"
  resource_group_name = azurerm_resource_group.yousif_soc_lab.name
  location            = azurerm_resource_group.yousif_soc_lab.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_windows_virtual_machine" "Cloud_VM" {
  name                  = "Cloud_VM"
  resource_group_name   = azurerm_resource_group.yousif_soc_lab.name
  location              = azurerm_resource_group.yousif_soc_lab.location
  size                  = "Standard_D2s_v7"
  admin_username        = "adminuser"
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.yousif_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "win11-26h2-pro"
    version   = "26300.9725.261024"
  }
}

