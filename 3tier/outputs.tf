# output "all_subnets_cidr" {
#   value = local.all_subnets_cidr
# }

# output "all_subnets" {
#   value = local.all_subnets_name
# }

output "app_subnetname_cidr_list" {
  value = local.app_subnetname_cidr_list
}

output "rdb_subnetname_cidr_list" {
  value = local.rdb_subnetname_cidr_list
}

output "dev_subnetname_cidr_list" {
  value = local.dev_subnetname_cidr_list
}
# output "azs" {
#   value = data.aws_availability_zones.available.names
# }

