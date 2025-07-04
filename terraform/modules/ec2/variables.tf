variable "ami" {
  description = "AMI para a instância EC2"
  type        = string
  default     = "ami-000ec6c25978d5999"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID para a EC2"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de security groups para a EC2"
  type        = list(string)
}

variable "iam_instance_profile" {
  description = "Perfil IAM para a EC2"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script para inicialização (ex: Docker)"
  type        = string
  default     = <<-EOF
#!/bin/bash
# Atualiza os pacotes
yum update -y
# Habilita e instala o Docker
amazon-linux-extras enable docker
yum install -y docker
# Inicia o serviço Docker
service docker start
# Adiciona o ec2-user ao grupo docker
usermod -aG docker ec2-user
# Habilita o Docker na inicialização
systemctl enable docker
EOF
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
} 