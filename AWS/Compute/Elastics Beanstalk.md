# AWS Elastic Beanstalk

- AWS Elastic Beanstalk is an AWS managed service that takes your uploaded code of your web application code and automatically provision and deploys the required resources within AWS to make the web application operational
- These resources can include other AWS services and features, such as EC2, Auto Scaling, application health-monitoring, and Elastic Load Balancing, in addition to capacity provisioning
- An ideal service for engineers who may not have the familiarity or the necessary skills within AWS to deploy, provision, monitor, and scale the correct environment themselves to run the developed applications
- The responsibility is passed on to AWS Elastic Beanstalk to deploy the correct infrastructure to run the uploaded code
- You can continue to support and maintain the environment as you would with a custom built environment
- You can perform some of the maintenance tasks from the Elastic Beanstalk dashboard itself
- Elastic Beanstalk is able to operate with a variety of different platforms and programming languages, making it a very flexible service for your DevOps teams;
- It is s free to use; however, any resources that are created on your application's behalf, such as EC2 instances,  will be charged


## The application version

- An application version is a very specific reference to a section of deployable code
- The application version will point typically to S3, simple storage service to where the deployable code may reside


## The environment

- An environment refers to an application version that has been deployed on AWS resources which are configured and provisioned by AWS Elastic Beanstalk
- At this stage, the application is deployed as a solution and becomes operational within your environment
- The environment is comprised of all the resources created by Elastic Beanstalk and not just an EC2 instance with your uploaded code


## Environment configurations

- A collection of parameters and settings that dictate how an environment will have its resources provisioned by Elastic Beanstalk and how these resources will behave


## The environment tier

- This component reflects on how Elastic Beanstalk provisions resources based on what the application is designed to do
  - If the application manages and handles HTTP requests, then the app will be run in a web server environment
  - If the application does not process HTTP requests, and instead perhaps pulls data from an SQS queue, then it would run in a worker environment


## The configuration template

- This is the template that provides the baseline for creating a new, unique environment configuration. 


## Platform

- Platform is a culmination of components in which you can build your application upon using Elastic Beanstalk
- These comprise of the OS  of the instance, the programming language, the server type (web or application), and components of Elastic Beanstalk itself, and as a whole can be defined as a platform


## Applications

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


## Elastics Beanstalk Workflow

- Create an application
- Upload your application version, along with additional configuration
  - This creates the environment configuration
- Launch Environment
  - The environment is then created by Elastic Beanstalk with the appropriate resources to run your code
  - Any management of your application can then take place, such as deploying new versions of your application
- Manage Environment 
  - If the management of your applications have altered the environment configuration, then your environment will automatically be updated to reflect the new code should additional resources be required
  