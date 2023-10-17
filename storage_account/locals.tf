
locals {

  azurerm_resource_group = {
    "resourcegroup01" = {
      name = "dev-resourcegroup"
      env  = "dev"
    }
    "resourcegroup02" = {
      name = "stage-resourcegroup"
      env  = "stage"
    }
    "resourcegroup03" = {
      name = "prod-resourcegroup"
      env  = "prod"
    }

  }


  resource_group_name = flatten([
    for rsg in local.azurerm_resource_group : [
      rsg.name
    ]
  ])



  azurerm_storage_account = [
    {
      account_tier             = "Standard"
      location                 = "eastus"
      account_replication_type = "LRS"
    }

  ]

  rsg_product = setproduct(values(local.azurerm_resource_group), local.azurerm_storage_account)

  collection_of_storage = {
    for i in local.rsg_product :
    format("%s-%s-%s", i[0]["env"], "storage", var.suffix) => {
      name = format("%s-%s-%s", i[0]["env"], "storage", var.suffix)
      location = i[1]["location"]
      # Note: test = "${ condition ? value : (elif-condition ? elif-value : else-value)}"
      resource_group_name      = i[0]["env"] == "prod" ? local.resource_group_name[2] : (i[0]["env"] == "dev" ? local.resource_group_name[0] : local.resource_group_name[1])
      account_tier             = i[0]["env"] == "prod" ? "Premium" : "Standard"
      account_replication_type = i[1]["account_replication_type"]


    }

  }



}

variable "suffix" {
  default = "st"
}

output "resource_group_name" {
  value = local.resource_group_name
}

output "collection_of_storage" {
  value = local.collection_of_storage
}


/*
commands: 
---------
$terraform init

$terraform plan -var-file=dev.tfvars -out tf.plan

$terraform show -no-color -json tf.plan > tfplan.json

*/
