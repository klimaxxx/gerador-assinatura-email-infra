variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI para EC2"
  type        = string
  default     = "ami-000ec6c25978d5999"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "iam_instance_profile" {
  description = "Perfil IAM para EC2"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script para inicialização (ex: Docker)"
  type        = string
  default     = "<<-EOF
#!/bin/bash
yum update -y
amazon-linux-extras enable docker
yum install -y docker
service docker start
usermod -aG docker ec2-user
systemctl enable docker
EOF"
}