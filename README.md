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

Step 5:- Run kubeadm to get things started. Once you run the below command,you will get the token to join the worker nodes, keep it somewhere safely

kubeadm init --pod-network-cidr=192.168.0.0/16



Step 6:- Exit from the root user, and run the below commands as normal user

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config


Step 7:- Install an etcd instance with the following command.

kubectl apply -f \
https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/hosted/etcd.yaml

Step 8:- Install the RBAC roles required for Calico

kubectl apply -f \
https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/rbac.yaml

Step 9:- Install Calico with the following command.

kubectl apply -f \
https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/hosted/calico.yaml


Step 10:- Confirm that all of the pods are running with the following command.Note that this takes time, so please watch it for few minutes.

watch kubectl get pods --all-namespaces

Step 11:- Confirm that the master node is in ready status using the below command

kubectl get nodes









