# Azure Batch
[toc]
## Overview
- A service that runs large-scale parallel and high-performance computing (HPC) batch jobs in Azure.
- Allows you to run jobs in a group of Linux or Windows virtual machines.
## Components
- A **task** represents a unit of computation and a **job** is a collection of tasks.
- **Job priority** values range from the lowest priority to the highest priority.
- To specify certain limits for your jobs, you can use  job constraints
  - Maximum wallclock time – tasks are terminated if the job runs longer than the specified time.
  - Maximum number of task retries – if the task fails, it will be requeued to run again.
- A **job manager task** contains the information needed to create the tasks required for the job.
- **Scheduled jobs** allow you to create recurring jobs.
- Simultaneously run on more than one compute node with a **multi-instance task**.
- With **task dependencies**, the task depends on the completion of other tasks before its execution.
## Pricing
- No additional charge for using Azure Batch and you are only charged for the underlying resources consumed.
## Sources
- https://docs.microsoft.com/en-us/azure/batch/batch-technical-overview
- https://azure.microsoft.com/en-us/services/batch/
