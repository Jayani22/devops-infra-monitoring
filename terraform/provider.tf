terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.16.0"
        }
    }
    # s3 "backend" {
    #     name = "tf-state-backend-jayani"
    #     key = "terraform-ec2"
    #     encrypt = true
    # }
    
}

provider "aws" {
    region = "us-east-1"
}