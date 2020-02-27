# EC2 Auto Scaling

Auto Scaling is a mechanism that automatically allows you to increase or decrease your EC2 resources to meet the demand based off of custom defined metrics and thresholds. 

- Amazon EC2 Auto Scaling
  - Focuses on the scaling of your EC2 fleet
- AWS Auto Scaling service
  - Allows you to scale Amazon ECS tasks, DynamoDB tables and indexes, in addition to Amazon Aurora replicas

## EC2 Auto Scaling Example

- As the requests and demand increases, so does the load on the instance
- Additional processing power will be required to process the additional requests and therefore the CPU utilization would also increase
- You would need to deploy another EC2 instance to load balance the demand and process the increased requests
- With Auto Scaling, you could configure a metric to automatically launch a second instance when the CPU utilization got to 75% on the first instance
- By load balancing traffic evenly, it would reduce the demand put upon each instance and reduce the chance of the first web server failing or slowing due to high CPU usage
- Similarly, when the demand on your web server reduces, so would your CPU utilization; you could also set a metric to scale back
- In this example, you could configure Auto Scaling to automatically terminate one of your EC2 instances when the CPU utilization dropped to 20% as it would no longer be required due to the decreased demand
- Reduces Costs
- Actions termed scale out and in for adding and reducing EC2 instances

### EC2 Auto Scaling Advantages

- Automation
  - Your infrastructure can elastically provision the required resources, preventing your operations team from manually deploying and removing resources
- Greater customer satisfaction
  - If you are always able to provision enough capacity within your environment when the demand increases, then it's unlikely that your end users will experience performance issues
- Cost reduction
  - With the ability to automatically reduce the amount of resources you have when the demand drops, you will stop paying for those resources

When you couple Auto Scaling with an Elastic Load Balancer, you get a real sense of how beneficial building a scalable and flexible architecture for your resources can be.


## Components of EC2 Auto Scaling

1. Create a Launch Configuration or Launch Template
   - These define how an Auto Scaling Group builds new EC2 instances
     - Which Amazon Machine Image to use
     - Which Instant Type to use
     - If you would like to use Spot Instances
     - If and when Public IP addresses should be used
     - If any user data is on first boot
     - What storage volume configuration should be used
     - What Security Groups should be used
2. Create an Auto Scaling Group

A launch template is essentially a newer and more advanced version of the launch configuration

Being a template you can build a standard configuration allowing you to simplify how you launch instances for your auto scaling groups

## Creating Launch Template
> EC2 > Instances > Launch Templates > Create Launch Template

- Single page with many options
- Create a new template / create a new template version
- Name
- Version description
- Source template: from previous template if existing
- Launch template contents
  - AMI ID; with search button 
    - Quick Start
    - My AMIs
    - AWS Marketplace
    - Community AMIs
  - Instance type
  - Key pair name
  - Network type: VPC, Classics
  - Security Groups
- Network interface
  - Add
- Storage Volumes
  - Comes with 8GB EBS
  - Add new volume
- Instance tags
- Advanced 
  - Spot or not
  - Instance profile
  - Shutdown behavior: terminate or stop
  - Many More
  - User data
- Create Launch Template

## Creating Launch Configuration

> EC2 > Auto Scaling > Launch Configurations > Create Launch Configuration

- Same as launch template but less options
- Then a wizard version of launch template


Without either the Launch Configuration or Launch Template, Auto Scaling would not know what instance it was launching and to which configuration

## Auto Scaling Groups

- The Auto Scaling Group defines
  - The desired capacity and other limitations of the group using scaling policies
  - Where the Group should scale resources, such as which availability zone

### Create A Auto Scaling Group

> EC2 > Auto Scaling > Auto Scaling Groups > Create Auto Scaling Group

- Select either launch configuration of launch template
- Then select the template or configuration to use from the list
- Name
- Version; if applicable
- Fleet Composition 
  - Adhere to the launch template
  - Combine purchase options and instances
- Group size: start with x instances
- Network
- Subnet
- Advanced details
  - Load Balancing; receive traffic from one or more load balancers
    - If yes select classic load balancers and target groups
  - Health check type: ELB EC2
  - Health Check Grace Period
  - Instance protection; protect from scale in
    - If selected auto scaling won't terminate any protected instances
  - Service-Linked Role
- Create auto scaling group
  - Keep this group at its initial size
  - Use scaling policies to adjust the capacity of this group
    - Scale between x and x instances (min and max)
    - Scale group size
      - Name
      - Metric type: eg avg cpu utilization
  - Scale the Auto Scaling group using step or simple scaling policies
    - Increase Group Size
      - Name
      - Execute when (policy); add alarm details such as average cpu utilization is x for x time etc
      - Take the action
        - Add x instances when XX cpu utilization < +infinity
    - Decrease Group Size
      - Similar to the Increase Group Size
  - Configure Notifications
    - Add Notification
      - Send notification to
      - Whenever instances; launch, terminate, fail to launch, fail to terminate
  - Configure Tags
  - Review
  - Create Auto Scaling Group
  - You can then see the running instances under the instances of the E2C Dashboard


## Using ELB and E2C Auto Scaling Together

- It is easy to associate your E2C Auto Scaling Group to An Elastic Load Balancer
  - The ELB allows you to dynamically manage load across your resources based on target groups and rules
  - EC2 auto scaling allows you to elastically scale those groups based upon the demand put upon your infrastructure
- Example 1
  - Suppose you have an ELB configured but without any auto scaling. You will need to ensure you manually add and remove targets or instances based upon the demand
  - You will need to monitor this demand and manually add/remove targets or instances as required
- Example 2
  - Let's assume you have E2C auto scaling configured by not ELB
  - How are you going to evenly distribute traffic to your E2C fleet?
- Combining an ELB and Auto Scaling helps you to manage and automatically scale your E2C Compute resources both in and out
- When you attach an ELB to an auto scaling group, the ELB will automatically detect the instances and start to distribute all traffic to the resources in the auto scaling group
  - To associate an ALB or NLB, you must associated the auto scaling group with the ELB target group
  - For the Classic Load Balancer, the EC2 fleet will be registered directly with the load balancer


### How to associate your ELBs with an auto scaling group

> EC2 > Auto Scaling > Auto Scaling Groups

- Select the required auto scaling group and then edit, scroll to CLB or Target Groups. Select from the list options. The target groups are the pool of resources tha the ALB or NLB are associated to