terraform {
  backend "s3" {
    bucket         = "terraform-on-aws-eks-amora"
    key            = "preprod/backend.tfstate"
    region         = "us-east-1"
  }
}