# SRE_Major-League-Hacking_Code-sample

This project is a simple static web app that has been containerized using Docker and pushed to Docker Hub. It can be deployed in a Kubernetes cluster running on AWS EKS. The EKS cluster has been created using Terraform modules.

Prerequisites

Docker installed on your machine.
A Docker Hub account.
AWS CLI installed on your machine.
An AWS account.
Terraform installed on your machine.

### Docker
### To build the Docker image, navigate to the root directory of the project and run the following command:

docker build -t <docker-hub-username>/<image-name>:<tag> .

### Once the image has been built, push it to Docker Hub using the following command:

docker push <docker-hub-username>/<image-name>:<tag>

### Terraform
### To create an EKS cluster using Terraform, navigate to the terraform directory and run the following commands:
### initialize

    terraform init

### preview terraform actions

    terraform plan

### apply configuration with variables

    terraform apply -var-file terraform-dev.tfvars
### Run the following command to update your kubectl configuration with the credentials for the EKS cluster:

 aws eks update-kubeconfig --name <cluster-name>

### Run the following command to verify that kubectl is configured to communicate with the EKS cluster:

kubectl cluster-info

### apply configuration file to  the Kubernetes cluster using the following command:

kubectl apply -f <deployment-file-name>.yaml



Conclusion
This project demonstrates a simple workflow for containerizing a static web app, pushing it to Docker Hub, and deploying it to a Kubernetes cluster running on AWS EKS. The EKS cluster is created using Terraform modules, which simplifies the process of creating and managing the infrastructure.