# Fundamentals #

Use '?' to get some shortcuts for navigating Azure.

Selecct a deployment model; Virtually always should use Resource Manager over classic

Most resources require a name to identify the resource.

SSD normally but costs more. Use hdd for batch/network intensive processing where disk access is not really requried.

Subscriptions; you can have multiple subscriptions associated with an Azure account

Resource Group; logically container for resources. This is more to tie all resources for an appllciation rather than a category.

Location; where they are located. All related resources should be within the same location and also closest to your client

Power; associated in letters. Each with their own profile. Azure will try and recommend from your choices but you can always select what you want.

You can see resources by their type, all resources and also the resource group. 

# Virtual Machine #

d:\ drive is temp and could be lost at any point; c drive is backed up and if your machine is moved by MS for any reason it will be restored.

Login-AzureRmAccount cna be used to connect a powershell session to Azure.
Get-AzureRmSubscription to get the subscritpions/connect subscriptoin
Get-AzureRmSubscription -SubscriptionName XXXName | Select-AzureSubscription to associate a subscirption to the powershell
Get-AzureRmContext to see which one is currently connected
Get-AzureRmVm to get a list of VMs
Stop-AzureRmVm -ResourceGroupName XXX -Name YYY --force to stop a VM, start with the start command

You still pay for the hd storage but not the processor
You can delete the vm; bets with the resource group as it will get rid of all the associated resources.


# Building Web Applications and APIs #

- On-premises; pre cloud
- Infrastructure as a Service (Iaas)
	- You maintain the Apps and OS but the Hardware is maintained by Azure
- Platform as a Service (PaaS)
	- OS an dHardware maintained by Azure, Apps is maintained by you.

Microsoft Azure App Services; go to App Services

You select what frameworks you want installed.

Name has to unique on the entire Azure platform; this is your url prefix

Select the App Service Plan. Defines the performance characteristic. You select the hardware requirement but don't need to manage it.

You can have multiple app services on the same plan and they will be hosted on the sam VM, though you can have them on seperate ones as well.

Scale up -> better hardware
Scale out -> double the number of instances

We can configure scaling dynamically as well.

There is a free plan to allow experimenting. Does not allow external url or SSL

You can deploy in VS but the intial setup add to azure; the publish onthe solution or via build servers

Publish creates publish files in PublishProfiles; you cna habe multiple for different settings. The password is stored in the same dir but .user with a hashed password.

You can download these from Azure and import them into Visual Studio to be able to publish direct from VS. (There is an import button on the publish wizard)

VS extension Cloud Explorer; downloading the publish profiles for the site on this account has the username and password not encrypted and really shoult not be saved into source control

Right clkick open in portal to jump into the azure profile

# Monitoring & Scaling Web Aplication APIs #

## Deployment Slots ##

Deployment slots are the environments for an application; staging, production etc.

We also can set app settings which overrride the variables within the app settings etc. Slot setting check box means they are sticky and not overrideen between environments.

You can swap slots using the swap button; i.e swap swap staging into production. The swap happens by starting to direct new users onto the new live environment. In effect we have no down time.

## Monitoring ##

The overview of the App Service has requests and errors over the last error. This can all be edited for different times and  other information/breakdown.

There is a section under the Monitoring section of the app server blade; this includes current live traffic.

Metrics per instance can see performance monitor counters for the hardware.   This includes the average response times, amount of cpu time and memmory, I/O of data. Per plan see the aggregate of all app services on the plan


## Alerts ##

Define criteria of unusual activity which then will generate some form of alert.

The resource type defines whether we are interested in the software resources or the hardware resources

You can configure to email you, additional people or call a web hook.

## Scaling  ##

Vertical scaling up/down increase/drecrease or decrease hardware performance ( memmory, cores etc)

Horizontal scaling outwards on to multiple instances of the same machine type.

You can configure these through the plan section of the dash board.

Plan -> Change App Service plan / Scale up / Scale out

In general it is better scale out but this is only a  rule of thumb. Sometimes it is good just to move an app service into its own plan so it is not sharing with others.

Scaling out can be made always (pay all the time (an instance count that I enter manually) ), or dynamically (by cpu usage) to spin up new instances. You select the min and max instances as well as the low and upper target of the cpu. the upper will trigger a new instance until the top number of instances is reached, the lower triggers an instance to spin down. A check box for email when spinned up or down can be set.

Schedule and perfomance rules allow a mix of time based rules and performance (recurrence) by a actual date (fixed date). These generate profiles and then rules for these can be configured. You need a pair of rules for scaling up and down. The rules get very complex and powerful.

## Debugging ##

Diagnostic logs need to be turned on as they are not on by default

Diagnostic logs -> Application Logging (Filesystem). This is turned off after 12 hours but the blob version is not. 

Other options include web  server  logging, detailed error message and failed request tracing ( the latter is very detailed by very big and should be used with care.)

Application Insights is great for seeing what is happening in your code. This needs a new resource and is not free; it is costed. It works best when your code is setup to record telemetrics into application insights. In VS right click; add application insights telementary. this is a wiazrd allowing you to set the resource name entered into azure, it then adds nuget packages as well as an applicationinsights.config file which contains the insutrmentation key; helps identify different applications for the same resource key Enabling trace ois great for hard to reach debug but causes a lot of data to be generated.

Application Insights you can see information; you can drill down into different areas including where errors are being raised and where from.

Monitoring -> Log Stream allows connect to appliation logs or web server logs; not quite real time as there is a bit of a load. You can download the files by the cloud explorer -> app service -> log file

### Kudu ###

Development Tools --> Advanced Tools, follow go link to get to Kudu project for your app service. Permissioned only to people who have access in the portal

Tools --> Diagnostic Dump for all log files
Process Exploreer --> to see what is running on the server
Debug console -> CMD/Powershell on the server. which can help you actually get onto the machine to work on. You can see a file system of all the files, you cna edit and save files. for example doing this on the web.config will replicate onto all running instances.

### Remote  debugging ###

Application Settings -> Remove debuggin can be turnred on. This can be  turned on automatically via cloud explorer if you have permisisons. Right click (cloud explorer) -> attach debugger.

Should deploy using debug mode and not release mode. It is possible to debug release code if you select  (disable just my code and continue)

Publish --> Settings --> Configuration : Debug/Release