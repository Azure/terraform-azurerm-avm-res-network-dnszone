locals {
  a_records = {
    "a_record" = {
      name                = "a_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records             = ["10.0.180.17", "10.0.180.18"]
      tags = {
        "cc" = "avm"
      }
    }
  }
  aaaa_records = {
    "aaaa_record" = {
      name                = "aaaa_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records             = ["fd5d:70bc:930e:d008:0000:0000:0000:7334", "fd5d:70bc:930e:d008::7335"]
      tags = {
        "cc" = "avm"
      }
    }
  }
  caa_records = {
    "caa_record" = {
      name                = "caa_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      record = {
        caa_record_1 = {
          flags = 0
          tag   = "issue"
          value = "example.com"
        }
        caa_record_2 = {
          flags = 0
          tag   = "issue"
          value = "example.net"
        }
      }
      tags = {
        "cc" = "avm"
      }
    }
  }
  cname_records = {
    "cname_record_prod" = {
      name                = "cname_record_prod"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      record              = "contoso-prod.com"
      tags = {
        "cc" = "avm"
      }
    }
    "cname_record_dev" = {
      name                = "cname_record_dev"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      record              = "contoso-dev.com"
      tags = {
        "cc" = "avm"
      }
    }
  }
  enable_telemetry = false
  lock = {
    kind = "CanNotDelete"
    name = "dns-zone-lock" # Optional - a default will be generated if not specified
  }
  mx_records = {
    "mx_record" = {
      name                = "mx_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records = {
        "record1" = {
          preference = 10
          exchange   = "mail1.contoso.com"
        }
        "record2" = {
          preference = 20
          exchange   = "mail2.contoso.com"
        }
      }
      tags = {
        "cc" = "avm"
      }
    }
  }
  name = "mydomain.com"
  ns_records = {
    "ns_record" = {
      name                = "ns_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records             = ["ns1.contoso.com", "ns2.contoso.com"]
      tags = {
        "cc" = "avm"
      }
    }
  }
  ptr_records = {
    "ptr_record" = {
      name                = "ptr_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records             = ["web1.contoso.com", "web2.contoso.com"]
      tags = {
        "cc" = "avm"
      }
    }
  }
  srv_records = {
    "srv_record" = {
      name                = "srv_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records = {
        "srvrecord1" = {
          priority = 1
          weight   = 5
          port     = 8080
          target   = "target1.contoso.com"
        }
        "srvrecord2" = {
          priority = 1
          weight   = 5
          port     = 8080
          target   = "target2.contoso.com"
        }
      }
      tags = {
        "cc" = "avm"
      }
    }
  }
  tags = {
    env = "prod"
  }
  txt_records = {
    "txt_record" = {
      name                = "txt_record"
      resource_group_name = "avmrg"
      zone_name           = "mydomain.com"
      ttl                 = 300
      records = {
        "txtrecord1" = {
          value = "google-site-authenticator"
        }
        "txtrecord2" = {
          value = "more site info here"
        }
      }
      tags = {
        "cc" = "avm"
      }
    }

  }
}
