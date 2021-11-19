provider "aws" {
  region      = "us-east-1"
  access_key  = "AKIAZZ6564OJI4IOLPPY"
  secret_key  = "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"
}

resource "aws_vpc" "myproj-vpc" {
  cidr_block = var.myvpc_cidr_block
  tags = {
    Name = "myproj-vpc"
  }
}

resource "aws_subnet" "myproj-subnet-a" {
  vpc_id = aws_vpc.myproj-vpc.id
  cidr_block = var.mysubnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "myproj-subnet-a"
  }
}

resource "aws_default_route_table" "myproj-main-route-table" {
  default_route_table_id = aws_vpc.myproj-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myproj-vpc-igw.id
  }
  tags = {
    Name = "myproj-main-route-table"
  }
}

resource "aws_internet_gateway" "myproj-vpc-igw" {
  vpc_id = aws_vpc.myproj-vpc.id
  tags = {
    Name = "myproj-vpc-igw"
  }
}

resource "aws_security_group" "myproj-sg" {
  name = "myproj-sg"
  vpc_id = aws_vpc.myproj-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
    tags = {
    Name = "myproj-sg"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*x86_64-gp2"]
  }
}

# resource "aws_instance" "myproj-nginx-serv" {
#   ami = data.aws_ami.latest-amazon-linux-image.image_id
#   instance_type = var.instance_type
#   subnet_id = aws_subnet.myproj-subnet-a.id
#   vpc_security_group_ids = [aws_security_group.myproj-sg.id]
#   availability_zone = var.avail_zone
#   associate_public_ip_address = true
#   key_name = "ec2-keypair"
  
  # user_data = <<EOF
  #                 #!/bin/bash
  #                 sudo yum update -y
  #                 sudo yum install -y docker
  #                 sudo systemctl start docker
  #                 sudo usermod -aG docker ec2-user
  #                 docker run -p 8080:80 nginx
  #             EOF
  #   user_data = file("bootstrap_script.sh")

#   tags = {
#     Name = "myproj-nginx-serv"
#   }
# }

#----------------------------------------------------------------
# Connecting EC2 instance from Terraform using private key
# connection {
#   type = "ssh"
#   host = self.public_ip
#   user = "ec2-user"
#   private_key = file(var.private_key_location)
# }

## ---------------------------------------------------------------- ##
# Three provisioners available - File, Remote Exec and Local Exec

# To copy files from local machine to remote EC2 instance using Terraform
# provisioner "file" {
#   source = "bootstrap_script.sh"
#   destination = "/home/ec2-user/bootstrap_script.sh"
# }

# To run bootstrap script or any commands on remote EC2 instance from Terraform
# provisioner "remote-exec" {
#   script = file("bootstrap_script.sh")
#   inline = [
#     "mkdir new_dir",
#     "cd new_dir"
#   ]
# }

# To run commands on local machine using Terraform
# provisioner "local-exec" {
#   command = "dir  > output.txt"
#   command = "echo ${self.public_ip}  > ip_output.txt"
# }
    

# resource "aws_route_table" "myproj-vpc-route-table" {
#   vpc_id = aws_vpc.myproj-vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.myproj-vpc-igw.id
#   }
#   tags = {
#     Name = "myproj-vpc-route-table"
#   }
# }


# resource "aws_route_table_association" "myproj-route-table-subnet" {
#   subnet_id = aws_subnet.myproj-subnet-a.id
#   route_table_id = aws_route_table.myproj-vpc-route-table.id
# }

# description = "VPC CIDR Block"
# default = "10.0.0.0/16"
# cidr = "10.0.0.0/16"
# tag ={
#   Name = "${var.env_prefix}-vpc"
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
