# Azure Monitor

[toc]

## Overview

- Monitoring tool for your Azure resources and applications.
- A service to display the metrics of your resources. You can  also configure alerts that send notifications when a threshold is  breached.

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

## Application Insights

- Enables you to monitor custom events and metrics.
- Monitor diagnostic trace logs from your application.

## Pricing

- You pay for the ingestion and retention of data in Log Analytics (per GB/month).
- You are billed for the number of metrics you have per month.
- There are no charges for health criteria alerts.

## Sources

- https://docs.microsoft.com/en-us/azure/azure-monitor/overview
- https://azure.microsoft.com/en-us/services/monitor
- https://www.youtube.com/embed/eSutaPE80PM