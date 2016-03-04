# Kubernetes Lab Terraform

/!\ this currently does only launch 2 nodes on DO, nothing more.

## Configure

Rename `terraform.tfvars.example` to `terraform.tfvars`:

    $ cp terraform.tfvars.example terraform.tfvars

Edit the amount of required instances in `terraform.tfvars`:

    num_servers = 2

Or change the region:

    do_region = "fra1"

Etc.

## Run

    $ terraform apply

## Destroy

    $ terraform destroy

## Kubernetes

    /usr/bin/dnf -y install --enablerepo=updates-testing kubernetes
    /usr/bin/dnf -y install etcd iptables
