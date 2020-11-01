# Azure Batch
[toc]
## Overview
- Use Azure Batch to run large-scale parallel and high-performance computing (HPC) batch jobs efficiently in Azure
- Azure Batch creates and manages a pool of compute nodes (virtual  machines), installs the applications you want to run, and schedules jobs to run on the nodes
- There's no cluster or job scheduler software to install, manage, or scale. Instead, you use [Batch APIs and tools](https://docs.microsoft.com/en-us/azure/batch/batch-apis-tools), command-line scripts, or the Azure portal to configure, manage, and monitor your jobs
- Allows you to run jobs in a group of Linux or Windows virtual machines.
## Components
- A **task** represents a unit of computation and a **job** is a collection of tasks.
- **Job priority** values range from the lowest priority to the highest priority.
- To specify certain limits for your jobs, you can use  job constraints
  - Maximum wallclock time – tasks are terminated if the job runs longer than the specified time.
  - Maximum number of task retries – if the task fails, it will be required to run again.
- A **job manager task** contains the information needed to create the tasks required for the job.
- **Scheduled jobs** allow you to create recurring jobs.
- Simultaneously run on more than one compute node with a **multi-instance task**.
- With **task dependencies**, the task depends on the completion of other tasks before its execution.
## Pricing
- There is no additional charge for using Batch. You only pay for the  underlying resources consumed, such as the virtual machines, storage,  and networking.
## Sources
- https://docs.microsoft.com/en-us/azure/batch/batch-technical-overview
