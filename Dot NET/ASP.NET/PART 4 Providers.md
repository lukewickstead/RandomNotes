PART IV Providers 


- [CHAPTER 14: Introduction to the Provider Model]{Chap14} 
- [CHAPTER 15: Extending the Provider Model]{Chap15}

#14 Introduction to the Provider Model# {Chap14}

ASP.NET is a way to build applications for the Internet. That means an application’s display code travels over HTTP, which is a stateless protocol.

ASP.NET works with a disconnected architecture. The simple nature of this model means that requests come in and then responses are sent back.

On top of that, ASP.NET does not differentiate one request from another. The server containing an ASP.NET application is simply reacting to any request thrown at it.

This means that a developer building a web application has to put some thought into how users can remain in context between their requests to the server as they work through the application.

Keeping a user in context means recording state (the state of the user) to some type of data store.

You can do this in multiple ways, and no one way is the perfect way.

State can be stored via multiple methods, some of which include: Application state Session state The Cache object

You use all these methods on the server, but you can also employ your own custom methods — such as simply storing state in a database using your own custom schema.

Writing state back to the clients, either directly on their computers or by placing state in the HTML output in the response, is also possible.

- Cookies 
- Querystrings 
- Hidden 
- Fields 
- ViewState

##UNDERSTANDING THE PROVIDER##

Recording state to data stores in more advanced modes is accomplished through the use of providers.

By default, sessions in ASP.NET are stored InProc, meaning in the same process where ASP.NET is running.

In ASP.NET, you can simply change the provider used for the Session object; this will, in turn, change where the session is stored.

The available providers for storing session information include:

- InProc 
- StateServer 
- SQLServer

Besides InProc, you can use StateServer, which enables you to store sessions in a process that is entirely separate from the one in which ASP.NET runs. This protects your sessions if the ASP.NET process shuts down.

You can also store your sessions to disk (in a database, for example) using the SQLServer option. This method enables you to store your sessions directly in Microsoft’s SQL Server.

One option to change the provider used for sessions is through the Internet Information Services (IIS) Manager,

The other option is to go directly to a system-wide configuration file (such as the machine.config file) or to an application configuration file (such as the web.config). In

the sessionState section of the configuration document.

##THE PROVIDER MODEL IN ASP.NET 4.5##

As ASP.NET developed, users wanted to be able to store sessions by means other than the three methods — InProc, StateServer, and SQLServer.

instead of building providers for each and every possible scenario, the developers designed a provider model that enabled them to add any providers they wanted.

The systems based on the provider model found in ASP.NET 4.5 that require advanced state management include the following: Membership Role management Site navigation Personalization Health monitoring web events Configuration file protection

> *NOTE* This chapter covers the built-in, classic providers in ASP.NET. However, it’s highly recommended that you download and use the Universal Providers using Package Manager. The Universal Providers are explained more in Chapters 18 and 19.

Out of the box, ASP.NET 4.5 provides a couple of membership providers that enable you to store user information. The included providers are the SQL Server and the Active Directory membership providers (found at System.Web.Security.SqlMembershipProvider and System.Web.Security.ActiveDirectoryMembershipProvider, respectively).

As you can see from the diagram, ASP.NET provides a large number of providers out of the box. Some systems have only a single provider (such

as the profile system that includes only a provider to connect to SQL Server), whereas other systems include multiple providers (such as the WebEvents provider that includes six separate providers).

###Setting Up Your Provider to Work with Microsoft SQL Server 2005, 2008, or 2012###

Quite a number of providers work with SQL Server. For example, the membership, role management, personalization, and other systems work with SQL Server right out of the box.

However, all these systems work with LocalDB by default instead of with one of the full-blown versions

To work with any of these databases, you must set up the database using the aspnet_regsql.exe tool.

creates the necessary tables, roles, stored procedures, and other items needed by the providers.

Visual Studio 2012 Command Prompt.

This gives you access to the ASP.NET SQL Server Setup Wizard.

tool that facilitates setup of the SQL Server to work with many of the systems that are built into ASP.NET 4.5, such as the membership, role management, and personalization systems.

using a command-line tool or using a GUI tool.

###The ASP.NET SQL Server Setup Wizard Command-Line Tool###

You can get at the actual tool, aspnet_regsql.exe, from the Visual Studio Command Prompt

To get a list of all the command-line options

```
aspnet_regsql.exe –? 
```

|COMMAND OPTION| DESCRIPTION|
|--|--|
|-? |Displays a list of available option commands. |
|-W| Uses the Wizard mode. This uses the default installation if no other parameters are used.| 
|-S <server> |Specifies the SQL Server instance to work with.|
|-U <login> |Specifies the username to log in to SQL Server. If you use this, you also use the -P command. 
|-P <password> |Specifies the password to use for logging in to SQL Server. If you use this, you also use the -U command.|
| -E |Provides instructions to use the current Windows credentials for authentication. |
|-C |Specifies the connection string for connecting to SQL Server. If you use this, you can avoid using the -U and -P commands because they are specified in the connection string itself.|
| -A all| Adds support for all the available SQL Server operations provided by ASP.NET including membership, role management, profiles, site counters, and page/control personalization.|
| -A p |Adds support for working with profiles.|
| -R all| Removes support for all the available SQL Server operations that have been previously installed. These include membership, role management, profiles, site counters, and page/control personalization. |
|-R p | Removes support for the profile capability from SQL Server. -d <database> Specifies the database name to use with the application services. If you don’t specify a name of a database, aspnetdb is used. |
|-sqlexportonly <filename> |Instead of modifying an instance of a SQL Server database, use this command in conjunction with the other commands to generate a SQL script that adds or removes the features specified. This command creates the scripts in a file that has the name specified in the command.|

To modify SQL Server to work with the personalization provider using this command-line tool, you enter a command such as the following:

```
aspnet_regsql.exe -A all -E
```

creates the features required by all the available ASP.NET 4.5 systems.

When this action is completed, you can see that a new database, aspnetdb, has been created in the Microsoft SQL Server Management Studio,

You now have the appropriate tables for working with all the ASP.NET systems that are able to work with SQL Server

set up the database for the membership system only,

```
aspnet_regsql.exe -A m -E
```

