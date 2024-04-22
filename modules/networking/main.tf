resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "${var.name}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = toset(var.public_cidrs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.key

  tags = {
    "Name" = "${var.name}-public_subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  count = var.public_cidrs != [] ? 1 : 0
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_rt" {
  count = var.public_cidrs != [] ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[count.index].id
  }
}


