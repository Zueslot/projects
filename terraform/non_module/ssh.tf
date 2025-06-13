resource "tls_private_key" "ssh_key_gen" {
  algorithm = "RSA"
  rsa_bits  = 4096 #Generates the public key and private key
}

resource "local_file" "private_key" {                               #Picks and save the private key on local machine
  content  = trimspace(tls_private_key.ssh_key_gen.private_key_pem) #(trimspace makes sure there is no empty line below the keys)
  filename = "${path.module}/private_key.pem"
}

resource "local_file" "public_key" { #Picks and save the public key on local machine     
  content  = trimspace(tls_private_key.ssh_key_gen.public_key_openssh)
  filename = "${path.module}/public_key.pub"
}