resource "aws_security_group" "web_sg" {
  name = "HTTP and SSH"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "instance" {
  count           = 2
  ami             = "ami-0ab0629dba5ae551d"
  instance_type   = "t2.micro"
  security_groups = ["HTTP and SSH"]
  key_name        = "terraform-key"
  tags = {
    Name = "tarea-terraform-${count.index + 1}"
  }
}
output "public-ip-server1" {
  value = aws_instance.instance[0].public_ip
}
output "public-ip-server2" {
  value = aws_instance.instance[1].public_ip
}
