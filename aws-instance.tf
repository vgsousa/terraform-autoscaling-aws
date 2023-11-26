data "aws_ami" "ubuntu_latest" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = "aws-key-${var.service_name}"
  public_key = var.aws_key_pub
}

resource "aws_launch_template" "this" {
  name_prefix   = "terraform-"
  image_id      = data.aws_ami.ubuntu_latest.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name
  user_data     = filebase64("aws-instance-ec2.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.auto_scaling.id]
  }
}

resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.instance_private.id]
  subnet_id              = aws_subnet.this["private_b"].id
  availability_zone      = "${var.aws_region}b"

  tags = merge(local.common_tags, { Name = "Instance Private" })
}