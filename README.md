# Drupal-setup
This is a installation guide for setting up drupal using Docker Image and deploying it using Kubernetes and monitoring the pods using ELK.


# Install Docker

Switch to root and run the below command

apt install -y docker.io


So with the above command,it has not only installed docker but also the group docker,setup users in the appropriate group and also setup the services upon bootup.Just to make sure your kubelet and docker are using the same group, we would create the following json file

vi /etc/docker/daemon.json

{
        "exec-opts": ["native.cgroupdriver=systemd"]
}

# Install Kubernetes

Step 1:- Add the key for the repo

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

Step 2:- Add the kubernetes sources

vi /etc/apt/sources.list.d/kubernetes.list

deb http://apt.kubernetes.io/ kubernetes-xenial main

Step 3:- Do an update to grab the above sources

apt update

Step 4:- Install the 3 packages

apt install -y kubelet kubeadm kubectl

Step 5:- Run kubeadm to get things started

kubeadm init --pod-network-cidr=192.168.0.0/16

You will get the token to join the worker nodes, keep it somewhere safely


Step 6:- Exit from the root user, and run the below commands as normal user

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config










