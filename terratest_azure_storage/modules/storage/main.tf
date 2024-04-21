terraform {
  required_providers {
    azurerm = {
      version = "~>3.0.0"
      source  = "hashicorp/azurerm"
    }
    time = {
      source = "hashicorp/time"
      version = "0.11.1"
    }
  }

  required_version = ">=0.13.0"
}
provider "time" {}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

resource "azurerm_resource_group" "myrsg" {
  location = var.resource_group_name
  name     = var.location
}

locals {
  tags = {
    environment = var.env,
    subscription = format('%s-%s',var.env,"subscription"),
    budget = format('%s-%s',var,env,"budget"),
    businessunit = format('%s-%s',var.env,"bu")
  }
}
resource "azurerm_storage_account" "stg" {
  account_replication_type = var.env == "prod" ? "GRS" : "LRS"
  account_tier             = var.env == "prod" ? "Premium" : "Standard"
  location                 = azurerm_resource_group.myrsg.location
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.myrsg.name
  identity {
    type = "SystemAssigned"
  }
  tags = local.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  location            = var.location
  name                = var.keyvault_name
  resource_group_name = azurerm_resource_group.myrsg.name
  sku_name            = var.env == "prod" ? "Premium" : "Standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags = local.tags
}

resource "azurerm_key_vault_access_policy" "kvpolicy" {
  key_vault_id = azurerm_key_vault.kv.id
  object_id    = azurerm_storage_account.stg.identity.0.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_permissions = var.env == "prod" ? var.prodcution_key_permissions : var.dev_key_permisssionss
  secret_permissions = var.env == "prod" ? var.production_secret_permissions : var.dev_secret_permisssions
}

resource "azurerm_storage_container" "container" {
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.stg.name
}

output "keyvault_id" {
  value = [for i in azurerm_key_vault.kv.name : i.id ]
}
