terraform {
  required_version = "~> 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.74, < 5.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# This example assumes a DNS zone already exists.
# In this case, we create it first for demonstration purposes,
# but in a real Hub & Spoke scenario, this would already exist.
resource "azurerm_resource_group" "example" {
  location = "East US"
  name     = "example-dns-rg"
}

resource "azurerm_dns_zone" "example" {
  name                = "example-addrecords.com"
  resource_group_name = azurerm_resource_group.example.name
}

# Now use the addrecords module to add records to the existing zone
module "addrecords" {
  source = "../../modules/addrecords"

  resource_group_name = azurerm_resource_group.example.name
  zone_name           = azurerm_dns_zone.example.name
  a_records           = local.a_records
  aaaa_records        = local.aaaa_records
  cname_records       = local.cname_records
  mx_records          = local.mx_records
  txt_records         = local.txt_records
}
