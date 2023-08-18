resource "aws_vpc" "Tena-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Tena-VPC"
  }
}


# Public subnets
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id     = aws_vpc.Tena-VPC.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "Prod-pub-sub1"
  }
}


resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id     = aws_vpc.Tena-VPC.id
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "Prod-pub-sub2"
  }
}


# Private subnets

resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id     = aws_vpc.Tena-VPC.id
  cidr_block = "10.0.7.0/24"

  tags = {
    Name = "Prod-priv-sub1"
  }
}

resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id     = aws_vpc.Tena-VPC.id
  cidr_block = "10.0.8.0/24"

  tags = {
    Name = "Prod-priv-sub2"
  }
}


# Public route table
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.Tena-VPC.id
  tags   = { 
  Name   = "Prod-pub-route-table"
  }   
 }    

# Private route table
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.Tena-VPC.id
  tags   = { 
  Name   = "Prod-priv-route-table"
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
    Name = "Prod-igw"

  }
}
# Associating internet gateway with the public subnets
resource "aws_route" "Prod-igw-association" {
  route_table_id            =  aws_route_table.Prod-pub-route-table.id
  gateway_id                =  aws_internet_gateway.Prod-igw.id
  destination_cidr_block    = "0.0.0.0/0"
  
}

# Allocate Elastic IP Address
resource "aws_eip" "Tena-IP" {
  
}

resource "aws_nat_gateway" "Prod-Nat-gateway"{
  allocation_id = aws_eip.Tena-IP.id
  subnet_id     = aws_subnet.Prod-pub-sub1.id

  tags = {
    Name = "Prod-Nat-gateway"
  }
}

resource "aws_route" "Prod-Nat-association" {
  route_table_id            =  aws_route_table.Prod-priv-route-table.id
  gateway_id                =  aws_nat_gateway.Prod-Nat-gateway.id
  destination_cidr_block    = "0.0.0.0/0"
}