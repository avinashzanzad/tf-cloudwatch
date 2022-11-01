
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.34.0"
    }
  }
}

provider "aws" {

  region  = "us-east-2"
  profile = "demo-server"

} 


