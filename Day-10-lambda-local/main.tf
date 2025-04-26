resource "aws_lambda_function" "dev_tf_lambda_local" {
  function_name = "dev_tf_lambda_local"
   runtime       = "python3.12"
  role          = aws_iam_role.dev_tf_lambda_role.arn
  handler       = "dev_tf_lambda_local.lambda_handler"
  timeout       = 900
  memory_size   = 128

  filename         = "dev_tf_lambda_local.zip"  # Ensure this file exists
  source_code_hash = filebase64sha256("dev_tf_lambda_local.zip")
}


# IAM Role for Lambda Execution
resource "aws_iam_role" "dev_tf_lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach AWS-Managed Policy for Basic Execution
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.dev_tf_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}