// create s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket
  acl    = "public-read"
}

// upload lambda zip file to s3
resource "aws_s3_bucket_object" "object" {
	bucket = aws_s3_bucket.s3_bucket.id
	key = "url_api"
	acl    = "public-read"
	source = "api/lambda_api_zip.zip"
}

// lambda execution role
resource "aws_iam_role" "lambda_role" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

// create lambda function
resource "aws_lambda_function" "url_shortner_lambda" {
  s3_bucket = aws_s3_bucket.s3_bucket.id
  s3_key      = "url_api"
  function_name = var.lambda_func_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  
  depends_on = [aws_s3_bucket_object.object]
}