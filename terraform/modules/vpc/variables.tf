variable "cidr_block" {
  description = "CIDR block da VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block da subnet pública"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidade para a subnet pública"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
} 