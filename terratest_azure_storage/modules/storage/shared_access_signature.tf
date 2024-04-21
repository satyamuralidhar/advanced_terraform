resource "time_offset" "days" {
  offset_days = 7
}
resource "time_static" "current" {}

data "azurerm_storage_account_sas" "sas_access" {
  connection_string = azurerm_storage_account.sas_access.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = var.env == "prod" ? false : true
    table = var.env == "prod" ? false : true
    file  = var.env == "prod" ? false : true
  }

  start  = time_static.current.rfc3339
  expiry = time_offset.days.rfc3339

  permissions {
    read    = true
    write   = var.env == "prod" ? false : true
    delete  = false
    list    = false
    add     = var.env == "prod" ? false : true
    create  = var.env == "prod" ? false : true
    update  = var.env == "prod" ? false : true
    process = false
    tag     = false
    filter  = false
  }
}

output "sas_url_query_string" {
  value = data.azurerm_storage_account_sas.sas_access.sas
}