provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxx"
  region     = "ap-south-1"
}

resource "aws_instance" "ubuntu" {
  ami             = "ami-03a933af70fa97ad2"
  instance_type   = "t2.micro"
  key_name        = "Key_name"
  security_groups = ["sg_name"]
  tags = {
    Name = "Ubuntu VM"
  }

connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("key_file")
  host        = self.public_ip
 }

  provisioner "remote-exec"  {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y software-properties-common",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get install -y ansible"
    ]
  }
}
