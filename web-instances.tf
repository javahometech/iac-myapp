# Create EC2 instancea in public subnet to host web application
resource "aws_instance" "web" {
  count                       = local.pub_sub_length
  ami                         = data.aws_ami.linux2.id
  instance_type               = "t2.micro"
  subnet_id                   = local.pub_sub_ids[count.index]
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.nat.id]
  key_name                    = "hari2020"
  tags = {
    "Name" = "Web Instance - ${count.index + 1}"
  }
}