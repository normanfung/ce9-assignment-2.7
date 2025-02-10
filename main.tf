resource "aws_instance" "ec2-instance" {
  ami                         = data.aws_ami.ami_linux.id #Challenge, find the AMI ID of Amazon Linux 2 in us-east-1
  instance_type               = var.ami_instance_type_t2_micro
  subnet_id                   = aws_subnet.public_subnets["public_subnet_1"].id #Public Subnet ID, e.g. subnet-xxxxxxxxxxx
  associate_public_ip_address = true
  key_name                    = var.key_pair #Change to your keyname, e.g. jazeel-key-pair
  vpc_security_group_ids      = [aws_security_group.norman_security_group.id]

  tags = {
    Name = "norman-ec2-ebs" #Prefix your own name, e.g. jazeel-ec2
  }
}

resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.ec2-instance.availability_zone
  size              = 1
  iops              = 3000
  throughput        = 125
  type              = "gp3"

  tags = {
    Name = "norman-ebs"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.ec2-instance.id
}