The ASP.NET SQL Server Setup Wizard GUI Tool Instead of working with the tool through the command line, you can also work with a GUI version of the same wizard. To get at the GUI version,

```
aspnet_regsql.exe
```

The Database option is  default — meaning that the wizard creates a database called aspnetdb.

###Connecting Your Default Provider to a New SQL Server Instance###

create a connection string to the database in your machine.config or web.config

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="LocalSqlServer" connectionString="Data Source=127.0.0.1;Integrated Security=SSPI" />
   </connectionStrings>
</configuration>
```

look further in the providers section

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="LocalSqlServer" connectionString="Data Source=127.0.0.1;Integrated Security=SSPI;Initial Catalog=aspnetdb;" />
   </connectionStrings>
   <system.web>
      <compilation debug="false" targetFramework="4.5" />
      <httpRuntime targetFramework="4.5" />
      <membership defaultProvider="AspNetSqlMembershipProvider">
         <providers>
            <add name="AspNetSqlMembershipProvider" type="System.Web.Security.SqlMembershipProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" connectionStringName="LocalSqlServer" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="true" applicationName="/" requiresUniqueEmail="false" passwordFormat="Hashed" maxInvalidPasswordAttempts="5" minRequiredPasswordLength="7" minRequiredNonalphanumericCharacters="1" passwordAttemptWindow="10" passwordStrengthRegularExpression="" />
         </providers>
      </membership>
   </system.web>
</configuration>
```

The name of this provider instance is AspNetSqlMembershipProvider.

You can see that this instance also uses the connection string of LocalSqlServer,

Pay attention to some important attribute declarations

the provider used by the membership system is defined via the defaultProvider attribute

can specify whether the provider is one of the built-in providers or whether it is a custom provider that you have built yourself or received from a third party.

##Membership Providers##

The membership system enables you to easily manage users in your ASP.NET applications.

it features a series of server controls that interact with a defined provider to either retrieve or record information to and from the data store defined by the provider.

You just change the underlying provider of the overall system (in this case, the membership system) by making a simple configuration change in the ASP.NET application. It really makes no difference to the server controls.

ASP.NET 4.5 provides two membership providers:

- System.Web.Security.SqlMembershipProvider: Provides you with the capability to use the membership system to connect to Microsoft’s SQL Server 2005, 2008, and 2012 as well as with Microsoft SQL Server Express Edition.
- System.Web.Security.ActiveDirectoryMembershipProvider: Provides you with the capability to use the membership system to connect to Microsoft’s Active Directory (available in Microsoft Windows Server).

Both of these membership provider classes inherit from the MembershipProvider base class, System.Web.Security.SqlMembershipProvider

The default provider is the SqlMembershipProvider

Shows the definition of this provider, which is located in the machine.config

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <membership defaultProvider="AspNetSqlMembershipProvider">
         <providers>
            <add name="AspNetSqlMembershipProvider" type="System.Web.Security.SqlMembershipProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" connectionStringName="LocalSqlServer" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="true" applicationName="/" requiresUniqueEmail="false" passwordFormat="Hashed" maxInvalidPasswordAttempts="5" minRequiredPasswordLength="7" minRequiredNonalphanumericCharacters="1" passwordAttemptWindow="10" passwordStrengthRegularExpression="" />
         </providers>
      </membership>
   </system.web>
</configuration>
```

By default, this provider is also configured to work with a SQL Server Express

You can see this by looking at the defined connectionStringName

In this case, it is set to LocalSqlServer.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <clear />
      <add name="LocalSqlServer" connectionString=" data source=.\SQLEXPRESS;Integrated               Security=SSPI;AttachDBFilename=|DataDirectory|aspnetdb.mdf; User Instance=true" providerName="System.Data.SqlClient" />
   </connectionStrings>
</configuration>
```

###System.Web.Security.ActiveDirectoryMembershipProvider###

Active Directory Application Mode (ADAM), which is a standalone directory product.

Because the default membership provider is defined in the machine.config files at the SqlMembershipProvider, you must override these settings in your application’s web.config

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="ADConnectionString" connectionString="LDAP://domain.myAdServer.com/CN=Users,DC=domain,DC=testing,DC=com" />
   </connectionStrings>
</configuration>
```

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="ADConnectionString" connectionString="LDAP://domain.myAdServer.com/CN=Users,DC=domain,DC=testing,DC=com" />
   </connectionStrings>
   <system.web>
      <membership defaultProvider="AspNetActiveDirectoryMembershipProvider">
         <providers>
            <add name="AspNetActiveDirectoryMembershipProvider" type="System.Web.Security.ActiveDirectoryMembershipProvider,  System.Web, Version=1.0.3600, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" connectionStringName="ADConnectionString" connectionUsername="UserWithAppropriateRights" connectionPassword="PasswordForUser" connectionProtection="Secure" enablePasswordReset="true" enableSearchMethods="true" requiresQuestionAndAnswer="true" applicationName="/" description="Default AD connection" requiresUniqueEmail="false" clientSearchTimeout="30" serverSearchTimeout="30" attributeMapPasswordQuestion="department" attributeMapPasswordAnswer="division" attributeMapFailedPasswordAnswerCount="singleIntAttribute" attributeMapFailedPasswordAnswerTime="singleLargeIntAttribute" attributeMapFailedPasswordAnswerLockoutTime="singleLargeIntAttribute" attributeMapEmail="mail" attributeMapUsername="userPrincipalName" maxInvalidPasswordAttempts="5" passwordAttemptWindow="10" passwordAnswerAttemptLockoutDuration="30" minRequiredPasswordLength="7" minRequiredNonalphanumericCharacters="1" passwordStrengthRegularExpression="(?=.{6,})(?=(.*\d){1,})(?=(.*\W){1,})" />
         </providers>
      </membership>
   </system.web>
</configuration>
```

you can easily declare the instance in its simplest form, as shown here:

```
<?xml version="1.0" encoding="UTF-8"?>
<membership defaultProvider="AspNetActiveDirectoryMembershipProvider">
   <providers>
      <add name="AspNetActiveDirectoryMembershipProvider" type="System.Web.Security.ActiveDirectoryMembershipProvider,  System.Web, Version=1.0.3600, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" connectionStringName="ADConnectionString" />
   </providers>
</membership>
```

