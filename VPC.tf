#------------vpc resource-----------
#vpc
resource "aws_vpc" "global-vpc" {
  cidr_block           = var.global_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "global-vpc"
  }
}

#IGW
resource "aws_internet_gateway" "global-igw" {
  vpc_id = aws_vpc.global-vpc.id
  tags = {
    Name = "global-igw"
  }
}

#Nat GW
resource "aws_eip" "global-eip" {
  vpc = true
  tags = {
    Name = "global-eip"
  }
}

resource "aws_nat_gateway" "global-ngw" {
  allocation_id = aws_eip.global-eip.id
  subnet_id     = aws_subnet.global-public-subnet-a.id
  tags = {
    Name = "global-ngw"
  }
}

#Public subnet
resource "aws_subnet" "global-public-subnet-a" {
  vpc_id                  = aws_vpc.global-vpc.id
  cidr_block              = var.public_subnet_a
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name = "global-public-subnet-a"
  }

}
resource "aws_subnet" "global-public-subnet-c" {
  vpc_id                  = aws_vpc.global-vpc.id
  cidr_block              = var.public_subnet_c
  availability_zone       = var.az_c
  map_public_ip_on_launch = true

  tags = {
    Name = "global-public-subnet-c"
  }

}

#private Subnet-web
resource "aws_subnet" "global-private-subnet-a-web" {
  vpc_id            = aws_vpc.global-vpc.id
  cidr_block        = var.private_subnet_a_web
  availability_zone = var.az_a

  tags = {
    Name = "global-private-subnet-a-web"
  }

}
resource "aws_subnet" "global-private-subnet-c-web" {
  vpc_id            = aws_vpc.global-vpc.id
  cidr_block        = var.private_subnet_c_web
  availability_zone = var.az_c

  tags = {
    Name = "global-private-subnet-c-web"
  }
}


#private subnet-DB
resource "aws_subnet" "global-private-subnet-a-db" {
  vpc_id            = aws_vpc.global-vpc.id
  cidr_block        = var.private_subnet_a_DB
  availability_zone = var.az_a

  tags = {
    Name = "global-private-subnet-a-db"
  }

}

resource "aws_subnet" "global-private-subnet-c-db" {
  vpc_id            = aws_vpc.global-vpc.id
  cidr_block        = var.private_subnet_c_DB
  availability_zone = var.az_c

  tags = {
    Name = "global-private-subnet-c-db"
  }

}
#Route ,Route table
#Public RT
resource "aws_route_table" "global-public-routetable" {
  vpc_id = aws_vpc.global-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.global-igw.id
  }
  tags = {
    Name = "global-public-routetable"
  }
}

# public subnet -> public route table
resource "aws_route_table_association" "global-public-rta-a" {
  subnet_id      = aws_subnet.global-public-subnet-a.id
  route_table_id = aws_route_table.global-public-routetable.id
}

resource "aws_route_table_association" "global-public-rta-c" {
  subnet_id      = aws_subnet.global-public-subnet-c.id
  route_table_id = aws_route_table.global-public-routetable.id
}
resource "aws_route_table" "global-private-routetable-web" {
  vpc_id = aws_vpc.global-vpc.id

  tags = {
    Name = "global-private-routetable-web"
  }
}

resource "aws_route" "global-private-route-web" {
  route_table_id         = aws_route_table.global-private-routetable-web.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.global-ngw.id
}

#db rt
resource "aws_route_table" "global-private-routetable-db" {
  vpc_id = aws_vpc.global-vpc.id

  tags = {
    Name = "global-private-routetable-db"
  }
}

resource "aws_route" "global-private-route-db" {
  route_table_id         = aws_route_table.global-private-routetable-db.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.global-ngw.id
}

# private subnet -> pirvate route table
resource "aws_route_table_association" "global-private-rta-a-web" {
  subnet_id      = aws_subnet.global-private-subnet-a-web.id
  route_table_id = aws_route_table.global-private-routetable-web.id
}

resource "aws_route_table_association" "global-private-rta-c-web" {
  subnet_id      = aws_subnet.global-private-subnet-c-web.id
  route_table_id = aws_route_table.global-private-routetable-web.id
}

resource "aws_route_table_association" "global-private-rta-a-db" {
  subnet_id      = aws_subnet.global-private-subnet-a-db.id
  route_table_id = aws_route_table.global-private-routetable-db.id
}

resource "aws_route_table_association" "global-private-rta-c-db" {
  subnet_id      = aws_subnet.global-private-subnet-c-db.id
  route_table_id = aws_route_table.global-private-routetable-db.id
}
