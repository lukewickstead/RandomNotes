# AWS Compute Fundamentals
> https://aws.amazon.com/products/compute

The basic building blocks for cloud under AWS and covers a wide range of services
- Amazon EC2
- Amazon Lightsail
- Amazon ECS
- AWS Fargate
- AWS Lambda

## EC2 - Elastic Compute Cloud
> https://aws.amazon.com/ec2
> https://cloudacademy.com/blog/aws-shared-responsibility-model-security

EC2 allows you to deploy virtual servers within your AWS environment and most people will require an EC2 instance within their environment as a part of at least one of their solutions. 

The EC2 service can be broken down into the following components:
- Amazon machine images (AMIs)
- Instant types
- Instance purchasing options
- Tenancy
- User data
- Storage options
- Security

### Amazon Machine Images (AMI)
- Templates of pre-configured EC2 instances
- Prevents having to install an operating system, common applications and other configuration
- You can create AMI images from set up EC2 instance
- AWS market place for third party AMIs such as F5, cisco etc
- Community AMIs is a repository of community created AMIs

### Instance Types
An instance type simply defines the size of the instance based on a number of different parameters, these being ECUs. 

This defines a number of EC2 compute units for instance:
- vCPUs; the number of virtual CPUs on the instance
- Physical processor; process speed used on the instance
- Clock speed, it's clock speed in gigahertz
- Memory, the amount of memory
- Incident storage;  capacity of the local instance store volumes available
- EBS optimized available, this defines if the instance supports EBS optimized storage or not
- Network performance, this shows the performance level of rate of data transfer
- IPV6 support, this simply indicates if the instance type supports IPV6
- Process architecture; the architecture type of the processor
- AES-NI, this stands for advanced encryption standard new instructions and it shows if the instance supports it for enhanced data protection
- AVX this indicates if the instance supports AVX which is advanced vector extensions, which are primary used for applications focused on audio and video, scientific calculations and 3D modeling analysis
- And finally Turbo which shows if the instance supports intel turbo boost and AMD turbo core technologies
  
#### Instance Type Families
- Micro instances; low cost with minimal amount of CPU and memory power, ideal for very low traffics websites
- General-purpose; balanced mix of CPU memory and storage,  ideal for small to medium databases, tests and development servers and back-end servers
- Compute optimized; a greater focus on compute with the highest performing processes installed. Ideal for high-performance front end servers, web servers, high-performance science and engineering applications and video encoding and batch processing
- GPU; optimized for graphic intensive applications
- FPGA; field programmable gate arrays. To create application specific hardware accelerations when used with applications that use massively parallel processing power such as genomics and financial computing
- Memory optimized;  used for large-scale enterprise class in-memory applications. They have the lowest cost per gigabyte of RAM against all other instance families
- Storage optimized; optimized for enhanced storage. SSD backed instant storage for low latency and very high I/O, input/output performance, including very high IOPS which is input/output operations per second. And these are great for analytic workloads and no SQL databases. Data file systems and log processing applications

#### Instance purchasing options
There are a variety of different payment plans:
- On-demand instances
- Reserved instances
- Scheduled instances
- Spot instances
- On-demand capacity reservations

##### On-demand instance
- Can launch at any time
- Can be used for as long as needed
- Flat rate determined on the instance type
- Typically used for short-term uses
- Best fit for testing and development environments
  
##### Reserved instances
- Purchases for a set period of time for reduces cost
- All Upfront; complete payment for 1 or 3 yra time frame
- Partial; smaller upfront payment for smaller discount
- No Upfront; the smallest discount is applied

##### Scheduled instances
- You pay for the reservations on a recurring schedule; daily, weekly or monthly
- You could set up a schedule instance run during that set time frame once a week
- If you don't use the instance you will still be charged

##### Spot instances
- Bid for a unused EC2 Compute resource
- No guarantees for a fixed period of time
- Fluctuation of prices based on supply and demand
- Purchase large EC2 instances at a very low price
- Useful for processing data that can be suddenly interrupted

