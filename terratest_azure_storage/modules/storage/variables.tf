variable "resource_group_name" {}
variable "location" {}
variable "env" {
  default = "dev"
}
variable "storage_account_name" {}
variable "storage_container_name" {}
variable "dev_key_permisssions" {
  type = list(string)
  default = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover","Restore","Sign", "UnwrapKey","Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy","SetRotationPolicy"]
}
variable "dev_secret_permisssions" {
  type = list(string)
  default = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore"]
}
variable "prodcution_key_permissions" {
  type = list(string)
  default = ["Get", "List","Encrypt", "Decrypt"]
}
variable "production_secret_permissions" {
  type = list(string)
  default = ["Get", "List"]
}
