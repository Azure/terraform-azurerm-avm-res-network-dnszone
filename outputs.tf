output "a_record_outputs" {
  description = "The a record output"
  value = {
    for record_name, record in azurerm_dns_a_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value = {
    for record_name, record in azurerm_dns_aaaa_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "caa_record_outputs" {
  description = "The caa record output"
  value = {
    for record_name, record in azurerm_dns_caa_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "cname_record_outputs" {
  description = "The cname record output"
  value = {
    for record_name, record in azurerm_dns_cname_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "max_number_of_record_sets" {
  description = "Maximum number of Records in Zone output"
  value       = azurerm_dns_zone.zone.max_number_of_record_sets
}

output "mx_record_outputs" {
  description = "The mx record output"
  value = {
    for record_name, record in azurerm_dns_mx_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "name_servers" {
  description = "List of values that make up NS Record for Zone"
  value       = azurerm_dns_zone.zone.name_servers
}

output "ns_record_outputs" {
  description = "The ns record output"
  value = {
    for record_name, record in azurerm_dns_ns_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "number_of_record_sets" {
  description = "Number of records in DNS Zone"
  value       = azurerm_dns_zone.zone.number_of_record_sets
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value = {
    for record_name, record in azurerm_dns_ptr_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "resource_id" {
  description = "Id of dns zone"
  value       = azurerm_dns_zone.zone.id
}

output "srv_record_outputs" {
  description = "The srv record output"
  value = {
    for record_name, record in azurerm_dns_srv_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "txt_record_outputs" {
  description = "The txt record output"
  value = {
    for record_name, record in azurerm_dns_txt_record.record :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "lock" {
  description = "The lock resource. This will be `null` if no lock is configured."
  value       = var.lock != null ? azurerm_management_lock.this[0] : null
}