##### On-demand capacity reservations
- Reserve capacity based on different attributes such as instance type, platform and tenancy, within a particular availability zone for any period of time
- It could be used in conjunction with your reserved instance discount

### Tenancy
This relates to what underlying host your EC2 instance will reside on. So essentially the physical server within an AWS data center.

- Shared tenancy
  - EC2 instance is launched on any available host with the required resources
  - The same host may be used by multiple customers
  - AWS Security mechanisms
- Dedicated tenancy
  - Hosted on hardware that no other customer can access
  - Maybe required to meet compliances
  - Dedicated instances incur additional chagres
- Dedicated host
  - Additional visibility and control on the physical host
  - Allows to use the same host for a number of instances
  - May be required to meet compliance

### User data
Allows you to enter commands that will run during the first boot cycle of the instance:
- Pull down any additional software you want installing from any software repositories you may have. You could also 
- Download and get the latest OS updates during boot. 
- For example you could enter yum update dash y, for a Linux instance which will then update its own software automatically at the time of boot. Storage 

### Storage requirements
Selecting storage for your EC2 instance will depend on the instance selected, what you intend to use the instance for and how critical the data is. Ephemeral and Persistance options are available

- Persistent storages
  - Available by attaching EBS volumes
  - EBS volumes are separated from the EC2 instance
  - These volumes are logically attached via AWS network
  - You can disconnect the volume from the EC2 instance maintaining data
  - You can implement encryption and take backup snapshots of all data
- Ephemeral storage
  - Created by EC2 instances using local storage
  - Physically attached to the underlying host
  - When the instance is stopped or terminated, all saved data on disk is lost
  - If you reboot your data **will** remain intact
  - You are unable to detach instance store volume from the instance

### Security
> https://cloudacademy.com/blog/aws-shared-responsibility-model-security

- Each EC2 instance requires a security group
  - A security group is an instance level firewall allowing restriction of both ingress and egress traffic by source, ports and protocols
- Each EC2 instance requires a key pair
  - Private and public key
  - Can create or download one
  - Encrypt and Decrypt the login information for Linux and Windows EC2 instances
  - Public key held by AWS, private key is your responsibility
  - Can set up additional less privileged access controls such as local windows, AD access etc
  - Key pairs can be shared between E2C instances
- Your responsibility to maintain and install the latest OS and security patches released by the OS vendor as dictated within the AWS shared responsibility model

## Amazon ECS
- Amazon EC2 Container Service; commonly known as Amazon ECS
- Allows running of Docker-enabled applications packaged as containers across a cluster of EC2 instances without requiring you to manage a complex and administratively heavy cluster management system
- Burden of managing a cluster management system is abstracted with the Amazon ECS service by passing that responsibility over to AWS, specifically through the use of AWS Fargate. 
- AWS Fargate is an engine used to enable ECS to run containers without having to manage and provision instances and clusters for containers. 
- Manages your cluster management system due to its interactions with AWS Fargate
- No need to install any management or monitoring software for your cluster
- 2 types of launces; Fargate and EC2

### Fargate
- Specify CPU, memory, IAM policies and package your containers
- Patches and scales for you

## EC2 launch
- Far greater scope of customization and configurable parameters
- You are responsible for patching and scaling your instances
- Can specify which instance types you used, and how many containers should be in a cluster
- Monitoring is taken care of through the use of AWS CloudWatch

### Amazon ESC Cluster
- Comprised of a collection of EC2 instances
- Clusters act as a resource pool, aggregating
-  resources such as CPU and memory
- Clusters are dynamically scalable and multiple instances can be used
- Clusters can only scale in a single region
- Containers can be scheduled to be deployed across your cluster
- Instances within the cluster also have a Docker daemon and an ESC agent

## Amazon ECR
- ECR provides a secure location to store and manage your docker images
- This is a fully managed service, so you don't need to provision any infrastructure tro allow you to create this registry of docker images
- This service allows developers to push, pull and manage their library of docker images in a central and secure location
- ECR is comprised of the following components
  - Registry
  - Authorization token
  - Repository
  - Repository policy
  - Image

