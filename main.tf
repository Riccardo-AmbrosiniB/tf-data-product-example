terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "quantyca-internal-giandomenico-avelluto"
    storage_account_name = "quantycaodmterraform"
    container_name       = "terraform-state"
    key                  = "odm/terraform.tfstate"
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Deploy VM
module "virtual_machines" {
  source = "./modules/virtual_machines"
  #lake_name = var.lake_name
  resource_group_name = var.resource_group_name
  region = var.region
}
