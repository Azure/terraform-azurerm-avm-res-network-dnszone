output "a_record_outputs" {
  description = "All A records created"
  value       = module.addrecords.a_record_outputs
}

output "aaaa_record_outputs" {
  description = "All AAAA records created"
  value       = module.addrecords.aaaa_record_outputs
}

output "cname_record_outputs" {
  description = "All CNAME records created"
  value       = module.addrecords.cname_record_outputs
}

output "mx_record_outputs" {
  description = "All MX records created"
  value       = module.addrecords.mx_record_outputs
}

output "txt_record_outputs" {
  description = "All TXT records created"
  value       = module.addrecords.txt_record_outputs
}
