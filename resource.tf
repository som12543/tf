## Create security group ####

resource "aws_key_pair" "key-t-1" {
  key_name   = "server-t-2"
  public_key = file("${path.module}/id_rsa.pub")

}


## Security Group ###

resource "aws_security_group" "security-t-1" {
  name        = "security"
  description = "this is security group"
  dynamic "ingress" {
    for_each = [22, 443, 80, 3306, 27017]
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}





### EC2 instance

resource "aws_instance" "server-1" {
  ami           = var.ami_id
  instance_type = var.instance
  tags = {
    name = "server-t-1"
  }
  key_name               = aws_key_pair.key-t-1.key_name
  vpc_security_group_ids = ["${aws_security_group.security-t-1.id}"]



}