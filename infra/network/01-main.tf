terraform {
  required_version = ">= 1.3.9"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.44.1"
    }
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