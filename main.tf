// Creating first EC2 instance

resource "aws_instance" "web" {
  ami                         = "ami-0da543a6b4536a9e2"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]

  tags = {
    Name = "webserver1"
  }
}

// Creating a key-pair
resource "aws_key_pair" "key" {
  key_name   = "tarraform-key"
  public_key = file("./terraform-key.pub")
}

resource "aws_security_group" "sg" {
  name = "frontend-sg"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}