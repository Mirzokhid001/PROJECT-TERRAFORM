# Step 1. Create VPC
resource "aws_vpc" "wiki-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.environment} - VPC"
  }
}

# Step 2. Create Internet Gateway
resource "aws_internet_gateway" "wiki-gateway" {
  vpc_id = aws_vpc.wiki-vpc.id

  tags = {
    Name = "${var.environment} - Gateway"
  }
}

# Step 3. Create Route Table
resource "aws_route_table" "wiki-routetable" {
  vpc_id = aws_vpc.wiki-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wiki-gateway.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.wiki-gateway.id
  }

  tags = {
    Name = "${var.environment} - Route Table"
  }
}

# Step 4. Create Subnets
resource "aws_subnet" "wiki-subnet" {
  vpc_id     = aws_vpc.wiki-vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.environment} - subnet 1"
  }
}

resource "aws_subnet" "wiki-subnet-2" {
  vpc_id     = aws_vpc.wiki-vpc.id
  cidr_block = var.subnet_cidr_2
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.environment} - subnet 2"
  }
}

# Step 5. Create Subnets with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.wiki-subnet.id
  route_table_id = aws_route_table.wiki-routetable.id
}

# Step 6. Create Security Group to allow ports:22,80,443
resource "aws_security_group" "allow_all" {
  name        = "allow_all_tracffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.wiki-vpc.id

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment} - Allow all"
  }
} 
