terraform {
  backend "s3" {
    bucket         = "joriz-terraform-state"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
  }
}

