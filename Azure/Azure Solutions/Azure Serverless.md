# Azure Serverless

[toc]

## Overview

- Enables you to build applications without managing infrastructure.

## Azure Functions

- Enables you to run a small piece of code to do a task.
- A single task is performed for each invocation.
- Supported languages: C#, Java, JavaScript, Python, and PowerShell
- You can run your code based on the HTTP requests or schedule when your function runs
- You are only charged for the time you run your code.

## Azure Logic Apps

- Allows you to automate your workflows without writing a single line of code.
- Build your workflow using a logic app designer.
- Components:
  - **Workflow** helps you create a series of steps for your logic app.
  - **Managed connectors** allow you to access and work with your data.
  - **Trigger** is the first step to run your logic app. 
  - **Actions** are steps that happen after the trigger and perform tasks in the workflow of your logic app.
  - **Enterprise Integration Pack** allows you to create an automated, scalable enterprise integration workflow.

 ## Azure Event Grid 

- A network to route events between applications
- Route custom events to different endpoints.
- Components:
  - **Events** – The information that happened in the system.
  - **Event sources** – Where the event comes from.
  - **Topics** – It provides an endpoint where the publisher sends events.
  - **Event subscriptions** – Filter the events that are sent to you.
  - **Event handlers** – The service that will process the event.
- You must provide a SAS token or key authentication before publishing a topic.

## Azure Functions vs Logic Apps vs Event Grid

| **Functions**   | **Logic Apps**                                               | **Event Grid**                                               |                                                              |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Service**     | Serverless Compute                                           | Serverless Workflows                                         | Serverless Events                                            |
| **Description** | Run a small piece of code to do a task                       | Automate your workflows without writing a single line of code. | Route custom events to different endpoints.                  |
| **Features**    | Serverless applications Choice of language Bring your own dependencies Integrated security Flexible development tools Stateful serverless architecture | Built-in and managed connectors Control your workflows Manage or manipulate data App, data and system integration Enterprise application integration B2B communication in the cloud or on-premises | Advanced filtering Fan-out to multiple endpoints Supports high-volume workloads Built-in Events Custom Events |
| **Development** | Code-first                                                   | Designer-first                                               | Event Source and Handlers                                    |
| **Use case**    | Big data processing, serverless messaging                    | Connect legacy, modern, and cutting-edge systems with pre-built connectors. | Serverless application architectures, Ops Automation, and Application integration |
| **Pricing**     | You are only charged for the time you run your code.         | You are charged for the execution of triggers, action, and connectors. | You are charged for each operation, such as ingress events, advanced matches, delivery attempts, and management calls. |


## Sources

- https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview   
- https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-overview   
  https://docs.microsoft.com/en-us/azure/event-grid/overview