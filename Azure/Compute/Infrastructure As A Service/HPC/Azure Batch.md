# Azure Batch
[toc]
## Overview
- Use Azure Batch to run large-scale parallel and high-performance computing (HPC) batch jobs efficiently in Azure
- Azure Batch creates and manages a pool of compute nodes (virtual  machines), installs the applications you want to run, and schedules jobs to run on the nodes
- There's no cluster or job scheduler software to install, manage, or scale. Instead, you use [Batch APIs and tools](https://docs.microsoft.com/en-us/azure/batch/batch-apis-tools), command-line scripts, or the Azure portal to configure, manage, and monitor your jobs
- Allows you to run jobs in a group of Linux or Windows virtual machines
- Can be run as part of a larger workflow by managed tools such as Azure Data Factory



## Run Parallel Workload

- Batch works well with intrinsically parallel workloads
  - Also known as "embarrassingly parallel"
  - The workloads have applications which can run independently, each instance completing part of the work
  - The applications don't need to communicate with each other than sharing some data; therefore this allows them to run at large scale
- Batch can also run tightly coupled workloads where the applications need to communicate with each other
  - Often use the Message Passing Interface (MPI) to communicate between applications
  - Microsoft MPI or Intel MPI



## How It Works



<img src="https://docs.microsoft.com/en-us/azure/batch/media/batch-technical-overview/tech_overview_03.png" style="zoom:50%;" />



-  Upload **input files** and the **applications** to process those files to your Azure Storage account.
-  Create a Batch **pool** of compute nodes in your Batch account, a **job** to run the workload on the pool, and **tasks** in the job.
  - Compute nodes are the VMs that execute your tasks
  - Specify properties such as number and size of the nodes
  - Specify Windows or Linux VM images
  - Specify an application to install when the nodes join the pool
  - Batch service automatically schedules the tasks for execution on the compute nodes in the pool
- Download input files and the applications to Batch
  - Before a task executes it can download the input data that it will process to the assigned node
  - Once everything is downloaded and installed the task executes on the assigned node
- Monitor task execution
  - Query batch to monitor the progress of the job and its tasks
- Upload task output
  - As the tasks complete they upload their result data to Azure Storage
- Download output files
  - When your monitoring detects that the tasks in your job have completed,  your client application or service can download the output data for  further processing
- Batch can be used in other workflows; the above is just an example



## Components

- **Batch account**
  - All processing and resources are associated to a batch account
  - Can run multiple **batch workloads** in a single batch account
  - Can also distribute workloads among batch accounts that are in the same subscription but different regions
  - **Poll Allocations**
    - **User Subscription**
      - Batch VMs and other resources are created directly in your subscription when a pool is created
      - Required if you want to create Batch pools using Azure Reserved VM Instances
    - **Batch Service**
      - For most cases you should default to this
      - Pools are allocated behind the scenes in Azure-managed subscriptions
- **Azure storage**
  - Normally used to store resource files and output files 
- **Nodes**
  -  A compute node (or *node*) is a virtual machine that processes a portion of your application's workload
  - Can create pools of nodes from Windows or Linux nodes by using Azure Cloud Services, images from the Azure Virtual Machines Marketplace, or custom images that you prepare
  - Can run any executable or script that is supported by the OS of the node
    - exe, cmd, bat, ps1, bin, sh, py etc
  - All compute nodes in a Batch also include
    - A standard folder structure and associated environment variables
    - Firewall settings 
    - Remote access by either RDP or SSH unless the pool is created with remote access disabled
  - By default nodes can communicate with each other in the same pool
  - Communication with different pools nodes or with your on-premise network provision the pool to a permissioned subnet of a VNet
  - Node Types
    - Dedicated nodes are reserved for you work. They are guaranteed to never be preempted
    - Low priority nodes are cheaper and take advantage of surplus capacity but can be preempted and the tasks requeued. Ensure any work lost will be minimal and easy to recreate
