# Azure Service Bus

[toc]

## Overview

- A fully managed message broker service.
- It allows you to decouple applications and services. 
- Provides a reliable and secure platform for asynchronous data and state transfer.
- Enables you to deliver messages to multiple subscribers and fan-out message delivery to downstream systems.



## Features

- **Message Sessions** for implementing first in, first out (FIFO) and request-response patterns to ensure the order of messages in the queue.
- **Autoforwarding** allows you to remove messages from a queue or subscription and transfer it to a different queue or topic (*must be in the same namespace*).
- A dead-letter queue holds the messages that can’t be delivered to any receiver.
- It supports a scheduled delivery of messages.
- You can set aside a message using **message deferral**.
- With **client-side batching**, you can delay the sending of messages for a certain period of time.
- **Autodelete on idle** enables you to set an idle interval to automatically delete a queue. Five minutes is the minimum duration.
- **Duplicate detection** allows you to resend the same message and discard any duplicate copies.
- You can continue the operation of your environment in a different region or datacenter with **geo-disaster recovery**.



## Components

- A container for all messaging components is called a **namespace**.
- You send and receive messages from **queues** (*point-to-point communication*).
- Multiple queues and topics are supported in a single namespace, and namespaces often serve as application containers.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F09%2Fazure-service-bus-1.png)                            

- **Topics** also allow you to send and receive messages  and mainly used in publish/subscribe scenarios. It contains multiple  independent subscriptions called **entities**.
- To filter specific messages, you can use rules and filters to define conditions that trigger optional actions.

​          ![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F09%2Fazure-service-bus-2.png)                            



## Security

- **Shared Access Signatures (SAS)** guards access to Service Bus based on authorization rules.
- You can authenticate and authorize an application to access  Service Bus entities such as queues, topics, subscriptions, and filters  using **Azure AD**.
- Create a security identity using **Managed identities for Azure resources** and associate that identity with access-control roles to grant custom permissions for accessing specific Azure resources.



## Pricing

- You are charged based on the following:
  - The number of operations
  - The number of AMQP connections or HTTP calls
- For hybrid connections, you are charged based on the number of listeners.
- With Windows Communication Foundation (WCF) relays, you are charged based on the message volume and relay hours.



## Sources

- https://azure.microsoft.com/en-us/services/service-bus/   
- https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-messaging-overview