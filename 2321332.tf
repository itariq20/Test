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
    yor_trace            = "9348dd70-37ac-4d11-b343-6f428aa4c14f"
    git_commit           = "3e4f81fc783bfcaf7babf7b25be51b3e878f5c6d"
    git_file             = "2321332.tf"
    git_last_modified_at = "2025-04-15 01:26:39"
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
