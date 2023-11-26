
variable "aws_region" {
  description = "Região onde os recursos serão criados na AWS"
  type        = string
  default     = "us-east-1"
}

variable "aws_key_pub" {
  description = "Chave pública para a máquina na AWS"
  type        = string
}

variable "service_name" {
  description = "Nome dos recursos a serem criados"
  type        = string
  default     = "terraform"
}

variable "instance_type" {
  type        = string
  description = "Tipo de máquina EC2"
  default     = "t3.micro"
}

variable "db_user" {
  type        = string
  description = "Usuário Database"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Senha Database"
  sensitive   = true
}