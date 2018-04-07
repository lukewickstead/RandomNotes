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

# Monitoring & Scaling Web Aplication APIs 

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

# Using Cloud Databases

## Azure SQL Database

This is simply SQL Server in the cloud.

SQL Databases --> Add opens a wizard

Allows creating from blank, adventure works or a backup.

Every database needs to be associated to a azure sql server; this is not a physical or virtualisation server. It is simply a logical container for one or more databases. The dbs might or might not exist on the same database server / disk. That is up to MS and their infrqastrcuture.

Configure Server, allows configuration of the host server.

- Server Name needs to be unique as this might be addressable over the internet. By default the db will not be contactable over the internet.

You can configure the sql database to use SQL elastic pool; this allows you to purchase and share a plan across multiple databases.

Selecting the plan for a databses is deifferent. The important facts are size and DTU ( data throughput unit, a lreative unit of how much power is behind the database.) 5 is more than good enough for a test/developer machine where not many concurrent users are requried (plan B)

Production requires a standard tier with DTUs from 10 through to 100 100 is ten times more powerful than 10.

25K views a day with each with 2/3 db hits per view S0 (DTU 10) should be enough. You can monitor, review and set up alerts.

Premium plans is 125DTU to 4K DTU and TBs of database

Plans are per database and not server, so think of elastic plans if you have multiple daatbases.

SQL Database blade is very similar to the VM and App server blade we have already seen.

- Overview
	- Export allows a back up to be created	
	- Restore from a backup
	- Firewall, by default this is on for azure services but not from the internet. You can add in ip addresses for remote connection
	- A graph with resource utilisation of % of DTU usage.
	- Geo-replication replicate into other azure data centers by simply selecting them from the map
	- Transparent data encryption; simply turn on and nothing else is required by your code to encrypt or decrype the data
	- Alert Rules to get notice on metrics such as 
		- Failed connections
		- DTU %
		- Total DB size
			 Same as what we did on the app service alerts  	
	Database Size shows how much used and your threshold
	Performanc overview allows a view of how effectively you are using the resources
	Query Performance Insight to see most expensive or longest running. You can click on it to see the sql query and the averages of usagge over time.
	 automatic tuniing, monitors the db and can create and drop indexes as it see fit.
	
### Connecting from Code

The username and password you set when you created the db is the admin one and should not be used for connection. 

You need to use SQL Server Management Studio or Visual Studio to create and manage the users

Get the connection string by clicking on connection in the overview of the database.

You can connect to the database from SQL Server Explorer in VS. You can see an option for Azure connections if you are signed on. 

SQL Server Management Studio; use the servername, SQL Server Authentication. By default not reachable from anything outside of Azure. You are given the option to login and add your current ip address into the whitelist.

Under the server; Security -> Logins -> New Login (rclick)

Under the db; Security -> New (rclick) -> User providing the  login from above.

Add in roles;  db_datareader, db_datawriter, dbdlladmin are good ones for people who need to manage schemas

Put in the connection string into  web.release.config OR App Service -> Settings -> connection strings. These are then not checked into code. It allows you to provide a connection string. (The copied cponnection string has place holder for username and password). Again used slot setting to allow different environmnets.

## Document DB

MS allow a DocumentDB emulator to code against locally without occuring any charges

NoSQL  (Document DB)

A lot of this is the same for SQL Server.

NoSQL API: You can give the db MongoDB confirmation if you are moving from a MongoDB application. 

The intial entry is for a DocumentDB Account. The pricing plan is associated by the collectoins.

Hierachy DoccumentDB Account -> Databases -> Collectoions.

### Adding a collection

Collections --> Add

Pricing Tier is done as PAsS. You are charged by storage and throughput reserved as RU ( Request Unit). 1 RU is how much it costs to get over HTTP a  1 kilobyte is 1 RU.

If you need more data then go to partitioned. Partitioned wil;l affect how you design your application and query your data.

Azure provides a costing estimator:

https://www.documentdb.com/capacityplanner
https://azure.microsoft.com/en-gb/updates/documentdb-capacity-planner-update/

You can upload a sample document along with estimates of create, read, update deletes.

Here you get to create a database to assign the collection to.

Browser --> Scale

You can reduce/increase the throughput. You pay for what you reserve and not what you use. If you exceeed you get 429 status code; all requests are done over http.

### Connecting from Code

In c#, use either lower case for the field names on the models or override with an attribute to allow serialising and deserializing using the name.

You can insert a parent with children and all the data and realtions are saved automatically.

Add Reference -> MS.Azure.DocumentDB througn nuget.

Surface endpoint is the uri from the overview.

The key is found under settings -> Key. You cna get different connection keys. There is also a button to regenerate a key which will revoke the existing one. It is a good idea to do this periodically.

Be careful over the primary/.seconday. Primary seems to be full admin account.

```c#
var client = new DocumentClient(serviceEndpoint, key);

var uriLink = UriFactory.CreateDocumentCollectionUri("DbName", "CollectionName");


// Query
client.CreateDocumentQuery<MyDTO>(uriLink).OrderBy(d => d.Field).Where(d => d.Field = "Boo");

// Insert
client.CreateDocumentAsync(uriLink, myDTO);
```

### Metrics

Monitoring -> Metrics

See how many 429 status returns and other cool bits.

Monitoring -> Alert Rules; same as boefore

Collections -> Document Exporer to actually see the data and also upload it.
Collection -> Query Explorder to query the db with the query language which is similar to SQL.


Collections -> Script Explorer -> Create Stored Prociedre, triggers and user defined funcitons. Same as SQL Server but use JavaScript.



# Cloud Storage

