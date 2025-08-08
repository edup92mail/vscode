##############################
# Identity Block
##############################

module "module_sesidentity_infoemail" {
  source      = "git@github.com:edu0p92a6w169/common-terraform-modules.git//sesidentity?ref=main"
  Domain      = var.Network.Route53.Public.InfoEmail
  providers = {
    aws = aws.eu_west_1
  }
}

module "module_sesidentity_leadsemail" {
  source      = "git@github.com:edu0p92a6w169/common-terraform-modules.git//sesidentity?ref=main"
  Domain      = var.Network.Route53.Public.LeadsEmail
  providers = {
    aws = aws.eu_west_1
  }
}

module "module_sesidentity_mktemail" {
  source      = "git@github.com:edu0p92a6w169/common-terraform-modules.git//sesidentity?ref=main"
  Domain      = var.Network.Route53.Public.MktEmail
  providers = {
    aws = aws.eu_west_1
  }
}