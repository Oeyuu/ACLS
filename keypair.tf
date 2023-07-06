resource "tls_private_key" "key"{
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.key.public_key_openssh
}

output "private_key" {
  value = tls_private_key.key.private_key_pem
  sensitive = true
}
