resource "null_resource" "remote" {
  count = 2
  connection {
    type        = "ssh"
    port        = "22"
    user        = "ubuntu"
    private_key = file("./terraform-key.pem")
    host        = aws_instance.instance[count.index].public_ip
    timeout     = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt -y install apache2",
      "sudo apt -y install git",
      "sudo systemctl enable apache2",
      "git clone https://github.com/casasmgb/front-back-terraform.git",
      "sudo cp -r front-back-terraform/compilado/*  /var/www/html/"
    ]
  }
}
