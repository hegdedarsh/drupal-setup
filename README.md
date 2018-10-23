# Drupal-setup
This is a installation guide for setting up drupal using Docker Image and deploying it using Kubernetes and monitoring the logs using ELK.


# Install Docker
Step 1:-For starters, try to do an apt-get update.

Switch to root and run the below command

apt install -y docker.io


So with the above command,it has not only installed docker but also the group docker,setup users in the appropriate group and also setup the services upon bootup.Just to make sure your kubelet and docker are using the same group, we would create the following json file

vi /etc/docker/daemon.json

{
        "exec-opts": ["native.cgroupdriver=systemd"]
}

Step 2:-Add the docker group if it doesn't already exist,Add the connected user "$USER" to the docker group. Change the user name to match your preferred user if you do not want to use your current use.Once you do this, you can execute docker commands for non-root user without typing sudo


sudo groupadd docker

sudo gpasswd -a $USER docker

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

kubeadm init –pod-network-cidr=10.244.0.0/16



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


Step 10:- Confirm that all of the pods are running with the following command.Note that this takes time, so please watch it for few minutes.Make sure you see all the pods as running, it takes a bit of time for the control plane to get ready

watch kubectl get pods --all-namespaces

Step 11:- Confirm that the master node is in ready status using the below command

kubectl get nodes

Step 12:- Setup worker nodes and join them to master, To do this, follow the Install Docker steps completely and follow the Install Kubernetes steps till Step 4.Follow these steps as many times depending on the number of worker nodes you need, which basically is a new VM.

Step 13:- Join token

In my case, this is what the token looked like, please use your own token which gets created when you run kubeadm.

kubeadm join 172.31.25.97:6443 --token t0mt55.hg8ib424gow5kcj8 --discovery-token-ca-cert-hash sha256:7f5bb869a80f5731959702f0d72507f9e5ad27f2f12f2c0013e25edaa92109e3

Step 14:- If you have lost the token and not able to find it, you can run the below command and get the token


kubeadm token create --print-join-command

Step 15: Go Back to master and execute the below command.You should see that the master and the worker are in ready status.

kubectl get nodes

# Dockerfile

Step 1:- To build the docker image you need to create a Dockerfile.Make sure the Dockerfile and test.sh are in the same directory as test.sh will be used in the dockerfile for execution.

Step 2:- Run the below command to build the docker image

docker build -t drupal-test:v1 .

Step 3:- Use the image to run the container

docker run -it -p 80:80 --name drupal-test drupal-test:v1

or 

docker run -d -p 80:80 --name drupal-test drupal-test:v1


Here if we use -it , then its interactive mode and you can check the whole process.If you use -d , then its background mode and you will only see the docker container id

One of the issues that i am facing, it takes time for the drupal page to show up, so would request you to refresh the page and wait for 5-10 minutes





