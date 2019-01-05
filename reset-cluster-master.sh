# Drain and delete the nodes (for each node you have)
kubectl drain rock1 --delete-local-data --force --ignore-daemonsets
kubectl delete node rock1
kubectl drain rock2 --delete-local-data --force --ignore-daemonsets
kubectl delete node rock2

# Reset the deployment
sudo kubeadm reset

# On each node

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
sudo iptables -F
sudo iptables -X
sudo systemctl restart docker
