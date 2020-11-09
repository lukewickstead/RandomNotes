# Understanding AWS Lambda to Run & Scale Your Code

## An Overview of AWS Lambda

1. You only ever have to pay for compute power when Lambda is in use via Lambda Functions
2. AWS Lambda charges compute power per 100ms of use only when your code is running, in addition to the number of times your code runs


- You can either upload your code to Lambda or write it wihtin the code editors that Lambda provides
   - Suported langauegs
      - Node.js
      - Java
      - C#
      - Python
      - Go
      - Powershell
      - Ruby
   - Configure your Lambda functions to execyte upon specific triggers from supported event sources
   - Once the specific trigger is initiated Lambda will run your code ( as per your Lambda function)  using only the required compute power as defined
   - AWS records the compute time in Milliseconds and the quantity of Lambda functions run to ascertain the cost of the service

AWS Lambda can be found within the AWSD Management Console under the Compute category

### Components for AWS Lambda 

- A Lambda function is compiled of your own code that you want Lambda to invoke
- Event Sources are AWS services that can be used to trigger your Lambda functions
- Downstream resources are resources that are required during the executio of your Lambda function
- Log streams help to identify issues and troubleshoot issues with your Lambda function


### Creating a Lambda

- How to package a component for release to Lambda can be found here
  - https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-features.html#gettingstarted-features-package
- Zipinfo can be used to see read permissions which are required to release the code; this is for Linux/Unix/OSX
- 7-Zip can be used for permission in windows
- Writing code in Lambda causes the package to be created automatically
- Upload can occur via console, cli and SDKs


### Understanding Event Source Mapping

- An event source is an AWS service that produces the events that your Lambda function responds to by invoking it
- Event source can either be poll or push based
- Poll based examples
  - Amazon Inesis
  - Amazon SQS
  - Amazon DynamoDB
- Lambda polls the service looking for particular events and invokes the associated function when a matching even is found
- Push based
  - All others
  - Services using this pish model public events in addition to actually invoking your lambda function


### Event Source Mappings

- An event sourc emapping is the configuration that links your event source to your Lambda function
- It's what links the events generated from your even source to invoke your function

#### Push Based Services

- The mapping is maintained wihtin the Event source
- by using the appropriate API calls for the event source servvice, you are able to create and configure the relevant mappings
- This will require specific access to allow you event source to invoke the function


#### Poll Based Services

- The configuration of the mappings are held within your lambda function
- With the CreateEventSourceMapping API you can set up the relevant event source mapping for your poll-based service
- The permission is required in the Execution role policy


#### Synchronous VS Asynchronous Invocations

when you manually invoke a lambda function or when you bustom built application invokes it, you have the ability to use the invoke option which allows you to specify if the function should be invoked synchronously or asynchronously

When a fjunction is invoked synchronously, it enables you to assess the result before moving onto the next operation requroied

If you want to control the flow of your functions then synchronous invocations can help you maintain an order

Asyncrnons invocations can be used when there is no need to maintain an order of function execution

When event sources are used to call and invoke your function the invocation type is dependent on the service

- For poll based event sources, the invocation type is always synchronous
- For push based event sources it varies on the service


## Monitoring And Common Errors

### Monitoring 

- Monitoring statistics related to your lambda functions with Amazon CloudWatch is be default already configured
- CloudWatch has the following metric that are automatically populated by Lambdas
  - Invocations
    - This determins how mant times a function has been invoked and will match the number of billed requests that you are charged
  - Errors
    - This metric counts the number of failed invocations of the function, for example the result of a permission error
  - DeadLetterErrors
    - This counts the number of times Lambda failed to write to the Dead Letter Queue
  - Duration
    - This metric simply measures how long the function runs for in milliseconds from the point of invocation to when it terminates its execution
  - Throttles
    - This counts how many times a function was invoked and throttled due to the limit of concurrency having been reached
  - IteratorAge
    - This is only used for stream-based invocations. It measures in time how long Lambda took to receive a batch of records to the time of the last record written to the stream
  - ConcurrentExecutions
    - This is combined metric for all of you lambda functions in addition to function within a custom concurrency limit. It calculates the total sum of concurrent execution at any point in time
  - UnreservedConcurrentExecutions
    - This is also a combined metric for all your functions in your account. It calculates the sum of the concurrent of functions without a custom concurrency limit at any given time
- In addition to these metrics, CloudWatch also gathers log data sent by Lambda
  - For each function that you have running, CloudWatch will create a different log group
  - The log group name is defined as /aws/lambda/functionname
  - Its possible to add cjustom logging statement into your function code, which are then sent to CloudWatch logs
  - If using Node.js the following statement can be used to generate custom logging statement
    - console.log()
    - console.error()
    - console.warn()
    - console.info()


### Common Errors

- Some of the common issues as to why your functions might nor run relate to permissions
  - An IAM role is required for Lambda to assume and execute the code of your function
  - A function policy is reqwuired to specify which AWS resources are allowed to invoke your function
  - Having an error either in the IAM role or in the function policy can cause your function to fail
  - If within the role execcution policy, you fail to add permissions to operate your function wihtin a VPC to allow the creation of ENIs using the following permissions, then your function would fail
    - e22:CreateNetworkInterface
    - ec2:DescribeNetworkInterfaces
    - ec2DeleteNetworkInterface
  - Alternatively if your function policy does not include the correct permissions to allow your push based event source to trigger the function requried, then again you will receive a failure
  - Premissions and access to resources from both your execution role and funciton policy are the most likely causes of issues as to why a function would fail
  - Check your policies and understand which policy is used for which purpose
  - 
