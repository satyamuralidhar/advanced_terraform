vpc_cidr_block = "192.168.0.0/16"
location       = "ap-south-1"

app_snet_name = ["app-sub-01", "app-sub-02", "app-sub-03"]
rdb_snet_name = ["rdb-sub-01", "rdb-sub-02", "rdb-sub-03"]
dev_snet_name = ["dev-sub-01", "dev-sub-02", "dev-sub-03"]
#rds_names = ["rds01","rds02","rds03"]
db_instance_size    = "db.t3.micro"
enable_key_rotation = true
# db_user_name = 
# db_password = 
ssm_db_user_name = "satya123"

ssm_db_password   = "admin123"
ssm_paasword_type = "SecureString"