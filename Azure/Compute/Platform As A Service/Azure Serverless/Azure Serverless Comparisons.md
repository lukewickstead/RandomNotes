# Azure Serverless Comparisons

[toc]


## Azure Functions vs Logic Apps vs Event Grid



|                 | **Functions**                                                | **Logic Apps                                                 | ****Event Grid**                                             |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Service**     | Serverless Compute                                           | Serverless Workflows                                         | Serverless Events                                            |
| **Description** | Run a small piece of code to do a task                       | Automate your workflows without writing a single line of code. | Route custom events to different endpoints.                  |
| **Features**    | Serverless applications Choice of language Bring your own dependencies Integrated security Flexible development tools Stateful serverless architecture | Built-in and managed connectors Control your workflows Manage or manipulate data App, data and system integration Enterprise application integration B2B communication in the cloud or on-premises | Advanced filtering Fan-out to multiple endpoints Supports high-volume workloads Built-in Events Custom Events |
| **Development** | Code-first                                                   | Designer-first                                               | Event Source and Handlers                                    |
| **Use case**    | Big data processing, serverless messaging                    | Connect legacy, modern, and cutting-edge systems with pre-built connectors. | Serverless application architectures, Ops Automation, and Application integration |
| **Pricing**     | You are only charged for the time you run your code.         | You are charged for the execution of triggers, action, and connectors. | You are charged for each operation, such as ingress events, advanced matches, delivery attempts, and management calls. |



## Compare Azure Functions and Azure Logic Apps



|                   | Durable Functions                                            | Logic Apps                                                   |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Development       | Code-first (imperative)                                      | Designer-first (declarative)                                 |
| Connectivity      | [About a dozen built-in binding types](https://docs.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings#supported-bindings), write code for custom bindings | [Large collection of connectors](https://docs.microsoft.com/en-us/azure/connectors/apis-list), [Enterprise Integration Pack for B2B scenarios](https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-enterprise-integration-overview), [build custom connectors](https://docs.microsoft.com/en-us/azure/logic-apps/custom-connector-overview) |
| Actions           | Each activity is an Azure function; write code for activity functions | [Large collection of ready-made actions](https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-workflow-actions-triggers) |
| Monitoring        | [Azure Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview) | [Azure portal](https://docs.microsoft.com/en-us/azure/logic-apps/quickstart-create-first-logic-app-workflow), [Azure Monitor logs](https://docs.microsoft.com/en-us/azure/logic-apps/monitor-logic-apps) |
| Management        | [REST API](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-http-api), [Visual Studio](https://docs.microsoft.com/en-us/visualstudio/azure/vs-azure-tools-resources-managing-with-cloud-explorer?view=vs-2019) | [Azure portal](https://docs.microsoft.com/en-us/azure/logic-apps/quickstart-create-first-logic-app-workflow), [REST API](https://docs.microsoft.com/en-us/rest/api/logic/), [PowerShell](https://docs.microsoft.com/en-us/powershell/module/az.logicapp), [Visual Studio](https://docs.microsoft.com/en-us/azure/logic-apps/manage-logic-apps-with-visual-studio) |
| Execution context | Can run [locally](https://docs.microsoft.com/en-us/azure/azure-functions/functions-runtime-overview) or in the cloud | Runs only in the cloud                                       |



## Compare Functions and WebJobs



| Functions                                                    | WebJobs with WebJobs SDK                                     |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Serverless app model](https://azure.microsoft.com/solutions/serverless/) with [automatic scaling](https://docs.microsoft.com/en-us/azure/azure-functions/functions-scale#how-the-consumption-and-premium-plans-work) | ✔                                                            |                                                              |
| [Develop and test in browser](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-azure-function) | ✔                                                            |                                                              |
| [Pay-per-use pricing](https://docs.microsoft.com/en-us/azure/azure-functions/functions-scale#consumption-plan) | ✔                                                            |                                                              |
| [Integration with Logic Apps](https://docs.microsoft.com/en-us/azure/azure-functions/functions-twitter-email) | ✔                                                            |                                                              |
| Trigger events                                               | [Timer](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer) [Azure Storage queues and blobs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob) [Azure Service Bus queues and topics](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus) [Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb) [Azure Event Hubs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs) [HTTP/WebHook (GitHub, Slack)](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook) [Azure Event Grid](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-grid) | [Timer](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-timer) [Azure Storage queues and blobs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob) [Azure Service Bus queues and topics](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-service-bus) [Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-cosmosdb) [Azure Event Hubs](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs) [File system](https://github.com/Azure/azure-webjobs-sdk-extensions/blob/master/src/WebJobs.Extensions/Extensions/Files/FileTriggerAttribute.cs) |
| Supported languages                                          | C# F# JavaScript Java Python PowerShell                      | C#1                                                          |
| Package managers                                             | NPM and NuGet                                                | NuGet2                                                       |



## Sources 

- https://docs.microsoft.com/en-us/azure/azure-functions/functions-compare-logic-apps-ms-flow-webjobs?toc=/azure/azure-functions/durable/toc.json