provider "aws" {
#   region = "us-east-1"
}

resource "aws_security_group" "salt_master_sg" {
  name_prefix = "salt-master-sg"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider using your IP range for better security
  }
  ingress {
    from_port   = 4505
    to_port     = 4506
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "salt_minion_sg" {
  name_prefix = "salt-minion-sg"

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider using your IP range for better security
  }
  ingress {
    from_port   = 4505
    to_port     = 4506
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "salt_master" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.salt_master_sg.name]

  user_data = file("user_data_salt_master.sh")

  tags = {
    Name = "SaltMaster"
  }
}

resource "aws_instance" "salt_minion" {
  count         = var.minion_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.salt_minion_sg.name]

  user_data = file("user_data_salt_minion.sh")

  tags = {
    Name = "SaltMinion${count.index + 1}"
  }
}

output "salt_master_public_ip" {
  value = aws_instance.salt_master.public_ip
}

output "salt_minion_public_ips" {
  value = [for instance in aws_instance.salt_minion : instance.public_ip]
}
