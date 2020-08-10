# Create EC2 instancea in public subnet to host web application
resource "aws_instance" "web" {
  count                       = local.pub_sub_length
  ami                         = data.aws_ami.linux2.id
  instance_type               = "t2.micro"
  subnet_id                   = local.pub_sub_ids[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web.id]
  key_name                    = "hari2020"
  user_data                   = file("scripts/apache.sh")

  tags = {
    "Name" = "Web Instance - ${count.index + 1}"
  }
}

# Security Group for web instance

resource "aws_security_group" "web" {
  name        = "web-rules"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
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
    Name = "web-instance-security-group"
  }
}