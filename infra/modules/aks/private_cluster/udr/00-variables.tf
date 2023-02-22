variable "resource_group" {
  type = object
}

variable "outbound_type" {
  type = string
}

variable "api_server_subnet_id" {
  type = string
}

variable "worker_subnet_id" {
  type = string
}

variable "admin_group_object_ids" {
  type = list
}