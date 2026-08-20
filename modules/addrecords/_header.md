# Adding DNS records module

This module is used to add DNS records to an existing public DNS zone.

## Features

This module supports adding DNS records to an existing public DNS zone. Any DNS records supported by public DNS zone can be added, including:
- A records
- AAAA records
- CAA records
- CNAME records
- MX records
- NS records
- PTR records
- SRV records
- TXT records

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables which are **resource_group_name** and **zone_name**, then followed by the optional variables representing the various DNS records.

### Example - Basic A record

This example shows the most basic usage of the module. It adds A records to an existing public DNS zone.

```terraform

locals {
  a_records = {
    "a_record1" = {
      name    = "my_arecord1"
      ttl     = 300
      records = ["10.1.1.1", "10.1.1.2"]
      tags = {
        "env" = "prod"
      }
    }

    "a_record2" = {
      name    = "my_arecord2"
      ttl     = 300
      records = ["10.2.1.1", "10.2.1.2"]
      tags = {
        "env" = "dev"
      }
    }
  }
}

module "addrecords" {
  source              = "Azure/avm-res-network-dnszone/azurerm//modules/addrecords"
  resource_group_name = "my-resource-group"
  zone_name           = "mydomain.com"
  a_records           = local.a_records
}

```

### Example - Multiple record types

This example shows how to add multiple record types to an existing DNS zone.

```terraform

locals {
  a_records = {
    "web" = {
      name    = "www"
      ttl     = 300
      records = ["10.0.0.1"]
    }
  }

  cname_records = {
    "blog" = {
      name   = "blog"
      ttl    = 300
      record = "www.mydomain.com"
    }
  }

  mx_records = {
    "mail" = {
      name = "@"
      ttl  = 300
      records = {
        "primary" = {
          preference = 10
          exchange   = "mail.mydomain.com"
        }
      }
    }
  }
}

module "addrecords" {
  source              = "Azure/avm-res-network-dnszone/azurerm//modules/addrecords"
  resource_group_name = "my-resource-group"
  zone_name           = "mydomain.com"
  a_records           = local.a_records
  cname_records       = local.cname_records
  mx_records          = local.mx_records
}

```

## Use Case: Hub & Spoke Topology

This module is particularly useful in a Hub & Spoke network topology where:
1. The DNS zone is created in the Hub
2. Spoke networks need to add their own DNS records to the shared zone

Each spoke can use this module to independently manage its DNS records without recreating the zone.
