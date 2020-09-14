resource "aws_s3_bucket" "main-bucket" {
  bucket = "main-bucket"
  acl    = "private"

  tags = {
    Name = "main-bucket"
  }
}

resource "aws_s3_bucket_object" "s3_folder" {
    provider = aws
    bucket   = aws_s3_bucket.main-bucket.id
    acl      = "private"
    key      =  "${var.S3_FOLDER_NAME}/"
}