terraform {
  backend "s3" {
    bucket         = "meu-terraform-state-production"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "meu-terraform-lock-table"
    encrypt        = true
  }
} 