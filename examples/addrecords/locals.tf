locals {
  a_records = {
    "web" = {
      name    = "www"
      ttl     = 300
      records = ["10.0.0.1", "10.0.0.2"]
      tags = {
        "environment" = "production"
      }
    }
    "api" = {
      name    = "api"
      ttl     = 300
      records = ["10.0.1.1"]
      tags = {
        "environment" = "production"
      }
    }
  }

  aaaa_records = {
    "web-ipv6" = {
      name    = "www"
      ttl     = 300
      records = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"]
      tags = {
        "environment" = "production"
      }
    }
  }

  cname_records = {
    "blog" = {
      name   = "blog"
      ttl    = 300
      record = "www.example-addrecords.com"
      tags = {
        "environment" = "production"
      }
    }
  }

  mx_records = {
    "mail" = {
      name = "@"
      ttl  = 300
      records = {
        "primary" = {
          preference = 10
          exchange   = "mail1.example-addrecords.com"
        }
        "secondary" = {
          preference = 20
          exchange   = "mail2.example-addrecords.com"
        }
      }
      tags = {
        "environment" = "production"
      }
    }
  }

  txt_records = {
    "verification" = {
      name = "@"
      ttl  = 300
      records = {
        "spf" = {
          value = "v=spf1 include:_spf.example.com ~all"
        }
        "verification" = {
          value = "example-domain-verification-token"
        }
      }
      tags = {
        "environment" = "production"
      }
    }
  }
}
