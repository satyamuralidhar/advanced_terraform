locals {
    file = jsondecode(file("network.json")).Virtualnetwork
    network = flatten([
        for network_key , network in local.file : [
            for sub_key , subnet_val in network.subnets : {
              vnet_name = substr(format("%s-%s",network_key,"vnet"),0,15)
              location = network.location
              vnet_cidr = network.address_space
              subnet_name = format("%s-%s",network.location,sub_key)
              //cidrsubnet funtion need cidradress as string not list [], ""
              subnet_address = cidrsubnet(join("",network.address_space),8,subnet_val.address_prefix)
            } if sub_key != "delegated"
        ]#if network_key != "dr"
    ])
}

output "network" {
  value = local.network
}