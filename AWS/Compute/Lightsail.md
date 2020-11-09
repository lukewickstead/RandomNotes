# Amazon Lightsail

[toc]

## Overview

Amazon Lightsail is essentially a virtual private server, A VPS, backed by AWS infrastructure, much like an EC2 instance but without as many configurable steps throughout its creation.

- It has been designed to simple, quick, and very easy to use at a low cost point for small-scale use cases by small business or for single users
  - It's commonly used to host simple websites, small applications, and blogs
  - You can run multiple Lightsail instances together, allowing them to communicate
  - It's even possible if required to connect it to other AWS resources and to your existing VPC, running within AWS via a peering connection



## Deploying A Lightsail Instance

- A Lightsail instance can be deployed from a single page with just a few simple configuration options
- Amazon Lightsail can be accessed either via the AWS console under the compute category, or directly to the homepage of AWS Lightsail, which sits outside of the Management Console
  - https://lightsail.aws.amazon.com/ls/webapp/home/resources



## Creation

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



## Management

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



## Sources

- https://docs.aws.amazon.com/lightsail/?id=docs_gateway
- https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-frequently-asked-questions-faq
- https://tutorialsdojo.com/amazon-lightsail
- https://lightsail.aws.amazon.com/ls/webapp/home/resources