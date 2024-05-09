provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "demo-server" {
  ami = "ami-0efcece6bed30fd98"
  instance_type = "t2.micro"
  key_name = "devops"
  security_groups = ["demo_sg"]

  tags = {
    Name = "demo-server"
  }
}

resource "aws_security_group" "demo_sg" {
  name        = "demo_sg"
  description = "SSH Access"
  
  tags = {
    Name = "ssh-port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.demo_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.demo_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

