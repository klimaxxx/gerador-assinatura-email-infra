variable "cidr_block" {
  description = "CIDR block da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block da subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Zona de disponibilidade para a subnet pública"
  type        = string
  default     = "us-east-1a"
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
} 