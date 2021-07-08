# Creación de subnets adicionales
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnetEnv" {
    count                  = length(var.entornos)
    name                   = "terraformsubnet-${var.entornos[count.index]}"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.${count.index + 30}.0/24"]
}

