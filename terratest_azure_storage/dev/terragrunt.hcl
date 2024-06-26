include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "../modules//storage"
  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]

    required_var_files = ["dev.tfvars"]
  }

}