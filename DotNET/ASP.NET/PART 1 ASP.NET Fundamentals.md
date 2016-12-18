#ASP.NET Web Forms Structure#

PostBackUrl property. This property takes a string value that points to the location of the file to which this page should post.

```
pp_Textbox1 = CType(PreviousPage.FindControl("Textbox1"), TextBox)
```


```
<%@ PreviousPageType VirtualPath="Page1.aspx" %>
```

To be able to work with the properties that Page1.aspx exposes, you have to strongly type the PreviousPage property to Page1.aspx. To do this, you use the PreviousPageType directive.

The IsCrossPagePostBack property enables you to check whether the request is from Page1.aspx.

If PreviousPage IsNot Nothing AndAlso PreviousPage.IsCrossPagePostBack Then

##App_Code Folder##

The App_Code folder is meant to store your classes, .wsdl files, and typed data sets.

The nice thing about the App_Code folder is that when you place something inside it, Visual Studio 2012 automatically detects this and compiles it if it is a class (.vb or .cs), automatically creates your XML web service proxy class (from the .wsdl file), or automatically creates a typed data set for you from your .xsd files.

The class files placed within the App_Code folder are not required to use a specific language. This means that even if all the pages of the solution are written in Visual Basic, the Calculator class in the App_Code folder of the solution can be built in C# (Calculator.cs).

Because all the classes contained in this folder are built into a single assembly, you cannot have classes of different languages sitting in the root App_Code folder,

Two classes made up of different languages in the App_Code folder (as shown here) causes an error to be thrown.

Therefore, to be able to work with multiple languages in your App_Code folder, you must make some changes to the folder structure and to the web.config file.

\App_Code
  \VB
    Add.vb
  \CS
    Subtract.cs

