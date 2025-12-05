module "vpc" {
  source = "git::https://github.com/example/module?ref=main"


  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform            = "true"
    Environment          = "dev"
    yor_name             = "vpc"
    yor_trace            = "e6758c38-095e-49f8-bdb2-3681fc71b08a"
    git_commit           = "8e0d6dabe665f527042737290a1565b248f55f64"
    git_file             = "ckv2test.tf"
    git_last_modified_at = "2025-12-05 23:42:12"
    git_last_modified_by = "31933916+itariq20@users.noreply.github.com"
    git_modifiers        = "31933916+itariq20"
    git_org              = "itariq20"
    git_repo             = "Test"
  }
}
