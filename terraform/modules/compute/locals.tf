locals {
  name_suffix = terraform.workspace == "dev" ? "" : "-${terraform.workspace}"
}
