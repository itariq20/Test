data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["prod-shared-vpc"]
  }

}


data "aws_vpc" "cmh" {
  provider = aws.cmh
  filter {
    name   = "tag:Name"
    values = ["prod-vpc"]
  }

}


resource "aws_route53_zone" "this" {
  name    = "*********"
  comment = "prod-shared services"
  vpc {
    vpc_id = data.aws_vpc.this.id
  }

  lifecycle {
    ignore_changes = [vpc]
  }
  tags = {
    yor_name             = "this"
    yor_trace            = "69e36383-ceca-4d98-b992-cb02f8a010a3"
    git_commit           = "a0908cd9516cc4c766b453586d177b001967997e"
    git_file             = "dns.tf"
    git_last_modified_at = "2025-04-01 22:14:16"
    git_last_modified_by = "31933916+itariq20@users.noreply.github.com"
    git_modifiers        = "31933916+itariq20"
    git_org              = "itariq20"
    git_repo             = "Test"
  }
}

resource "aws_route53_zone_association" "secondary" {
  provider = aws.cmh
  zone_id  = aws_route53_zone.this.zone_id
  vpc_id   = data.aws_vpc.cmh.id
}
