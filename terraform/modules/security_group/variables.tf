variable "name" {
  description = "Nome do security group"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
} 