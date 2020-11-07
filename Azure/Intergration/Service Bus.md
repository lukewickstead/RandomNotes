# Azure Service Bus

[toc]

## Overview

- A fully managed message broker service
- It allows you to decouple applications and services.
- Provides a reliable and secure platform for asynchronous data and state transfer
- Enables you to deliver messages to multiple subscribers and fan-out message delivery to downstream systems
- Some common messaging scenarios are
  - *Messaging*. Transfer business data, such as sales or purchase orders, journals, or inventory movements
  - *Decouple applications*. Improve reliability and scalability of applications and services. Client and service don't have to be online at the same time
  - *Topics and subscriptions*. Enable 1:*n* relationships between publishers and subscribers
  - *Message sessions*. Implement workflows that require message ordering or message deferral



## Features

- **Message Sessions** for implementing first in, first out (FIFO) and request-response patterns to ensure the order of messages in the queue
- **Autoforwarding** allows you to remove messages from a queue or subscription and transfer it to a different queue or topic (*must be in the same namespace*)
- A dead-letter queue holds the messages that can’t be delivered to any receiver
- It supports a scheduled delivery of messages
- You can set aside a message using **message deferral**
- With **client-side batching**, you can delay the sending of messages for a certain period of time
- **Autodelete on idle** enables you to set an idle interval to automatically delete a queue. Five minutes is the minimum duration
- **Duplicate detection** allows you to resend the same message and discard any duplicate copies.
- You can continue the operation of your environment in a different region or datacenter with **geo-disaster recovery**



## Components

- A container for all messaging components is called a **namespace**
- You send and receive messages from **queues** (*point-to-point communication*)
- Multiple queues and topics are supported in a single namespace, and namespaces often serve as application containers

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F09%2Fazure-service-bus-1.png)                            

- **Topics** also allow you to send and receive messages  and mainly used in publish/subscribe scenarios. It contains multiple  independent subscriptions called **entities**
- To filter specific messages, you can use rules and filters to define conditions that trigger optional actions

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F09%2Fazure-service-bus-2.png)                            



## Security

- **Shared Access Signatures (SAS)** guards access to Service Bus based on authorization rules
- You can authenticate and authorize an application to access  Service Bus entities such as queues, topics, subscriptions, and filters  using **Azure AD**
- Create a security identity using **Managed identities for Azure resources** and associate that identity with access-control roles to grant custom permissions for accessing specific Azure resources



## Pricing

- You are charged based on the following
  - The number of operations
  - The number of AMQP connections or HTTP calls
- For hybrid connections, you are charged based on the number of listeners
- With Windows Communication Foundation (WCF) relays, you are charged based on the message volume and relay hours



## Premium Messaging Tier

- Alongside the standard tier, the *Premium* tier of Service Bus Messaging addresses common  customer requests around scale, performance, and availability for  mission-critical applications
- Provides resource isolation at the CPU and memory level so that each customer workload runs in isolation
- This resource container is called a *messaging unit*. Each  premium namespace is allocated at least one messaging unit
- You can  purchase 1, 2, 4 or 8 messaging units for each Service Bus Premium  namespace
- A single workload or entity can span multiple messaging units and the number of messaging units can be changed at will. The result is predictable and repeatable performance for your Service Bus-based  solution.
- Not only is this performance more predictable and available, but it  is also faster
- Service Bus Premium Messaging builds on the storage  engine introduced in 
- With Premium Messaging, peak performance is much faster than with the Standard tier



| Premium                                                      | Standard                       |
| ------------------------------------------------------------ | ------------------------------ |
| High throughput                                              | Variable throughput            |
| Predictable performance                                      | Variable latency               |
| Fixed pricing                                                | Pay as you go variable pricing |
| Ability to scale workload up and down                        | N/A                            |
| Message size up to 1 MB. This limit may be raised in the future. For latest important updates to the service, see [Messaging on Azure blog](https://techcommunity.microsoft.com/t5/messaging-on-azure/bg-p/MessagingonAzureBlog). | Message size up to 256 KB      |



## Storage Queues vs. Service Bus Queues



| Comparison Criteria      | Storage queues                                               | Service Bus queues                                           |
| ------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Ordering guarantee       | **No**   For more information, see the first note in the [Additional Information](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted#additional-information) section. | **Yes - First-In-First-Out (FIFO)**  (through the use of [message sessions](https://docs.microsoft.com/en-us/azure/service-bus-messaging/message-sessions)) |
| Delivery guarantee       | **At-Least-Once**                                            | **At-Least-Once** (using PeekLock receive mode. It's the default)   **At-Most-Once** (using ReceiveAndDelete receive mode)     Learn more about various [Receive modes](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-queues-topics-subscriptions#receive-modes) |
| Atomic operation support | **No**                                                       | **Yes**                                                      |
| Receive behavior         | **Non-blocking**  (completes immediately if no new message is found) | **Blocking with or without a timeout**  (offers long polling, or the ["Comet technique"](https://go.microsoft.com/fwlink/?LinkId=613759))  **Non-blocking**  (through the use of .NET managed API only) |
| Push-style API           | **No**                                                       | **Yes**  [QueueClient.OnMessage](https://docs.microsoft.com/en-us/dotnet/api/microsoft.servicebus.messaging.queueclient.onmessage#Microsoft_ServiceBus_Messaging_QueueClient_OnMessage_System_Action_Microsoft_ServiceBus_Messaging_BrokeredMessage__) and [MessageSessionHandler.OnMessage](https://docs.microsoft.com/en-us/dotnet/api/microsoft.servicebus.messaging.messagesessionhandler.onmessage#Microsoft_ServiceBus_Messaging_MessageSessionHandler_OnMessage_Microsoft_ServiceBus_Messaging_MessageSession_Microsoft_ServiceBus_Messaging_BrokeredMessage__) sessions .NET API. |
| Receive mode             | **Peek & Lease**                                             | **Peek & Lock**  **Receive & Delete**                        |
| Exclusive access mode    | **Lease-based**                                              | **Lock-based**                                               |
| Lease/Lock duration      | **30 seconds (default)**  **7 days (maximum)** (You can renew or release a message lease using the [UpdateMessage](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.storage.queue.cloudqueue.updatemessage) API.) | **60 seconds (default)**  You can renew a message lock using the [RenewLock](https://docs.microsoft.com/en-us/dotnet/api/microsoft.servicebus.messaging.brokeredmessage.renewlock#Microsoft_ServiceBus_Messaging_BrokeredMessage_RenewLock) API. |
| Lease/Lock precision     | **Message level**  Each message can have a different timeout value, which you can then update as needed while processing the message, by using the [UpdateMessage](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.storage.queue.cloudqueue.updatemessage) API. | **Queue level**  (each queue has a lock precision applied to all of its messages, but you can renew the lock using the [RenewLock](https://docs.microsoft.com/en-us/dotnet/api/microsoft.servicebus.messaging.brokeredmessage.renewlock#Microsoft_ServiceBus_Messaging_BrokeredMessage_RenewLock) API.) |
| Batched receive          | **Yes**  (explicitly specifying message count when retrieving messages, up to a maximum of 32 messages) | **Yes**  (implicitly enabling a pre-fetch property or explicitly through the use of transactions) |
| Batched send             | **No**                                                       | **Yes**  (through the use of transactions or client-side batching) |



## Sources

- https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview
- https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted