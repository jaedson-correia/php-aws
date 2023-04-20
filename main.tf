provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "web_vpc"
  }
}

// Configuração para as portas do ssh e porta 80 apache
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "SSH, HTTP"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_sg"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "my_public_subnet"
  }
}

resource "aws_internet_gateway" "web_gateway" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name = "web_gateway"
  }
}

resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_gateway.id
  }

  tags = {
    Name = "web_rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_instance" "web" {
  ami                    = "ami-0c94855ba95c71c99"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
  subnet_id              = aws_subnet.public.id

  // instalação postgresql na instancia
  user_data = templatefile("postgres.sh", {
    pg_hba_file = file("pg_hba.conf"),
  })

  tags = {
    Name = "web"
  }
}