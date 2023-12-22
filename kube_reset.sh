kubeadm reset -f  

rm -rf /etc/cni /etc/kubernetes /etc/cni/net.d /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/run/kubernetes ~/.kube/* /var/lib/containerd/
 
iptables -F && iptables -X
iptables -t nat -F && iptables -t nat -X
iptables -t raw -F && iptables -t raw -X
iptables -t mangle -F && iptables -t mangle -X
 
sudo systemctl restart containerd
sudo systemctl enable containerd