##Role Providers##

After a user is logged in to the system (possibly using the ASP.NET membership system), the ASP.NET role management system enables you to work with the role of that user to authorize him for a particular access to the overall application.

By default, ASP.NET 4.5 offers three providers for the role management system:

- System.Web.Security.SqlRoleProvider: Provides you with the capability to use the ASP.NET role management system to connect to Microsoft’s SQL Server 2005/2008/2012 as well as to Microsoft SQL Server Express Edition.
- System.Web.Security.WindowsTokenRoleProvider: Provides you with the capability to connect the ASP.NET role management system to the built-in Windows security group system.
- System.Web.Security.Authorization StoreRoleProvider: Provides you with the capability to connect the ASP.NET role management system to either an XML file, Active Directory, or in an Active Directory Application Mode (ADAM) store.

classes for role management inherit from the RoleProvider base class,

###System.Web.Security.SqlRoleProvider###

Looking at the SqlRoleProvider instance in the machine.config.comments file, you will notice the syntax

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <roleManager enabled="false" cacheRolesInCookie="false" cookieName=".ASPXROLES" cookieTimeout="30" cookiePath="/" cookieRequireSSL="false" cookieSlidingExpiration="true" cookieProtection="All" defaultProvider="AspNetSqlRoleProvider" createPersistentCookie="false" maxCachedResults="25">
      <providers>
         <clear />
         <add connectionStringName="LocalSqlServer" applicationName="/" name="AspNetSqlRoleProvider" type="System.Web.Security.SqlRoleProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
         <add applicationName="/" name="AspNetWindowsTokenRoleProvider" type="System.Web.Security.WindowsTokenRoleProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
      </providers>
   </roleManager>
</configuration>
```

To connect to the Microsoft SQL Server 2012 instance

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="LocalSqlServer" connectionString="Data Source=127.0.0.1;Integrated Security=SSPI;Initial Catalog=aspnetdb;" />
   </connectionStrings>
   <system.web>
      <roleManager enabled="true" cacheRolesInCookie="true" cookieName=".ASPXROLES" cookieTimeout="30" cookiePath="/" cookieRequireSSL="false" cookieSlidingExpiration="true" cookieProtection="All" defaultProvider="AspNetSqlRoleProvider" createPersistentCookie="false" maxCachedResults="25">
         <providers>
            <clear />
            <add connectionStringName="LocalSqlServer" applicationName="/" name="AspNetSqlRoleProvider" type="System.Web.Security.SqlRoleProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
         </providers>
      </roleManager>
   </system.web>
</configuration>
```

###System.Web.Security.WindowsTokenRoleProvider###

The Windows operating system has a role system built into it. This Windows security group system is an ideal system to use when you are working with intranet-based applications where you might have all users already in defined roles.

This is a read-only provider because ASP.NET is not allowed to modify the settings applied in the Windows security group system.

the only methods you have at your disposal are IsUserInRole and GetUsersInRole.

To configure your WindowsTokenRoleProvider

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <authentication mode="Windows" />
      <roleManager defaultProvider="WindowsProvider" enabled="true" cacheRolesInCookie="false">
         <providers>
            <add name="WindowsProvider" type="System.Web.Security.WindowsTokenRoleProvider" />
         </providers>
      </roleManager>
   </system.web>
</configuration>
```

###System.Web.Security.AuthorizationStoreRoleProvider###

This role provider class enables you to store roles inside of an Authorization Manager policy store. These types of stores are also referred to as AzMan stores.

AuthorizationStoreRoleProvider is a bit limited because it is unable to support any AzMan business rules.

To use AuthorizationStoreRoleProvider, you must first make a connection in your web.config file to the XML data store used by AzMan,

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="LocalPolicyStore" connectionString="msxml://~\App_Data\SampleStore.xml" />
   </connectionStrings>
</configuration>
```

> *Note* that when you work with these XML-based policy files, storing them in the App_Data folder is best.

Files stored in the App_Data folder cannot be pulled up in the browser.

the next step is to configure your AuthorizationStoreRoleProvider instance.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <connectionStrings>
      <add name="MyLocalPolicyStore" connectionString="msxml://~\App_Data\datafilename.xml" />
   </connectionStrings>
   <system.web>
      <authentication mode="Windows" />
      <identity impersonate="true" />
      <roleManager defaultProvider="AuthorizationStoreRoleProvider" enabled="true" cacheRolesInCookie="true" cookieName=".ASPROLES" cookieTimeout="30" cookiePath="/" cookieRequireSSL="false" cookieSlidingExpiration="true" cookieProtection="All">
         <providers>
            <clear />
            <add name="AuthorizationStoreRoleProvider" type="System.Web.Security.AuthorizationStoreRoleProvider" connectionStringName="MyLocalPolicyStore" applicationName="SampleApplication" cacheRefreshInterval="60" scopeName="" />
         </providers>
      </roleManager>
   </system.web>
</configuration>
```

##The Personalization Provider##

the membership system found in ASP.NET, the personalization system (also referred to as the profile system)

This system makes associations between the end user viewing the application and any data points stored centrally that are specific to that user.

ASP.NET provides a single provider for data storage. This provider enables you to use the ASP.NET personalization system to connect to Microsoft’s SQL Server

This single class for the personalization system inherits from the ProfileProvider base class,

define your connection in the web.config file and then associate your SqlProfileProvider

```
<connectionStrings>
   <add name="LocalSqlServer" connectionString="Data Source=127.0.0.1;Integrated Security=SSPI" />
</connectionStrings>

<system.web>
   <profile>
      <providers>
         <clear />
         <add name="AspNetSqlProfileProvider" connectionStringName="LocalSqlServer" applicationName="/" type="System.Web.Profile.SqlProfileProvider, System.Web,                       Version=4.0.0.0, Culture=neutral,                       PublicKeyToken=b03f5f7f11d50a3a" />
      </providers>
      <properties>
         <add name="FirstName" />
         <add name="LastName" />
         <add name="LastVisited" />
         <add name="Age" />
         <add name="Member" />
      </properties>
   </profile>
