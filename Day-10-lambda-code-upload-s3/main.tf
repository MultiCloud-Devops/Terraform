

# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "dev-lambda-bucket-s3-tf"
  acl    = "private"
  force_destroy = true

  tags = {
    Name = "LambdaBucket"
  }
}

# Upload Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip" # Path to your zip file containing the Lambda code
  etag   = filemd5("lambda_function.zip")
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "dev_tf_lambda_from_s3" {
  function_name    = "dev_tf_lambda_from_s3"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "dev_tf_lambda_from_s3.lambda_handler"  
  s3_bucket        = aws_s3_bucket.lambda_bucket.id  
  s3_key           = aws_s3_object.lambda_code.key  
  timeout          = 10
  memory_size      = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE" # Example environment variable
    }
  }

  tags = {
    Name = "dev_tf_lambda_function"
  }
}