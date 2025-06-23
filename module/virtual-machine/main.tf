resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = var.rgloc
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.datapublic.id
  }
}

resource "azurerm_linux_virtual_machine" "lvm" {
  name                = var.lvmm
  resource_group_name = var.rgname
  location            = var.rgloc
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password =  var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
