resource "aws_instance" "terraform-instance" {
  ami           = "ami-0055e70f580e9ae80"
  instance_type = "t2.micro"

  user_data = <<-COMMANDS
                #!/bin/bash
                mkdir test_dir
                echo "hello world" > test_dir/test.txt
                COMMANDS

  key_name               = aws_key_pair.ec2-keys.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "ec2-keys" {
  public_key = file("./key.pem.pub")
}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "allow ssh access from the internet"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public-ip" {
  value = aws_instance.terraform-instance.public_ip
}