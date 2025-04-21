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
    yor_trace            = "7d0715c0-ff6a-447d-8c0b-d5e75fbf0074"
    git_commit           = "e575c88168fd2cd9a91c58dcc072d8dc9d48a905"
    git_file             = "dsad.tf"
    git_last_modified_at = "2025-04-21 19:56:23"
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
