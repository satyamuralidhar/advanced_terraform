locals {
  #Getting all subnets cidr from the resource 
  all_subnets_cidr = [for i in local.all_subnets_name : aws_subnet.subnet[i].cidr_block]

  #Mergging all subnetname and subnet cidrs
  subnetname_cidr = zipmap(local.all_subnets_name, local.all_subnets_cidr)

  /*
  #app-subnet = setproduct(data.aws_availability_zones.available[*].names,local.all_subnets_name)
    #using compact function to remove null or "" in list
  #app_snet_cidr_name = compact([for i in local.subnetname_cidr : (substr(i,0,3) == "app") ? i : ""]) 
  subnet_filter = [for i in local.all_subnets_name : substr(i,0,3)]
*/


  # merging all subnet names 
  all_subnets_name = flatten([var.app_snet_name, var.rdb_snet_name, var.dev_snet_name])

  # create a key and values of subnet name and cidr based on tier like app , rdb , dev

  app_subnetname_cidr_list = { for k, v in local.subnetname_cidr : k => v if(substr(k, 0, 3) == "app") }
  rdb_subnetname_cidr_list = { for k, v in local.subnetname_cidr : k => v if(substr(k, 0, 3) == "rdb") }
  dev_subnetname_cidr_list = { for k, v in local.subnetname_cidr : k => v if(substr(k, 0, 3) == "dev") }


}