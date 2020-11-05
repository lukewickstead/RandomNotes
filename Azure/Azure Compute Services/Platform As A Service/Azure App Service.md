# Azure App Service
[toc]
## Overview
- HTTP-based service for hosting web applications, REST APIs, and mobile back end
- A fully managed platform (PaaS) for building, deploying, and scaling your web apps
  - Azure automatically patches and maintains the OS and language frameworks
- Different types of App Services: **Web Apps, Web Apps for Containers,** and **API Apps**
- App Service can scale up or out manually or automatically
- App Service supports the following languages; .NET, .NET Core, Java, Ruby, Node.js, PHP, or Python
## App Service plans 
- An **App Service App** always runs in an App Service plan
- An **App Service Plan** defines a set of compute resources for a web app to run; similar to a server farm in conventional web hosting
- One or more apps can run in the same App service Plan
- Each App Service plan consists of a **region, number & size of virtual machines** and **pricing tier**
- The **Pricing tier** determines what features are available and how much you pay 
  - Features available can be found
    - https://azure.microsoft.com/en-gb/pricing/details/app-service/windows/
  - **Shared Compute**
    - Consisting of **Free** and **Shared** tiers
    - Runs an app on the same VM as other app service apps which might be other customers
    - CPU quotas (minutes) are allocated to each app that runs on the shares resources
    - Resources cannot scale out
    - In the **Shared** tier, each app receives a quota of CPU minutes, so *each app* is charged for the CPU quota.
    - In the **Free** tier you are not charged but it is considered a try for free
  - **Dedicated Compute**
    - Consisting of **Basic, Standard, Premium PremiumV2 and PremiumV3** tiers
    - Runs apps on dedicated Azure VMs
    - Only apps in the same App Service Plan share the same compute resource
    - The higher the tier, the more VM instances are available to you for scale-out.
    - The App Service plan defines the number of VM instances the apps are scaled to
    - Each VM charged regardless of usage
  - **Isolated**
    - Dedicated Azure VMs on dedicated Azure Virtual Networks
    - Provides network isolation on top of compute isolation. 
    - Provides the maximum scale-out capabilities.
    - The App service plan
    - The App Service Environment defines the number of isolated workers
    - Each isolated worker is charged
    - A flat fee for running the App Service Environment is also applied
- An App Service plan is the scale unit as all resources run on them and they define the number of VMs to use (except shared)
- An App Service plan can be scaled up and down at any time by changing the pricing tier
- Alternatively you can move an app into its own App Service plan
- Grouping apps into the same App Service plan can save money
- Be careful overloading an App Service as this could cause downtime
## Operating Systems
- Supports both Windows and Linux based environments
- Linux apps run in their own containers
  - 	No access to the host operating system is allowed
  - 	You do not have root access to the container
  - 	Not supported on shared pricing tier
- You cannot mix Windows and Linux apps in the same resource group
- Apps run their framework in fully trusted mode; they can spawn processes, make network requests, see mounted network drives and the disks of the VM
- Are limited to the permission of the VM; for example you cannot unmounted disks
## Deployment

- Deployment components in App Service:
  - **Deployment Source** – is where the application code is stored; for example Bit Bucket or GitHub
  - **Build Pipeline** reads your code and performs the required state to make artefacts for your app to run
  - **Deployment Mechanism** is the action required to put your built application into the */home/site/wwwroot*  directory
    - Supported mechanisms are Kudo, FTP and WebDeploy
    - Deployment tools such as Azure Pipelines, Jenkins, and editor plugins use one of these deployment mechanisms
- **Deployment Center** lets you choose the location of your  code, as well as build and deploy to the cloud. It also has built-in  continuous delivery for containers
- **Deployment slots** 
  - Allow deploying to an offline environment 
  - Prevents downtime due to releasing
  - Allow validating the new environment and running smoke tests
  - Slots are swapped once you are happy with the new environment
- App Service supports the continuous deployment of code and containers.
- You can use **local cache** if your app needs high performance read only content store
  - Content is normally stored on Azure storage
- App Service **diagnostics** will help you in troubleshooting your application.
## Security
- Your app resources are [secured](https://github.com/projectkudu/kudu/wiki/Azure-Web-App-sandbox) from the other customers' Azure resources.
- [VM instances and runtime software are regularly updated](https://docs.microsoft.com/en-us/azure/app-service/overview-patch-os-runtime) to address newly discovered vulnerabilities.
- Communication of secrets (such as connection strings) between your app and other Azure resources (such as [SQL Database](https://azure.microsoft.com/services/sql-database/)) stays within Azure and doesn't cross any network boundaries. Secrets are always encrypted when stored.
- All communication over the App Service connectivity features, such as [hybrid connection](https://docs.microsoft.com/en-us/azure/app-service/app-service-hybrid-connections), is encrypted.
- Connections with remote management tools like Azure PowerShell, Azure CLI, Azure SDKs, REST APIs, are all encrypted.
- 24-hour threat management protects the infrastructure and platform  against malware, distributed denial-of-service (DDoS), man-in-the-middle (MITM), and other threats.
- App Service protocols: HTTPS, TLS 1.1/1.2 and FTPS
- The default domain name is using HTTPs. You can also secure your custom domain using an SSL/TLS certificate.
- **Service endpoints** allow you to restrict access from a virtual network or subnet and an app
- The first IP restriction rule has an explicit **Deny all** rule with a priority of 2147483647.
- Service-to-service authentication:
  - Service Identity / Managed Identity
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
- Access on-premises data
- Uses host:port combination.
- It provides network access to your application using a TCP endpoint.
- Supports access to multi-networks from a single app.
- Host your hybrid connection endpoint using a relay agent or **Hybrid Connection Manager (HCM)**.
- You can run multiple HCMs on a separate machine to achieve high availability.
## Pricing
- **Free** is a try for free plan
- **Shared** tier, each app receives a quota of CPU minutes, so *each app* is charged for the CPU quota.
- **Dedicated** are charged per VM
- **Isolated** are charged by the number of isolated workers and a flat fee for the App Service Environment
- You are charged on a per-second basis in the App Service plan.
- You are charged for the applications while they are in a stopped state.
- You are charged for data egress when using VNet Integration.
- You are charged for each listener in a Hybrid Connection
- You pay for the Azure compute resources you use.
## Sources
- https://docs.microsoft.com/en-us/azure/app-service/overview
- https://azure.microsoft.com/en-gb/pricing/details/app-service/windows/