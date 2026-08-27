variable "name" {
  type        = string
  description = "The name of the this resource."
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
  nullable    = false
}

variable "a_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = optional(list(string))
    target_resource_id  = optional(string)
    tags                = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a A record."

  validation {
    condition = alltrue([
      for k, v in var.a_records : (
        !(v.records != null && v.target_resource_id != null) &&
        (v.records != null || v.target_resource_id != null)
      )
    ])
    error_message = "Either 'records' or 'target_resource_id' must be specified for each A record in 'a_records' at a time."
  }
}

variable "aaaa_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = optional(list(string))
    target_resource_id  = optional(string)
    tags                = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a AAAA record."

  validation {
    condition = alltrue([
      for k, v in var.aaaa_records : (
        !(v.records != null && v.target_resource_id != null) &&
        (v.records != null || v.target_resource_id != null)
      )
    ])
    error_message = "Either 'records' or 'target_resource_id' must be specified for each AAAA record in 'aaaa_records' at a time."
  }
}

variable "caa_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    record = map(object({
      flags = string
      tag   = string
      value = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a CAA record."
}

variable "cname_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    record              = string
    tags                = optional(map(string), null)
    target_resource_id  = optional(string)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a CNAME record."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
  Controls the Resource Lock configuration for this resource. The following properties can be specified:
  
  - `kind` - (Required) The type of lock. Possible values are `"CanNotDelete"` and `"ReadOnly"`.
  - `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
  DESCRIPTION

  validation {
    condition     = var.lock != null ? contains(["CanNotDelete", "ReadOnly"], var.lock.kind) : true
    error_message = "Lock kind must be either `\"CanNotDelete\"` or `\"ReadOnly\"`."
  }
}

variable "mx_records" {
  type = map(object({
    name                = optional(string, "@")
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records = map(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a MX record."
}

variable "ns_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = list(string)
    tags                = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a NS record."
}

variable "ptr_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records             = list(string)
    tags                = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a PTR record."
}

variable "srv_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records = map(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a SRV record."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "txt_records" {
  type = map(object({
    name                = string
    resource_group_name = string
    zone_name           = string
    ttl                 = number
    records = map(object({
      value = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a TXT record."
}
