output "myproj-vpc-id" {
  value = aws_vpc.myproj-vpc.id
}

output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image
}
