# Kubernetes Lab Terraform

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

echo "10.135.15.98 fed-master
10.135.15.97 fed-node" >> /etc/hosts

Both nodes:

vi /etc/kubernetes/config

# Comma separated list of nodes in the etcd cluster
KUBE_MASTER="--master=http://fed-master:8080"

# logging to stderr means we get it in the systemd journal
KUBE_LOGTOSTDERR="--logtostderr=true"

# journal message level, 0 is debug
KUBE_LOG_LEVEL="--v=0"

# Should this cluster be allowed to run privileged docker containers
KUBE_ALLOW_PRIV="--allow-privileged=false"

systemctl disable iptables-services firewalld
systemctl stop iptables-services firewalld

master node:

vi /etc/kubernetes/apiserver
# The address on the local server to listen to.
KUBE_API_ADDRESS="--address=0.0.0.0"

# Comma separated list of nodes in the etcd cluster
KUBE_ETCD_SERVERS="--etcd-servers=http://127.0.0.1:2379"

# Address range to use for services
KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"

# Add your own!
KUBE_API_ARGS=""

on master node:

vi /etc/etcd/etcd.conf
ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"

mkdir /var/run/kubernetes
chown kube:kube /var/run/kubernetes
chmod 750 /var/run/kubernetes

on master

for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler; do
    systemctl restart $SERVICES
    systemctl enable $SERVICES
    systemctl status $SERVICES
done
