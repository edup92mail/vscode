#################################
# Sgs Block
##################################

module "module_sg_test" {
  source = "git@github.com:edu0p92/common-terraform-modules.git//sg?ref=main"
  Name   = "Test"
  VpcId  = module.module_vpc_main.Id
  Ingress = [
    {
      FromPort = 0
      ToPort   = 0
      Protocol = "-1"
      Cidr     = "0.0.0.0/0"
    }
  ]
  Tags   = var.Tags
}


module "module_sg_instance_jump" {
  source      = "git@github.com:edu0p92/common-terraform-modules.git//sg?ref=main"
  Name        = "InstanceJump"
  VpcId       =  module.module_vpc_main.Id
  Tags = var.Tags
}