# Cicd

variable "Tags" {
  type = object({
    Project = string
    Repo    = string
    Stage   = string
  })
}

# Project

variable "Network" {
  type = object({
    Vpc = object({
      Config     = object({
        Cidr         = string
        Ipv6Support = bool
      })
      Subnets = object({
        Public  = map(list(string))
        Nat     = optional(map(list(string)))
        Private = optional(map(list(string)))
      })
    })
  })
}

variable "Route53" {
  type = object({
    Public  = map(string)
    Private = map(string)
  })
}

variable "Ec2" {
  type = object({
    Instaces = object({
      Jump = object({
        Image   = string
        InstanceType = string
      })
    })
    KeyPairs = object({
      Main   = string
    })
  })
}

variable "Tailscale" {
  type = object({
    AuthKey = string
  })
  sensitive = true
}