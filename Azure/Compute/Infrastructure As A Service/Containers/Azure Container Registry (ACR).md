## Azure Container Registry (ACR)

[toc]

## Overview

- Azure Container Registry is a managed, private Docker registry service based on the open-source Docker Registry 2.0
- ACR is a regional service.



## Use Cases

- Pull images from an Azure container registry to various deployment targets:
  - **Scalable orchestration systems** that manage containerized applications across clusters of hosts, including [Kubernetes](https://kubernetes.io/docs/), [DC/OS](https://docs.mesosphere.com/), and [Docker Swarm](https://docs.docker.com/get-started/swarm-deploy/)
  - **Azure services** that support building and running applications at scale, including [Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/), [App Service](https://docs.microsoft.com/en-us/azure/app-service/), [Batch](https://docs.microsoft.com/en-us/azure/batch/), [Service Fabric](https://docs.microsoft.com/en-us/azure/service-fabric/), and others
- Push to a container registry as part of a container development workflow; for example Azure Pipelines or Jenkins
- ACR Tasks can automatically rebuild images when their base images are updated or their commits are made to a code repository
- Supports webhook integration, authentication with AAF and delete functionality



## Service Tiers

- An Azure subscription can contain one more more container registries
- Registries have three tiers; Basic, Standard, Premium



| Tier         | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| **Basic**    | A cost-optimized entry point for developers learning about Azure  Container Registry. Basic registries have the same programmatic  capabilities as Standard and Premium (such as Azure Active Directory [authentication integration](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication#individual-login-with-azure-ad), [image deletion](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-delete), and [webhooks](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-webhook)). However, the included storage and image throughput are most appropriate for lower usage scenarios. |
| **Standard** | Standard registries offer the same capabilities as Basic, with  increased included storage and image throughput. Standard registries  should satisfy the needs of most production scenarios. |
| **Premium**  | Premium registries provide the highest amount of included storage  and concurrent operations, enabling high-volume scenarios. In addition  to higher image throughput, Premium adds features such as [geo-replication](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-geo-replication) for managing a single registry across multiple regions, [content trust](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-content-trust) for image tag signing, [private link with private endpoints](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link) to restrict access to the registry. |



## Concepts

- **Registry**
  - A registry is a collection of repositories to store and distribute container images
  - You must be authenticated before you can pull and push images
  
- **Artifact**

  - The address of an artifact contains loginUrl, repository and tag
    - [loginUrl]/[repository:][tag]
- **Repository**
  - A repository is a group of similar container images and other artifacts.
  - Identify similar repositories and artifacts with namespaces
  
- **Image**
  
  - Images are used in ACR tasks.
  - A container image consists of tags, layers, and a manifest.
  - Orphaned images are generated by repeated pushing of modified images with identical tags.



## Best Practices

- If you place your registry near your container hosts, it will help reduce both latency and costs
- When you are deploying containers to multiple regions, you can use the geo-replication feature
- ACR supports nested namespaces that allow you to share a single registry across multiple groups
- There are two main situations when authenticating with an ACR:
  - Individual identity – allows you to pull or push images from the development machine.
  - Service/Headless identity – enables you to build and deploy pipelines where the user is not directly involved.
- ACR allows you to delete images by tag, by manifest digest, and by repository



## Tasks

- **Quick Task**
  - Verify your automated build definitions and catch potential problems prior to committing your code
  - Build and push a single container image to a container  registry on-demand, in Azure, without needing a local Docker Engine  installation.
- **Trigger Task**
  - You can create an image using one or more triggers on:
  - Source code update
  - Base image update
  - Schedule
- **Multi-step Task**
  - Multi-container-based workflows
  - With multi-step tasks in ACR Tasks, you have more granular  control over image building, testing, and OS and framework patching  workflows.
- Deleted registry resources such as repositories, images, and tags cannot be recovered after deletion.



## Tagging

- Use stable tags to maintain base images for your container builds.
- If the updated image has a stable tag, the previously tagged image is untagged, resulting in an orphaned image.
- You can use unique tags for deployments, particularly in an environment where multiple nodes can scale.



## Network

- You can connect to your ACR via public and private endpoints.
- A private endpoint connection is only available for Premium SKU.



## Security

- Encrypts the registry content at rest with service-managed keys or customer-managed keys.
- Customer-Managed Key is only available for Premium SKU.
- You can enable a customer-managed key only when you create a registry.
- Authenticate through **Azure Active Directory** user, service principal, admin login, or through Azure managed identity.



## Pricing

- You are charged (GiB/day) for the image storage.
- Users will be charged for the preceding SKU price until the  point of change and will be charged for the new SKU price after the  change has been made.
- Standard networking fees apply to network egress.
- If you replicate a registry to your desired regions, you are charged with premium registry fees for each region.



### Create A Private Container Registry

### Steps

1. Create a resource group
2. Create a container registry
   - The registry name must be unique within Azure, and contain 5-50 alphanumeric characters
   - Take a note of the loginServer from the output
   - loginServer is in the format of *<registry-name>.azurecr.io*
3. Login to registry
4. Push image to registry
   - Images must be tagged it with the  fully qualified name of your registry login server
5. List container images
6. Run image from repository
7. Clean up resources



### CLI

```bash
# 1. Create a resource group
az group create --name myResourceGroup --location eastus

# 2. Create a container registry
az acr create --resource-group myResourceGroup \
  --name myContainerRegistry007 --sku Basic
  
# 3. Login to reigstry
az acr login --name <registry-name>

# 4. Push image to registry
docker pull hello-world # just to get an image
docker tag hello-world <login-server>/hello-world:v1
docker tag hello-world mycontainerregistry.azurecr.io/hello-world:v1
docker push <login-server>/hello-world:v1
docker rmi <login-server>/hello-world:v1 # clear up local image but not from ACR

# 5. List container images
az acr repository list --name <registry-name> --output table
az acr repository show-tags --name <registry-name> --repository hello-world --output table # lists tags

# 6. Run image from repository
docker run <login-server>/hello-world:v1

# 7. Clean up resources
az group delete --name myResourceGroup
```



### Portal

1. Select **Create a resource** > **Containers** > **Container Registry**
2. https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-portal



### PowerShell

```powershell
# 1. Create a resource group
Connect-AzAccount # login
New-AzResourceGroup -Name myResourceGroup -Location EastUS

# 2. Create a container registry
$registry = New-AzContainerRegistry -ResourceGroupName "myResourceGroup" -Name "myContainerRegistry007" -EnableAdminUser -Sku Basic

# 3. Login to reigstry
$creds = Get-AzContainerRegistryCredential -Registry $registry
$creds.Password | docker login $registry.LoginServer -u $creds.Username --password-stdin

# 4. Push image to registry
docker pull hello-world # just to get an image
docker tag hello-world <login-server>/hello-world:v1
docker tag hello-world mycontainerregistry.azurecr.io/hello-world:v1
docker push <login-server>/hello-world:v1
docker rmi <login-server>/hello-world:v1 # clear up local image but not from ACR

# 5. List container images

# 6. Run image from repository
docker run <login-server>/hello-world:v1

# 7. Clean up resources
Remove-AzResourceGroup -Name myResourceGroup
```



### ARM Template



```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "acrName": {
      "type": "string",
      "defaultValue": "[concat('acr', uniqueString(resourceGroup().id))]",
      "minLength": 5,
      "maxLength": 50,
      "metadata": {
        "description": "Globally unique name of your Azure Container Registry"
      }
    },
    "acrAdminUserEnabled": {
      "type": "bool",
      "defaultValue": false,
      "metadata": {
        "description": "Enable admin user that has push / pull permission to the registry."
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for registry home replica."
      }
    },
    "acrSku": {
      "type": "string",
      "defaultValue": "Premium",
      "allowedValues": [
        "Premium"
      ],
      "metadata": {
        "description": "Tier of your Azure Container Registry. Geo-replication requires Premium SKU."
      }
    },
    "acrReplicaLocation": {
      "type": "string",
      "metadata": {
        "description": "Short name for registry replica location."
      }
    }
  },
  "resources": [
    {
      "comments": "Container registry for storing docker images",
      "type": "Microsoft.ContainerRegistry/registries",
      "apiVersion": "2019-12-01-preview",
      "name": "[parameters('acrName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('acrSku')]",
        "tier": "[parameters('acrSku')]"
      },
      "tags": {
        "displayName": "Container Registry",
        "container.registry": "[parameters('acrName')]"
      },
      "properties": {
        "adminUserEnabled": "[parameters('acrAdminUserEnabled')]"
      }
    },
    {
      "type": "Microsoft.ContainerRegistry/registries/replications",
      "apiVersion": "2019-12-01-preview",
      "name": "[concat(parameters('acrName'), '/', parameters('acrReplicaLocation'))]",
      "location": "[parameters('acrReplicaLocation')]",
      "dependsOn": [
        "[resourceId('Microsoft.ContainerRegistry/registries/', parameters('acrName'))]"
      ],
      "properties": {}
    }
  ],
  "outputs": {
    "acrLoginServer": {
      "value": "[reference(resourceId('Microsoft.ContainerRegistry/registries',parameters('acrName')),'2019-12-01-preview').loginServer]",
      "type": "string"
    }
  }
}
```







## Sources

- https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro