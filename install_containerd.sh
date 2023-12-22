#!/bin/bash

# Update package lists
sudo apt update

# Install required dependencies
sudo apt install -y libseccomp2

# Download and install containerd
CONTAINERD_VERSION="1.5.7"
wget https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}.linux-amd64.tar.gz
tar xvf containerd-${CONTAINERD_VERSION}.linux-amd64.tar.gz
sudo cp bin/* /usr/local/bin/

# Create containerd configuration directory
sudo mkdir -p /etc/containerd

# Create a simple configuration file
sudo sh -c 'echo "runtime {\n  default_runtime_name = \"runc\"\n  no_pivot = false\n  no_shim = false\n}" > /etc/containerd/config.toml'

# Create a systemd service file for containerd
sudo sh -c 'echo "[Unit]\nDescription=containerd container runtime\nDocumentation=https://containerd.io\n\n[Service]\nExecStartPre=/sbin/modprobe overlay\nExecStart=/usr/local/bin/containerd\nDelegate=yes\nKillMode=process\nRestart=always\nLimitNOFILE=4096\nLimitNPROC=infinity\nLimitCORE=infinity\nTasksMax=infinity\nOOMScoreAdjust=-999\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/containerd.service'

# Reload systemd and start containerd
sudo systemctl daemon-reload
sudo systemctl start containerd
sudo systemctl enable containerd

# Clean up
rm containerd-${CONTAINERD_VERSION}.linux-amd64.tar.gz
rm -rf bin

echo "Containerd is installed and running."




