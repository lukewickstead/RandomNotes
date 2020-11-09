# Azure Monitor

[toc]

## Overview

- Azure Monitor maximizes the availability and performance of your applications and services by delivering a comprehensive solution for  collecting, analyzing, and acting on telemetry from your cloud and  on-premises environments
- It helps you understand how your applications  are performing and proactively identifies issues affecting them and the  resources they depend on
- Monitoring tool for your Azure resources and applications
- Log Analytics and Application Insights have been migrated into it
- You can  also configure alerts that send notifications when a threshold is breached
- Just a few examples of what you can do with Azure Monitor include:
  - Detect and diagnose issues across applications and dependencies with [Application Insights](https://docs.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview).
  - Correlate infrastructure issues with [Azure Monitor for VMs](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/vminsights-overview) and [Azure Monitor for Containers](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-overview).
  - Drill into your monitoring data with [Log Analytics](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview) for troubleshooting and deep diagnostics.
  - Support operations at scale with [smart alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-smartgroups-overview) and [automated actions](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-action-rules).
  - Create visualizations with Azure [dashboards](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-logs-dashboards) and [workbooks](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview).

![img](https://pocket-image-cache.com//filters:no_upscale()/https%3A%2F%2Fk2y3h8q6.stackpathcdn.com%2Fwp-content%2Fuploads%2F2020%2F08%2Fazure-monitor.png)

## Features

- Metrics represents a time-ordered set of data points that are published to Azure Monitor.
- The metrics collected are stored for a maximum of 93 days.
- Share your dashboards with other users using Azure Dashboards.
- The data is stored as a set of records in either the Log Analytics or Application Insights.
- You may use **log analytics** to collect and store the data from various log sources and use a custom query language to query them.
- Application Insights helps you detect and diagnose issues across applications and dependencies.
- When important conditions are found in your monitoring data, you can create an **alert rule** to identify and address issues.
- You can export basic usage metrics from your CDN endpoint with diagnostic logs.



## Log Analytics

- All log data obtained by Azure Monitor shall be stored in a Log Analytics workspace
- Query simple to advanced logs.
- The data is retrieved from a workspace using a log query written using Kusto Query Language (KQL).
- If the query includes workspaces in 20 or more regions, your query will be blocked from running.
- Log Analytics results are limited to a maximum of 10,000 records.
- With a log analytics agent, you can collect logs and performance data from virtual or physical devices outside Azure.
- Log analytics agent cannot send data to Azure Monitor Metrics, Azure Storage, or Azure Event Hubs.



## Metrics

- Metrics in Azure Monitor are lightweight and capable of supporting near  real-time scenarios making them particularly useful for alerting and  fast detection of issues
- Metrics are numerical values that describe some aspect of a system at a  particular time
- Metrics are collected at regular intervals and are  useful for alerting because they can be sampled frequently, and an alert can be fired quickly with relatively simple logic



|           | Description                                                  |
| :-------- | :----------------------------------------------------------- |
| Analyze   | Use [metrics explorer](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-charts) to analyze collected metrics on a chart and compare metrics from different resources. |
| Visualize | Pin a chart from metrics explorer to an [Azure dashboard](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-app-dashboards). Create a [workbook](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/workbooks-overview) to combine with multiple sets of data in an interactive report.Export the results of a query to [Grafana](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/grafana-plugin) to leverage its dashboarding and combine with other data sources. |
| Alert     | Configure a [metric alert rule](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric) that sends a notification or takes [automated action](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/action-groups) when the metric value crosses a threshold. |
| Automate  | Use [Autoscale](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/autoscale-overview) to increase or decrease resources based on a metric value crossing a threshold. |
| Export    | [Route Metrics to Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/resource-logs#send-to-azure-storage) to analyze data in Azure Monitor Metrics together with data in Azure  Monitor Logs and to store metric values for longer than 93 days. Stream Metrics to an [Event Hub](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/stream-monitoring-data-event-hubs) to route them to external systems. |
| Retrieve  | Access metric values from a command line using  [PowerShell cmdlets](https://docs.microsoft.com/en-us/powershell/module/az.applicationinsights) Access metric values from custom application using [REST API](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/rest-api-walkthrough). Access metric values from a command line using  [CLI](https://docs.microsoft.com/en-us/cli/azure/monitor/metrics). |
| Archive   | [Archive](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/platform-logs-overview) the performance or health history of your resource for compliance, auditing, or offline reporting purposes. |



- **Platform metrics** are created by Azure resources and give you visibility into their health and performance. Each type of resource creates a [distinct set of metrics](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported) without any configuration required. Platform metrics are collected from Azure resources at one-minute frequency unless specified otherwise in  the metric's definition.
- **Guest OS metrics** are collected from the guest operating system of a virtual machine. Enable guest OS metrics for Windows virtual machines with [Windows Diagnostic Extension (WAD)](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostics-extension-overview) and for Linux virtual machines with [InfluxData Telegraf Agent](https://www.influxdata.com/time-series-platform/telegraf/).
- **Application metrics** are created by Application  Insights for your monitored applications and help you detect performance issues and track trends in how your application is being used. This  includes such values as *Server response time* and *Browser exceptions*.
- **Custom metrics** are metrics that you define in addition to the standard metrics that are automatically available. You can [define custom metrics in your application](https://docs.microsoft.com/en-us/azure/azure-monitor/app/api-custom-events-metrics) that's monitored by Application Insights or create custom metrics for an Azure service using the [custom metrics API](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-store-custom-rest-api).



## Azure Platform Logs

- Platform logs provide detailed diagnostic and auditing information for  Azure resources and the Azure platform they depend on
- They are  automatically generated although you need to configure certain platform  logs to be forwarded to one or more destinations to be retained



| Log                                                          | Layer              | Description                                                  |
| :----------------------------------------------------------- | :----------------- | :----------------------------------------------------------- |
| [Resource logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/resource-logs) | Azure Resources    | Provide insight into operations that were performed within an Azure resource (the *data plane*), for example getting a secret from a Key Vault or making a request to a  database. The content of resource logs varies by the Azure service and  resource type.  *Resource logs were previously referred to as diagnostic logs.* |
| [Activity log](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log) | Azure Subscription | Provides insight into the operations on each Azure resource in the subscription from the outside (*the management plane*) in addition to updates on Service Health events. Use the Activity Log, to determine the *what*, *who*, and *when* for any write operations (PUT, POST, DELETE) taken on the resources in  your subscription. There is a single Activity log for each Azure  subscription. |
| [Azure Active Directory logs](https://docs.microsoft.com/en-us/azure/active-directory/reports-monitoring/overview-reports) | Azure Tenant       | Contains the history of sign-in activity and audit trail of changes made in the Azure Active Directory for a particular tenant. |



There are different options for viewing and analyzing the different Azure platform logs.

- View the Activity log in the Azure portal and access events from PowerShell and CLI. See [View the Activity log](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/activity-log#view-the-activity-log) for details.
- View Azure Active Directory Security and Activity reports in the Azure portal. See [What are Azure Active Directory reports?](https://docs.microsoft.com/en-us/azure/active-directory/reports-monitoring/overview-reports)  for details.
- Resource logs are automatically generated by supported Azure  resources, but they aren't available to be viewed unless you send them  to a [destination](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/platform-logs-overview#destinations).

You can send platform logs to one or more of the destinations

| Destination             | Description                                                  |      |
| :---------------------- | :----------------------------------------------------------- | ---- |
| Log Analytics workspace | Analyze the logs of all your Azure resources together and take advantage of all the features available to [Azure Monitor Logs](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs) including [log queries](https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview) and [log alerts](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-log). Pin the results of a log query to an Azure dashboard or include it in a workbook as part of an interactive report. |      |
| Event hub               | Send platform log data outside of Azure, for example to a third-party SIEM or custom telemetry platform. |      |



## Application Insights

- Enables you to monitor custom events and metrics
- Monitor diagnostic trace logs from your application
- You need to add Application Insights into your project via a dependency
- Register your instrumentation key during bootstrapping



## Pricing

- You pay for the ingestion and retention of data in Log Analytics (per GB/month).
- You are billed for the number of metrics you have per month.
- There are no charges for health criteria alerts.



## Sources

- https://docs.microsoft.com/en-us/azure/azure-monitor/overview
- https://www.youtube.com/embed/eSutaPE80PM
- https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-runtime-exceptions?WT.mc_id=thomasmaurer-blog-thmaure
- https://docs.microsoft.com/en-us/azure/azure-monitor/learn/tutorial-performance?WT.mc_id=thomasmaurer-blog-thmaure