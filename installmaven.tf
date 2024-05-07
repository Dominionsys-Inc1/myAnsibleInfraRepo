# Define the AWS instance
resource "aws_instance" "example" {
  ami           = "ami-09040d770ffe2224f"
  instance_type = "t2.medium"  # Updated instance type to t2.medium

  tags = {
    Name = "example-instance"
  }

  # Use provisioner to install Maven
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y maven"
    ]
  }
}

# Define the connection block for the provisioner
provider "aws" {
  region = "us-west-2"
}

# Provide SSH connection details for the provisioner
# Replace key_file and connection_type with appropriate values
# depending on your environment
connection "ssh" {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("${path.module}/demo.pem")
  output "public_ip" {
  value = aws_instance.example.public_ip
}
  host        = aws_instance.example.public_ip
}
