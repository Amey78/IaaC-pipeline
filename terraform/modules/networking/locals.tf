# Keep dev names unchanged; separate other environments
locals {
  name_suffix = terraform.workspace == "dev" ? "" : "-${terraform.workspace}"
}
