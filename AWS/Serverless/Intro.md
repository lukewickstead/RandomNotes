# What is Serverless and How Does it Work?

- The benefit of using Functions as a Service is that all platforms will provide you with better scalability and economy, so when a function is invoked, the AWS Lambda service launches a container that is an execution environment based on the configuration settings that you've provided
- AWS Lambda manages container creations and deletions, and there is no AWS Lambda API for you to actually manage the container
- The Lambda function tries to reuse the container for subsequent invocations of the Lambda function; however, that reuse is not guaranteed
- The container reuse approach means that any declarations to your Lambda function code outside of the actual handler remain initialized, and that means the function can be optimized when it's invoked again.
- Now, each container implemented by Lambda provides some disk space in our /tmp directory, which is currently 500 megabytes. The directory content remains there when the content container is frozen, which provides you with some transient cache that can be used for multiple invocations. 
- You should make sure any background processes or callbacks in your code are completed before the code exits
- You need to design your code to be state-independent, ideally storing state in a persistent data store such as DynamoDB
- So, a serverless function is really fast to implement and can be easily scaled, and you only pay for the processing time that you use

## Hoe Do We Trigger a Lambda Function

- AWS Lambda uses the invoke method to recognize an execution trigger
- Lambda supports three types of invocation methods via the X-Amz-Invocation-Type header
  - RequestResponse (default)
    - The RequestResponse runs your function and returns a result back to the requester
    - Run in synchronous mode, i.e. the response is delivered in real time.
  - Event
    - EventType
      - Push
      - Pull
    - EventModel
      - Synchronous
      - Asynchronous
  - DryRun
 

### Event

- There's two types of event invocation supported, a push and a pull, and there's two modes, synchronous and asynchronous
- So the event invocation type allows you to map an event source, and that event source can be another core AWS service, e.g. Amazon S3, where, for example, Amazon S3 will push an event to Lambda when a file is uploaded or changed. This is called the push method.
- Lambda also supports stream-based event sources such as DynamoDB or Kinesis, for example. And with a stream as an event source, Lambda pulls the streams and invokes your Lambda function. Now, this is referred to as the pull model, and with the pull model, the event source mappings are maintained within AWS Lambda. So, AWS Lambda provides the relevant APIs to create and manage event source mappings
- Event mapping is really useful, as there's a number of predefined event sources set up in Lambda already, most of the core services, in fact, so S3, DynamoDB, Kinesis, etc., and this makes it really easy.
- You can also use your own application as an event source. To do that, we use the invoke method on demand, and a Lambda function can be invoked from, say, your mobile application. So if the event source is our own application or service, that service uses the Lambda invoke API to send the event invocation type. Now, that application can call Lambda from a different account, but it does need a cross-account role with correct privileges to do that type of call.
- So, just to clarify, when we use the push model, you can set the invocation event to be asynchronous or synchronous, and with the pull model, the invocation method is defined for us by the Lambda service. Okay, so those are the two main invocation models

###  Dry Run

The DryRun parameters makes sure that Lambda does everything except execute your function. So this is really important when you want to check your verification. If you've got some sort of cross-account access requirement, and you need to check that your inputs are valid, then using the DryRun invocation means that everything else bar the actual execution is run, and, of course, you'll trap any errors if any occur.

## HTTP/HTTPS

Now, we can also invoke our function over HTTPS:// using a REST API. Now, that's a common use case, and we can do this by creating a custom REST API and endpoint with the Amazon API Gateway service. With that, we can map individual API operations such as get or put, or we can create our own methods if we want and map those to specific Lambda functions. So when you send an HTTPS:// request to the API endpoint, the Amazon API Gateway service invokes the corresponding Lambda function, and using API Gateway, we're using the push model. API Gateway invokes the Lambda function by passing data in the request body as a parameter to that Lambda function

# What are the Building Blocks of Serverless Computing?

1. RESTFul API
2. Stateless Function
   1. Synchronously will be pull events
   2. Asynchronously will be push event
3. Microservice Design

Each published event is a unit of work. Therefore, the number of events or requests these event sources publish influences the concurrency of that service.

There are formulas you can use to estimate the concurrent Lambda function invocations, that basically is events or requests per second times the function duration

> events per second * function duration

> 10 events a second * 3 secon duration = estimate 30 concurrent executions

While Lambda has some features in common with EC2 containers, it's obviously more than that as a service. So, if serverless computing's not the same as containers is it more like a service like Amazon Elastic Beanstalk? So although Lambda does provide a platform for developers, it's much simpler than Amazon Elastic Beanstalk. AWS Lambda inherits some features from the EC2 container service and other features from Elastic Beanstalk, but it's conceptually distant from both of those. This type of processing isn't going to suit every deployment, but for non-human processing, it's often a far easier way to provision and deploy.

# How Can We Use Serverless Computing?

## Serverless Coding Patterns

1. Nanoservices
   1. 1 function = 1 job
   2. A lot of code
2. Microservices
   1. 1 function = N related jobs
   2. Less functions, easier to organise code
   3. More chance of Lambda functions remain warm and therefore they don't need to start up and are quicker
3. New Monolithic
   1. 1 function + GraphQL
   2. Uses an interface aggregator
   3. The intent is that it is easier to manage and maintain your apis easier


## How Do You Use Functions As A Service

### Design Considerations

1. Stateless
2. More than one function can be added to a single source
3. Fast
4. Provides all the required infrastructures
5. Built it logging and monitoring


### What are the Benefits / Trade Offs?

1. Zero Administration
2. Easily Scaled
3. High availability and fault tolerance
4. Reduce Costs