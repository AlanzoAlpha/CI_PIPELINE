provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = "true"

}
resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block1
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = "true"

}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}


resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.open_internet
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.vpc.id

  # Only MySQL in
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_sg" {
  name        = "DefaultSGWeb"
  description = "Allow SSH"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.inbound_port
    protocol    = "tcp"
    to_port     = var.inbound_port
    description = "Telnet"
    cidr_blocks = [var.open_internet]
  }

  egress {
    from_port   = var.outbound_port
    protocol    = "-1"
    to_port     = var.outbound_port
    cidr_blocks = [var.open_internet]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    description = "MySQL"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    description = "_"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    protocol    = "tcp"
    from_port   = 8081
    to_port     = 8081
    description = "_"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance
  availability_zone           = "eu-west-1a"
  key_name                    = aws_key_pair.pub_key.id
  associate_public_ip_address = var.enable_public_ip
  subnet_id                   = aws_subnet.subnet_a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  # nginx installation
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }
  connection {

    user        = var.ec2_os
    private_key = file(var.private_key_path)
    host        = aws_instance.ec2.public_ip
  }
}

resource "aws_key_pair" "pub_key" {
  key_name   = "pub_key"
  public_key = file(var.public_key_path)
}

resource "aws_db_subnet_group" "dbsubnet" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

}

resource "aws_db_instance" "users" {
  allocated_storage                   = 5
  storage_type                        = "gp2"
  availability_zone                   = "eu-west-1a"
  engine                              = "mysql"
  engine_version                      = "5.7"
  instance_class                      = "db.t2.micro"
  name                                = "users"
  username                            = "admin"
  password                            = "password"
  skip_final_snapshot                 = "true"
  publicly_accessible                 = "true"
  port                                = "3306"
  iam_database_authentication_enabled = "true"
  vpc_security_group_ids              = [aws_security_group.web_sg.id]
  db_subnet_group_name                = aws_db_subnet_group.dbsubnet.name

}
resource "aws_db_instance" "testdb" {
  allocated_storage                   = 5
  storage_type                        = "gp2"
  availability_zone                   = "eu-west-1a"
  engine                              = "mysql"
  engine_version                      = "5.7"
  instance_class                      = "db.t2.micro"
  name                                = "testdb"
  username                            = "admin"
  password                            = "password"
  skip_final_snapshot                 = "true"
  publicly_accessible                 = "true"
  port                                = "3306"
  iam_database_authentication_enabled = "true"
  vpc_security_group_ids              = [aws_security_group.web_sg.id]
  db_subnet_group_name                = aws_db_subnet_group.dbsubnet.name
}