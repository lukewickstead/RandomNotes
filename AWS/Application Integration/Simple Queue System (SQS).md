# Introduction to the Simple Queue Service (SQS)

With the continuing growth of mock services and the cloud-based practice of designing decoupled systems, it's imperative that developers have the ability to utilize a service, or system, that handles the delivery of messages between components.

It is a service that handles the delivery of messages between components 

- SQS is a fully managed service offered by AWS that works seamlessly with serverless systems, mock services, and any distributed architecture
- It has the capability of sending, storing, and receiving these messages at scale without dropping message data
- Utilizes different queue types depending on requirements
- Includes additional features, such as dead-letter queues
- It is also possible to configure the service using the AWS Management Console, the AWS Sarli, or using the AWS SDKs


## SQS Components

Composed of three components; Producer, Queue and the Consumer.

- The actual queue, which is managed by SQS and is managed across a number of SQS servers for resiliency
- The producer component of your architecture is responsible for sending messages to your queue
- Consumers are responsible for processing the messages within your queue by activating the visibility timeout on the message


## Visibility Timeout

When a message is retrieved by a consumer, the visibility timeout is started.

- Ensures that the same message will not be read and processed by another consumer
- When the message has been processed, the consumer then deletes the message from the queue
- The default time is 30 seconds
- It can be set up to as long as 12 hours
- If the visibility timeout expires the message will become available again in the queue for other consumers to process


## SQS Queue Types

- Standard queues
- First-in, first-out queues
- Dead-letter queues

## Standard queues

Are the default queue type upon configuration

Support at-least-once delivery of messages. This means that the message might actually be delivered to the queue more than once, which is largely down to the highly distributive volume of SQS servers, which would make the message appear out of its original order or delivery. As a result, the standard queue will only offer a best-effort on trying to preserve the message ordering from when the message are sent by the producers.

Standard queues also offer an almost unlimited number of transactions per second, TPS, making this queue highly scalable

It is also possible to enable encryption using server-side encryption via KMS.


## First-in, first-out queues

This queue is able to ensure the order of messages is maintained, and that there are no duplication of messages within the queue.

Unlike standard queues, FIFO queues do have a limited number of transactions per second. These are defaulted to 300 per second for all send and receive and delete operations.

If you use batching with SQS, then this changes to 3,000. Batching essentially allows you to perform actions against 10 messages at once within a single action.

It is also possible to enable encryption using server-side encryption via KMS.

So, the key takeaways between the two queues are for standard queues, you have unlimited throughput, at-least-once delivery, and best-effort ordering. And for first-in, first-out queues, you have high throughput, first-in, first-out delivery, and exactly-once processing.


## Dead-Letter Queue

A dead-letter queue differs to the standard and FIFA queues as this dead-letter queue is not used as a source queue to hold messages submitted by producers. Instead, the dead-letter queue is used by the source queue to send messages that fail processing for one reason or another.

This could be the result of cloud enabling your application, corruption within the message, or simply missing information within a database that no message data relates to.

If the message can't be processed by a consumer after a maximum number of tries specified, the queue will send the message to a dead-letter queue. This allows engineers to assess why the message failed, to identify where the issue is, to help prevent further messages from falling into the dead-letter queue.

By viewing and analyzing the content of these messages, it might be possible to identify the problem and ascertain if the issue exists from the producer or consumer perspective.

A couple of points to make with a dead-letter queue is that is must be configured as the same queue type as the source is used against. For example, if the source queue is a standard queue, the dead-letter queue must also be a standard queue type. And similarly, for FIFA queues, the dead-letter queue must also be configured as a FIFA queue.