### Registry
- The ECR registry is the object that allows you to host and store your docker images in as well as create image repositories
- By default the URL for the the registry is as follows:
  - https://**aws_account_id**.dkr.ecr.**region**.amazonaws.com
- Your account will have both read and write access by default to any images you create within the registry and any repositories
- Access to your registry and images can be controlled via IAM policies in addition to repository polices
- Before your docker client can access your registry, it needs to be authenticated as an AWS user via an Authorization token

### Authorization Token
To authorize docker with your default registry for 12 hours: 
```bash
aws ecr get-login --region **region** --no-include-email
docker login -u AWS -p password https://aws_account_id.dkr.ecr.region.amazonaws.com
```
 
### Repository
- These are objects within your registry that allow you to group together and secure different docker images
- You can create multiple repositories allowing you to organize and manage your docker images into different categories
- Using policies from both IA and repository policies you can assign set permissions to each repository

### Repository Policy
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

### Images
- Once you have configured your registry, repositories and security controls, and authenticated your docker client with ECR, you can then begin storing your docker images in the required repositories
- To push an image into ECR use the docker push command
  - https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
- To pull an image from ECR use the docker pull command
  - https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-pull-ecr-image.html
  
## Amazon EKS
Other Resources:
  - https://cloudacademy.com/course/introduction-to-aws-eks
  - https://cloudacademy.com/course/introduction-to-kubernetes/introduction


- Elastics container service for Kubernetes
- Kubernetes is an open-source container orchestration tool designed to automate, deploying, scaling, and operating containerized applications
- Run Kubernetes across your AWS infrastructure without having to take care of provisioning and running the Kubernetes management infrastructure by the the control plane; only need to provision and maintain the worker nodes

### Kubernetes Control Plane
- There are a number of different components that make up the control plane and these include a number of different APIs, the kubelet processes and the Kubernetes Master
- The control plan schedules containers onto nodes
- The control plane also tracks the state of all Kubernetes objects by continually monitoring the objects
- In EKS, AWS is responsible for 
- These dictate how kubernetes and your clusters communicate with each other
- In EKS, AWS is responsible for provisioning, scaling and managing the control plane and they do this by utilising multiple availability zones for additional resilience

### Worker nodes
- Kubernetes clusters are composed of nodes; cluster is an aggregate of nodes
- A node is a worker machine in Kubernetes. It runs as an on-demand EC2 instance and includes software to run containers
- For each node created, a specific AMI is used which also ensures docker and kubelet in addition to the AWS IAM authenticator is installed for security controls
- Once the worker nodes are provisioned they can then connect to EKS using an endpoint

### Working With EKS
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

## AWS Elastic Beanstalk
- AWS Elastic Beanstalk is an AWS managed service that takes your uploaded code of your web application code and automatically provision and deploys the required resources within AWS to make the web application operational
- These resources can include other AWS services and features, such as EC2, Auto Scaling, application health-monitoring, and Elastic Load Balancing, in addition to capacity provisioning
- An ideal service for engineers who may not have the familiarity or the necessary skills within AWS to deploy, provision, monitor, and scale the correct environment themselves to run the developed applications
- The responsibility is passed on to AWS Elastic Beanstalk to deploy the correct infrastructure to run the uploaded code
- You can continue to support and maintain the environment as you would with a custom built environment
- You can perform some of the maintenance tasks from the Elastic Beanstalk dashboard itself
- Elastic Beanstalk is able to operate with a variety of different platforms and programming languages, making it a very flexible service for your DevOps teams;
- It is s free to use; however, any resources that are created on your application's behalf, such as EC2 instances,  will be charged

### The application version
- An application version is a very specific reference to a section of deployable code
- The application version will point typically to S3, simple storage service to where the deployable code may reside

