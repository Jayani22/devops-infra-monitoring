resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.env}-vpc-jayani"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "public" {
    vpc_id                  = aws_vpc.this.id
    cidr_block              = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone       = var.availability_zone
    tags = {
        Name = "${var.env}-public-subnet-jayani"
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.this.id
    cidr_block = var.private_subnet_cidr
    availability_zone       = var.availability_zone
    tags = {
        Name = "${var.env}-private-subnet-jayani"
    }
}

resource "aws_eip" "nat" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public.id
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.env}-public-rt-jayani"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
        Name = "${var.env}-private-rt-jayani"
    }
}

resource "aws_route_table_association" "private" {
    subnet_id      = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
}