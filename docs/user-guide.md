# Guia do Usuário - Provisionamento de Infraestrutura

Este guia fornece instruções passo a passo para desenvolvedores provisionarem e gerenciarem a infraestrutura do projeto **gerador-assinatura-email** utilizando Terraform.

---

## Pré-requisitos

- **Conta AWS:** Você deve ter acesso a uma conta AWS com permissões para criar e gerenciar recursos (VPC, EC2, ECR, S3, DynamoDB, etc).
- **AWS CLI:** [Instale e configure o AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- **Credenciais AWS:**  
  Configure suas credenciais AWS localmente usando:
  ```sh
  aws configure
  ```
  Ou defina as seguintes variáveis de ambiente:
  ```sh
  export AWS_ACCESS_KEY_ID=sua-access-key
  export AWS_SECRET_ACCESS_KEY=seu-secret-key
  export AWS_DEFAULT_REGION=us-east-1
  ```
- **Terraform:** [Instale o Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (versão >= 1.3.0).

---

## Configuração Inicial

1. **Clone o repositório:**
   ```sh
   git clone https://github.com/your-org/gerador-assinatura-email-infra.git
   cd gerador-assinatura-email-infra/terraform/environments/staging
   ```

2. **Crie o bucket S3 e a tabela DynamoDB para o state remoto:**
   - Bucket S3: `meu-terraform-state-staging`
   - Tabela DynamoDB: `meu-terraform-lock-table` com chave primária `LockID` (String)
   - Exemplo usando AWS CLI:
     ```sh
     aws s3 mb s3://meu-terraform-state-staging
     aws dynamodb create-table \
       --table-name meu-terraform-lock-table \
       --attribute-definitions AttributeName=LockID,AttributeType=S \
       --key-schema AttributeName=LockID,KeyType=HASH \
       --billing-mode PAY_PER_REQUEST
     ```

3. **Inicialize o Terraform:**
   ```sh
   terraform init
   ```

4. **Revise e aplique o plano:**
   ```sh
   terraform plan -out=plan
   terraform apply plan
   ```

---

## Observações

- **Nunca faça commit das suas credenciais AWS** no repositório.
- Cada ambiente (`staging`, `production`) possui sua própria configuração e state.
- A AMI utilizada para a EC2 é definida no arquivo `.tfvars` de cada ambiente.
- A infraestrutura inclui VPC, subnet pública, instância EC2 (para Docker), Security Group e repositório ECR.

---

## Solução de Problemas

- Se encontrar erros de state lock, verifique se a tabela DynamoDB está configurada corretamente.
- Para erros de região ou provider, confira se `aws_region` está definida nas variáveis ou no arquivo `.tfvars`.

---

## Links Úteis

- [Documentação do Provider AWS para Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Documentação AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

--- 