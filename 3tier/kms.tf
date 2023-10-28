resource "aws_kms_key" "kms" {
  description             = "KMS Key 1"
  deletion_window_in_days = 10
  enable_key_rotation     = var.enable_key_rotation == false ? false : true
}

variable "enable_key_rotation" {
  default = false
}