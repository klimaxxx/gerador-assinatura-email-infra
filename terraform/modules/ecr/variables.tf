variable "name" {
  description = "Nome do repositório ECR"
  type        = string
}

variable "tags" {
  description = "Tags para o repositório"
  type        = map(string)
  default     = {}
} 