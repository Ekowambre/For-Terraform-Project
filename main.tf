resource "aws_vpc" "Tena-VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance-tenancy
  enable_dns_hostnames = true

  tags = {
    Name = var.Tag-2
  }
}


# Public subnets
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id            = aws_vpc.Tena-VPC.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.AZ-1

  tags = {
    Name = var.tag-change
  }
}


resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id            = aws_vpc.Tena-VPC.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.AZ-2

  tags = {
    Name = var.Tag-3
  }
}


# Private subnets

resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id            = aws_vpc.Tena-VPC.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.AZ-3

  tags = {
    Name = var.Tag-4
  }
}

resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id            = aws_vpc.Tena-VPC.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.AZ-4

  tags = {
    Name = var.Tag-5
  }
}


# Public route table
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.Tena-VPC.id
  tags = {
    Name = var.Tag-6
  }
}

# Private route table
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.Tena-VPC.id
  tags = {
    Name = var.Tag-7
  }
}

# Public subnets association
resource "aws_route_table_association" "Prod-pub-route-table-association-1" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

# Public subnets association
resource "aws_route_table_association" "Prod-pub-route-table-association-2" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}

# Private subnets association
resource "aws_route_table_association" "Prod-priv-route-table-association-1" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# Private subnets association
resource "aws_route_table_association" "Prod-priv-route-table-association-2" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# internet gateway
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Tena-VPC.id

  tags = {
    Name = var.Tag-8

  }
}
# Associating internet gateway with the public subnets
resource "aws_route" "Prod-igw-association" {
  route_table_id         = aws_route_table.Prod-pub-route-table.id
  gateway_id             = aws_internet_gateway.Prod-igw.id
  destination_cidr_block = var.igw-destination-cidr

}

# Allocate Elastic IP Address
resource "aws_eip" "Tena-IP" {

}

resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.Tena-IP.id
  subnet_id     = aws_subnet.Prod-pub-sub1.id

  tags = {
    Name = var.Tag-9
  }
}

resource "aws_route" "Prod-Nat-association" {
  route_table_id         = aws_route_table.Prod-priv-route-table.id
  gateway_id             = aws_nat_gateway.Prod-Nat-gateway.id
  destination_cidr_block = var.ngw-destination-cidr
}