locals{
  az_names = data.aws_availability_zones.available.names
}
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name       = "terrafrom-vpc"
    Batch      = "9AM Training"
    Location   = "India"
    Department = "HR"
  }
}
# Create subnet
resource "aws_subnet" "main" {
  count      = length(local.az_names)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}