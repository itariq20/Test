# main.tf

provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  instance_type = "t2.micro"
  ami_id = "ami-0c94855ba95c71c99"
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}