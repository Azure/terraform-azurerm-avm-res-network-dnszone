terraform {
  required_version = "~> 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.74, < 5.0"
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
  source  = "Azure/avm-utl-regions/azurerm"
  version = "0.11.0"

  enable_telemetry = false
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
  version = "0.4.3"
}

data "azurerm_client_config" "current" {}

/*
resource "azurerm_resource_group" "this" {
  location = module.regions.regions[random_integer.region_index.result].name
  name     = module.naming.resource_group.name_unique
}
*/

module "dns_zones" {
  source = "../../"

  # source             = "Azure/avm-<res/ptn>-<name>/azurerm"
  # ...
  name                = local.name
  resource_group_name = azurerm_resource_group.this.name
  a_records           = local.a_records
  aaaa_records        = local.aaaa_records
  caa_records         = local.caa_records
  cname_records       = local.cname_records
  enable_telemetry    = local.enable_telemetry
  mx_records          = local.mx_records
  ns_records          = local.ns_records
  ptr_records         = local.ptr_records
  role_assignments = {
    deployment_dns_zone_contributor = {
      role_definition_id_or_name = "DNS Zone Contributor"
      principal_id               = data.azurerm_client_config.current.object_id
    }
  }
  srv_records = local.srv_records
  tags        = local.tags
  txt_records = local.txt_records
}