</system.web>
```

##The SiteMap Provider##

Sitemaps are what ASP.NET uses to provide you with a centralized way of maintaining site navigation.

The sitemap provider lets you interact with this XML file, the .sitemap file,

The provider available for sitemaps is System.Web.XmlSiteMapProvider, which enables you to use the ASP.NET navigation system to connect to an XML-based file.

inherits from the StaticSiteMapProvider base class, which is a partial implementation of the SiteMapProvider base class,

```
<system.web>
   <siteMap defaultProvider="MyXmlSiteMapProvider" enabled="true">
      <providers>
         <add name="MyXmlSiteMapProvider" description="SiteMap provider that reads in .sitemap files." type="System.Web.XmlSiteMapProvider, System.Web, Version=4.0.0.0,                       Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" siteMapFile="AnotherWeb.sitemap" />
      </providers>
   </siteMap>
</system.web>
```

The default filename of the XML file it is looking for is web.sitemap, although you can change this default setting (as you can see in Listing 14-13) by using the siteMapFile attribute within the provider declaration in the web.config file.

##SessionState Providers##

The available modes of storing session state for your users include InProc, StateServer, SQLServer, or even Custom.

Each mode has definite pros and cons associated with it,

This provider model is a bit different from the others discussed so far in this chapter. The SessionStateModule class is a handler provided to load one of the available session state modes:

- System.Web.SessionState.InProcSessionStateStore: Provides you with the capability to store sessions in the same process as the ASP.NET worker process. This is by far the best-performing method of session state management.
- System.Web.SessionState.OutOfProcSessionStateStore: Provides you with the capability to store sessions in a process separate from the ASP.NET worker process. This mode is a little more secure, but a little worse in performance than the InProc mode.
- System.Web.SessionState.SqlSessionStateStore: Provides you with the capability to store sessions in SQL Server. This is by far the most secure method of storing sessions, but it is the worst performing mode of the three available methods.

###System.Web.SessionState.InProcSessionStateStore###

sessions generated are held in the same process as that being used by the ASP.NET worker process (aspnet_wp.exe or w3wp.exe).

best performing,

whenever the worker process is recycled, all the sessions are destroyed.

```
<configuration>
   <system.web>
      <sessionState mode="InProc" />
   </system.web>
</configuration>
```

##System.Web.SessionState.OutOfProcSessionStateStore##

StateServer mode is an out-of-process method of storing session state.

does not perform as well

This makes sense because the method must jump process boundaries to work with the sessions you are employing.

more reliable than running the sessions using InProcSessionStateStore.

If your application’s worker process recycles, the sessions that this application is working with are still maintained.

This capability is vital for those applications that are critically dependent upon sessions.

```
<system.web>
   <sessionState mode="StateServer" stateConnectionString="tcpip=127.0.0.1:42424" />
</system.web>
```

this case, the local server is used, meaning that the sessions are stored on the same machine,

easily stored the sessions on a different server by providing the appropriate IP address

###System.Web.SessionState.SqlSessionStateStore###

This method is definitely the most resilient of the three available modes.

it is also the worst performing

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <sessionState mode="SQLServer" allowCustomSqlDatabase="true" sqlConnectionString="Data Source=127.0.0.1; database=MyCustomASPStateDatabase;Integrated Security=SSPI" />
   </system.web>
</configuration>
```

##Web Event Providers##

in ASP.NET 4.5, more providers are available for the health monitoring system than for any other system.

(errors and other possible triggers)

These events are referred to as web events.

By default, ASP.NET 4.5 offers several possible providers for the health monitoring system:

- System.Web.Management.EventLogWebEventProvider: Provides you with the capability to use the ASP.NET health monitoring system to record security operation errors and all other errors into the Windows event log.
- System.Web.Management.SimpleMailWebEventProvider: Provides you with the capability to use the ASP.NET health monitoring system to send error information in an e-mail.
- System.Web.Management.TemplatedMailWebEventProvider: Similar to the SimpleMailWebEventProvider, the TemplatedMailWebEventProvider class provides you with the capability to send error information in a templated e-mail. Templates are defined using a standard .aspx page.
- System.Web.Management.SqlWebEventProvider: Provides you with the capability to use the ASP.NET health monitoring system to store error information in SQL Server. As with the other SQL providers for the other systems in ASP.NET, the SqlWebEventProvider stores error information in SQL Server Express Edition by default.
- System.Web.Management.TraceWebEventProvider: Provides you with the capability to use the ASP.NET health monitoring system to send error information to the ASP.NET page tracing system.
- System.Web.Management.IisTraceWebEventProvider: Provides you with the capability to use the ASP.NET health monitoring system to send error information to the IIS tracing system.
- System.Web.Management.WmiWebEventProvider: Provides you with the capability to connect the ASP.NET health monitoring system, the Windows Management Instrumentation (WMI) event provider.

inherit from either the WebEventProvider base class, or the BufferedWebEventProvider (which, in turn, inherits from the WebEventProvider),

The big difference is that the WebEventProvider writes events as they happen, whereas the BufferedWebEventProvider holds web events until a collection of them is made.

###System.Web.Management.EventLogWebEventProvider###

By default, the health monitoring system uses the Windows event log to record the items that are already specified in the server’s configuration files or items you have specified in the web.config file of your application.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <healthMonitoring heartbeatInterval="0" enabled="true">
         <bufferModes>
            <!-- Removed for clarity -->
         </bufferModes>
         <providers>
            <clear />
            <add name="EventLogProvider" type="System.Web.Management.EventLogWebEventProvider,                       System.Web,Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
            <!-- Removed for clarity -->
         </providers>
         <profiles>
            <!-- Removed for clarity -->
         </profiles>
         <rules>
            <add name="All Errors Default" eventName="All Errors" provider="EventLogProvider" profile="Default" minInstances="1" maxLimit="Infinite" minInterval="00:01:00" custom="" />
            <add name="Failure Audits Default" eventName="Failure Audits" provider="EventLogProvider" profile="Default" minInstances="1" maxLimit="Infinite" minInterval="00:01:00" custom="" />
         </rules>
         <eventMappings>
            <!-- Removed for clarity -->
         </eventMappings>
      </healthMonitoring>
   </system.web>
