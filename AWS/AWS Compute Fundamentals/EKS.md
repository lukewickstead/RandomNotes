# Amazon EKS

Other Resources:
  - https://cloudacademy.com/course/introduction-to-aws-eks
  - https://cloudacademy.com/course/introduction-to-kubernetes/introduction


- Elastics container service for Kubernetes
- Kubernetes is an open-source container orchestration tool designed to automate, deploying, scaling, and operating containerized applications
- Run Kubernetes across your AWS infrastructure without having to take care of provisioning and running the Kubernetes management infrastructure by the the control plane; only need to provision and maintain the worker nodes


## Kubernetes Control Plane

- There are a number of different components that make up the control plane and these include a number of different APIs, the kubelet processes and the Kubernetes Master
- The control plan schedules containers onto nodes
- The control plane also tracks the state of all Kubernetes objects by continually monitoring the objects
- In EKS, AWS is responsible for 
- These dictate how kubernetes and your clusters communicate with each other
- In EKS, AWS is responsible for provisioning, scaling and managing the control plane and they do this by utilising multiple availability zones for additional resilience


## Worker nodes

- Kubernetes clusters are composed of nodes; cluster is an aggregate of nodes
- A node is a worker machine in Kubernetes. It runs as an on-demand EC2 instance and includes software to run containers
- For each node created, a specific AMI is used which also ensures docker and kubelet in addition to the AWS IAM authenticator is installed for security controls
- Once the worker nodes are provisioned they can then connect to EKS using an endpoint


## Working With EKS

- Create an EKS Service Role
  - Create an IAM service-role that allows EKS to provision and configure specific resources; can be shared for all other EKS clusters created going forward
  - The role needs to have the following permissions policies attached to the role
    - AmazonEKSServicePolicy
    - AmazonEKSClusterPolicy
- Create an EKS Cluster VPC
  - Using AWS CloudFormation you need to create a and run a CloudFormation stack based on the following template, which will configure a new VPC for you to use with EKS
    - https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/amazon-eks-vpc-sample.yaml 
- Install kubectl
  - Kubectl is a command line utility for Kubernetes
    - https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html 
- Install AWS-IAM-Authenticator
    -  The IAM-Authenticator is required to authenticate with the EKS cluster
       -  https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator
       -  https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/windows/amd64/aws-iam-authenticator.exe
- Create your EKS Cluster
  - Using the EKS console you can now create your EKS cluster using the details and information from the VPC created in step 1 and 2
- Configure kubectl for EKS
  - Using the update-kubeconfig command via the AWS CLI you need to create a kubeconfig file for your EKS cluster
    - https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
- Provision and configure Worker Nodes
  - Once your EKS cluster shows an active status you can launch your worker nodes using CloudFormation based on the following template
    - https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/amazon-eks-nodegroup.yaml
- Configure the Worker Node to join the EKS Cluster: Using a configuration map downloaded here
  - curl -O https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2019-02-11/aws-auth-cm.yaml
  - You must edit it and Replace the <ARN of instance role (not instance profile)> with the NodeInstanceRole value from step 6
  - You EKS Cluster and worker nodes are now configured ready for your to deploy your applications with Kubernetes