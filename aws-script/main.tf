provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQCONAACBKULVD2G3"
  secret_key = "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"
}

# Create Dynamo DB

resource "aws_dynamodb_table" "user_content" {
  name           = "user_content"
  billing_mode   = "PROVISIONED" # Change this to "PROVISIONED" if you want provisioned capacity
  hash_key       = "ID"
  read_capacity  = 1000 # Adjust capacity units as needed
  write_capacity = 1000

  attribute {
    name = "ID"
    type = "S"
  }
}  