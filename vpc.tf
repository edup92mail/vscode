##############################
# VPC Block
##############################

module "module_vpc_main" {
  source      = "git@github.com:edu0p92a6w169/common-terraform-modules.git//vpc?ref=main"
  Name        = "Main"
  Cidr        = var.Network.Vpc.Config.Cidr
  Ipv6Support = var.Network.Vpc.Config.Ipv6Support
  Subnets     = var.Network.Vpc.Subnets
  Tags        = var.Tags
}