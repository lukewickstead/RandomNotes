# AWS Batch

AWS Batch is used to manage and run Batch computing workloads within AWS


## What Is Batch Computing

- Batch computing is primarily used in specialist use cases which require a vast amount of compute power across a cluster of compute resources to complete batch processing executing a series of jobs or tasks
- With AWS Batch, many of these constraints, administration activities and maintenance tasks are removed
- You can seamlessly create a cluster of compute resources which is highly scalable, taking advantage of the elasticity if AWS, coping with any level of batch processing while optimizing the distribution of the workloads
- All provisioning, monitoring, maintenance and management of the clusters themselves is taken care of by AWS


## AWS Batch Components

### Jobs

- A job is classed as a unit of work that is to be run by AWS Batch
- A job can be an executable file, an application within an ECS cluster or a shell script
- Jobs run on EC2 instances as a containerized application
- Jobs can have different states, for example, submitted, pending, running, failed, etc


## Job definitions

- These define specific parameters for the jobs themselves and dictate how the job will run and with what configuration
  - How many vCPUs to use for the container
  - Which data volume should be used
  - Which IAM role should be used to allow access for AWS Batch to communicate with other AWS services
  - Mount points.


## Job queues

- Jobs that are scheduled are placed into a job queue until they run
  - You can have multiple queues with different priorities
  -  On-demand and spot instances are supported by AWS Batch
  -  AWS Batch can even bid on your behalf for those spot instances

## Job scheduling

- The Job Scheduler takes care of when a job should be run and from which Compute Environment
  - Typically it will operate on a first-in-first-out basis
  - It ensures that higher priority queues are run first


## Compute Environments

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