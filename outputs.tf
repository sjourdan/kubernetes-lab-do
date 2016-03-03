# outputs all public IPv4 addresses
output "public_ips" {
  value = "${join(",", digitalocean_droplet.node.*.ipv4_address)}"
}

output "local_ips" {
  value = "${join(",", digitalocean_droplet.node.*.ipv4_address_private)}"
}
