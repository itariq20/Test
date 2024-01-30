#Bucket Name
variable "name" {
}

variable "account_env" {
}

variable "bucket_name" {
}

variable "region" {
}

#Cloudfront Setting
variable "dns_domain" {
}

variable "dns_zone_id" {
}

variable "acm_certificate" {
}

variable "log_bucket_name" {
}

variable "redirect_url" {
}

variable "edge_lambda_name" {
}

variable "edge_lambda_role_name" {
}

variable "tagged_version" {
  description = "Jenkins build version"
  default = ""
}

data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_bucket_server_side_encryption_configuration" {
  bucket = var.bucket_name

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_logging" "aws_bucket_logging" {
  bucket = var.bucket_name

  target_bucket = "logging-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  target_prefix = "s3/${var.bucket_name}/"
}

resource "aws_s3_bucket_website_configuration" "aws_website_configuration" {
  bucket = var.bucket_name
  redirect_all_requests_to {
    host_name = var.redirect_url
    protocol  = "https"
  }
}

resource "aws_s3_bucket_acl" "aws_bucket_acl" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "aws_bucket_versioning" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "main" {
  statement {
    sid = "Grant a CloudFront Origin Identity access to support private content"

    actions = [
      "s3:GetObject"
    ]

    principals {
      type = "AWS"
      identifiers = [
      "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.main.id}"]
    }

    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_s3_bucket_public_access_block" "main" {
  # The dependency is added to ensure that the access block is created after the policy is applied.
  # Without the dependency, the asynchronous nature of aws_s3_bucket_public_access_block creation, conflicts
  # with S3 bucket policy updates, if happening in same terraform run.
  depends_on = [aws_s3_bucket_policy.main]

  bucket = var.bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = var.bucket_name
}

locals {
  edge_lambda_code = templatefile("${path.module}/redirect-lambda.js",
  { redirect_url = "https://${var.redirect_url}" })
}

data "archive_file" "edge_lambda_code_archive" {
  type        = "zip"
  output_path = "${path.module}/${var.edge_lambda_name}.zip"

  source {
    content  = local.edge_lambda_code
    filename = "lambda.js"
  }
}

data "aws_iam_role" "edge_lambda_role" {
  name = var.edge_lambda_role_name
}

resource "aws_lambda_function" "edge_lambda" {
  depends_on = [data.archive_file.edge_lambda_code_archive]

  function_name = var.edge_lambda_name
  role          = data.aws_iam_role.edge_lambda_role.arn
  runtime       = "nodejs18.x"

  handler = "lambda.handler"

  filename         = "${var.edge_lambda_name}.zip"
  source_code_hash = data.archive_file.edge_lambda_code_archive.output_base64sha256
  publish          = true
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = "${var.bucket_name}.s3-website-${var.region}.amazonaws.com"
    origin_id   = "s3-${var.bucket_name}.s3.amazonaws.com"

    custom_origin_config {
      http_port                = "80"
      https_port               = "443"
      origin_keepalive_timeout = "5"
      origin_protocol_policy   = "https-only"
      origin_read_timeout      = "30"
      origin_ssl_protocols     = ["TLSv1.2"]
    }
  }

  enabled = true
  comment = var.name

  logging_config {
    include_cookies = false
    bucket          = "${var.log_bucket_name}.s3.amazonaws.com"
    prefix          = var.name
  }

  aliases = [var.dns_domain]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-${aws_s3_bucket.main.bucket_domain_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = "${aws_lambda_function.edge_lambda.arn}:${aws_lambda_function.edge_lambda.version}"
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
}

resource "aws_route53_record" "main" {
  zone_id = var.dns_zone_id
  name    = var.dns_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = "false"
  }
}

