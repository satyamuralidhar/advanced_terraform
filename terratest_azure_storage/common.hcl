generate "backend" {
    path      = "backend.tf"
    if_exists = "overwrite"
    contents = <<EOF
backend "azurerm" {
    resource_group_name  = "terraformrsg"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "tfstdg01"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "terraformstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "${path_relative_to_include()}/terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
EOF
}