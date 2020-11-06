# Azure Functions

[toc]

## Overview

- Enables you to build applications without managing infrastructure
- Enables you to run a small piece of code to do a task
- A single task is performed for each invocation
- Supported languages: C#, Java, JavaScript, Python, and PowerShell
- You can run your code based on the HTTP requests or schedule when your function runs
- You are only charged for the time you run your code
- **Integrated security**: Protect HTTP-triggered functions  with OAuth providers such as Azure Active Directory, Facebook, Google,  Twitter, and Microsoft Account
- **Stateful serverless architecture**: Orchestrate serverless applications with [Durable Functions](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview)
- **Open-source**: The Functions runtime is open-source and [available on GitHub](https://github.com/azure/azure-webjobs-sdk-script)
- Max runtime depends upon the Plan and the runtime version; for v3
  - Consumption default 5, max 10
  - Premium and App Service default 30, maximum unlimited
- 230 seconds is the maximum amount of time that an HTTP triggered  function can take to respond to a request. This is because of the default idle timeout of Azure Load Balancer, using durable functions async pattern can get around this.



## Triggers And Bindings

- Azure functions have one or more attributes in their method definition which define triggers and bindings
- Bindings are written to function.json
- JavaScript and softly typed language require developers to write the function.json file
- Bindings can be input or output
- Bindings support a type which defines what triggers them
- Output bindings can trigger other Azure functions or Azure services

A sample function.json file

```javascript
{
    "dataType": "binary",
    "type": "httpTrigger",
    "name": "req",
    "direction": "in"
}
```



### Supported Bindings

| Type                                                         | 1.x  | 2.x and higher1 | Trigger | Input | Output |
| ------------------------------------------------------------ | :--: | :-------------: | :-----: | :---: | :----: |
| [Blob storage](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob) |  ✔   |        ✔        |    ✔    |   ✔   |   ✔    |
| [Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb-v2) |  ✔   |        ✔        |    ✔    |   ✔   |   ✔    |
| [Dapr](https://github.com/dapr/azure-functions-extension)3   |      |        ✔        |    ✔    |   ✔   |   ✔    |
| [Event Grid](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-grid) |  ✔   |        ✔        |    ✔    |       |   ✔    |
| [Event Hubs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs) |  ✔   |        ✔        |    ✔    |       |   ✔    |
| [HTTP & webhooks](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook) |  ✔   |        ✔        |    ✔    |       |   ✔    |
| [IoT Hub](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-iot) |  ✔   |        ✔        |    ✔    |       |   ✔    |
| [Kafka](https://github.com/azure/azure-functions-kafka-extension)2 |      |        ✔        |    ✔    |       |   ✔    |
| [Mobile Apps](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-mobile-apps) |  ✔   |                 |         |   ✔   |   ✔    |
| [Notification Hubs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-notification-hubs) |  ✔   |                 |         |       |   ✔    |
| [Queue storage](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-queue) |  ✔   |        ✔        |    ✔    |       |   ✔    |
| [RabbitMQ](https://github.com/azure/azure-functions-rabbitmq-extension)2 |      |        ✔        |    ✔    |       |   ✔    |
| [SendGrid](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-sendgrid) |  ✔   |        ✔        |         |       |   ✔    |
| [Service Bus](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus) |  ✔   |        ✔        |    ✔    |       |   ✔    |
| [SignalR](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-signalr-service) |      |        ✔        |         |   ✔   |   ✔    |
| [Table storage](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-table) |  ✔   |        ✔        |         |   ✔   |   ✔    |
| [Timer](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer) |  ✔   |        ✔        |    ✔    |       |        |
| [Twilio](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-twilio) |  ✔   |        ✔        |         |       |   ✔    |



### Bindings code examples

| Service         | Examples                                                     | Samples                                                      |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Blob storage    | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob-trigger?tabs=csharp#example) [Input](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob-input?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob-output?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?technology=Blob Storage&language=C%23) |
| Azure Cosmos DB | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb-v2-trigger?tabs=csharp#example) [Input](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb-v2-input?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb-v2-output?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?technology=Cosmos%2CCosmos DB&language=C%23) |
| Event Grid      | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-grid-trigger?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-grid-output?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?technology=Event Grid&language=C%23) |
| Event Hubs      | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs-trigger?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs-output?tabs=csharp#example) |                                                              |
| IoT Hub         | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-iot-trigger?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-iot-output?tabs=csharp#example) |                                                              |
| HTTP            | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?language=C%23&filtertext=http) |
| Queue storage   | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-queue-trigger?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-queue-output?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?technology=Storage Queue&language=C%23) |
| SendGrid        | [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-sendgrid?tabs=csharp#example) |                                                              |
| Service Bus     | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus-trigger?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus-output?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?technology=Service Bus Queue&language=C%23) |
| SignalR         | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-signalr-service-trigger?tabs=csharp#example) [Input](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-signalr-service-input?tabs=csharp#example) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-signalr-service-output?tabs=csharp) |                                                              |
| Table storage   | [Input](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-table-input?tabs=csharp) [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-table-output?tabs=csharp) |                                                              |
| Timer           | [Trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer?tabs=csharp#example) | [Link](https://www.serverlesslibrary.net/?language=C%23&filtertext=timer) |
| Twilio          | [Output](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-twilio?tabs=csharp#example---functions-2x-and-higher) | [Link](https://www.serverlesslibrary.net/?language=C%23&filtertext=twilio) |



## Hosting Plans

Azure Functions has three kinds of pricing plans. Choose the one that best fits your needs:

- **Consumption plan**: Azure provides all of the  necessary computational resources. You don't have to worry about  resource management, and only pay for the time that your code runs.
- **Premium plan**: You specify a number of pre-warmed instances that are always online and ready to immediately respond. When your function runs, Azure provides any additional computational  resources that are needed. You pay for the pre-warmed instances running  continuously and any additional instances you use as Azure scales your  app in and out.  Every premium plan will have at least one active (billed) instance at all times.
- **App Service plan**: Run your functions just like  your web apps. If you use App Service for your other applications, your  functions can run on the same plan at no additional cost.



## Performance Considerations

- Avoid long running functions
- For cross function communication, if not using Durable Functions, you should use queues and or blob storage, i.e. other triggers. Treat functions like micro services
- Service Bus topics are useful if you require message filtering before processing
- Event hubs are useful to support high volume communications
- Write functions to be stateless
- Write defensively
  - Assume your code will fail and should be be able to resume
- Don't share storage accounts between function apps
- Prefer asynchronous code especially when blocking I/O operations are involved
- Some triggers like Event Hub enable receiving a batch of messages on a  single invocation.  Batching messages has much better performance



## Azure Functions Proxies

- Azure Functions  Proxies allow you to specify endpoints on your function  app that are implemented by another resource
- You can use these proxies  to break a large API into multiple function apps (as in a microservice  architecture), while still presenting a single API surface for clients.



## Durable Functions

- *Durable Functions* is an extension of [Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview) that lets you write stateful functions in a serverless compute  environment
- The extension lets you define stateful workflows by writing [*orchestrator functions*](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-orchestrations) and stateful entities by writing [*entity functions*](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-entities) using the Azure Functions programming model
- Behind the scenes, the  extension manages state, checkpoints, and restarts for you, allowing you to focus on your business logic
- Supported languages include C#, JavaScript, Python, F# PowerShell; has a goal of all languages supported by Azure functions but currently does not support them all
- Should only use deterministic apis; things like dates, times and guids are should be avoided
- Application Patterns
  - [Function chaining](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=csharp#chaining)
  - [Fan-out/fan-in](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=csharp#fan-in-out)
  - [Async HTTP APIs](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=csharp#async-http)
  - [Monitoring](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=csharp#monitoring)
  - [Human interaction](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=csharp#human)
  - [Aggregator (stateful entities)](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-overview?tabs=csharp#aggregator)



## Sources

- https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview
- https://docs.microsoft.com/en-us/azure/azure-functions/durable/