### The environment
- An environment refers to an application version that has been deployed on AWS resources which are configured and provisioned by AWS Elastic Beanstalk
- At this stage, the application is deployed as a solution and becomes operational within your environment
- The environment is comprised of all the resources created by Elastic Beanstalk and not just an EC2 instance with your uploaded code

### Environment configurations
- A collection of parameters and settings that dictate how an environment will have its resources provisioned by Elastic Beanstalk and how these resources will behave

### The environment tier
- This component reflects on how Elastic Beanstalk provisions resources based on what the application is designed to do
  - If the application manages and handles HTTP requests, then the app will be run in a web server environment
  - If the application does not process HTTP requests, and instead perhaps pulls data from an SQS queue, then it would run in a worker environment

### The configuration template
- This is the template that provides the baseline for creating a new, unique environment configuration. 

### Platform
- Platform is a culmination of components in which you can build your application upon using Elastic Beanstalk
- These comprise of the OS  of the instance, the programming language, the server type (web or application), and components of Elastic Beanstalk itself, and as a whole can be defined as a platform

### Applications
- An application is a collection of different elements, such as environments, environment configurations, and application versions
- In fact, you can have multiple application versions held within a single application
- You can deploy your application across one of two different environment tiers, either the web server tier or the worker tier
- The web server environment
  - Typically used for standard web applications that operate and serve requests over HTTP port 80
  - This tier will typically use service and features such as
    - Route 53
    - Elastic Load Balancing
    - Auto Scaling
    - EC2
    - Security Groups
- The worker environment 
  - Slightly different and are used by applications that will have a back-end processing task that will interact with AWS SQS, the Simple Queue Service
  - This tier typically uses the following AWS resources in this environment
    - SQS Queue
    - IAM Service Role
    - Auto Scaling
    - EC2

### Elastics Beanstalk Workflow
- Create an application
- Upload your application version, along with additional configuration
  - This creates the environment configuration
- Launch Environment
  - The environment is then created by Elastic Beanstalk with the appropriate resources to run your code
  - Any management of your application can then take place, such as deploying new versions of your application
- Manage Environment 
  - If the management of your applications have altered the environment configuration, then your environment will automatically be updated to reflect the new code should additional resources be required


## AWS Lambda
- AWS Lambda is a serverless compute service which has been designed to allow you to run your application code without having to manage and provision your own EC2 instances
- Serverless means that you do not need to worry about provisioning and managing your own compute resource to run your own code, instead this is managed and provisioned by AWS
- Serverless, does require compute power, to carry out your code requests, but because the AWS user does not need to be concerned with what's managing this compute power, or where it's provisioned from, it's considered serverless from the user perspective
- You only ever have to pay for the compute power when Lambda is in use via Lambda functions
- AWS Lambda charges compute power per 100 milliseconds of use only when your code is running, in addition to the number of times your code runs

### Working With AWS Lambda
- You can either upload this code to AWS Lambda, or write it within the code editor that Lambda provides. Currently, AWS Lambda supports Notebook.js, JavaScript, Python, Java, Java 8 compatible, C#, .NET Core, Go, and also Ruby
- Configure Lambda functions to execute your code upon specific triggers from supported event sources, such as S3 
- Once the specific trigger is initiated during the normal operations of AWS, AWS Lambda will run your code, as per your Lambda function, using only the required compute power as defined
- AWS records the compute time in milliseconds and the quantity of Lambda functions run to ascertain the cost of the service

### Components Of AWS Lambda
The following form the key constructs of a Lambda application:
- Lambda function are compiled of your own code that you want Lambda to invoke as per defined triggers
- Event sources are AWS services that can be used to trigger your Lambda functions, or put another way, they produce the events that your Lambda function essentially responds to by invoking it
  - https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html#supported-event-source-s3
- Trigger is essentially an operation from an event source that causes the function to invoke
- Downstream Resources are resources that are required during the execution of your Lambda function
- Log streams help you identify issues and troubleshoot issues with your Lambda function. These log streams will essentially be a sequence of events that all come from the same function and recorded in CloudWatch

