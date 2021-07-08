# Definición del tamaño de la máquina virtual
variable "vm_size" {
  type = string
  description = "Tamaño de la máquina virtual"
  default = "Standard_D1_v2" # 3.5 GB, 1 CPU 
}

# Definición del tamaño de la máquina virtual de los workers
variable "vmworker_size" {
  type = string
  description = "Tamaño de la máquina virtual de los workers"
  default = "Standard_D1_v2" # 4 GB, 2 CPU
}

# Definición de los entornos de trabajo
# index = 0 es dev, index = 1 es pre
variable "entornos" {
  type = list(string)
  description = "Entornos"
  default = ["dev", "pre"]
}

# Máqinas virtuales nfs y máster. No se tiene en cuenta los workers aquí.
variable "vms" {
  type = list(string)
  description = "Máquinas para la arquitectura de Kubernetes"
  default = ["nfs", "master"]
}

# Variable con el número de workers que se desean desplegar
variable "nworkers" {
  type = number
  description = "Numero de máquinas virtuales"
  default = "2"
}
