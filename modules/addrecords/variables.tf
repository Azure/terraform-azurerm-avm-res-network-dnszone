variable "resource_group_name" {
  type        = string
  description = "The resource group of the DNS zone."
}

variable "zone_name" {
  type        = string
  description = "The name of the DNS zone."
}

variable "a_records" {
  type = map(object({
    name               = string
    ttl                = number
    records            = optional(list(string))
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
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
    name               = string
    ttl                = number
    records            = optional(list(string))
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
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
    name = string
    ttl  = number
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
    name               = string
    ttl                = number
    record             = string
    target_resource_id = optional(string)
    tags               = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a CNAME record."
}

variable "mx_records" {
  type = map(object({
    name = optional(string, "@")
    ttl  = number
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
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a NS record."
}

variable "ptr_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a PTR record."
}

variable "srv_records" {
  type = map(object({
    name = string
    ttl  = number
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

variable "txt_records" {
  type = map(object({
    name = string
    ttl  = number
    records = map(object({
      value = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a TXT record."
}
