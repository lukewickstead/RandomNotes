# EC2 - Elastic Compute Cloud

The basic building blocks for cloud under AWS and covers a wide range of services
- Amazon EC2
- Amazon Lightsail
- Amazon ECS
- AWS Fargate
- AWS Lambda
- ECR, ECS, EKS

> https://aws.amazon.com/ec2
> https://aws.amazon.com/products/compute
> https://cloudacademy.com/blog/aws-shared-responsibility-model-security

EC2 allows you to deploy virtual servers within your AWS environment and most people will require an EC2 instance within their environment as a part of at least one of their solutions

The EC2 service can be broken down into the following components:
- Amazon machine images (AMIs)
- Instant types
- Instance purchasing options
- Tenancy
- User data
- Storage options
- Security


## Amazon Machine Images (AMI)

- Templates of pre-configured EC2 instances
- Prevents having to install an operating system, common applications and other configuration
- You can create AMI images from set up EC2 instance
- AWS market place for third party AMIs such as F5, cisco etc
- Community AMIs is a repository of community created AMIs


## Instance Types

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


### Instance Type Families

- Micro instances; low cost with minimal amount of CPU and memory power, ideal for very low traffics websites
- General-purpose; balanced mix of CPU memory and storage,  ideal for small to medium databases, tests and development servers and back-end servers
- Compute optimized; a greater focus on compute with the highest performing processes installed. Ideal for high-performance front end servers, web servers, high-performance science and engineering applications and video encoding and batch processing
- GPU; optimized for graphic intensive applications
- FPGA; field programmable gate arrays. To create application specific hardware accelerations when used with applications that use massively parallel processing power such as genomics and financial computing
- Memory optimized;  used for large-scale enterprise class in-memory applications. They have the lowest cost per gigabyte of RAM against all other instance families
- Storage optimized; optimized for enhanced storage. SSD backed instant storage for low latency and very high I/O, input/output performance, including very high IOPS which is input/output operations per second. And these are great for analytic workloads and no SQL databases. Data file systems and log processing applications


### Instance purchasing options

There are a variety of different payment plans:
- On-demand instances
- Reserved instances
- Scheduled instances
- Spot instances
- On-demand capacity reservations


#### On-demand instance

- Can launch at any time
- Can be used for as long as needed
- Flat rate determined on the instance type
- Typically used for short-term uses
- Best fit for testing and development environments


#### Reserved instances

- Purchases for a set period of time for reduces cost
- All Upfront; complete payment for 1 or 3 yra time frame
- Partial; smaller upfront payment for smaller discount
- No Upfront; the smallest discount is applied


#### Scheduled instances

- You pay for the reservations on a recurring schedule; daily, weekly or monthly
- You could set up a schedule instance run during that set time frame once a week
- If you don't use the instance you will still be charged


#### Spot instances

- Bid for a unused EC2 Compute resource
- No guarantees for a fixed period of time
- Fluctuation of prices based on supply and demand
- Purchase large EC2 instances at a very low price
- Useful for processing data that can be suddenly interrupted


#### On-demand capacity reservations

- Reserve capacity based on different attributes such as instance type, platform and tenancy, within a particular availability zone for any period of time
- It could be used in conjunction with your reserved instance discount


## Tenancy

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


## User data

Allows you to enter commands that will run during the first boot cycle of the instance:
- Pull down any additional software you want installing from any software repositories you may have. You could also 
- Download and get the latest OS updates during boot. 
- For example you could enter yum update dash y, for a Linux instance which will then update its own software automatically at the time of boot. Storage 


## Storage requirements

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


## Security

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
