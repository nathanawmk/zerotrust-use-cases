resource "aws_s3_bucket" "scytale-bucket" {
  bucket = "scytale-oidc"
  acl    = "private"
  region = var.region

  tags = {
    Name      = "scytale-oidc"
    yor_trace = "0d4bad95-66b2-4e56-af8f-c833a28f286a"
  }
}

resource "aws_s3_bucket_object" "scytale_object" {
  key                    = "scytale_object"
  bucket                 = aws_s3_bucket.scytale-bucket.id
  source                 = "files/test.txt"
  server_side_encryption = "AES256"
  tags = {
    yor_trace = "f77b2fb8-f4d0-4165-bece-293797ddb4ca"
  }
}