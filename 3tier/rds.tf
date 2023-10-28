resource "aws_db_instance" "rds" {
  for_each          = toset(var.rdb_snet_name)
  allocated_storage = 10
  #db_name              = var.rds_names
  availability_zone    = element(data.aws_availability_zones.available.names, index(var.rdb_snet_name, each.key))
  db_subnet_group_name = each.value
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instance_size
  username             = var.ssm_db_user_name
  password             = var.ssm_db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

#variable "rds_names" {}
variable "db_instance_size" {}
# variable "db_user_name" {
#   sensitive = true
# }
# variable "db_password" {
#   sensitive = true
# }
