# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "main"
  }
}

# public subnet
resource "aws_subnet" "main-public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.PUBLIC_SUBNET_CIDR
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "main-public"
  }
}

resource "aws_subnet" "main-public-subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.PUBLIC_SUBNET_CIDR_1
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "main-public"
  }
}

#Database private subnet
resource "aws_subnet" "main-private-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.PRIVATE_SUBNET_CIDR
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "main-private"
  }
}


# Internet GW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gw"
  }
}

# route tables
resource "aws_route_table" "main-public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main-public-subnet-rt"
  }
}

#route tables for private subnet through public subnet
resource "aws_route_table" "main-public-subnet-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.main_poc.id
  }

  tags = {
    Name = "main-private-subnet-rt"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-rt" {
  subnet_id      = aws_subnet.main-public-subnet.id
  route_table_id = aws_route_table.main-public-rt.id
}

resource "aws_route_table_association" "main-public-rt-1" {
  subnet_id      = aws_subnet.main-public-subnet-1.id
  route_table_id = aws_route_table.main-public-rt.id
}

resource "aws_route_table_association" "main-public-rt-2" {
  subnet_id      = aws_subnet.main-private-subnet.id
  route_table_id = aws_route_table.main-public-rt.id
}