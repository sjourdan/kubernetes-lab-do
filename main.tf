# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = "${var.do_token}"
}

# Configure the SSH Key
resource "digitalocean_ssh_key" "k8s-lab-key" {
    name = "k8s Lab Key"
    public_key = "${file("${var.do_ssh_key_file}.pub")}"
}

# Create a number of similar nodes
resource "digitalocean_droplet" "node" {
  count = "${var.num_servers}"
  image = "${var.do_image}"
  name = "node-${count.index+1}"
  region = "${var.do_region}"
  size = "${var.do_size}"
  ssh_keys = [ "${digitalocean_ssh_key.k8s-lab-key.id}" ]
  private_networking = true
  user_data = ""

  connection {
    user = "root"
    key_file = "${var.do_ssh_key_file}"
  }

  provisioner "remote-exec" {

    inline = [
      "/usr/bin/dnf update -yq"
    ]

  }
}