</configuration>
```

a lot of possible settings can be applied in the health monitoring system.

The rules section of the listing, you can see that specific error types are assigned to be monitored.

###System.Web.Management.SimpleMailWebEventProvider###

```
<configuration>
   <system.web>
      <healthMonitoring heartbeatInterval="0" enabled="true">
         <bufferModes>
            <add name="Website Error Notification" maxBufferSize="100" maxFlushSize="20" urgentFlushThreshold="1" regularFlushInterval="00:01:00" urgentFlushInterval="00:01:00" maxBufferThreads="1" />
         </bufferModes>
         <providers>
            <clear />
            <add name="EventLogProvider" type="System.Web.Management.EventLogWebEventProvider,                       System.Web,Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
            <add name="SimpleMailProvider" type="System.Web.Management.SimpleMailWebEventProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" from="website@company.com" to="admin@company.com" cc="adminLevel2@company.com" bcc="director@company.com" bodyHeader="Warning!" bodyFooter="Please investigate ASAP." subjectPrefix="Action required." buffer="true" bufferMode="Website Error Notification" maxEventLength="4096" maxMessagesPerNotification="1" />
         </providers>
         <profiles>
            <!-- Removed for clarity -->
         </profiles>
         <rules>
            <add name="All Errors Default" eventName="All Errors" provider="EventLogProvider" profile="Default" minInstances="1" maxLimit="Infinite" minInterval="00:01:00" custom="" />
            <add name="Failure Audits Default" eventName="Failure Audits" provider="EventLogProvider" profile="Default" minInstances="1" maxLimit="Infinite" minInterval="00:01:00" custom="" />
            <add name="All Errors Simple Mail" eventName="All Errors" provider="SimpleMailProvider" profile="Default" />
            <add name="Failure Audits Default" eventName="Failure Audits" provider="SimpleMailProvider" profile="Default" />
         </rules>
         <eventMappings>
            <!-- Removed for clarity -->
         </eventMappings>
      </healthMonitoring>
   </system.web>
</configuration>
```

SimpleMailWebEventProvider is that this class inherits from the BufferedWebEventProvider instead of from the WebEventProvider as the EventLogWebEventProvider does.

The bufferModes section defines how the buffering works.

###System.Web.Management.TemplatedMailWebEventProvider###

To send out a more artistically crafted e-mail that contains even more information, you can use the TemplatedMailWebEventProvider.

```
<providers>
   <clear />
   <add name="EventLogProvider" type="System.Web.Management.EventLogWebEventProvider,           System.Web,Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
   <add name="TemplatedMailProvider" type="System.Web.Management.TemplatedMailWebEventProvider,           System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" template="../mailtemplates/errornotification.aspx" from="website@company.com" to="admin@company.com" cc="adminLevel2@company.com" bcc="director@company.com" bodyHeader="Warning!" bodyFooter="Please investigate ASAP." subjectPrefix="Action required." buffer="true" bufferMode="Website Error Notification" maxEventLength="4096" maxMessagesPerNotification="1" />
</providers>

```

The TemplatedMailWebEventProvider has a template attribute that specifies the location of the template to use for the e-mail

###System.Web.Management.SqlWebEventProvider###

When your application is running in a web farm, you might want all the errors that occur across the farm to be written to a single location.

```
<configuration>
   <connectionStrings>
      <add name="LocalSqlServer" allowCustomSqlDatabase="true" connectionString="Data Source=127.0.0.1;Integrated Security=SSPI" />
   </connectionStrings>
</configuration>
```

the next step is to use this connection in your SqlWebEventProvider declaration in the web.config

```
<configuration>
   <system.web>
      <healthMonitoring>
         <!-- Other nodes removed for clarity -->
         <providers>
            <clear />
            <add name="SqlWebEventProvider" type="System.Web.Management.SqlWebEventProvider,System.Web" connectionStringName="LocalSqlServer" maxEventDetailsLength="1073741823" buffer="true" bufferMode="SQL Analysis" />
         </providers>
      </healthMonitoring>
   </system.web>
</configuration>
```

the SqlWebEventProvider inherits from the BufferedWebEventProvider.

You trigger these batches by using the buffer and bufferMode attributes

###System.Web.Management.TraceWebEventProvider###

Tracing enables you to view details on the request, application state, cookies, the control tree, the form collection, and more.

```
<configuration>
   <system.web>
      <healthMonitoring>
         <!-- Other nodes removed for clarity -->
         <providers>
            <clear />
            <add name="TraceWebEventProvider" type="System.Web.Management.TraceWebEventProvider,System.Web" maxEventLength="4096" maxMessagesPerNotification="1" />
         </providers>
      </healthMonitoring>
   </system.web>
</configuration>
```

Remember, even with the provider in place, you must assign the provider to the particular errors you want to trap. You do so through the <rules> section of the health monitoring system.

The IisTraceWebEventProvider is the same, except that the tracing information is sent to IIS rather than to the ASP.NET tracing system.

###System.Web.Management.WmiWebEventProvider###

This provider enables you to map any web events that come from the health monitoring system to Windows Management Instrumentation (WMI) events.

When you pass events to the WMI subsystem, you can represent the events as objects.

```
<configuration>
   <system.web>
      <healthMonitoring>
         <!-- Other nodes removed for clarity -->
         <providers>
            <clear />
            <add name="EventLogProvider" type="System.Web.Management.EventLogWebEventProvider,                       System.Web,Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
            <add connectionStringName="LocalSqlServer" maxEventDetailsLength="1073741823" buffer="false" bufferMode="Notification" name="SqlWebEventProvider" type="System.Web.Management.SqlWebEventProvider, System.Web,Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
            <add name="WmiWebEventProvider" type="System.Web.Management.WmiWebEventProvider,                       System.Web,Version=4.0.0.0,Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
         </providers>
      </healthMonitoring>
   </system.web>
