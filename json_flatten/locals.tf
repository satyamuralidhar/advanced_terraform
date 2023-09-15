locals {
    vnet = jsondecode(file("demo.json")).virtualNetworks

    network = flatten([
        for vnet_key , vnet_value in local.vnet : [
            for snet_key , snet_value in vnet_value.subnets: {
                    vnet_name = vnet_key
                    vnet_address = vnet_value.address_prefix
                    vnet_location = vnet_value.location
                    subnet_name = snet_key
                    subnet_address = snet_value.cidr_range
            }
            
        ]
    ])
}

output "network" {
  value = local.network
}

output "subnets" {
  value = {for k , v in local.network : v.subnet_name => v.subnet_address }
}
