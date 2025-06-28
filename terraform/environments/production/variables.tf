variable "ami" {
  description = "AMI para EC2"
  type        = string
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
  description = "User data para EC2 (ex: script Docker)"
  type        = string
  default     = ""
} 