# Simple Notification Service (SNS)

The Simple Notification Service is used as a publish and subscribe messaging service

- SNS is centered around topics. And you can think of a topic as a group for collecting messages
- Users over endpoints can then subscribe to this topic and messages or events are then published to that particular topic
- When a message is published, ALL subscribers to that topic receive a notification of that message
- This helps to implement event driven architectures within a decoupled environment. 
- SNS is a managed service and highly scalable, allowing you to distribute messages automatically to all subscribers across your environment, including mobile devices
- It can be configured with the AWS management console, the CLI, or the AWS SDK.

## SNS Topics

- SNS uses a concept of publishers and subscribers, which can also be classed as consumers and producers, and works in the same principle as SQS from this perspective
- The producers, or publishers, send messages to a topic, which is used as a central communication control point
- Consumers, or subscribers of the topic, are then notified of this message by one of the following methods
  - HTTP
  - HTTPS
  - Email
  - Email-JSON
  - Amazon SQS
  - Application
  - AWS Lambda
  - SMS
- Subscribers don't just have to be users. For example, it could be a web server and they can be notified of the message via the HTTP protocol
- Or if it was a user, you could use the email notification method and enter their email address
- SNS offers methods of controlling specific access to your topics through a topic policy. For example, you might want to restrict which protocol subscribers can use, such as SMS or HTTPS, or only allow access to this topic for a specific user
- The policy themselves follow the same format as IAM policies

## SND & SQS

- Both SNS and SQS integrate with each other, which makes sense, as both of these services are designed to run in a highly distributed and decoupled environment

By working together, a solution can be designed to send messages to subscribers through a push method. Or SQS handles incoming messages, and waits for consumers to pull data. Therefore, being able to use SNS as a producer for an SQS queue makes perfect sense from a development perspective. To do this, you'll need to have your SQS queue subscribed to the SNS topic

## Invoking Lambda Functions With SNS

- This integration allows SNS notifications to invoke existing Lambda functions
- Like SQS, the Lambda function has to be subscribed to the topic
- Then when a message is sent to the topic, the message is pushed out to the Lambda function to invoke it
- The function itself uses the payload of the message as an input parameter, where it can then alter the message if required, or forward the message onto another AWS service, or indeed to another SNS topic.
- To configure AWS Lambda to work with the topic, you can perform the following steps
  - From within the SNS dashboard of the AWS management console, select topics
  - Select the topic that you want to subscribe to with the Lambda function
  - Select actions, and subscribe to topic
  - Using the protocol menu, select the AWS Lambda option
  - Then you must select the Lambda function to be used from the endpoint dropdown box
  - Finally, you can select the version or alias of the function, and to select the latest of the function, choose the latest option
  - Select create subscription
