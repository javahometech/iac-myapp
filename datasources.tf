data "aws_availability_zones" "available" {
  state = "available"
}

# Fetch AMI id for web ec2 instances

data "aws_ami" "linux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}