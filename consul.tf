# Create a new tag
resource "digitalocean_tag" "consul_bootstrap" {
  name = "consul_bootstrap"
}
resource "digitalocean_tag" "consul_server" {
  name = "consul_server"
}
resource "digitalocean_tag" "consul_client" {
  name = "consul_client"
}
resource "digitalocean_tag" "staging" {
  name = "staging"
}

resource "digitalocean_droplet" "consul-01" {
  image = "ubuntu-16-04-x64"
  name = "consul-01"
  region = "fra1"
  size = "1gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags   = ["${digitalocean_tag.consul_bootstrap.id}","${digitalocean_tag.staging.id}"]
}

resource "digitalocean_droplet" "consul-02" {
  image = "ubuntu-16-04-x64"
  name = "consul-02"
  region = "fra1"
  size = "1gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags   = ["${digitalocean_tag.consul_server.id}","${digitalocean_tag.staging.id}"]
}

resource "digitalocean_droplet" "consul-03" {
  image = "ubuntu-16-04-x64"
  name = "consul-03"
  region = "fra1"
  size = "1gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags   = ["${digitalocean_tag.consul_server.id}","${digitalocean_tag.staging.id}"]
}

resource "digitalocean_droplet" "consul-ui" {
  image = "ubuntu-16-04-x64"
  name = "consul-ui"
  region = "fra1"
  size = "1gb"
  private_networking = true
  ssh_keys = ["${var.ssh_fingerprint}"]
  tags   = ["${digitalocean_tag.consul_client.id}","${digitalocean_tag.staging.id}"]
}

output "ipv4" {
    value = "${digitalocean_droplet.consul-ui.ipv4_address}"
}
