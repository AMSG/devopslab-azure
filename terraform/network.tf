# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

# Create NIC (Network interface controller)
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNicMaster" {
  name                = "vmnicMaster"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfigurationMaster"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static" # Puede ser Static o Dynamic. En el caso de IP dinámica no sera necesario el parametro private_ip_address
    private_ip_address             = "10.0.1.10"
    public_ip_address_id           = azurerm_public_ip.myPublicIpMaster.id # Asignación de la IP pública
  }

    tags = {
        environment = "CP2"
    }

}

#resource "azurerm_network_interface" "myNic2" {
#  name                = "vmnic2"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#
#    ip_configuration {
#    name                           = "myipconfiguration2"
#    subnet_id                      = azurerm_subnet.mySubnet.id
#    private_ip_address_allocation  = "Static" # Puede ser Static o Dynamic. En el caso de IP dinámica no sera necesario el parametro private_ip_address
#    private_ip_address             = "10.0.1.11"
#    public_ip_address_id           = azurerm_public_ip.myPublicIp2.id # Asignación de la IP pública
#  }
#
#    tags = {
#        environment = "CP2"
#    }
#
#}

resource "azurerm_network_interface" "myNicWorkers" {
  count               = var.nworkers
  name                = "vmnicworker${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration${count.index}"
    subnet_id                      = azurerm_subnet.mySubnet.id
    private_ip_address_allocation  = "Static" # Puede ser Static o Dynamic. En el caso de IP dinámica no sera necesario el parametro private_ip_address
    private_ip_address             = "10.0.1.${count.index + 100}"
    public_ip_address_id           = azurerm_public_ip.myPublicIpWorkers[count.index].id # Asignación de la IP pública
  }

    tags = {
        environment = "CP2"
    }

}

# Definición de la IP pública para poder acceder desde fuera de Azure
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIpMaster" {
  name                = "vmipMaster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic" # Necesario para la facturación

    tags = {
        environment = "CP2"
    }

}

#resource "azurerm_public_ip" "myPublicIp2" {
#  name                = "vmip2"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  allocation_method   = "Dynamic"
#  sku                 = "Basic" # Necesario para la facturación
#
#    tags = {
#        environment = "CP2"
#    }
#}

resource "azurerm_public_ip" "myPublicIpWorkers" {
  count               = var.nworkers
  name                = "vmipWorker${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic" # Necesario para la facturación

    tags = {
        environment = "CP2"
    }

}
