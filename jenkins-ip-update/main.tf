terraform {
  backend "s3" {
    bucket = "d76-terraform-state"
    key    = "misc/jenkins-ip-update/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_instance" "jenkins" {
  instance_id = ""
}

resource "aws_route53_record" "jenkins" {
  name    = "jenkins"
  type    = "A"
  zone_id = ""
  ttl     = 10
  records = [data.aws_instance.jenkins.public_ip]
}


data "aws_instance" "artifactory" {
  instance_id = ""
}

resource "aws_route53_record" "artifactory" {
  name    = "artifactory"
  type    = "A"
  zone_id = ""
  ttl     = 10
  records = [data.aws_instance.artifactory.public_ip]
}

data "aws_instance" "elk" {
  instance_id = ""
}

resource "aws_route53_record" "elk" {
  name    = "elasticsearch"
  type    = "A"
  zone_id = ""
  ttl     = 10
  records = [data.aws_instance.elk.public_ip]
}

data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = [""]
}

resource "aws_instance" "load-gen" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [""]
  tags = {
    Name = "load-gen"
  }
}

data "aws_instance" "gocd" {
  instance_id = ""
}

resource "aws_route53_record" "gocd" {
  name    = "gocd"
  type    = "A"
  zone_id = ""
  ttl     = 10
  records = [data.aws_instance.gocd.public_ip]
}