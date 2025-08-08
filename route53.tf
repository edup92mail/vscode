#################################
# Route53 Block
##################################

module "module_route53zone_public_main" {
  source     = "git@github.com:edu0p92/common-terraform-modules.git//route53zone?ref=main"
  Name       = "Main"
  Domain     = var.Route53.Public.Main
  Type       = "Public"
  Vpc        = module.module_vpc_main.Id
  Tags       = var.Tags
}

module "module_route53record_public_main_ses_verification" {
  source  = "git@github.com:edu0p92/common-terraform-modules.git//route53record?ref=main"
  Zone    = module.module_route53zone_public_main.Id
  Records = [
    {
      Name    = "_amazonses.${var.Route53.Public.InfoEmail}"
      Type    = "TXT"
      Ttl     = 300
      Values = [module.module_sesidentity_infoemail.VerificationToken]
    },
    {
      Name    = "_amazonses.${var.Route53.Public.LeadsEmail}"
      Type    = "TXT"
      Ttl     = 300
      Values = [module.module_sesidentity_leadsemail.VerificationToken]
    },
    {
      Name    = "_amazonses.${var.Route53.Public.MktEmail}"
      Type    = "TXT"
      Ttl     = 300
      Values = [module.module_sesidentity_mktemail.VerificationToken]
    }
  ]
}

module "module_route53record_public_main_ses_dkim" {
  source = "git@github.com:edu0p92/common-terraform-modules.git//route53record?ref=main"
  Zone   = module.module_route53zone_public_main.Id
  Records = flatten([
    for pair in [
      {
        tokens  = module.module_sesidentity_infoemail.DkimTokens
        domain  = var.Route53.Public.InfoEmail
      },
      {
        tokens  = module.module_sesidentity_leadsemail.DkimTokens
        domain  = var.Route53.Public.LeadsEmail
      },
      {
        tokens  = module.module_sesidentity_mktemail.DkimTokens
        domain  = var.Route53.Public.MktEmail
      }
    ] : [
      for token in pair.tokens : {
        Name   = "${token}._domainkey.${pair.domain}"
        Type   = "CNAME"
        Ttl    = 300
        Values = ["${token}.dkim.amazonses.com"]
      }
    ]
  ])
}

module "module_route53record_public_main_dmarc" {
  source = "git@github.com:edu0p92/common-terraform-modules.git//route53record?ref=main"
  Zone   = module.module_route53zone_public_main.Id
  Records = [
    for domain in [
      var.Route53.Public.InfoEmail,
      var.Route53.Public.LeadsEmail,
      var.Route53.Public.MktEmail
    ] : {
      Name   = "_dmarc.${domain}"
      Type   = "TXT"
      Ttl    = 300
      Values = ["v=DMARC1; p=none;"]
    }
  ]
}

module "module_route53record_public_main_ses_spf" {
  source  = "git@github.com:edu0p92/common-terraform-modules.git//route53record?ref=main"
  Zone    = module.module_route53zone_public_main.Id
  Records = [
    for domain in [
      var.Route53.Public.InfoEmail,
      var.Route53.Public.LeadsEmail,
      var.Route53.Public.MktEmail
    ] : {
      Name   = "${domain}"
      Type   = "TXT"
      Ttl    = 300
      Values = ["v=spf1 include:amazonses.com ~all"]
    }
  ]
}

module "module_route53zone_private_remote" {
  source     = "git@github.com:edu0p92/common-terraform-modules.git//route53zone?ref=main"
  Name       = "Remote"
  Domain     = var.Route53.Private.Remote
  Type       = "Private"
  Vpc        = module.module_vpc_main.Id
  Tags       = var.Tags
}

module "module_route53record_private_remote_test" {
  source  = "git@github.com:edu0p92/common-terraform-modules.git//route53record?ref=main"
  Zone    = module.module_route53zone_private_remote.Id
  Records = [
    {
      Name    = "test"
      Type    = "A"
      Ttl     = 300
      Values = ["8.8.8.8"]
    }
  ]
}