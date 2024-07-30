resource "azurerm_dns_zone" "zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_dns_a_record" "record" {
  for_each = var.a_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
  target_resource_id  = each.value.target_resource_id

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_aaaa_record" "record" {
  for_each = var.aaaa_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
  target_resource_id  = each.value.target_resource_id

  depends_on = [azurerm_dns_zone.zone]
}


resource "azurerm_dns_caa_record" "record" {
  for_each = var.caa_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.record
    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_cname_record" "record" {
  for_each = var.cname_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  record              = each.value.record
  tags                = lookup(each.value, "tags", null)
  target_resource_id  = each.value.target_resource_id

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_mx_record" "record" {
  for_each = var.mx_records

  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  name                = each.value.name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records
    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_ns_record" "record" {
  for_each = var.ns_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_ptr_record" "record" {
  for_each = var.ptr_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_srv_record" "record" {
  for_each = var.srv_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records
    content {
      port     = record.value.port
      priority = record.value.priority
      target   = record.value.target
      weight   = record.value.weight
    }
  }

  depends_on = [azurerm_dns_zone.zone]
}

resource "azurerm_dns_txt_record" "record" {
  for_each = var.txt_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value.value
    }
  }

  depends_on = [azurerm_dns_zone.zone]
}
