variable "prefix" {
  type = string
}

variable "resource_group" {
}

variable "instances" {
  type = number
  default = 2
}

variable "vm_sku" {
  type = string
  default = "Standard_FX4mds"
}

variable "admin_username" {
  type = string
  default = "azdoadmin"
}

variable "admin_ssh_key" {
  type = string
}

variable "azdo_org_name" {
  type = string
}

variable "azdo_pat" {
  type = string
}

variable "azdo_pool_name" {
  type = string
}