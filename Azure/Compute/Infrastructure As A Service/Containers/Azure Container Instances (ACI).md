# Azure Container Instances (ACI)

[toc]

## Overview

- Containers are lightweight VMs, they share more resources with the host OS and therefore have much smaller foot prints
- Run Docker containers on-demand in a managed, serverless Azure environment
- Azure Container Instances is a solution for any scenario that can operate in isolated containers, without orchestration
- Run event-driven applications, quickly deploy from your container  development pipelines, and run data processing and build jobs
- Containers offer significant startup benefits over virtual machines (VMs)
- Linux or Windows container images
- Public or private registries can be used
- Expose container groups directly to the internet with an IP address and qualified domain name
- Can expose with a custom DNS name label so you can reach your container at *customlabel*.*azureregion*.azurecontainer.io
- Can mount Azure File Shares backed by Azure Storage to retrieve and persist state
- Azure Container Instances provides some of the basic scheduling capabilities of orchestration platforms



## Container Group

- A collection of containers that get scheduled on the same host machine
- The containers in a container group share a lifecycle, resources, local  network, and storage volumes. It's similar in concept to a *pod* in [Kubernetes](https://kubernetes.io/docs/concepts/workloads/pods/)
- Containers in a group can share an external facing IP address, and a DNS label with a fully qualified domain name (FQDN), each container can listen to a different port
- You can specify external volumes to mount within a container group. Supported volumes include:
  - Azure file share
  - Secret
  - Empty directory
  - Cloned git repo



## Deploy a Container Instance

### Steps

1. Login 
2. Create a resource group	
	- All resources including containers must be deployed into a resource group
3. Create a container
   - Expose the container to the internet via the **ports**  and **dns-name-label**
   - dns-name-label should be unique within the azure region otherwise you will get the error *DNS name label not available*
   - Use the show command to see the status
   - Got to the FQDN to see the the container running;  [dns-name-label].[region].azurecontainer.io to
   - You might need to wait a few seconds while DNS propagates
4. Pull the container logs
   - Allows checking for errors
5. Attach output streams
   - Attach your local standard out and standard error streams to that of the container
   - Detach via Control-C
6. Clean up resources
   - Delete the container or the group and all of its resources



### CLI



```bash
# 1. Login 
az login

# 2. Create a resource group
az group create --name myResourceGroup --location eastus

# 3. Create a container
az container create --resource-group myResourceGroup --name mycontainer --image mcr.microsoft.com/azuredocs/aci-helloworld --dns-name-label aci-demo --ports 80

az container show --resource-group myResourceGroup --name mycontainer --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" --out table

# 4. Pull the container logs
az container logs --resource-group myResourceGroup --name mycontainer

# 5. Attach output streams
az container attach --resource-group myResourceGroup --name mycontainer

# 6. Clean up resources
az container delete --resource-group myResourceGroup --name mycontainer
az container list --resource-group myResourceGroup --output table # Verify
az group delete --name myResourceGroup # Delete all resources in a group
```



### Portal

1. Select the **Create a resource** > **Containers** > **Container Instances**
2. https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-portal



### PowerShell

```powershell
# 1. Login
Connect-AzAccount # or can be done via Azure Cloud Shell

# 2. Create a resource group
New-AzResourceGroup -Name myResourceGroup -Location EastUS

# 3. Create a container
New-AzContainerGroup -ResourceGroupName myResourceGroup -Name mycontainer -Image mcr.microsoft.com/windows/servercore/iis:nanoserver -OsType Windows -DnsNameLabel aci-demo-win

Get-AzContainerGroup -ResourceGroupName myResourceGroup -Name mycontainer # Verify

# 4. Pull the container logs
Get-AzContainerInstanceLog -ResourceGroupName myResourceGroup -ContainerGroupName mycontainer -Name mycontainer

# 5. Attach output streams

# 6. Clean up resources
Remove-AzContainerGroup -ResourceGroupName myResourceGroup -Name mycontainer
```



### ARM Template



```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "name": {
      "type": "string",
      "defaultValue": "acilinuxpublicipcontainergroup",
      "metadata": {
        "description": "Name for the container group"
      }
    },
    "image": {
      "type": "string",
      "defaultValue": "mcr.microsoft.com/azuredocs/aci-helloworld",
      "metadata": {
        "description": "Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials."
      }
    },
    "port": {
      "type": "string",
      "defaultValue": "80",
      "metadata": {
        "description": "Port to open on the container and the public IP address."
      }
    },
    "cpuCores": {
      "type": "string",
      "defaultValue": "1.0",
      "metadata": {
        "description": "The number of CPU cores to allocate to the container."
      }
    },
    "memoryInGb": {
      "type": "string",
      "defaultValue": "1.5",
      "metadata": {
        "description": "The amount of memory to allocate to the container in gigabytes."
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources."
      }
    },
    "restartPolicy": {
      "type": "string",
      "defaultValue": "always",
      "allowedValues": [
        "never",
        "always",
        "onfailure"
      ],
      "metadata": {
        "description": "The behavior of Azure runtime if container has stopped."
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.ContainerInstance/containerGroups",
      "apiVersion": "2019-12-01",
      "name": "[parameters('name')]",
      "location": "[parameters('location')]",
      "properties": {
        "containers": [
          {
            "name": "[parameters('name')]",
            "properties": {
              "image": "[parameters('image')]",
              "ports": [
                {
                  "port": "[parameters('port')]"
                }
              ],
              "resources": {
                "requests": {
                  "cpu": "[parameters('cpuCores')]",
                  "memoryInGb": "[parameters('memoryInGb')]"
                }
              }
            }
          }
        ],
        "osType": "Linux",
        "restartPolicy": "[parameters('restartPolicy')]",
        "ipAddress": {
          "type": "Public",
          "ports": [
            {
              "protocol": "Tcp",
              "port": "[parameters('port')]"
            }
          ]
        }
      }
    }
  ],
  "outputs": {
    "containerIPv4Address": {
      "type": "string",
      "value": "[reference(resourceId('Microsoft.ContainerInstance/containerGroups/', parameters('name'))).ipAddress.ip]"
    }
  }
}
```



### Docker CLI

```bash
# 1. Login
docker login azure

# 2. Create a resource group
docker context create aci myacicontext
docker context ls

# 3. Create a container
docker context use myacicontext
docker run -p 80:80 mcr.microsoft.com/azuredocs/aci-helloworld
docker ps # gets the ip address 

# 4. Pull the container logs
docker logs hungry-kirch

# 5. Attach output streams

# 6. Clean up resources
docker rm hungry-kirch
```



## Source

- https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview