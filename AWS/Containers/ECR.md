# Amazon ECR

- ECR provides a secure location to store and manage your docker images
- This is a fully managed service, so you don't need to provision any infrastructure tro allow you to create this registry of docker images
- This service allows developers to push, pull and manage their library of docker images in a central and secure location
- ECR is comprised of the following components
  - Registry
  - Authorization token
  - Repository
  - Repository policy
  - Image


## Registry

- The ECR registry is the object that allows you to host and store your docker images in as well as create image repositories
- By default the URL for the the registry is as follows:
  - https://**aws_account_id**.dkr.ecr.**region**.amazonaws.com
- Your account will have both read and write access by default to any images you create within the registry and any repositories
- Access to your registry and images can be controlled via IAM policies in addition to repository polices
- Before your docker client can access your registry, it needs to be authenticated as an AWS user via an Authorization token


## Authorization Token

To authorize docker with your default registry for 12 hours: 
```bash
aws ecr get-login --region **region** --no-include-email
docker login -u AWS -p password https://aws_account_id.dkr.ecr.region.amazonaws.com
```


## Repository

- These are objects within your registry that allow you to group together and secure different docker images
- You can create multiple repositories allowing you to organize and manage your docker images into different categories
- Using policies from both IA and repository policies you can assign set permissions to each repository


## Repository Policy

Other Resources:
- https://cloudacademy.com/course/overview-of-aws-identity-and-access-management-iam/

There are a number rof different IAM managed policies to help you control access to ECR:
  - AmazonEC2ContainerRegistryFullAccess
  - AmazonEC2ContainerRegistryPowerUser
  - AmazonEC2ContainerRegistryReadOnly

Repository policies are resource-based policies:
- You need to ensure you add a principal to the policy to determine who has access and what permissions they have
- For an AWS user to gain access to the registry they will require access to the ecr:GetAuthorizationToken API call
- Once they have this access, repository policies can control what actions those users can perform on each of the repositories


## Images

- Once you have configured your registry, repositories and security controls, and authenticated your docker client with ECR, you can then begin storing your docker images in the required repositories
- To push an image into ECR use the docker push command
  - https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
- To pull an image from ECR use the docker pull command
  - https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-pull-ecr-image.html
