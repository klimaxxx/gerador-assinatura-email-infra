terraform {
  backend "s3" {
    bucket         = "gerador-template-email"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gerador-template-email-lock-table"
    encrypt        = true
  }
} 