# Región de Azure donde desplegaremos
variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

# Definición del Storage Account
variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "storageaccountamsg"
}

# Clave pública para acceder por ssh a las máquinas virtuales
variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" # o la ruta correspondiente
}

# Usuario ssh para el acceso a las máquinas virtuales
variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "adminUsername"
}

