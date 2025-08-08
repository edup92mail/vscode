Network = {
  Vpc = {
    Config = {
      Cidr        = "10.10.0.0/16"
      Ipv6Support = false
    }
    Subnets = {
      Public = {
        Main = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
      }
      Nat = {
        Main = ["10.10.20.0/24", "10.10.21.0/24", "10.10.22.0/24"]
      }
      Private = {
        Main = ["10.10.30.0/24", "10.10.31.0/24", "10.10.32.0/24"]
      }
    }
  }
}

Route53 = {
	Public = {
	}
	Private = {
	}
}

Ec2 = {
  Instaces = {
    Jump = {
      Image        = "ami-06d2fa08b9d976d86"
      InstanceType = "t4g.nano"
    }
  }
}

Tailscale = {
  AuthKey = ""
}