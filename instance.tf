resource "aws_instance" "main_poc" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  # role:
  iam_instance_profile = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name

  #VPC Subnet
  subnet_id = aws_subnet.main-public-subnet.id

  #Security Group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  associate_public_ip_address = true

  source_dest_check = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = false
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  tags = {
    Name = "main_Webserver"
  }
}

#Define database inside the private subnet
resource "aws_instance" "db" {
  ami                    = var.AMIS[var.AWS_REGION]
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.mykey.key_name
  subnet_id              = aws_subnet.main-private-subnet.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  source_dest_check      = false
  associate_public_ip_address = true
  tags = {
    Name = "main_DB"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = false
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh", # Remove the spurious CR characters.
      "sudo /tmp/script.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}


resource "aws_lb_target_group_attachment" "alb-http" {
  target_group_arn = aws_lb_target_group.my-target-group-http.arn
  target_id        = aws_instance.main_poc.id
  port             = 80
}

# resource "aws_lb_target_group_attachment" "alb-https" {
#   target_group_arn = aws_lb_target_group.my-target-group-https.arn
#   target_id        = aws_instance.main_poc.id
#   port             = 443
# }