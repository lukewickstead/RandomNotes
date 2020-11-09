# AWS Step Functions

## Explaining what is AWS Step Functions

AWS Step Functions is a web service that enables you to coordinate the components of distributed applications and microservices using visual workflows. You build applications from individual components that each perform a discrete function, or task, allowing you to scale and change applications quickly. Step Functions provides a reliable way to coordinate components and step through the functions of your application. Step Functions provides a graphical console for visualising the components of your application as a series of steps. It automatically triggers and tracks each step and retries when there are errors, so your application executes in order as expected, every time. Step Functions logs the state of each step, so when things do go wrong, you can diagnose and debug problems quickly.

Step Functions manages the operations and underlying infrastructure for you to ensure your application is available at any scale.

With Step Functions, you are able to easily coordinate complex process composed of different task. For example, if you have an image and you need to convert it into multiple formats, scale in different resolution and analyse it with Amazon Rekognition, you can split this process into single and atomic tasks represented by Lambda Functions and execute them in parallel. After that, you can have another function that checks the result of this process.
Without using this service you have to coordinate yourself each Lambda Function and manage every kind of errors in all steps of this complex process.

