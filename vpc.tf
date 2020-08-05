# Create vpc for our application
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_tenancy

  tags = {
    Name        = "myapp-vpc"
    Environment = terraform.workspace
  }
}

# create private subnets
resource "aws_subnet" "private" {
  count             = local.az_length
  vpc_id            = aws_vpc.main.id
  availability_zone = local.az_names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)

  tags = {
    Name = "Private-${count.index + 1}-${terraform.workspace}"
  }
}

# create public subnets
resource "aws_subnet" "public" {
  count             = local.az_length
  vpc_id            = aws_vpc.main.id
  availability_zone = local.az_names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + local.az_length)

  tags = {
    Name = "Public-${count.index + 1}-${terraform.workspace}"
  }
}

# Create Internet Gateway for public subnets
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myapp"
  }
}

# Create route table for public subnet

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-${terraform.workspace}"
  }
}

# attach public subnets with public route tables

resource "aws_route_table_association" "a" {
  count          = local.pub_sub_length
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# Create route table for private subnet

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name = "private-${terraform.workspace}"
  }
}
