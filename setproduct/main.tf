
locals {
    rsgs_list = setproduct(values(var.users),var.rsgs)
    users_rsgs = {
    for i in local.rsgs_list : 
    format("%s-%s",i[0]["name"],i[1]["suffix"]) => {
        username = i[0]["name"]
        resource_group_name = format("%s-%s",i[0]["name"],i[1]["suffix"])
        suffix = i[1]["suffix"]
        location =i[1]["location"]
        storage = i[1]["storage"]
        bastion = i[1]["bastion"]
        }
    }

}

variable "users" {
  type = map
}
variable "rsgs" {
  type = list
}

output "demo" {
  value = local.rsgs_list
}

output "demo2" {
  value = local.users_rsgs
}


