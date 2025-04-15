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
    yor_trace            = "e5379dc7-74bc-49dc-8b58-607b659f5f10"
    git_commit           = "a67dce50f4a49fb1c5c7d8953480e609fa1449dc"
    git_file             = "fasfas.tf"
    git_last_modified_at = "2025-04-15 01:29:14"
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
