terraform {
  required_version = "~> 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = "~> 0.3"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
}

resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}


module "test" {
  source = "../../"
  # source             = "Azure/avm-<res/ptn>-<name>/azurerm"
  # ...
  location            = azurerm_resource_group.avmrg.location
  name                = local.name
  resource_group_name = azurerm_resource_group.avmrg.name
  tags                = local.tags
  caa_records         = local.caa_records
  aaaa_records        = local.aaaa_records
  ns_records          = local.ns_records
  a_records           = local.a_records
  cname_records       = local.cname_records
  mx_records          = local.mx_records
  ptr_records         = local.ptr_records
  srv_records         = local.srv_records
  txt_records         = local.txt_records
  enable_telemetry    = var.enable_telemetry
}
