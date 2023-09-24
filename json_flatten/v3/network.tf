locals {
    rsg_local = jsondecode(file("network.json")).Resourcegroup
    network_local = jsondecode(file("network.json")).Virtualnetwork

    //resoucgroup01 for prod
    rsg01 = flatten([for k , v in local.rsg_local : [

        for key , val in v.production : {
          resource_group = substr(format("%s-%s","prod",val.resource_group),0,12)
          location = val.location
      }
    ]
     ])

    //resourcegroup2 for dr
    rsg02 = flatten([for k , v in local.rsg_local : [

        for key , val in v.dr : {
          resource_group = substr(format("%s-%s","dr",val.resource_group),0,12)
          location = val.location
      }
    ]
     ])
  //network if array 
    network = flatten([
        for network_key , network in local.network_local : [
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


      //network if map of object
    network02 = [
        for network_key , network in local.network_local : {
            for sub_key , subnet_val in network.subnets : 
            sub_key => merge({
              vnet_name = substr(format("%s-%s",network_key,"vnet"),0,15)
              location = network.location
              vnet_cidr = network.address_space
              subnet_name = format("%s-%s",network.location,sub_key)
              subnet_address = cidrsubnet(join("",network.address_space),8,subnet_val.address_prefix)
            })if sub_key != "delegated"
        } # if network_key != "dr"
    ]
}


