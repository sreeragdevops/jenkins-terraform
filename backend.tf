terraform {
  backend "s3" {
    bucket         = "tfstatelockaws321"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
  }
}
