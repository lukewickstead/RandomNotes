AWS Lambda is a service released for Developer Preview in April 2015. Some examples of the kinds of things you can achieve with Lambda are designing advanced materialized views out of DynamoDB tables, reacting to uploaded files on S3, and processing SNS messages or Kinesis streams.

In short, you can write a stateless Lambda function that will be triggered to react to certain events (or HTTP endpoints). In a way, it's the same Platform as a Service (PaaS) vein as Heroku. The key difference is in how data (events for Lambda, web requests for Heroku) is delivered to your code and the level of granularity you can achieve. In both cases, you write code that accepts some constraints in exchange for not having to do any provisioning, updating, or management of the underlying resources.

Lambda opens up all kinds of new possibilities and can lower your costs at the same time. When running a job processing server in EC2, you are charged for compute-time as long as your instance is running. Contrast that with Lambda, where you are only charged while actually processing a job, on a 100ms basis. Basically, you never pay for idle time.

This makes Lambda a great fit for spiky or infrequent workloads because it scales automatically and minimizes costs during slow periods. The event-based model Lambda provides makes it perfect for providing a backend for mobile clients, IoT devices, or adding no-stress asynchronous processing to an existing application, without worrying too much about scaling your compute power.

The current computing landscape for AWS looks crowded at first glance with EC2, Elastic Beanstalk, EKS, Lambda, Simple Workflow Service, and more vying for your workload. Before you start on this Lab, you should understand where Lambda fits in.

EC2 is the most basic service, as it only provides the instance with a base image while you supply the automation, configuration, and code to run. It's the most flexible option, but it also requires the most work from you.

Lambda is the complete opposite in that it handles provisioning, underlying OS updates, monitoring, and failover transparently. You only need to provide the code that will run and specify what events should trigger your code. Scaling a Lambda function happens automatically; AWS provisions more instances as needed and only charges you for the time your function runs. 

Elastic Beanstalk is a PaaS that lets you deploy code without worrying about the underlying infrastructure. However, compared to Lambda, it does provide more choices and controls. You can deploy complete applications to Elastic Beanstalk using a more traditional application model compared to deploying individual functions in Lambda.

Amazon Elastic Container Service (Amazon ECS) and Amazon Elastic Container Service for Kubernetes (Amazon EKS) are centered around containers compared to the individual functions of Lambda. ECS and EKS require less managerial overhead compared to running containers on EC2 instances, but generally require some operational expertise. Lambda is ideal for developers who just want to focus on their code.

Simple Workflow Service is a coordination service, and you must provision workers to complete your tasks.
****
A Lambda function is a small unit of computation that can execute in parallel, in a stateless fashion. This is only partially true though since you can potentially have some shared initialization code, at the container level.