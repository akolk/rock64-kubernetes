
## Reset the nodes and weave
sudo curl -L git.io/weave -o /usr/local/bin/weave
sudo chmod a+x /usr/local/bin/weave
sudo kubeadm reset
sudo weave reset --force

## Clean weave binaries
sudo rm /opt/cni/bin/weave-*

## Flush iptables rules on all nodes and restart Docker
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t nat -F
sudo iptables -t mangle -F
iptables -F
iptables -X
systemctl restart docker