- **Pools**
  - A pool is a collection of compute nodes for your application to run on
  - They provide large-scale allocation, application installation, data distribution, health monitoring, and flexible adjustment scaling of the number of compute nodes within a pool
  - When a node is removed from a pool any changes to the nodes OS or files are lost
  - A pool is assigned to a batch account and can only be used in that batch account
  - When creating a pool you specify the following
    - Node OS and version
    - Node type and target number of nodes
    - Node size
    - Automatic scaling policy
    - Communication status
    - Start tasks
    - Application packages
    - Virtual network (VNet) and firewall configuration
    - Lifetime
  - The number of compute nodes is referred to as a **target** because you pool might never reach this number due to core quota or the automatic scaling formula used
  - Enable automatic scaling by writing an [automatic scaling formula](https://docs.microsoft.com/en-us/azure/batch/batch-automatic-scaling#autoscale-formulas) and associating that formula with a pool
    - A scaling formula can be based on the following metrics:
      - **Time metrics** are based on statistics collected every five minutes in the specified number of hours.
      - **Resource metrics** are based on CPU usage, bandwidth usage, memory usage, and number of nodes.
      - **Task metrics** are based on task state, such as *Active* (queued), *Running*, or *Completed*.
    - Node deallocation option allows specifying if a node is allowed to finish its job or not
      - Requeue, retaindata, task completion and terminate
- A **task** represents a unit of computation
- **Job**
  - A collection of tasks
  - **Job priority** values range from  -1000 to 1000  (lowest to ) priority
  - To specify certain limits for your jobs, you can use  **job constraints**
    - **Maximum wallclock time** – tasks are terminated if the job runs longer than the specified time
    - **Maximum number of task retries** – if the task fails, it will be required to run again
- A **job manager task** contains the information needed to create the tasks required for the job
- **Scheduled jobs** allow you to create recurring jobs
- Simultaneously run on more than one compute node with a **multi-instance task**
- With **task dependencies**, the task depends on the completion of other tasks before its execution



## Pricing

- There is no additional charge for using Batch
- You only pay for the  underlying resources consumed, such as the virtual machines, storage,  and networking
- You are charged for pools while the nodes are running, even if no jobs are scheduled



## Run A Batch API

### Steps

1. Create a resource group
2. Create a storage account
3. Create a Batch account
4. Create a pool of compute nodes
5. Create a job
6. Create tasks
7. View task status
8. View task output
9. Clean up resources



### CLI

```bash
# 1. Create a resource group
az group create \
    --name QuickstartBatch-rg \
    --location eastus2

# 2. Create a storage account
az storage account create \
    --resource-group QuickstartBatch-rg \
    --name mystorageaccount \
    --location eastus2 \
    --sku Standard_LRS

# 3. Create a Batch account
az batch account create \
    --name mybatchaccount \
    --storage-account mystorageaccount \
    --resource-group QuickstartBatch-rg \
    --location eastus2
    
az batch account login \
    --name mybatchaccount \
    --resource-group QuickstartBatch-rg \
    --shared-key-auth

# 4. Create a pool of compute nodes
az batch pool create \
    --id mypool --vm-size Standard_A1_v2 \
    --target-dedicated-nodes 2 \
    --image canonical:ubuntuserver:16.04-LTS \
    --node-agent-sku-id "batch.node.ubuntu 16.04"

az batch pool show --pool-id mypool \
    --query "allocationState"

# 5. Create a job
az batch job create \
    --id myjob \
    --pool-id mypool

# 6. Create tasks (4 parallel)
for i in {1..4}
do
   az batch task create \
    --task-id mytask$i \
    --job-id myjob \
    --command-line "/bin/bash -c 'printenv | grep AZ_BATCH; sleep 90s'"
done

# 7. View task status
az batch task show \
    --job-id myjob \
    --task-id mytask1

# 8. View\Download task output 
az batch task file list \
    --job-id myjob \
    --task-id mytask1 \
    --output table
    
az batch task file download \
    --job-id myjob \
    --task-id mytask1 \
    --file-path stdout.txt \
    --destination ./stdout.txt

# 9. Clean up resources
az batch pool delete --pool-id mypool
az group delete --name QuickstartBatch-rg

```



### Portal

1. In the [Azure portal](https://portal.azure.com), select **Create a resource** > **Compute** > **Batch Service**.
2. https://docs.microsoft.com/en-us/azure/batch/quick-create-portal



### ARM Template



```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "batchAccountName": {
      "type": "string",
      "defaultValue": "[concat(toLower(uniqueString(resourceGroup().id)), 'batch')]",
      "metadata": {
        "description": "Batch Account Name"
      }
    },
    "storageAccountsku": {
      "type": "string",
      "defaultValue": "Standard_LRS",
      "allowedValues": [
        "Standard_LRS",
        "Standard_GRS",
        "Standard_ZRS",
        "Premium_LRS"
      ],
      "metadata": {
        "description": "Storage Account type"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources."
      }
    }
  },
  "variables": {
    "storageAccountName": "[concat(uniqueString(resourceGroup().id),'storage')]"
  },
  "resources": [
    {
      "comments": "This storage account is used to associate to a batch account",
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-06-01",
      "name": "[variables('storageAccountname')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('storageAccountsku')]"
      },
      "kind": "StorageV2",
      "tags": {
        "ObjectName": "[variables('storageAccountName')]"
      },
      "properties": {}
    },
    {
      "type": "Microsoft.Batch/batchAccounts",
      "apiVersion": "2020-05-01",
      "name": "[parameters('batchAccountName')]",
      "location": "[parameters('location')]",
      "dependsOn": [
        "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]"
      ],
      "tags": {
        "ObjectName": "[parameters('batchAccountName')]"
      },
      "properties": {
        "autoStorage": {
          "storageAccountId": "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]"
        }
      }
    }
  ],
  "outputs": {
    "storageAccountName": {
      "type": "string",
      "value": "[variables('storageAccountName')]"
    },
    "batchAccountName": {
      "type": "string",
      "value": "[parameters('batchAccountName')]"
    }
  }
}
```





## Manage batch jobs by using Batch Service API

- The Base URL for Batch service is https://{account-name}.{region-id}.batch.azure.com
- Account
  - List Pool Node Count
    - GET {batchUrl}/nodecounts?api-version=2020-09-01.12.0
    - GET {batchUrl}/nodecounts?$filter={$filter}&maxresults={maxresults}&timeout={timeout}&api-version=2020-09-01.12.0
  - List Supported Images
    - GET {batchUrl}/supportedimages?api-version=2020-09-01.12.0
    - GET {batchUrl}/supportedimages?$filter={$filter}&maxresults={maxresults}&timeout={timeout}&api-version=2020-09-01.12.0
  - Get Application
    - GET {batchUrl}/applications/{applicationId}?api-version=2020-09-01.12.0
    - GET {batchUrl}/applications/{applicationId}?timeout={timeout}&api-version=2020-09-01.12.0
    - GET {batchUrl}/applications?api-version=2020-09-01.12.0
    - GET {batchUrl}/applications?maxresults={maxresults}&timeout={timeout}&api-version=2020-09-01.12.0



## Sources

- https://docs.microsoft.com/en-us/azure/batch
- https://docs.microsoft.com/en-us/rest/api/batchservice
