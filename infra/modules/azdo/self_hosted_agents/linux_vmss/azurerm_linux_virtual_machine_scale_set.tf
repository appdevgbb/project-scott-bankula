resource "azurerm_linux_virtual_machine_scale_set" "azdo" {
  name                = "${var.prefix}-azdo-vmss"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = var.vm_sku
  instances           = var.instances
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "StandardSSD_LRS"
    caching              = "ReadOnly"
    diff_disk_settings {
      option = "Local"
      placement = "CacheDisk"

    }
    disk_size_gb = 30
  }

  network_interface {
    name    = "primary"
    primary = true
    enable_accelerated_networking = true

    ip_configuration {
      name      = "primary"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

  # required for AzDO Self-Hosted VMSS Agents 
  overprovision = false
  automatic_os_upgrade_policy {
    disable_automatic_rollback = true
    enable_automatic_os_upgrade = false
  }
}