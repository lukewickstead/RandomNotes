# Event Grid

[toc]

## Overview 

- Azure Event Grid allows you to easily build applications with event-based architectures. First, select the Azure resource you would  like to subscribe to, and then give the event handler or WebHook  endpoint to send the event to
- Event Grid has built-in support for  events coming from Azure services, like storage blobs and resource  groups. Event Grid also has support for your own events, using custom  topics
- You can use filters to route specific events to different endpoints,  multicast to multiple endpoints, and make sure your events are reliably  delivered
- Azure Event Grid is deployed to maximize availability by natively  spreading across multiple fault domains in every region, and across  availability zones (in regions that support them)



## Concepts

There are five concepts in Azure Event Grid that let you get going

- **Events** - What happened
- **Event sources** - Where the event took place
- **Topics** - The endpoint where publishers send events
- **Event subscriptions** - The endpoint or built-in  mechanism to route events, sometimes to more than one handler.  Subscriptions are also used by handlers to intelligently filter incoming events
- **Event handlers** - The app or service reacting to the event



## Capabilities

Here are some of the key features of Azure Event Grid

- **Simplicity** - Point and click to aim events from your Azure resource to any event handler or endpoint
- **Advanced filtering** - Filter on event type or event publish path to make sure event handlers only receive relevant events
- **Fan-out** - Subscribe several endpoints to the same event to send copies of the event to as many places as needed
- **Reliability** - 24-hour retry with exponential backoff to make sure events are delivered
- **Pay-per-event** - Pay only for the amount you use Event Grid
- **High throughput** - Build high-volume workloads on Event Grid with support for millions of events per second
- **Built-in Events** - Get up and running quickly with resource-defined built-in events
- **Custom Events** - Use Event Grid to route, filter, and reliably deliver custom events in your app



## Sources

- https://docs.microsoft.com/en-us/azure/event-grid