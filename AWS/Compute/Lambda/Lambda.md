# AWS Lambda

- AWS Lambda is a serverless compute service which has been designed to allow you to run your application code without having to manage and provision your own EC2 instances
- Serverless means that you do not need to worry about provisioning and managing your own compute resource to run your own code, instead this is managed and provisioned by AWS
- Serverless, does require compute power, to carry out your code requests, but because the AWS user does not need to be concerned with what's managing this compute power, or where it's provisioned from, it's considered serverless from the user perspective
- You only ever have to pay for the compute power when Lambda is in use via Lambda functions
- AWS Lambda charges compute power per 100 milliseconds of use only when your code is running, in addition to the number of times your code runs


## Working With AWS Lambda

- You can either upload this code to AWS Lambda, or write it within the code editor that Lambda provides. Currently, AWS Lambda supports Notebook.js, JavaScript, Python, Java, Java 8 compatible, C#, .NET Core, Go, and also Ruby
- Configure Lambda functions to execute your code upon specific triggers from supported event sources, such as S3 
- Once the specific trigger is initiated during the normal operations of AWS, AWS Lambda will run your code, as per your Lambda function, using only the required compute power as defined
- AWS records the compute time in milliseconds and the quantity of Lambda functions run to ascertain the cost of the service


## Components Of AWS Lambda

The following form the key constructs of a Lambda application:
- Lambda function are compiled of your own code that you want Lambda to invoke as per defined triggers
- Event sources are AWS services that can be used to trigger your Lambda functions, or put another way, they produce the events that your Lambda function essentially responds to by invoking it
  - https://docs.aws.amazon.com/lambda/latest/dg/lambda-services.html#supported-event-source-s3
- Trigger is essentially an operation from an event source that causes the function to invoke
- Downstream Resources are resources that are required during the execution of your Lambda function
- Log streams help you identify issues and troubleshoot issues with your Lambda function. These log streams will essentially be a sequence of events that all come from the same function and recorded in CloudWatch

## Creating Lambda Functions

- Selecting a blueprint
  - Select a blueprint template provided by AWS Lambda
  - Ex: S3-get-object - an S3 trigger that retrieves metadata
- Configure Triggers
  - Define the trigger for your Lamda functions
  - Ex: specifying the S3 bucket for you function
- Configure function
  - Upload code or edit it in-line
  - Defe the required resources, maximum execution timeout, IAM Role and Handler Name


## Key Benefits

AWS Lambda is a highly scalable serverless service, coupled with fantastic cost optimization compared to EC2 as you are only charged for Compute power while the code is running and for the number of functions called
