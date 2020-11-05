# Azure CycleCloud

[toc]

## Overview
- Orchestrate and manage high-performance computing (HPC) environments on Azure
- Enables you to provision infrastructure for HPC systems,  deploy familiar HPC schedulers, and scale the infrastructure  automatically to run jobs efficiently at any scale
- Azure CycleCloud is targeted at HPC administrators and users who want to deploy an HPC environment with a specific scheduler in mind
- Commonly used schedulers such as Slurm, PBSPro, LSF, Grid Engine, and HT-Condor are supported out of the box
- CycleCloud is the sister product to [Azure Batch](https://docs.microsoft.com/en-us/azure/batch/batch-technical-overview), which provides a Scheduler as a Service on Azure



![]()![Orchestration Diagram](https://docs.microsoft.com/en-us/azure/cyclecloud/images/concept_architecture_diagram.png?view=cyclecloud-7)



## Features

  - **Scheduler Agnostic** – use standard HPC schedulers or extend CycleCloud autoscaling plugins to work with your own scheduler.
  - **Manage Compute Resources** – manage VMs and scale sets to provide a set of compute resources to meet your workload requirements.
  - **Autoscale Resources** – adjust cluster size and components automatically based on workload, availability, and time requirements.
  - **Monitor and Analyze** – collect node-level metrics and analyze the performance data using a visualization tool.
  - **Template Clusters** – enables you to share your cluster topologies.
  - CycleCloud agent (called Jetpack)
    - Node Configuration
    - Distributed Synchronization
    - Health Check
# Sources
- https://docs.microsoft.com/en-us/azure/cyclecloud/overview?view=cyclecloud-7
- https://docs.microsoft.com/en-us/azure/architecture/topics/high-performance-computing