```
<compilation debug="false" targetFramework="4.5">
    <codeSubDirectories>
        <add directoryName="VB"></add>
        <add directoryName="CS"></add>
    </codeSubDirectories>
</compilation>

##App_Data Folder##

The App_Data folder holds the data stores utilized by the application.

The App_Data folder can contain Microsoft SQL Express files (.mdf files), Microsoft SQL Server Compact files (.sdf files), XML files, and more.

The user account utilized by your application will have read and write access to any of the files contained within the App_Data folder.

Another reason for storing all your data files in this folder is that much of the ASP.NET system — from the membership and role-management systems to the GUI tools, such as the ASP.NET MMC snap-in and ASP.NET Web Site Administration Tool — is built to work with the App_Data folder.

##App_GlobalResources Folder##

Resource files are string tables that can serve as data dictionaries for your applications when these applications require changes to content based on things such as changes in culture.

##App_LocalResources Folder##

Resources that can be used for a single .aspx page.

Default.aspx.resx Default.aspx.fi.resx

By default, the Default.aspx.resx resource file is used if another match is not found.

If the client is using a culture specification of fi-FI (Finnish), however, the Default.aspx.fi.resx file is used instead.

##App_WebReferences Folder##

The App_WebReferences folder is a new name for the previous Web References folder that was used in versions of ASP.NET prior to ASP.NET 3.5. Now you can use the App_WebReferences folder and have automatic access to the remote web services referenced from your application. Chapter 13 covers web services in ASP.NET.

##App_Browsers Folder##

The App_Browsers folder holds .browser files, which are XML files used to identity the browsers making requests to the application and understanding the capabilities these browsers have.

You can find a list of globally accessible .browser files at C:\Windows\Microsoft.NET\Framework\v4.0.xxxxx\Config\Browsers. In addition, if you want to change any part of these default browser definition files, just copy the appropriate .browser file from the Browsers folder to your application’s App_Browsers folder and change the definition.

When an ASP.NET page is referenced in the browser for the first time, the request is passed to the ASP.NET parser that creates the class file in the language of the page.

It is passed to the ASP.NET parser based on the file’s extension (.aspx) because ASP.NET realizes that this file extension type is meant for its handling and processing. After the class file has been created, the class file is compiled into a DLL and then written to the disk of the web server. At this point, the DLL is instantiated and processed, and an output is generated for the initial requester of the ASP.NET page. This is detailed in Figure 3-11.

On the next request, great things happen. Instead of going through the entire process again for the second and respective requests, the request simply causes an instantiation of the already-created DLL, which sends out a response to the requester.

This was quite a pain if you had a larger site and did not want your end users to experience the extreme lag that occurs when an .aspx page is referenced for the first time after compilation.

ASP.NET provides a few ways to precompile your entire application with a single command that you can issue through a command line.

To precompile your entire ASP.NET application, you must use the aspnet_compiler.exe tool that comes with ASP.NET.

```
aspnet_compiler -p "C:\Inetpub\wwwroot\WROX" -v none
```

> *NOTE* IIS 8 on Windows 8 and Windows Server 2012 includes a feature for Application Initialization, which is very similar to precompiling your application using the aspnet_compiler.exe utility. For more information, search online for IIS8 Application Initialization.

You can also use it to find errors on any of the ASP.NET pages in your application.

The next precompilation option is commonly referred to as precompilation for deployment.

This outstanding capability of ASP.NET enables you to compile your application down to some DLLs, which can then be deployed to customers, partners, or elsewhere for your own

This means that your website code is completely removed and placed in the DLL when deployed.

```
aspnet_compiler -v [Application Name] -p [Physical Location] [Target]
```

```
aspnet_compiler -v /ThomsonReuters -p C:\Websites\ThomsonReuters C:\Wrox
```

You see all the files and the file structures that were in the original application. However, if you look at the content of one of the files, notice that the file is simply a placeholder. In the actual file, you find the following comment:

This is a marker file generated by the precompilation tool    and should not be deleted!

> *Note* that this compilation process does not compile every type of web file. In fact, it compiles only the ASP.NET-specific file types and leaves out of the compilation process the following types of files: HTML files XML files XSD files web.config files Text files

##BUILD PROVIDERS##

Which file types are compiled in the App_Code folder? As with most things in ASP.NET, this is determined through settings applied in a configuration file.

```
<buildProviders>
    <add extension=".aspx" type="System.Web.Compilation.PageBuildProvider" />
    <add extension=".ascx" type="System.Web.Compilation.UserControlBuildProvider" />
    <add extension=".master"


build provider is simply a class that inherits from System.Web.Compilation.BuildProvider.

The ForceCopyBuildProvider copies only those files for deployment that use the defined extension.

Any .js files are simply copied and not included in the compilation process (which makes sense for JavaScript files). You can add other file types that you want to be a part of this copy process with the command shown here:

```
<add extension=".chm" type="System.Web.Compilation.ForceCopyBuildProvider" />
```

the IgnoreFileBuildProvider class. This provider causes the defined file type to be ignored in the deployment or compilation process.

Visual Studio will not copy, compile, or deploy any file of that type.

```
<add extension=".vsd" type="System.Web.Compilation.IgnoreFileBuildProvider" />
```

##GLOBAL.ASAX##

This file is used by the application to hold application-level events, objects, and variables — all of which are accessible application-wide.

- Application_Start: Called when the application receives its very first request.
- Session_Start: Similar to the Application_Start event except that this event is fired when an individual user accesses the application for the first time.
- Application_BeginRequest event is triggered before each request that comes its way.
- Application_AuthenticateRequest: Triggered for each request and enables you to set up custom authentications for a request.
- Application_Error: Triggered when an error is thrown anywhere in the application by any user of the application.
- Session_End: When running in InProc mode, this event is triggered when a user leaves the application.
- Application_End: Triggered when the application comes to an end. This is an event that most ASP.NET developers won’t use that often because ASP.NET does such a good job of closing and cleaning up any objects that are left around.

The Global.asax file allows for the following directives:

- @Application 
- @Assembly
- @Import
