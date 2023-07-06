resource "aws_ebs_volume" "bastion-host-ebs" {
    availability_zone = aws_instance.bastion-host.availability_zone
    size = 5
}


resource "aws_volume_attachment" "bastion-host-ebs" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.bastion-host-ebs.id
    instance_id = aws_instance.bastion-host.id
}
