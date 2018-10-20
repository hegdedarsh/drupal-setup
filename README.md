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






