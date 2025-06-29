terraform {
  backend "s3" {
    bucket         = "meu-terraform-state-developer"
    key            = "developer/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "meu-terraform-lock-table"
    encrypt        = true
  }
} 