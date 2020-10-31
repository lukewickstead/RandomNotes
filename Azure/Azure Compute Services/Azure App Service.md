# Azure App Service
[toc]
## Overview
- A fully managed platform (PaaS) for building, deploying, and scaling your web apps.
- Different types of App Services: **Web Apps, Web Apps for Containers,** and **API Apps**
- Automatically patches and maintains the OS and language frameworks.
- App Service can scale up or out manually or automatically.
- App Service supports the following languages:
  - .NET
  - .NET Core
  - Java
  - Ruby
  - Node.js
  - PHP
  - Python

- An **App Service plan** is a collection of compute resources needed for a web app to run.

- Each App Service plan consists of a **region, number & size of virtual machines** and **pricing tier**.
- App Service plan pricing tier: 
  - **Shared Compute** – **Free** and **Shared** are the two base tiers. These tiers allocate CPU quotas to every app  running on the shared resources, but the resources cannot scale-out.
  - **Dedicated Compute** – It is composed of **Basic, Standard, Premium,** and **PremiumV2** tiers. As the tier gets higher, you will have more VMs to scale-out.
  - **Isolated** – A dedicated virtual machine that provides maximum scale-out capabilities.

## App Services Types:

- Web Apps
  - Website and online applications hosted on Azure’s managed platform.
  - Build and deploy mission-critical web applications that scale with your business.
  - It supports auto-scaling and load balancing for resilience and high availability.
- Web Apps for Containers
  - Deploy and run containerized applications in Azure.
  - All dependencies are shipped inside the container.
- **API Apps**
- - Expose and connect your backend data.
  - Connect other applications programmatically.

### Deployment

- Deployment components in App Service:
  - Deployment Source – it is where the application code is stored.
  - Build Pipeline – reads your code and takes the application in a running state
  - Deployment Mechanism – enables you to put your application in  the /wwwroot directory. It also supports Kudu endpoints, FTP, and  WebDeploy.
- **Deployment Center** lets you choose the location of your  code, as well as build and deploy to the cloud. It also has built-in  continuous delivery for containers.
- Swap app content and configurations elements with **deployment slots**.
- App Service supports the continuous deployment of code and containers.
- You can use **local cache** and deployment slots to prevent downtime.
- App Service **diagnostics** will help you in troubleshooting your application.

### Security

- App Service protocols: HTTPS, TLS 1.1/1.2 and FTPS
- The default domain name is using HTTPs. You can also secure your custom domain using an SSL/TLS certificate.
- **Service endpoints** allow you to restrict access from a virtual network.
- The first IP restriction rule has an explicit **Deny all** rule with a priority of 2147483647.
- Service-to-service authentication:
  - Service Identity – you can use the identity of the app to access the remote resource.
  - On-behalf-of (OBO) – allows you to access a remote service using a delegated sign-in.

## VNet Integration

- It allows your app to access resources in your virtual network.
  - Regional VNet Integration 
    - You need to have a dedicated subnet to the services that you integrate with.
    - Block outbound traffic using network security groups.
    - Route table allows you to send outbound traffic.
  - Gateway-required VNet Integration 
    - Allows access to resources in the target virtual network.
    - **Sync network** allows you to sync certificates and network information.
    - You can also **add routes** for outbound traffic.

## Hybrid Connections
- Uses host:port combination.
- It provides network access to your application using a TCP endpoint.
- Supports access to multi-networks from a single app.
- Host your hybrid connection endpoint using a relay agent or **Hybrid Connection Manager (HCM)**.
- You can run multiple HCMs on a separate machine to achieve high availability.

## Pricing
- You are charged on a per-second basis in the App Service plan.
- You are charged for the applications while they are in a stopped state.
- You are charged for data egress when using VNet Integration.
- You are charged for each listener in a Hybrid Connection

## Sources
- https://azure.microsoft.com/en-us/services/app-service
- https://docs.microsoft.com/en-us/azure/app-service/overview