### Creating Lambda Functions
- Selecting a blueprint
  - Select a blueprint template provided by AWS Lambda
  - Ex: S3-get-object - an S3 trigger that retrieves metadata
- Configure Triggers
  - Define the trigger for your Lamda functions
  - Ex: specifying the S3 bucket for you function
- Configure function
  - Upload code or edit it in-line
  - Defe the required resources, maximum execution timeout, IAM Role and Handler Name

### Key Benefits
AWS Lambda is a highly scalable serverless service, coupled with fantastic cost optimization compared to EC2 as you are only charged for Compute power while the code is running and for the number of functions called

## AWS Batch
AWS Batch is used to manage and run Batch computing workloads within AWS

### What Is Batch Computing
- Batch computing is primarily used in specialist use cases which require a vast amount of compute power across a cluster of compute resources to complete batch processing executing a series of jobs or tasks
- With AWS Batch, many of these constraints, administration activities and maintenance tasks are removed
- You can seamlessly create a cluster of compute resources which is highly scalable, taking advantage of the elasticity if AWS, coping with any level of batch processing while optimizing the distribution of the workloads
- All provisioning, monitoring, maintenance and management of the clusters themselves is taken care of by AWS
  
### AWS Batch Components
#### Jobs
- A job is classed as a unit of work that is to be run by AWS Batch
- A job can be an executable file, an application within an ECS cluster or a shell script
- Jobs run on EC2 instances as a containerized application
- Jobs can have different states, for example, submitted, pending, running, failed, etc
  
### Job definitions
- These define specific parameters for the jobs themselves and dictate how the job will run and with what configuration
  - How many vCPUs to use for the container
  - Which data volume should be used
  - Which IAM role should be used to allow access for AWS Batch to communicate with other AWS services
  - Mount points.

### Job queues
- Jobs that are scheduled are placed into a job queue until they run
  - You can have multiple queues with different priorities
  -  On-demand and spot instances are supported by AWS Batch
  -  AWS Batch can even bid on your behalf for those spot instances

### Job scheduling
- The Job Scheduler takes care of when a job should be run and from which Compute Environment
  - Typically it will operate on a first-in-first-out basis
  - It ensures that higher priority queues are run first

### Compute Environments
- These are the environments containing the compute resources to carry out the job
- Can be Managed or Unmanaged
- Managed
  - The service will handle provisioning, scaling and termination of your Compute instances
  - The environment is created as an Amazon ECS CLuster
- Unmanaged
  - These environments are provisioned, managed and maintained by you
  - It requires greater customization but requires greater administration and maintenance
  - It requires you to create the necessary Amazon ECS Cluster


If you have a requirement to run multiple jobs in parallel using Batch computing, for example, to analyze financial risk models, perform media transcoding or engineering simulations, then AWS Batch would be a perfect solution

## Amazon Lightsail

Amazon Lightsail is essentially a virtual private server, A VPS, backed by AWS infrastructure, much like an EC2 instance but without as many configurable steps throughout its creation.

- It has been designed to simple, quick, and very easy to use at a low cost point for small-scale use cases by small business or for single users
  - It's commonly used to host simple websites, small applications, and blogs
  - You can run multiple Lightsail instances together, allowing them to communicate
  - It's even possible if required to connect it to other AWS resources and to your existing VPC, running within AWS via a peering connection

### Deploying A Lightsail Instance
- A Lightsail instance can be deployed from a single page with ust a few simple configuration options
- Amazon Lightsail can be accessed either via the AWS console under the compute category, or directly to the homepage of AWS Lightsail, which sits outside of the Management Console
  - https://lightsail.aws.amazon.com/ls/webapp/home/resources

