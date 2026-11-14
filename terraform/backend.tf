
terraform {
  backend "s3" {
    bucket         = "iaac-pipeline-tfstate"
    key            = "zero-touch-deployments/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "iaac-pipeline-locks"
  }
}
