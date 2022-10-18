resource "azurerm_virtual_network" "odm_demo" {
  name                = "odm_demo-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.region
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "odm_demo_subnet" {
  name                 = "odm_demo_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.odm_demo.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "odm_demo_public_ip" {
  name                = "odm_demo_public_ip"
  resource_group_name = var.resource_group_name
  location            = var.region
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "odm_demo_nic" {
  location            = var.region
  name                = "odm_demo_nic"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "odm_demo_nic_configuration"
    subnet_id = azurerm_subnet.odm_demo_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.odm_demo_public_ip.id
  }
}

resource "azurerm_network_security_group" "odm_demo_nic_security_group" {
  name                = "odm_demo_nic_security_group"
  location            = var.region
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "151.66.84.61/32"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "odm_demo_nic_security_group_association" {
  network_interface_id          = azurerm_network_interface.odm_demo_nic.id
  application_security_group_id = azurerm_application_security_group.odm_demo_nic_security_group.id
}

resource "azurerm_linux_virtual_machine" "odm_demo" {
  location              = var.region
  name                  = "odm_demo"
  network_interface_ids = [azurerm_network_interface.odm_demo_nic.id]
  resource_group_name   = var.resource_group_name
  size               = "Standard_A2_v2"
  //timezone = "W. Europe Standard Time"

  admin_ssh_key {
    username   = "giandomenico.avelluto"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDED0QBtWZ9PZAwCJpWVs1nTrZK5uATJysIm1XlK1lvuqyZYI0LSfnON3tyWDZGq6EVVx2VLBoZnD4wymJTL0IL2KIL7nLo5fuk3R5mUtctLi3LRABDxLZToWR6byTVsQu07AVFo5Nyl0zB1wsNocUqgB5/67+2ULVic8yQYy/m6lP0uuDytW+k+n3ig5lhEKJrhRNA9nAKpVWosY3vSZw9yHYszLFUM/NdjJb0f93sCcuTt8eSB0SfGva7Nmc4N1jEzhBPQYUF150mgbtTn1KDdzHEOn34Ty/xXZnOSY4L5MGyUzXKg1SxtRwdCDUnORMDKJTEqeqVAy2Le7ROdNch giandomenico@giandomenico-Latitude-3450"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    name              = "odm_demo_disk_os"
    caching           = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  computer_name  = "odmdemo"
  admin_username = "giandomenico.avelluto"
}
