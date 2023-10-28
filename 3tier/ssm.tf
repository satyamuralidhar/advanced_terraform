resource "aws_ssm_parameter" "ssm" {
  name  = var.ssm_db_user_name
  type  = var.ssm_paasword_type
  value = var.ssm_db_password
}

variable "ssm_db_user_name" {
  sensitive = true
}

variable "ssm_db_password" {
  sensitive = true
}
variable "ssm_paasword_type" {}