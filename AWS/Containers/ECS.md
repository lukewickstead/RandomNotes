# Amazon ECS

- Amazon EC2 Container Service; commonly known as Amazon ECS
- Allows running of Docker-enabled applications packaged as containers across a cluster of EC2 instances without requiring you to manage a complex and administratively heavy cluster management system
- Burden of managing a cluster management system is abstracted with the Amazon ECS service by passing that responsibility over to AWS, specifically through the use of AWS Fargate. 
- AWS Fargate is an engine used to enable ECS to run containers without having to manage and provision instances and clusters for containers. 
- Manages your cluster management system due to its interactions with AWS Fargate
- No need to install any management or monitoring software for your cluster
- 2 types of launces; Fargate and EC2


## Fargate

- Specify CPU, memory, IAM policies and package your containers
- Patches and scales for you


## EC2 launch

- Far greater scope of customization and configurable parameters
- You are responsible for patching and scaling your instances
- Can specify which instance types you used, and how many containers should be in a cluster
- Monitoring is taken care of through the use of AWS CloudWatch


## Amazon ESC Cluster

- Comprised of a collection of EC2 instances
- Clusters act as a resource pool, aggregating
-  resources such as CPU and memory
- Clusters are dynamically scalable and multiple instances can be used
- Clusters can only scale in a single region
- Containers can be scheduled to be deployed across your cluster
- Instances within the cluster also have a Docker daemon and an ESC agent