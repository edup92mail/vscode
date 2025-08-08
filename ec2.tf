#################################
# KeyPairs Block
##################################

module "module_keypair_main" {
  source      = "git@github.com:edu0p92/common-terraform-modules.git//keypair?ref=main"
  Name        = "Main"
  PublicKeyB64 =  var.Ec2.KeyPairs.Main
  Tags = var.Tags
}

#################################
# Amis Block
##################################

module "module_ami_jump" {
  source      = "git@github.com:edu0p92/common-terraform-modules.git//ami?ref=main"
  Name        = "Jump"
  Source    = "./src/playbooks/jump/"
  Instance = {
    ParentImage    = var.Ec2.Instaces.Jump.Image
    InstanceType   = var.Ec2.Instaces.Jump.InstanceType
    KeyPair        = module.module_keypair_main.Name
    Subnet         = module.module_vpc_main.SubnetPublic["Main"][0]
    SecurityGroup  = module.module_sg_instance_jump.Id
  }
  ExtraVars = {
    AUTHKEY  = var.ENV_TAILSCALE.AuthKey,
    ROUTES = concat(
      flatten([for _, cidrs in lookup(var.Network.Vpc.Subnets, "Nat", {}) : cidrs]),
      flatten([for _, cidrs in lookup(var.Network.Vpc.Subnets, "Private", {}) : cidrs])
    )
    DOMAINS = var.Network.Route53.Private.Remote
    HOSTNAME = "Jump${var.Tags.Project}${var.Tags.Stage}"
  }
  Tags = var.Tags
}

#################################
# Instances Block
##################################

module "module_instance_jump" {
  source        = "git@github.com:edu0p92/common-terraform-modules.git//instance?ref=main"
  Name          = "Jump"
  Image         = module.module_ami_jump.Id
  InstanceType  = var.Ec2.Instaces.Jump.InstanceType
  KeyPair       = module.module_keypair_main.Name
  Subnet        = module.module_vpc_main.SubnetPublic["Main"][0]
  SecurityGroup = module.module_sg_instance_jump.Id
  Tags = var.Tags
}
