sudo kubeadm init

rm -rf $HOME/.kube $HOME/.helm
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Weave Net as overlay network
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

# Taint the master node so application pods can run on it too
kubectl taint nodes --all node-role.kubernetes.io/master-
