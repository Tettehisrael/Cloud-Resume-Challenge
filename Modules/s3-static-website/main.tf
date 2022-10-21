#s3.terraform 
# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket        = "www.${var.bucket_name}"
  force_destroy = "true"
  acl           = "public-read"
  policy        = templatefile("templates/s3-public.json", { bucket = "www.${var.bucket_name}" })

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket = "var-bucket-name"
  acl    = "public-read"
  policy = templatefile("templates/s3-public.json", { bucket = "var-bucket-name" })

  website {
    redirect_all_requests_to = aws_s3_bucket.www_bucket.bucket_regional_domain_name
  }
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

output "website_endpoint" {
  value = aws_s3_bucket.www_bucket.bucket_regional_domain_name
}

