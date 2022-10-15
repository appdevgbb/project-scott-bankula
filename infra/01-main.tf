terraform {
  required_version = ">= 1.3.2"
  required_providers {
    azurerm = ">= 3.27.0"
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "uuid" {
  length = 4
  min_lower = 2
  min_numeric = 2
  special = false
}

locals {
  name = "${var.prefix}${random_string.uuid.result}"
}