</configuration>
```


##Configuration Providers##

A wonderful feature of ASP.NET 4.5 is that it enables you to actually encrypt sections of your configuration files.

This is an ideal way of keeping sensitive configuration information away from the eyes of everyone who peruses the file repository of your application.

By default, ASP.NET 4.5 provides two possible configuration providers out of the box:

- System.Configuration.DpapiProtectedConfigurationProvider: Provides you with the capability to encrypt and decrypt configuration sections using the Data Protection API (DPAPI) that is built into the Windows operating system.
- System.Configuration.RsaProtectedConfigurationProvider: Provides you with the capability to encrypt and decrypt configuration sections using an RSA public-key encryption algorithm.

These two providers used for encryption and decryption of the configuration sections inherit from the ProtectedConfigurationProvider base class,

###System.Configuration.DpapiProtectedConfigurationProvider###

The DpapiProtectedConfigurationProvider class enables you to encrypt and decrypt configuration sections using the Windows Data Protection API (DPAPI).

This provider enables you to perform these encryption and decryption tasks on a per-machine basis.

This provider is not good to use on a web farm.

If you look in the machine.config on your server, you see a definition in place for both the DpapiProtectedConfigurationProvider and the RsaProtectedConfigurationProvider.

```
<configProtectedData defaultProvider="DataProtectionConfigurationProvider">
   <providers>
      <clear />
      <add name="DataProtectionConfigurationProvider"  type="System.Configuration.DpapiProtectedConfigurationProvider, System.Configuration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" description="Uses CryptProtectData and CryptUnProtectData Windows APIs to encrypt and decrypt" useMachineProtection="true" keyEntropy="RandomStringValue" />
   </providers>
</configProtectedData>
```

Note that this configuration section sits outside the system.web section.

The useMachineProtection attribute by default is set to true, meaning that all applications in the server share the same means of encrypting and decrypting configuration sections. This also means that applications residing on the same machine can perform encryption and decryption against each other. Setting the useMachineProtection attribute to false means that the encryption and decryption are done on an application basis only. This setting also means that you must change the account that the application runs against so it is different from the other applications on the server.

The keyEntropy attribute provides a lightweight approach to prevent applications from decrypting each other’s configuration sections. The keyEntropy attribute can take any random string value to take part in the encryption and decryption processes.

###System.Configuration.RsaProtectedConfigurationProvider###

```
<configuration>
   <configProtectedData defaultProvider="RsaProtectedConfigurationProvider">
      <providers>
         <add name="RsaProtectedConfigurationProvider" type="System.Configuration.RsaProtectedConfigurationProvider, System.Configuration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" description="Uses RsaCryptoServiceProvider to encrypt and decrypt" keyContainerName="NetFrameworkConfigurationKey" cspProviderName="" useMachineContainer="true" useOAEP="false" />
         <add name="DataProtectionConfigurationProvider" type="System.Configuration.DpapiProtectedConfigurationProvider,System.Configuration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" description="Uses CryptProtectData and CryptUnProtectData Windows APIs to encrypt and decrypt" useMachineProtection="true" keyEntropy="" />
      </providers>
   </configProtectedData>
</configuration>
```

The RsaProtectedConfigurationProvider uses Triple-DES encryption to encrypt the specified sections of the configuration file.

The keyContainerName attribute is the defined key container that is used for the encryption/decryption process. By default, this provider uses the default key container built into the .NET Framework, but you can easily switch an application to another key container via this attribute.

The cspProviderName attribute is used only if you have specified a custom cryptographic service provider (CSP) to use with the Windows Cryptographic API (CAPI). If so, you specify the name of the CSP as the value of the cspProviderName attribute.

The useMachineContainer attribute enables you to specify that you want either a machine-wide or user-specific key container. This attribute is quite similar to the useMachineProtection attribute found in the DpapiProtectedConfigurationProvider.

The useOAEP attribute specifies whether to turn on the Optional Asymmetric Encryption and Padding (OAEP) capability when performing the encryption/decryption process.

#15 Extending the Provider Model# {Chap15}

##PROVIDERS ARE ONE TIER IN A LARGER ARCHITECTURE##

They enable you to use the various controls and APIs that compose these systems in a uniform manner regardless of the underlying data storage method of the provider.

##MODIFYING THROUGH ATTRIBUTE-BASED PROGRAMMING##

Probably the easiest way to modify the behaviors of the providers built into the .NET Framework 4.5 is through attribute-based programming.

This chapter provides an example of how to modify the SqlMembershipProvider.

##Simpler Password Structures through the SqlMembershipProvider##

When you create users with the SqlMembershipProvider instance, whether you are using SQL Server Express or Microsoft’s SQL Server 2005, 2008, or 2012, notice that the password required to create a user is a “semi-strong” password.

This is evident when you create a user through the ASP.NET Web Site Administration Tool, as

the minimum password length is seven characters and that at least one non-alphanumeric character is required.

This kind of behavior is specified by the membership provider and not by the controls or the API used in the membership system.

You find the definition of the requirements in the machine.config.comments file located at C:\WINDOWS\Microsoft.NET\Framework\v4.0.xxxxx\CONFIG.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <membership defaultProvider="AspNetSqlMembershipProvider" userIsOnlineTimeWindow="15" hashAlgorithmType="">
         <providers>
            <clear />
            <add connectionStringName="LocalSqlServer" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="true" applicationName="/" requiresUniqueEmail="false" passwordFormat="Hashed" maxInvalidPasswordAttempts="5" minRequiredPasswordLength="7" minRequiredNonalphanumericCharacters="1" passwordAttemptWindow="10" passwordStrengthRegularExpression="" name="AspNetSqlMembershipProvider" type="System.Web.Security.SqlMembershipProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
         </providers>
      </membership>
   </system.web>
</configuration>
```

the minRequiredPasswordLength and the minRequiredNonalphanumericCharacters attributes define this behavior.

Redefining a provider in the application’s web.config file is a fairly simple process.

machine.config

couple of options

redefine the named instance of the SqlMembershipProvider

must clear the previous defined instance

using the  lt clear / gt node within the <providers> section.

you redefine this provider using the add element.

The other approach to defining your own instance of the SqlMembershipProvider is to give the provider defined in the add element a unique value for the name attribute. If you take this approach, you must specify this new named instance as the default provider of the membership system using the defaultProvider attribute.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <authentication mode="Forms" />
      <membership defaultProvider="JasonsSqlMembershipProvider">
         <providers>
            <add connectionStringName="LocalSqlServer" enablePasswordRetrieval="false" enablePasswordReset="true" requiresQuestionAndAnswer="true" applicationName="/" requiresUniqueEmail="false" passwordFormat="Hashed" maxInvalidPasswordAttempts="5" minRequiredPasswordLength="4" minRequiredNonalphanumericCharacters="0" passwordAttemptWindow="10" name="JasonsSqlMembershipProvider" type="System.Web.Security.SqlMembershipProvider, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" />
         </providers>
      </membership>
   </system.web>
