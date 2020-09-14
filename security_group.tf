resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "Security group that allows ssh and all egress traffic"

  egress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = 0
    cidr_blocks = ["0.0.0.0/0"] //my public ip
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //my public ip
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.PRIVATE_SUBNET_CIDR]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = [var.PRIVATE_SUBNET_CIDR]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.PRIVATE_SUBNET_CIDR]
  }


  vpc_id = aws_vpc.main.id

  tags = {
    Name = "allow-ssh"
  }
}

#Define security group for private subnet
resource "aws_security_group" "database_group" {
  name = "sg_db"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.PUBLIC_SUBNET_CIDR}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = 0
    cidr_blocks = ["${var.PUBLIC_SUBNET_CIDR}"]
  }

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "DB SG"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id      = aws_vpc.main.id
  name        = "elb"
  description = "security group for load balancer"
  egress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb"
  }
}