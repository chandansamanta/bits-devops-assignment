resource "aws_lambda_function" "user_content_uploadUserInfo" {
  function_name    = "uploadUserInfo"
  handler          = "uploadUserInfo.lambda_handler"
  runtime          = "python3.12"
  filename         = "uploadUserInfo.zip" # Path to your Lambda deployment package
  source_code_hash = filebase64("uploadUserInfo.zip")
  role             = aws_iam_role.lambda_exec.arn
  tracing_config {
    mode = "Active"
  } 
}

resource "aws_lambda_function" "user_content_downloadUserInfo" {
  function_name    = "downloadUserInfo"
  handler          = "downloadUserInfo.lambda_handler"
  runtime          = "python3.12"
  filename         = "downloadUserInfo.zip" # Path to your Lambda deployment package
  source_code_hash = filebase64("downloadUserInfo.zip")
  role             = aws_iam_role.lambda_exec.arn
  tracing_config {
    mode = "Active"
  }   
}



# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "cloudwatch_access_policy" {
  name       = "cloudwatch_access_policy"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess" # Adjust permissions as needed
  roles      = [aws_iam_role.lambda_exec.name]
}

# Attach an IAM policy to the Lambda execution role for Comprehend access
resource "aws_iam_policy_attachment" "comprehend_access_policy" {
  name       = "comprehend_access_policy"
  policy_arn = "arn:aws:iam::aws:policy/ComprehendFullAccess" # Adjust permissions as needed
  roles      = [aws_iam_role.lambda_exec.name]
}

resource "aws_iam_policy_attachment" "dynamodb_access_policy" {
  name       = "dynamodb_access_policy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess" # Adjust permissions as needed
  roles      = [aws_iam_role.lambda_exec.name]
}

resource "aws_cloudwatch_log_group" "uploadUserInfo" {
  name              = "/aws/lambda/uploadUserInfo"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "downloadUserInfo" {
  name              = "/aws/lambda/downloadUserInfo"
  retention_in_days = 14
}