</configuration>
```

##Stronger Password Structures through the SqlMembershipProvider##

One approach is to use the same minRequiredPasswordLength and minRequiredNonalphanumericCharacters attributes

Another option is to use the passwordStrengthRegularExpression attribute.

For an example of using this attribute, suppose you require that the user’s password contains the following: At least one (1) uppercase letter At least one (1) lowercase letter At least one (1) number At least one (1) special character At least eight (8) characters in length

```
passwordStrengthRegularExpression="(?=^.{8,}$)(?=.*\d)(?=.*\W+)(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$
```

##EXAMINING PROVIDERBASE##

All the providers derive in some fashion from the ProviderBase class, found in the System.Configuration.Provider namespace. ProviderBase is an abstract class used to define a base template for inheriting providers.

there is not much to this class. It is really just a root class for a provider that exists to allow providers to initialize themselves.

The Name property is used to provide a friendly name, such as AspNetSqlRoleProvider. The Description property is used to enable a textual description of the provider, which can then be used later by any administration tools.

The main item in the ProviderBase class is the Initialize()

```
public virtual void Initialize(string name, NameValueCollection config)
```

These name/value pairs are the items that are also defined in the provider declaration in the configuration file

when you are creating your own customizations for working with the ASP.NET membership system, you have several options available to you.

First, you can simply create your own provider that implements the ProviderBase.

you can implement the MembershipProvider instance (a better approach) and work from the model it provides.

Finally, if you are working with SQL Server in some capacity and simply want to change the underlying behaviors of this provider, you can inherit from SqlMembershipProvider and modify the behavior of the class from this inheritance.

##BUILDING YOUR OWN PROVIDERS##

The example demonstrates building a membership provider that works from an XML file.

You can derive from a couple of classes — the SqlMembershipProvider class or the MembershipProvider class

In this case, basing everything on the MembershipProvider class is best.

###Creating the CustomProviders Application###

```
public class XmlMembershipProvider : MembershipProvider
{
}
```

###Constructing the Class Skeleton Required###

If you are using Visual Basic, all you have to do is press the Enter key. In C#, all you have to do is right-click the MembershipProvider statement in your code and simply select Implement Abstract Class from the available options.

```
namespace Chapter15_CustomProviders_CS.App_Code
{
  public class XmlMembershipProvider : MembershipProvider
  {
	// tonnes of non implemented members
  }
}
```


###Creating the XML User Data Store###

```
<?xml version="1.0" encoding="UTF-8"?>
<Users>
   <User>
      <Username>JasonGaylord</Username>
      <Password>Reindeer</Password>
      <Email>jason@jasongaylord.com</Email>
      <DateCreated>12/10/2012</DateCreated>
   </User>
   <User>
      <Username>ScottHanselman</Username>
      <Password>YabbaDabbaDo</Password>
      <Email>scott@outlook.com</Email>
      <DateCreated>12/02/2012</DateCreated>
   </User>
   <User>
      <Username>ChristianWenz</Username>
      <Password>BamBam</Password>
      <Email>christian@outlook.com</Email>
      <DateCreated>01/11/2013</DateCreated>
   </User>
</Users>
```

Defining the Provider Instance in the web.config File

you must override this setting and establish a new default provider.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <compilation debug="true" targetFramework="4.5" />
      <httpRuntime targetFramework="4.5" />
      <authentication mode="Forms" />
      <membership defaultProvider="XmlFileProvider">
         <providers>
            <add name="XmlFileProvider" type="XmlMembershipProvider" xmlUserDatabaseFile="/App_Data/Users.xml" />
         </providers>
      </membership>
   </system.web>
</configuration>
```

> *NOTE* The provider type may need a fully qualified class name, meaning that the class name is preceded with the appropriate namespace.

Beyond the attributes already used so far, you can create any attribute in your provider declaration that you want.

however, you must address the attributes in your provider and act upon the values that are provided with the attributes.

Not Implementing Methods and Properties of the MembershipProvider Class

Now, turn your attention to the XmlMembershipProvider class.

You are not required to make any real use of the methods contained in this skeleton; instead, you can simply build-out only the methods you are interested in working with.

```
public override bool ChangePassword(string username, string oldPassword, string newPassword)
{
    throw new NotSupportedException();
}
```

In this case, a NotSupportedException is thrown

If you do not want to throw an actual exception, you can simply return a false value and not take any other action,

```
public override bool ChangePassword(string username, string oldPassword, string newPassword)
{
    return false;   
}
```

###Implementing Methods and Properties of the MembershipProvider Class###

```
public class XmlMembershipProvider : MembershipProvider
{
    private string _AppName;
    private Dictionary<string, MembershipUser> _MyUsers;
    private string _FileName;
    // Code removed for clarity
}
```

###Defining the ApplicationName Property###

```
public override string ApplicationName
{
  get
  {
    return _AppName;
  }       
  set
  {
    _AppName = value;
  }
}
```

###Extending the Initialize() Method###

reads in the custom attribute and its associated values as defined in the provider declaration in the web.config file.

Overriding this method is not a requirement, and therefore, you won’t see it in the declaration of the class skeleton.

```
public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
{
    base.Initialize(name, config);
}
```

The Initialize() method takes two parameters. The first parameter is the name of the parameter. The second is the name/value collection from the provider declaration in the web.config file. This collection includes all the attributes and their values, such as the xmlUserDatabaseFile attribute and the value of the name of the XML file that holds the user information.

```
public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)   
{
    base.Initialize(name, config);
    _AppName = config["applicationName"];
    if (String.IsNullOrEmpty(_AppName))
    {
        _AppName = "/";
    }
    _FileName = config["xmlUserDatabaseFile"];
    if (String.IsNullOrEmpty(_FileName))
    {
        _FileName = "/App_Data/Users.xml";
    }
}
```

###Validating Users###

One of the more important features of the membership provider is that it validates users (it authenticates them). The validation of users is accomplished through the ASP.NET Login server control. This control, in turn, makes use of the Membership.ValidateUser() method that ends up using the ValidateUser() method in the XmlMembershipProvider class.

