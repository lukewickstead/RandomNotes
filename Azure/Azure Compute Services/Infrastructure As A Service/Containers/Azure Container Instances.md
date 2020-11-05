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



## Source

- https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview