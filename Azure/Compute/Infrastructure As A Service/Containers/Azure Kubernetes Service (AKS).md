# Azure Kubernetes Service (AKS)
[toc]
## Overview
- An open-source tool for orchestrating and managing many container images and applications.
- Lets you deploy a managed Kubernetes cluster in Azure.
- Azure AKS is a managed service, offloading much of the complexities of Kubernetes to Azure
- Azure AKS is free but you have to pay for the nodes
## Features
- Uses clusters and pods to scale and deploy applications.
- Kubernetes can deploy more images of containers as needed.
- It supports horizontal scaling, self-healing, load balancing, and secret management.
- Automatic monitoring of application load to determine when to scale the number of containers used.
- Allows you to replicate container architectures.
- Use Kubernetes with supported Azure regions and on-premises installations using **Azure Stack.**
- The images used by AKS come from Azure Container Registry.
- Use **Azure Advisor** to optimize your Kubernetes deployments with real-time, personalized recommendations.



## Components

- Kubernetes runs an application in your instance using **pods**.
- A **node** is made up of several **pods**, and **node pools** are a group of nodes with the same configuration.
- Use a **node selector** to control where a pod should be placed.
- You can run at least 2 nodes in the default node pool to ensure your cluster operates reliably.
- Multi-container pods are placed on the same node and allow containers to share the related resources.
- You can specify maximum resource limits that prevent a given pod from consuming too much compute resources from the underlying node.
- A **deployment** determines the number of replicas (pods) to be created, but you must define a manifest file in YAML format first.
- With **StatefulSets**, you can maintain the application’s state within a single pod life cycle.
- The resources are logically grouped into a **namespace**, and a user may only interact with resources within their assigned namespaces.



## Storage

- Persistent volumes are provided by Azure disk and file storage.
- Create a Kubernetes DataDisk resource using Azure Disk.
- Mount an SMB 3.0 share backed by an Azure Storage account to pods with Azure Files.
- Volumes that are defined and created as part of the pod lifecycle only exist until the pod is deleted.
- AKS has four initial storage classes:
  - default – uses Azure StandardSSD storage to create a Managed Disk.
  - managed-premium – uses Azure Premium storage to create Managed Disk.
  - azurefile – uses Azure Standard storage to create an Azure File Share.
  - azurefile-premium – uses Azure Premium storage to create an Azure File Share.
- If no StorageClass is specified for a persistent volume, the default StorageClass is used.



## Security

- With Kubernetes RBAC, you can create roles to define permissions and then assign those roles to users with role bindings.
- You can limit network traffic between pods in your cluster with Kubernetes network policies.
- Dynamic rules enforcement across multiple clusters with Azure Policy.
- Azure AD-integrated AKS clusters can grant users or groups  access to Kubernetes resources within a namespace or across the cluster.
- Secure communication paths between namespaces and nodes with Azure Private Link.



## Pricing

- You only pay for virtual machines, associated storage, and networking resources.
- There is no charge for cluster management.



## Versions

- Uses semantic versioning: [major].[minor].
- A user has 30 days from the version removal to upgrade into a supported patch and continue receiving support.
- Azure updates the cluster automatically if it has been out of support for more than 3 minor versions.
- Downgrading a version is not supported.



## Create An AKS Cluster

### Steps

1. Create a resource group
2. Create an AKS cluster
   - [Azure Monitor for containers](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/container-insights-overview) is enabled using the *--enable-addons monitoring* parameter, which requires *Microsoft.OperationsManagement* and *Microsoft.OperationalInsights* to be registered on you subscription
   - A second resource group will automatically be created by Azure
     1. (https://docs.microsoft.com/en-us/azure/aks/faq#why-are-two-resource-groups-created-with-aks)
3. Connect to the cluster
   - Use kubectl
   - get-credentials downloads and configures kubectl to use your credentials
   - ~/.kube/config is the default location used for 
4. Run the application
   - Requires a manifest file
5. Test the application
   - When the application runs, a Kubernetes service exposes the  application front end to the internet
   - This process can take a few  minutes to complete
   - To monitor progress, use the [kubectl get service](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command with the `--watch` argument
   - When the EXTERNAL-IP changes from pending to to an actual ip address you can use CTRL-C to stop watching
   - Open a browser using the EXTERNAL-IP
6. Delete the cluster
   - Delete the resource group
   - The Azure Active Directory service principal used by the AKS cluster is not removed



### Manifest Files

- A [Kubernetes manifest file](https://docs.microsoft.com/en-us/azure/aks/concepts-clusters-workloads#deployments-and-yaml-manifests) defines a desired state for the cluster, such as what container images to run



```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-back
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-back
  template:
    metadata:
      labels:
        app: azure-vote-back
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-back
        image: mcr.microsoft.com/oss/bitnami/redis:6.0.8
        env:
        - name: ALLOW_EMPTY_PASSWORD
          value: "yes"
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 6379
          name: redis
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: azure-vote-back
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-front
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-front
  template:
    metadata:
      labels:
        app: azure-vote-front
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-front
        image: mcr.microsoft.com/azuredocs/azure-vote-front:v1
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 80
        env:
        - name: REDIS
          value: "azure-vote-back"
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-front
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: azure-vote-front
```



### CLI

```bash
# 1. Create a resource group
az group create --name myResourceGroup --location eastus

# 2. Create an AKS cluster
az provider show -n Microsoft.OperationsManagement -o table # check if installed
az provider show -n Microsoft.OperationalInsights -o table # check if installed
az provider register --namespace Microsoft.OperationsManagement # install if requried
az provider register --namespace Microsoft.OperationalInsights # install if required

az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys # takes a few minutes

# 3. Connect to the cluster
az aks install-cli
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster

kubectl get nodes # verify the connection

# 4. Run the application
kubectl apply -f manifest.yaml # deploy

# 5. Test the application
kubectl get service azure-vote-front --watch

# 6. Delete the cluser
az group delete --name myResourceGroup --yes --no-wait
```

### PowerShell

```bash
# 1. Create a resource group
New-AzResourceGroup -Name myResourceGroup -Location eastus

# 2. Create an AKS cluster
ssh-keygen -m PEM -t rsa -b 4096 # Create
New-AzAks -ResourceGroupName myResourceGroup -Name myAKSCluster -NodeCount 1

# 3. Connect to the cluster
Install-AzAksKubectl
Import-AzAksCredential -ResourceGroupName myResourceGroup -Name myAKSCluster
kubectl get nodes # verify the connection

# 4. Run the application
kubectl apply -f manifest.yaml # deploy

# 5. Test the application
kubectl get service azure-vote-front --watch

# 6. Delete the cluser
Remove-AzResourceGroup -Name myResourceGroup
```



### ARM Template

```bash
# Create a service principle
az ad sp create-for-rbac --skip-assignment
```




```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.1",
  "parameters": {
    "clusterName": {
      "type": "string",
      "defaultValue": "aks101cluster",
      "metadata": {
        "description": "The name of the Managed Cluster resource."
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "The location of the Managed Cluster resource."
      }
    },
    "dnsPrefix": {
      "type": "string",
      "metadata": {
        "description": "Optional DNS prefix to use with hosted Kubernetes API server FQDN."
      }
    },
    "osDiskSizeGB": {
      "type": "int",
      "defaultValue": 0,
      "minValue": 0,
      "maxValue": 1023,
      "metadata": {
        "description": "Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize."
      }
    },
    "agentCount": {
      "type": "int",
      "defaultValue": 3,
      "minValue": 1,
      "maxValue": 50,
      "metadata": {
        "description": "The number of nodes for the cluster."
      }
    },
    "agentVMSize": {
      "type": "string",
      "defaultValue": "Standard_DS2_v2",
      "metadata": {
        "description": "The size of the Virtual Machine."
      }
    },
    "linuxAdminUsername": {
      "type": "string",
      "metadata": {
        "description": "User name for the Linux Virtual Machines."
      }
    },
    "sshRSAPublicKey": {
      "type": "string",
      "metadata": {
        "description": "Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example 'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm'"
      }
    },
    "servicePrincipalClientId": {
      "type": "securestring",
      "metadata": {
        "description": "Client ID (used by cloudprovider)"
      }
    },
    "servicePrincipalClientSecret": {
      "type": "securestring",
      "metadata": {
        "description": "The Service Principal Client Secret."
      }
    },
    "osType": {
      "type": "string",
      "defaultValue": "Linux",
      "allowedValues": [
        "Linux"
      ],
      "metadata": {
        "description": "The type of operating system."
      }
    }
  },
  "resources": [
    {
      "type": "Microsoft.ContainerService/managedClusters",
      "apiVersion": "2020-03-01",
      "name": "[parameters('clusterName')]",
      "location": "[parameters('location')]",
      "properties": {
        "dnsPrefix": "[parameters('dnsPrefix')]",
        "agentPoolProfiles": [
          {
            "name": "agentpool",
            "osDiskSizeGB": "[parameters('osDiskSizeGB')]",
            "count": "[parameters('agentCount')]",
            "vmSize": "[parameters('agentVMSize')]",
            "osType": "[parameters('osType')]",
            "storageProfile": "ManagedDisks"
          }
        ],
        "linuxProfile": {
          "adminUsername": "[parameters('linuxAdminUsername')]",
          "ssh": {
            "publicKeys": [
              {
                "keyData": "[parameters('sshRSAPublicKey')]"
              }
            ]
          }
        },
        "servicePrincipalProfile": {
          "clientId": "[parameters('servicePrincipalClientId')]",
          "Secret": "[parameters('servicePrincipalClientSecret')]"
        }
      }
    }
  ],
  "outputs": {
    "controlPlaneFQDN": {
      "type": "string",
      "value": "[reference(parameters('clusterName')).fqdn]"
    }
  }
}

```





## Sources

- https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes   