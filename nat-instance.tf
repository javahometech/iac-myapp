# Create NAT instance in public subnet
resource "aws_instance" "nat" {
  ami                         = lookup(var.nat_amis, var.region)
  instance_type               = "t2.micro"
  subnet_id                   = local.pub_sub_ids[0]
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.nat.id]
  key_name                    = "hari2020"
  tags = {
    "Name" = "Nat Instance"
  }
}

# Security Group for NAT instance

resource "aws_security_group" "nat" {
  name        = "nat-rules"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat-instance-security-group"
  }
}