#### Creation
- Select create instance, where you can then create your instance all from just one page of options
  - Select your region and availability zone as required as to where you'd like to provision your Lightsail instance
  - Select your platform, Linux or Windows based, and then additional blueprint if required
  - If you didn't need a blueprint, you can simply select to use the operating system only
  - You have the option to add a launch script and a different key pair
    - Launch script can be a shell script that will run at the time of the launch, much like user data for an EC2 instance
    - By default, you are provided with a key pair to connect to your instance. However, you can select to choose an alternative one if required
  - Select your instance plan; this section defines the resources of your instance and how much you're going to be paying on a monthly basis
    - The price per month option shows preset configurations based on memory, processing power, storage, and data transfer
    - You can tab through the corresponding tabs and customize the values of each 
      - On-demand price means you'll only pay for the resource when you're using them
      - Dollar per month price is based on having the instance on continuously, which AWS calculates as 31.25 days multiplied by 24 hours
  - Provide a unique name for your Lightsail instance
  - Add key-value tags to help organize your resources

#### Management
- Connect allows you to connect to your newly created instance using SSH either via inline SSH software provided by Lightsail or with your own SSH software using the key pair provided. The instance has given a public IP to allow you to connect
- Storage  provides an overview of your current storage, showing the capacity and the disk path. You can attach additional disks to your instance
- Metrics view graphical metrics of your instance, such as CPU utilization, network in, network out, StatusCheckFailed, StatusCheckFailed_Instance, and StatusCheckFailed_System
  - These graphs can be viewed over a number of different time periods, from one hour through to two weeks
- Networking allows you to view your IP address information along with a very simple virtual file, allowing you to control which ports your instance can accept connections from. You can also gain additional information on load balancing your traffic between instances
- Snapshots is a simple way to backup your instance
- Tags allow adding or edit of tags to help you filter and organize your resources. Key-value tags can also be used to help manage your billing and control access
- History provides a simple order information of your instance, such as the date and time the instance was created or when configuration changes occurred
- Delete allows you to delete your instance along with any data that was stored in it

Amazon Lightsail provides a lightweight solution for small projects and use cases which can be deployed quickly and cost effectively in just a few clicks


## Connecting to EC2
This can be done with putty and ssh; these examples uses ssh

``` bash
ssh -i /path/to/your/keypair.pem user@server-ip
```

- server-ip is the Public IP of your server, found on the Description tab of the running instance in the EC2 Console
- user is the remote system userthat will be used for the remote authentication
  -  ec2-user for Amazon Linux and RedHat
  -  admin for Debian
  -  ubuntu for ubuntu

Your SSH client may refuse to start the connection, warning that the key file is unprotected. You should deny the file access to any other system users by changing its permissions

``` bash
chmod 600  ~/keypair.pem
```

The Instances page provides a helpful shortcut for connecting to a Linux instance. Select the running instance and click the Connect button. It will formulate an example ssh command for you, including the required key name and public IP address. However, it is still useful to learn the basics of manually using the ssh command.


### Listing EC2 Metadata
List all instance metadata by issuing the following command:

```bash
curl -w "\n" http://169.254.169.254/latest/meta-data/
```

Note: The IP address used below (169.254.169.254) is a special use address to return metadata information tied to EC2 instances. The following options are returned:

- ami-id
- ami-launch-index
- ami-manifest-path
- block-device-mapping/
- events/
- hostname
- identity-credentials/
- instance-action
- instance-id
- instance-type
- local-hostname
- local-ipv4
- mac
- metrics/
- network/
- placement/
- profile
- public-hostname
- public-ipv4
- public-keys/
- reservation-id
- security-groups
- services/

Enter the following commands to extract specific metadata associated with your running instance: 

```
curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups
curl -w "\n" http://169.254.169.254/latest/meta-data/ami-id
curl -w "\n" http://169.254.169.254/latest/meta-data/hostname
curl -w "\n" http://169.254.169.254/latest/meta-data/instance-id
curl -w "\n" http://169.254.169.254/latest/meta-data/instance-type
```

Enter the following command to get the public SSH key of the attached key pair using the public-keys metadata:

``` bash
curl -w "\n" http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key
```