provider "aws" {
   access_key = "${var.access_key}"
   secret_key = "${var.secret_key}"
   region     = "${var.region}"
}

resource "aws_instance" "yashaswini_instance" {
    ami             = "ami-0c94855ba95c71c99"
    instance_type   = "t2.micro"
    key_name         = "udemy"
    security_groups = ["${aws_security_group.jenkins_sg.name}"]
   
   provisioner "file" {
    source      = "C:/Users/yashass/Documents/Terraform_Setup_Jenkins/jenkins.sh"
    destination = "/tmp/jenkins.sh"
  }

   provisioner "remote-exec" {
      inline = [  
      "sleep 30",
      "sudo yum install dos2unix -y",
      "cd /tmp",
      "chmod 777 jenkins.sh",
      "sudo dos2unix jenkins.sh",
      "sudo ./jenkins.sh"
    ]
  }
   connection {
      type = "ssh"
      user = "ec2-user" 
      private_key = "${file("C:/Users/yashass/Downloads/udemy.pem")}"
      host = self.public_ip
      timeout = "2m"
  } 
  } 

resource "aws_security_group" "jenkins_sg" {
    name        = "jenkins_sg"
    description = "security group for jenkins"

    ingress {
        from_port = 8080
        to_port   = 8080
        protocol  = "tcp"
        description = "tcp port"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        description = "ssh port"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
       from_port = 0
       to_port = 0
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }
}