../shared/provider.tf

module "vpc" {
  source              = "../../modules/vpc"
  cidr_block          = "10.20.0.0/16"
  public_subnet_cidr  = "10.20.1.0/24"
  availability_zone   = "us-east-1a"
  tags = {
    Environment = "production"
    Project     = "gerador-assinatura-email"
  }
}

module "security_group" {
  source = "../../modules/security_group"
  name   = "prod-ec2-sg"
  vpc_id = module.vpc.vpc_id
  tags = {
    Environment = "production"
    Project     = "gerador-assinatura-email"
  }
}

module "ec2" {
  source              = "../../modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = module.vpc.public_subnet_id
  security_group_ids  = [module.security_group.security_group_id]
  iam_instance_profile = var.iam_instance_profile
  user_data           = var.user_data
  tags = {
    Environment = "production"
    Project     = "gerador-assinatura-email"
  }
}

module "ecr" {
  source = "../../modules/ecr"
  name   = "gerador-assinatura-email-production"
  tags = {
    Environment = "production"
    Project     = "gerador-assinatura-email"
  }
} 