provider "aws" {
  access_key = "xxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxx"
  region     = "ap-south-1"
}

resource "aws_instance" "ubuntu" {
  ami             = "ami-03a933af70fa97ad2"
  instance_type   = "t2.micro"
  key_name        = "key_name"
  security_groups = ["launch-wizard-8"]
  tags = {
    Name = "Ubuntu VM"
  }

connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("key.pem")
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
