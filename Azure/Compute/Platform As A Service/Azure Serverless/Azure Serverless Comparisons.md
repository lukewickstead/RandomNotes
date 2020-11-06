# Azure Functions vs Logic Apps vs Event Grid



|                 | **Functions**                                                | **Logic Apps                                                 | ****Event Grid**                                             |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Service**     | Serverless Compute                                           | Serverless Workflows                                         | Serverless Events                                            |
| **Description** | Run a small piece of code to do a task                       | Automate your workflows without writing a single line of code. | Route custom events to different endpoints.                  |
| **Features**    | Serverless applications Choice of language Bring your own dependencies Integrated security Flexible development tools Stateful serverless architecture | Built-in and managed connectors Control your workflows Manage or manipulate data App, data and system integration Enterprise application integration B2B communication in the cloud or on-premises | Advanced filtering Fan-out to multiple endpoints Supports high-volume workloads Built-in Events Custom Events |
| **Development** | Code-first                                                   | Designer-first                                               | Event Source and Handlers                                    |
| **Use case**    | Big data processing, serverless messaging                    | Connect legacy, modern, and cutting-edge systems with pre-built connectors. | Serverless application architectures, Ops Automation, and Application integration |
| **Pricing**     | You are only charged for the time you run your code.         | You are charged for the execution of triggers, action, and connectors. | You are charged for each operation, such as ingress events, advanced matches, delivery attempts, and management calls. |



TODO: https://docs.microsoft.com/en-us/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs?toc=/azure/azure-functions/durable/toc.json