```
public override bool ValidateUser(string username, string password)
{
    if (String.IsNullOrEmpty(username) || String.IsNullOrEmpty(password))
    {
        return false;
    }

    try
    {
        ReadUserFile();
        MembershipUser mu;
        if (_MyUsers.TryGetValue(username.ToLower(), out mu))
        {
            if (mu.Comment == password)
            {
                return true;
            }
        }
        return false;
    }
    catch (Exception ex)
    {
        throw new Exception(ex.Message.ToString());
    }
}
```

_MyUsers variable is an instance of the Dictionary generic class. The key is a lowercase string value of the username, whereas the value is of type MembershipUser, a type provided via the membership system.

The MembershipUser does not contain the password of the user, and for this reason, the ReadUserFile() method makes the user’s password the value of the Comment property of the MembershipUser class.

###Building the ReadUserFile() Method###

```
private void ReadUserFile()
{
    if (_MyUsers == null)
    {
        lock (this)
        {
            _MyUsers = new Dictionary<string, MembershipUser>();
            var query = from users in
            XElement.Load(HostingEnvironment.MapPath(_FileName)).Elements("User")
            select users;
            
            foreach (var user in query)
            {
                MembershipUser mu = new MembershipUser(
                Name, 
                user.Element("Username").Value,
                null,
                user.Element("Email").Value,
                String.Empty,
                user.Element("Password").Value,
                true,
                false,
                DateTime.Parse(user.Element("DateCreated").Value),
                DateTime.Now,
                DateTime.Now,
                DateTime.Now,
                DateTime.Now);
                
                _MyUsers.Add(mu.UserName.ToLower(), mu);
            }
       }
    }
}
```

> *NOTE* You need to import the System.Xml, System.Xml.Linq, and System.Web.Hosting namespaces for this code to work.

The first action of the ReadUserFile() method is to place a lock on the action that is going to occur in the thread being run. This is a unique feature in ASP.NET. When you are writing your own providers, be sure you use thread-safe code.

Unlike an HttpHandler, only one instance of a provider is created and utilized by your ASP.NET application.

Because more than one request might be coming into the provider instance at the same time, you should create the provider in a thread-safe manner.

To lock the access, use the SyncLock (for Visual Basic) and the lock (for C#) statements

The MembershipUser object takes the following arguments:

```
public MembershipUser
(
  string providerName,
  string name,
  Object providerUserKey,
  string email,
  string passwordQuestion,
  string comment,
  bool isApproved,
  bool isLockedOut,
  DateTime creationDate,
  DateTime lastLoginDate,
  DateTime lastActivityDate,
  DateTime lastPasswordChangedDate,
  DateTime lastLockoutDate
)
```

###Using the XmlMembershipProvider for User Login###

create a Login.aspx page, and place a single Login server control on the page.

changes to the web.config file to allow for Forms authentication and to deny all anonymous users to view any of the pages.

```
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
   <system.web>
      <compilation debug="true" targetFramework="4.5" />
      <httpRuntime targetFramework="4.5" />
      <authentication mode="Forms" />
      <authorization>
         <deny users="?" />
      </authorization>
      <!-- Other settings removed for clarity -->
   </system.web>
</configuration>
```

run the Default.aspx page, and you are immediately directed to the Login.aspx

It is as simple as that!

The nice thing with the provider-based model found in ASP.NET 4.5 is that the controls that are working with the providers don’t know the difference when these large changes to the underlying provider are made.

the Login server control, the control is still simply making use of the Membership.ValidateUser() method, which is working with the XmlMembershipProvider

##EXTENDING PREEXISTING PROVIDERS##

In addition to building your own providers from one of the base abstract classes such as MembershipProvider, another option is to simply extend one of the preexisting providers that come with ASP.NET.

The other advantage of working from a preexisting provider is that no need exists to override everything the provider exposes. Instead, if you are interested in changing only a particular behavior of a built-in provider, you might only need to override a couple of the exposed methods and nothing more, making this approach rather simple and quick to achieve in your application.

Limiting Role Capabilities with a New LimitedSqlRoleProvider Provider

utilize the role management system in your ASP.NET

Suppose you also want to limit what roles developers can create in their applications, and you want to remove their capability to add users to a particular role in the system.

deriving your provider from SqlRoleProvider and simply changing the behavior of a few methods

```
using System.Collections.Generic;   
using System.Linq;   
using System.Web;   
using System.Web.Security;      
namespace Chapter15_CustomProviders_CS.App_Code
{
    public class LimitedSqlRoleProvider : SqlRoleProvider
    {
    }
}
```

For this example, you only override the CreateRole(), AddUsersToRoles(), and DeleteRole() methods. They are described next.

###The CreateRole() Method###

The CreateRole() method in the SqlRoleProvider class enables developers to add any role to the system.

```
public override void CreateRole(string roleName)
{
    if (roleName == "Administrator" || roleName == "Manager")
    {
        base.CreateRole(roleName);
    }
    else
    {
        throw new ProviderException("Role creation limited to only Administrator and Manager");
    }
}
```

> *NOTE* You need to import the System.Configuration.Provider namespace for this code to work.

###The DeleteRole() Method###


```
public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
{
    return false;
}
```

Looking at the DeleteRole() method, you can see that deleting any role is completely disallowed.

###The AddUsersToRoles() Method###

```
public override void AddUsersToRoles(string[] usernames, string[] roleNames) 
{
    foreach (string roleItem in roleNames)
    {
        if (roleItem == "Administrator")
        {
            throw new ProviderException("You are not authorized to add any users" + " to the Administrator role");
        }     
    }
}
```

```
base.AddUsersToRoles(usernames, roleNames); }
```

Using the New LimitedSqlRoleProvider Provider

make some modifications to the web.config

```
<configuration>
   <system.web>
      <roleManager defaultProvider="LimitedProvider" enabled="true">
         <providers>
            <add connectionStringName="LocalSqlServer" applicationName="/" name="LimitedProvider" type="LimitedSqlRoleProvider" />
         </providers>
      </roleManager>
   </system.web>
</configuration>
```


```
Roles.CreateRole(TextBox1.Text);
```

```
Roles.AddUserToRole(TextBox1.Text, TextBox2.Text);
```


