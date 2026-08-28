terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  ebs_block_device {
    device_name = "/dev/xvdba"
    volume_size = 10
    volume_type = "gp3"

  }

  tags = {
    Terraform            = "true"
    Environment          = "dev"
    git_commit           = "dd0cce242d2b7707a64f5ba2afda12ed33af2173"
    git_file             = "awsec2EBS.tf"
    git_last_modified_at = "2023-12-04 22:19:31"
    git_last_modified_by = "31933916+irfantariq1997@users.noreply.github.com"
    git_modifiers        = "31933916+irfantariq1997"
    git_org              = "itariq20"
    git_repo             = "Test"
    yor_name             = "ec2_instance"
    yor_trace            = "dc49d9da-cc96-4e62-9e5e-7d5455127f2d"
    manny                = "cepeda"
  }
}
