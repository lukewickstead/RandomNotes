# Event Grid vs. Event Hub vs. Service Bus



[toc]



## Overview



Event Grid, Event Hubds, Service Bus, Message Queue, Notifion Hubs have overlapping functionality but each one is speciallised for a specific role.



# Event vs. Message Services



### Event

- An event is a lightweight notification of a condition or a state change
- The publisher of the event has no expectation about how the event is  handled
- The consumer of the event decides what to do with the  notification
- Events can be discrete units or part of a series.



### Messages

- A message is raw data produced by a service to be consumed or stored  elsewhere
- The message contains the data that triggered the message  pipeline
- The publisher of the message has an expectation about how the  consumer handles the message
- A contract exists between the two sides
- For example, the publisher sends a message with the raw data, and  expects the consumer to create a file from that data and send a response when the work is done.



## Comparison of services



| Service     | Purpose                         | Type                          | When to use                                 |
| ----------- | ------------------------------- | ----------------------------- | ------------------------------------------- |
| Event Grid  | Reactive programming            | Event distribution (discrete) | React to status changes                     |
| Event Hubs  | Big data pipeline               | Event streaming (series)      | Telemetry and distributed data streaming    |
| Service Bus | High-value enterprise messaging | Message                       | Order processing and financial transactions |



## Use The Services Together



![Stream data overview](https://docs.microsoft.com/en-us/azure/event-grid/media/compare-messaging-services/overview.png)







## Sources

- https://docs.microsoft.com/en-us/azure/event-grid/compare-messaging-services?WT.mc_id=thomasmaurer-blog-thmaure