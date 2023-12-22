sudo systemctl stop kubelet
sudo systemctl disable kubelet

sudo apt-get purge kubeadm kubelet kubectl

sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/kubelet
sudo rm -rf $HOME/.kube

sudo rm /etc/systemd/system/kubelet.service

sudo systemctl daemon-reload
sudo rm -rf /var/lib/cni/
sudo rm -rf /var/lib/dockershim/
sudo rm -rf /etc/cni/

sudo apt-get autoremove