# Creamos una máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "myVM1" {
    name                = "my-first-azure-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    # admin_username    = "adminUsername"
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.myNic1.id ]
    disable_password_authentication = true

    admin_ssh_key {
        # username   = "adminUsername" 
        username     = var.ssh_user
        # public_key = file("~/.ssh/id_rsa.pub") # Ruta para Linux
        public_key   = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS" # Replicación: https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint # Logs
    }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_linux_virtual_machine" "myVM2" {
    name                = "my-second-azure-vm"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.myNic2.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username     = var.ssh_user
        public_key   = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS" # Replicación: https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint # Logs
    }

    tags = {
        environment = "CP2"
    }

}

resource "azurerm_linux_virtual_machine" "myVMWorkers" {
    count               = var.nworkers
    name                = "vm-worker${count.index}"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vmworker_size
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.myNicWorkers[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username     = var.ssh_user
        public_key   = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS" # Replicación: https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint # Logs
    }

    tags = {
        environment = "CP2"
   }

}
