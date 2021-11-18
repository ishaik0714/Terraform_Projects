provider "aws" {
  region      = "us-east-1"
  access_key  = "AKIAZZ6564OJI4IOLPPY"
  secret_key  = "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"
}

variable "my_cidr_block" {
  description = "VPC CIDR Block"
  default = "10.0.0.0/16"
  # cidr = "10.0.0.0/16"
}
resource "aws_vpc" "my-newvpc" {
  # cidr_block = "10.0.0.0/16"
  cidr_block = var.my_cidr_block
  instance_tenancy = "default"
    
   tags = {
    Name = "my-newvpc"
  }
}

# resource "aws_subnet" "my-newsubnet-a" {
#   vpc_id = aws_vpc.my-newvpc.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name = "my-newsubnet-a"
#   }
# }

# resource "aws_subnet" "my-newsubnet-b" {
#   vpc_id = aws_vpc.my-newvpc.id
#   cidr_block = "10.0.2.0/24"
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "my-newsubnet-b"
#   }
# }

# resource "aws_subnet" "my-newsubnet-c" {
#   vpc_id = aws_vpc.my-newvpc.id
#   cidr_block = "10.0.3.0/24"
#   availability_zone = "us-east-1c"
#   tags = {
#     Name = "my-newsubnet-c"
#   }
# }

# resource "aws_subnet" "my-newsubnet-d" {
#   vpc_id = aws_vpc.my-newvpc.id
#   cidr_block = "10.0.4.0/24"
#   availability_zone = "us-east-1d"
#   tags = {
#     Name = "my-newsubnet-d"
#   }
# }

# resource "aws_subnet" "my-newsubnet-e" {
#   vpc_id = aws_vpc.my-newvpc.id
#   cidr_block = "10.0.5.0/24"
#   availability_zone = "us-east-1e"
#   tags = {
#     Name = "my-newsubnet-e"
#   }
# }

# # resource "aws_subnet" "my-newsubnet-f" {
# #   vpc_id = aws_vpc.my-newvpc.id
# #   cidr_block = "10.0.6.0/24"
# #   availability_zone = "us-east-1f"
# #   tags = {
# #     Name = "my-newsubnet-f"
# #   }
# # }


# data "aws_vpc" "read-newvpc" {
#   id = aws_vpc.my-newvpc.id
# }


output "my-newvpc-id" {
  value = aws_vpc.my-newvpc.id
}

output "my-newvpc-cidr" {
  value = aws_vpc.my-newvpc.cidr_block
}