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