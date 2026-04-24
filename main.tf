resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "Main_VPC"
    Owner       = var.owner
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "Main_IGW"
    Owner       = var.owner
    Environment = var.environment
  }
}


resource "aws_subnet" "a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_a
  availability_zone = var.subnet_az_a
  tags = {
    Name        = "Subnet_public-1"
    Owner       = var.owner
    Environment = var.environment
  }
}

resource "aws_subnet" "b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_b
  availability_zone = var.subnet_az_b
  tags = {
    Name        = "Subnet_public-2"
    Owner       = var.owner
    Environment = var.environment
  }
}

resource "aws_subnet" "c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_c
  availability_zone = var.subnet_az_c
  tags = {
    Name        = "Subnet_private-1"
    Owner       = var.owner
    Environment = var.environment
  }
}

resource "aws_subnet" "d" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_d
  availability_zone = var.subnet_az_d
  tags = {
    Name        = "Subnet_private-2"
    Owner       = var.owner
    Environment = var.environment
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "NAT_EIP"
    Owner       = var.owner
    Environment = var.environment
  }
}

# NAT Gateway (placed in public subnet A)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.a.id   # must be a public subnet

  tags = {
    Name        = "Main_NAT"
    Owner       = var.owner
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.igw]
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name        = "Private_RT"
    Owner       = var.owner
    Environment = var.environment
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.c.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.d.id
  route_table_id = aws_route_table.private.id
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "Public_RT"
    Owner       = var.owner
    Environment = var.environment
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.b.id
  route_table_id = aws_route_table.public.id
}

