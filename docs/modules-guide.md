# Guia dos Módulos Terraform

Este documento descreve os módulos disponíveis no projeto e como utilizá-los em outros projetos Terraform.

---

## 1. Módulo VPC

**Caminho:** `terraform/modules/vpc`

### Descrição
Provisiona uma VPC pública, incluindo subnet pública, internet gateway e tabela de rotas.

### Parâmetros
| Nome                | Tipo        | Obrigatório | Descrição                                      |
|---------------------|-------------|-------------|------------------------------------------------|
| `cidr_block`        | string      | Sim         | CIDR block da VPC (ex: "10.0.0.0/16")        |
| `public_subnet_cidr`| string      | Sim         | CIDR block da subnet pública                   |
| `availability_zone` | string      | Sim         | Zona de disponibilidade (ex: "us-east-1a")   |
| `tags`              | map(string) | Não         | Tags para os recursos (default: `{}`)          |

### Outputs
| Nome                | Descrição                                  |
|---------------------|--------------------------------------------|
| `vpc_id`            | ID da VPC criada                           |
| `public_subnet_id`  | ID da subnet pública criada                |

### Exemplo de uso
```hcl
module "vpc" {
  source              = "../modules/vpc"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  availability_zone   = "us-east-1a"
  tags = {
    Environment = "dev"
    Project     = "meu-projeto"
  }
}
```

---

## 2. Módulo EC2

**Caminho:** `terraform/modules/ec2`

### Descrição
Provisiona uma instância EC2, pronta para rodar um container Docker.

### Parâmetros
| Nome                  | Tipo         | Obrigatório | Descrição                                         |
|-----------------------|--------------|-------------|---------------------------------------------------|
| `ami`                 | string       | Sim         | ID da AMI a ser utilizada                         |
| `instance_type`       | string       | Sim         | Tipo da instância EC2 (ex: "t2.micro")          |
| `subnet_id`           | string       | Sim         | ID da subnet onde a EC2 será criada               |
| `security_group_ids`  | list(string) | Sim         | Lista de IDs de security groups                   |
| `iam_instance_profile`| string       | Não         | Perfil IAM para a EC2 (default: `null`)           |
| `user_data`           | string       | Não         | Script de inicialização (ex: para instalar Docker) |
| `tags`                | map(string)  | Não         | Tags para os recursos (default: `{}`)             |

### Outputs
| Nome         | Descrição                |
|--------------|-------------------------|
| `instance_id`| ID da instância EC2     |
| `public_ip`  | IP público da EC2       |

### Exemplo de uso
```hcl
module "ec2" {
  source              = "../modules/ec2"
  ami                 = "ami-xxxxxxxx"
  instance_type       = "t2.micro"
  subnet_id           = module.vpc.public_subnet_id
  security_group_ids  = [module.security_group.security_group_id]
  iam_instance_profile = null
  user_data           = ""
  tags = {
    Environment = "dev"
    Project     = "meu-projeto"
  }
}
```

---

## 3. Módulo Security Group

**Caminho:** `terraform/modules/security_group`

### Descrição
Cria um security group para EC2 pública, liberando portas 80, 443 e 22 para o mundo.

### Parâmetros
| Nome     | Tipo        | Obrigatório | Descrição                        |
|----------|-------------|-------------|----------------------------------|
| `name`   | string      | Sim         | Nome do security group           |
| `vpc_id` | string      | Sim         | ID da VPC                        |
| `tags`   | map(string) | Não         | Tags para os recursos (default: `{}`) |

### Outputs
| Nome               | Descrição                |
|--------------------|-------------------------|
| `security_group_id`| ID do security group     |

### Exemplo de uso
```hcl
module "security_group" {
  source = "../modules/security_group"
  name   = "dev-ec2-sg"
  vpc_id = module.vpc.vpc_id
  tags = {
    Environment = "dev"
    Project     = "meu-projeto"
  }
}
```

---

## 4. Módulo ECR

**Caminho:** `terraform/modules/ecr`

### Descrição
Cria um repositório ECR para armazenar imagens Docker.

### Parâmetros
| Nome   | Tipo        | Obrigatório | Descrição                        |
|--------|-------------|-------------|----------------------------------|
| `name` | string      | Sim         | Nome do repositório ECR          |
| `tags` | map(string) | Não         | Tags para o repositório (default: `{}`) |

### Outputs
| Nome            | Descrição                        |
|-----------------|---------------------------------|
| `repository_url`| URL do repositório ECR criado    |

### Exemplo de uso
```hcl
module "ecr" {
  source = "../modules/ecr"
  name   = "meu-projeto-ecr"
  tags = {
    Environment = "dev"
    Project     = "meu-projeto"
  }
}
```

---

## Como reutilizar os módulos

- Use o parâmetro `source` para apontar para o caminho relativo do módulo ou para o repositório Git.
- Consulte sempre o arquivo `variables.tf` de cada módulo para saber os parâmetros obrigatórios e opcionais.
- Utilize os outputs dos módulos para conectar recursos entre si (ex: passar o `public_subnet_id` do módulo VPC para o EC2). 