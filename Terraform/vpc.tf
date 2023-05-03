resource "aws_vpc" "VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    name = "${var.environment}-vpc"
  }

}

resource "aws_subnet" "Private" {
  count      = 2
  cidr_block = cidrsubnet("10.0.0.0/16", 8, count.index)
  vpc_id     = aws_vpc.VPC.id
  depends_on = [
    aws_vpc.VPC
  ]
  tags = {
    name = "${var.environment}-private-subnet-${count.index + 1}"
  }


}


resource "aws_subnet" "Public" {
  count                   = 2
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, length(aws_subnet.Private) + count.index)
  vpc_id                  = aws_vpc.VPC.id
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)
  depends_on = [
    aws_vpc.VPC
  ]
  tags = {
    name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "intenatgateway" {
  vpc_id = aws_vpc.VPC.id
  tags = {
    name = "${var.environment}-Gateway"
  }

}

resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intenatgateway.id
  }


}

resource "aws_route_table_association" "Public_RT_Association" {
  count          = 2
  subnet_id      = aws_subnet.Public[count.index].id
  route_table_id = aws_route_table.Public_RT.id
}

