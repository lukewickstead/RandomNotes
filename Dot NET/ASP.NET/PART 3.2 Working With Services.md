PART III B Working with Services

This chapter looks at building XML Web Services and how you can consume XML web service interfaces and integrate them into your ASP.NET applications.

#COMMUNICATION BETWEEN DISPARATE SYSTEMS#

XML has its roots in the Standard Generalized Markup Language (SGML), which was created in 1986. Because SGML was so complex, something a bit simpler was needed — thus, the birth of XML.

Vendors and the industry as a whole soon realized that XML needed a specific structure that put some rules in place to clarify communication.

The industry settled on using Simple Object Access Protocol (SOAP) to make the standard XML structure work.

Previous attempts to solve the communication problem that arose included component technologies such as Distributed Component Object Model (DCOM), Remote Method Invocation (RMI), Common Object Request Broker Architecture (CORBA), and Internet Inter-ORB Protocol (IIOP).

SOAP enables you to expose and consume complex data structures, which can include items such as DataSets, or just tables of data that have all their relations in place.

The DataSets you send or consume can flow over the same Internet wires (HTTP), thereby bypassing many firewalls (as they move through port 80).

An example SOAP 1.2 request

```
POST /WebService.asmx HTTP/1.1   
Host: localhost   
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 19   
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
 xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <HelloWorld xmlns="http://tempuri.org/" />
  </soap12:Body>
</soap12:Envelope>
```

The request is sent to the web service to invoke the HelloWorld WebMethod

The SOAP response from the web service.

```
HTTP/1.1 200 OK     
Content-Type: application/soap+xml; charset=utf-8     
Content-Length: 14     
<?xml version="1.0" encoding="utf-8"?>
  <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"       
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"       
    xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">         
  <soap12:Body>             
    <HelloWorldResponse xmlns="http://tempuri.org/">                 
      <HelloWorldResult>Hello World </HelloWorldResult>             
    </HelloWorldResponse>         
  </soap12:Body>     
</soap12:Envelope>
```

A SOAP message uses a root node of <soap:Envelope> that contains the <soap:Body> or the body of the SOAP message.

Other elements that can be contained in the SOAP message include a SOAP header, soap:Header, and a SOAP fault, soap:Fault elements.

> *NOTE* For more information about the structure of a SOAP message, be sure to check out the SOAP specifications. You can find them at the W3C website, www.w3.org/tr/soap

#AMSX SERVICES: BUILDING A SIMPLE XML WEB SERVICE#

Make one or more methods from a class you create that is enabled for SOAP communication.

Once the project is created, right-click to add a new file to the project. Select Web Service (WebService.asmx)

> #WARNING# The next few pages of this chapter focus on ASMX Web Services. In 2009, ASMX Web Services were marked as legacy. Therefore, the code found within will not be updated with future ASP.NET releases (the exception would be a security update). However, the information has been included to help with the support of existing ASMX Web Services.

> *NOTE* ASP.NET Web Services are the original method of creating web services using ASP.NET. These are commonly called “ASMX services” in the community as opposed to two other methods, WCF and WebAPI, which are discussed later in this chapter.

##The WebService Page Directive##

Open the WebService.asmx file in Visual Studio, and you see that the file contains only the WebService page directive,

```
<%@ WebService Language="C#" CodeBehind="~/App_Code/WebService.cs" Class="WebService" %>
```

For .asmx web services, you use the @WebService directive instead of the @Page directive.

The simple @WebService directive has only four possible attributes:

Class: Required. It specifies the class used to define the methods and data types visible to the XML web service clients.

- CodeBehind: Required only when you are working with an XML web service file using the code-behind model. It enables you to work with web services in two separate and more manageable pieces instead of a single file. The CodeBehind attribute takes a string value that represents the physical location of the second piece of the web service — the class file containing all the web service logic. In ASP.NET, placing the code-behind files in the App_Code folder is best, starting with the default web service created by Visual Studio when you initially opened the web service project.
- Debug: Optional. It takes a setting of either True or False. If the Debug attribute is set to True, the XML web service is compiled with debug symbols in place; setting the value to False ensures that the web service is compiled without the debug symbols in place.
- Language: Required. It specifies the language that is used for the web service.

Looking at the Base Web Service Class File WebService.cs

```
using System;   
using System.Collections.Generic;   
using System.Linq;   
using System.Web;   
using System.Web.Services;
[WebService(Namespace = "http://tempuri.org/")]   
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]   
public class WebService : System.Web.Services.WebService
{       
  [WebMethod]       
  public string HelloWorld() 
  {
    return "Hello World";
  }
}
```

Notice the inclusion of the commented System.Web.Script.Services.ScriptService object (removed from Listing 13-3 for brevity) to work with ASP.NET AJAX scripts.

attribute, which builds the XML web service responses that conform to the WS-I Basic Profile 1.0 release (found at www.ws-i.org/Profiles/BasicProfile-1.0.html).

##Exposing Custom DataSets as SOAP##

```
using System;   
using System.Collections.Generic;   
using System.Data;   
using System.Data.SqlClient;   
using System.Linq;   
using System.Web;   
using System.Web.Services;      

[WebService(Namespace = "http://adventureworks/customers")]   
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]   
public class Customers : System.Web.Services.WebService 
{
  [WebMethod]       
  public DataSet GetCustomers() 
  {
    SqlConnection conn;           
    SqlDataAdapter myDataAdapter;           
    DataSet myDataSet;           

    string cmdString = "Select * From SalesLT.Customer";              
    conn = new SqlConnection("Server=(LocalDB)\v11.0;integrated security=True;attachdbfilename=|DataDirectory|\AdventureWorksLT2012_Data.mdf;");

    myDataAdapter = new SqlDataAdapter(cmdString, conn);
    myDataSet = new DataSet();           
    myDataAdapter.Fill(myDataSet, "Customers");                        
    
    return myDataSet;
  }
}
```

##The WebService Attribute##

All web services are encapsulated within a class. The class is defined as a web service by the WebService attribute

```
[WebService(Namespace = "http://adventureworks/customers")]
```

Namespace property, which has an initial value of http://tempuri.org/. This is meant to be a temporary namespace, and you should replace

Remember that the value does not have to be an actual URL; it can be any string value you want. The idea is that it should be unique.

Other possible WebService properties include Name and Description.

Name enables you to change how the name of the web service is presented to the developer via the ASP.NET test page

Description enables you to provide a textual description of the web service.

```
<WebService(Namespace:="http://adventureworks/customers", Name:="GetCustomers")>
```

##The WebMethod Attribute##

A WebService class can contain any number of WebMethods, or a mixture of standard methods along with methods that are enabled to be WebMethods via the use of the attribute

The only methods that are accessible across the HTTP wire are the ones to which you have applied the WebMethod attribute.

As with the WebService attribute, WebMethod can also contain some properties:

- BufferResponse: When BufferResponse is set to True, the response from the XML web service is held in memory and sent as a complete package. If it is set to False, the default setting, the response is sent to the client as it is constructed on the server.
- CacheDuration: Specifies the number of seconds that the response should be held in the system’s cache. The default setting is 0, which means that caching is disabled. Putting an XML web service’s response in the cache increases the web service’s performance.
- Description: Applies a text description to the WebMethod that appears on the .aspx test page of the XML web service.
- EnableSession: Setting EnableSession to True enables session state for a particular WebMethod. The default setting is False.
- MessageName: Applies a unique name to the WebMethod. This step is required if you are working with overloaded WebMethods (discussed later in the chapter).
- TransactionOption: Specifies the transactional support for the WebMethod. The default setting is Disabled. If the WebMethod is the root object that initiated the transaction, the web service can participate in a transaction with another WebMethod that requires a transaction. Other possible values include NotSupported, Supported, Required, and RequiresNew.

##The XML Web Service Interface##

Running Customers.asmx in the browser pulls up the ASP.NET web service test page. This visual interface to your web service is really meant either for testing purposes or as a reference page for developers interested in consuming the web services you expose.

A link to the web service’s Web Services Description Language (WSDL) document is also available

The WSDL file is the actual interface with the Customers web service.

It is designed to work with tools such as Visual Studio, informing the tool what the web service requires to be consumed.

Clicking the GetCustomers link gives you a new page, shown in Figure 13-5, that not only describes the WebMethod in more detail, but also enables you to test the WebMethod directly in the browser.

The page shows you the structure of the SOAP messages that are required to consume the WebMethod, as well as the structure the SOAP message takes for the response.

Below the SOAP examples is an example of consuming the XML web service using HTTP Post (with name/value pairs).

Using this method of consumption instead of using SOAP is possible.

##CONSUMING A SIMPLE XML WEB SERVICE##

The first step in consuming an XML web service in an ASP.NET application is to make a reference to the remote object — the web service.

Add Service Reference; initially before WCF this was called Adding a Web Reference

From the Service Reference dialog box, you can enter the URL of your service.

> *NOTE* In Visual Studio 2010 and earlier, the Add Web Reference dialog box had its own menu option called Add Web Reference. However, with the emergence of WCF and WebAPI, this menu option has been removed.

The Add Web Reference dialog box is really looking for WSDL files.

Microsoft’s XML Web Services automatically generate WSDL files based on the .asmx files themselves.

To pull up the WSDL file in the browser, simply type in the URL of your web service’s .asmx file and add a ?WSDL at the end of the string.

http://www.contoso.com/WebServices/Customers.asmx?WSDL

> *NOTE* If you are using Microsoft’s Visual Studio and its built-in web server instead of IIS, you will be required to also interject the port number the web server is using into the URL. In this case, your URL would be structured similar to http://localhost:4937/Customers.asmx?WSDL

Clicking the Add Reference button causes Visual Studio to make an actual reference to the web service from the web.config file of your application

You might find some additional files under the App_WebReferences folder — such as a copy of the web service’s WSDL file.

Your consuming application’s web.config file contains the reference to the web service in its <appSettings> section.

```
<?xml version="1.0"?>
<configuration>
  <system.web>
    <compilation debug="false" targetFramework="4.5"/>
    <httpRuntime targetFramework="4.5"/>
  </system.web>
  <appSettings>
    <add key="AdventureWorksCustomers.Customers" value="http://localhost:4473/Customers.asmx"/>
  </appSettings>
</configuration>
```

##Invoking the Web Service from the Client Application##

```
AdventureWorksCustomers.Customers ws = new AdventureWorksCustomers.Customers();
GridView1.DataSource = ws.GetCustomers();
GridView1.DataBind();
```

The Customers web service is invoked by the instantiation of the AdventureWorksCustomers.Customers proxy object:

```
AdventureWorksCustomers.Customers ws = new AdventureWorksCustomers.Customers();
```

##OVERLOADING WEBMETHODS##

With method overloading, one method can be called, but the call is routed to the appropriate method based on the full signature of the request.

```
public string HelloWorld()
{
  return "Hello";
}
public string HelloWorld(string FirstName)
{
  return "Hello " + FirstName;
}
```

To overload WebMethods is to use the MessageName property.

```
[WebMethod(MessageName = "HelloWorld")]   
public string HelloWorld()
{
return "Hello World";
}

[WebMethod(MessageName = "HelloWorldWithFirstName")]
public string HelloWorld(string FirstName)
{
  return "Hello " + FirstName;
}
```

In addition to adding the MessageName property of the WebMethod attribute, you must disable your web service’s adherence to the WS-I Basic Profile specification — which it wouldn’t be doing if you performed WebMethod overloading with your web services. You can disable the conformance to the WS-I Basic Profile specification in a couple of ways. One way is to add the <WebServiceBinding> attribute to your code,

```
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.None)]
public class WebService : System.Web.Services.WebService
{
  // Code here...
}
```

The other option is to turn off the WS-I Basic Profile capability in the web.config

```
<configuration>
  <system.web>
    <webServices>
      <conformanceWarnings>
        <remove name="BasicProfile1_1" />
      </conformanceWarnings>
    </webServices>
  </system.web>
</configuration>
```

##CACHING WEB SERVICE RESPONSES##

XML Web Services use an attribute to control caching of SOAP responses — the CacheDuration property.

```
[WebMethod(CacheDuration = 60)]   
public string GetServerTime()
{
  return DateTime.Now.ToLongTimeString();
}
```

CacheDuration takes an Integer value that is equal to the number of seconds during which the SOAP response is cached.

##USING SOAP HEADERS##

One of the more common forms of extending the capabilities of SOAP messages is to add metadata of the request to the SOAP message itself.

The metadata is usually added to a section of the SOAP envelope called the SOAP header.

The entire SOAP message is referred to as a SOAP envelope. Contained within the SOAP message is the SOAP body

The one optional component of the SOAP message is the SOAP header.

It is the part of the SOAP message in which you can place any metadata about the overall SOAP request instead of incorporating it in the signature of any of your WebMethods.

Keeping metadata separate from the actual request is important. What kind of information should you include in a header? It could include many things. One of the more common items placed in the SOAP header is any authentication/authorization functionality required to consume your web service or to get at specific pieces of logic or data. Placing usernames and passwords inside the SOAP headers of your messages is a good example of what you might include.

Building a Web Service with SOAP Headers

The initial step is to add a class that is an object representing what is to be placed in the SOAP header by the client,

```
public class HelloHeader : System.Web.Services.Protocols.SoapHeader
{
  public string Username;
  public string Password;
}
```

has to inherit from the SoapHeader class; System.Web.Services.Protocols.SoapHeader.

The SoapHeader class serializes the payload of the soap:header element into XML for you.

The names you create in this class are those used for the sub-elements of the SOAP header construction, so naming them descriptively is important.

```
[WebService(Namespace = "http://tempuri.org/")]   
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1, EmitConformanceClaims = true)]   
public class HelloSoapHeader : System.Web.Services.WebService
{
  public HelloHeader myHeader;

  [WebMethod]
  [SoapHeader("myHeader")]
  public string HelloWorld()
  {
    if (myHeader == null)
    {
      return "Hello World";
    } else {
      return "Hello " + myHeader.Username + ". " + "<br>Your password is: " + myHeader.Password;
    }
  }
}
```

From here, the WebMethod actually makes use of the myHeader object. If the myHeader object is not found (meaning that the client did not send in a SOAP header with his constructed SOAP message), a simple "Hello World" is returned. However, if values are provided in the SOAP header of the SOAP request, those values are used within the returned string value.

##Consuming a Web Service Using SOAP Headers##

```
helloSoapHeader.HelloSoapHeader ws = new helloSoapHeader.HelloSoapHeader();
helloSoapHeader.HelloHeader wsHeader = new helloSoapHeader.HelloHeader();
wsHeader.Username = "Jason Gaylord ";
wsHeader.Password = "Lights";
ws.HelloHeaderValue = wsHeader;
Label1.Text = ws.HelloWorld();
```

##The SOAP request##

```
<?xml version="1.0" encoding="utf-8" ?>
  <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"    
    xmlns:xsd="http://www.w3.org/2001/XMLSchema">      
    <soap:Header>
      <HelloHeader xmlns="http://tempuri.org/">
        <Username>Jason Gaylord</Username>
        <Password>Lights</Password>
      </HelloHeader>
    </soap:Header>
    <soap:Body>
      <HelloWorld xmlns="http://tempuri.org/" />
    </soap:Body>
  </soap:Envelope>
```

##The SOAP response##

```
<?xml version="1.0" encoding="utf-8" ?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"    
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"    
  xmlns:xsd="http://www.w3.org/2001/XMLSchema">      
  <soap:Body>         
    <HelloWorldResponse xmlns="http://tempuri.org/">
      <HelloWorldResult>Hello Jason Gaylord. Your password is: Lights</HelloWorldResult>
    </HelloWorldResponse>
  </soap:Body>
</soap:Envelope>
```

##Requesting Web Services Using SOAP 1.2##

In an ASP.NET application that is consuming a web service, you can control whether the SOAP request is constructed as a SOAP 1.1 message or a 1.2 message.

```
helloSoapHeader.HelloSoapHeader ws = new helloSoapHeader.HelloSoapHeader();           

helloSoapHeader.HelloHeader wsHeader = new helloSoapHeader.HelloHeader();           
wsHeader.Username = "Jason Gaylord";           
wsHeader.Password = "Lights";           

ws.HelloHeaderValue = wsHeader;           
ws.SoapVersion = System.Web.Services.Protocols.SoapProtocolVersion.Soap12;           

Label1.Text = ws.HelloWorld();
```

The property takes a value of System.Web.Services.Protocols.SoapProtocolVersion.Soap12 to work with SOAP 1.2 specifically.

##The SOAP request using SOAP 1.2##

When you compare the SOAP 1.1 and 1.2 messages, you see a difference in the Content-Type attribute.

In addition, the SOAP 1.2 HTTP header does not use the soapaction attribute because this is now combined with the Content-Type attribute.

You can turn off either SOAP 1.1 or 1.2 capabilities with the web services that you build by making the proper settings in the web.config

```
<?xml version="1.0"?>
<configuration>
  <system.web>
    <webServices>
      <protocols>
        <remove name="HttpSoap"/>
        <!-- Removes SOAP 1.1 abilities -->
        <remove name="HttpSoap1.2"/> <!-- Removes SOAP 1.2 abilities -->
      </protocols>
    </webServices>
  </system.web>
</configuration>
```

##CONSUMING WEB SERVICES ASYNCHRONOUSLY##

All .asmx web services have the built-in capability for asynchronous communication with consumers.

```
helloWorldAsync.HelloWorldAsyncService ws = new helloWorldAsync.HelloWorldAsyncService();           
IAsyncResult myIar = ws.BeginHelloWorld(null, null);           
int x = 0;              

while (myIar.IsCompleted == false)
{
  x += 1;
}
  Label1.Text = "Result from Web service: " + ws.EndHelloWorld(myIar) + "<br>Local count while waiting: " + x.ToString();
}
```

#WINDOWS COMMUNICATION FOUNDATION#

In the past, building components that were required to communicate a message from one point to another was not a simple task because Microsoft offered more than one technology that you could use for such an action.

Out of this confusion, Microsoft created the Windows Communication Foundation (WCF) to help you decide what path to take with the applications you are trying to build.

WCF is a framework for building service-oriented architecture (SOA).

##WCF Overview##

Building services that abide by the core principles of SOA and that these services are vendor-agnostic —

##Building a WCF Service##

When you build a WCF project in this manner, the idea is that you build a traditional class library that is compiled down to a DLL that can then be added to another project.

you can, however, just as easily build a WCF service directly in your .NET project, whether that is a console application or a Windows Forms application.

building them directly as a WCF Service Library project and using the created DLL in your projects or in IIS itself is usually better.

##What Makes a WCF Service##

When looking at a WCF service, you should understand that it is made up of three parts: the service, one or more endpoints, and an environment in which to host the service.

A service is a class that is written in one of the .NET-compliant languages. The class can contain one or more methods that are exposed through the WCF service. A service can have one or more endpoints. An endpoint is used to communicate through the service to the client.

Endpoints themselves are also made up of three parts. These parts are usually defined by Microsoft as the ABC of WCF.

- “A” is for address 
- “B” is for binding 
- “C” is for contract

Basically, you can think of this as follows: “A” is the where, “B” is the how, and “C” is the what.

Finally, a hosting environment is where the service is contained. This constitutes an application domain and process.

##Creating Your First WCF Service##

First, you must create a service contract. Second, you must create a data contract.

The service contract is really a class with the methods that you want to expose from the WCF service.

The data contract is a class that specifies the structure you want to expose from the interface.

##Creating the Service Framework##

The first step is to create the service framework in the project.

From the Add New Item dialog box, select WCF Service,

This step creates a Calculator.svc file, a Calculator.cs file, and an ICalculator.cs file.

The Calculator.svc file is a simple file that includes only the page directive,

The Calculator.cs does all the heavy lifting.

The Calculator.cs file is an implementation of the ICalculator.cs interface.

##Working with the Interface##

To create your service, you need a service contract. The service contract is the interface of the service. This consists of all the methods exposed, as well as the input and output parameters that are required to invoke the methods.

```
using System.ServiceModel;
[ServiceContract]
public interface ICalculator 
{
  [OperationContract]
  int Add(int a, int b);
  
  [OperationContract]       
  int Subtract(int a, int b);

  [OperationContract]       
  int Multiply(int a, int b);

  [OperationContract]
  nt Divide(int a, int b);
}
```

Make a reference to the System.ServiceModel namespace.

You use the ServiceContract attribute to define the class or interface as the service class,

each method is required to have the OperationContract attribute applied:

##Utilizing the Interface##

The next step is to create a class that implements the interface.

it is also implementing the service contract.

```
public class Calculator : ICalculator
{
  public int Add(int a, int b)
  {
    return (a + b);
  }

  public int Subtract(int a, int b) 
  {
    return (a - b);
  }

  public int Multiply(int a, int b)
  {
    return (a * b);
  }

  public int Divide(int a, int b)
  {
    return (a / b);
  }
}
```

With the interface and the class available, you now have your WCF service built and ready to go.

The next step is to get the service hosted.

> *Note* that this is a simple service — it exposes only simple types, rather than a complex type. This enables you to build only a service contract and not have to deal with the construction of a data contract.

##Hosting the WCF Service in a Console Application##

The next step is to take the service just developed and host it in some type of application process. Many hosting options are available, including the following:

Console applications Windows Forms applications Windows Presentation Foundation (WPF) applications Managed Windows Services Internet Information Services (IIS) 5.1 and later IIS Express

As stated earlier, this example hosts the service in IIS Express provided by Visual Studio 2012. You can activate hosting a couple of ways — either through the direct coding of the hosting behaviors or through declarative programming (usually done via the configuration file).

##Reviewing the WSDL Document##

As with ASP.NET Web Services, a WCF service can also autogenerate the WSDL file.

One of the features in WCF 4.5 is an option for a single WSDL file.

With this WSDL file, you can consume the service it defines through an HTTP binding.

The part of the WSDL file showing the service’s endpoint

```
<wsdl:service name="Calculator">
  <wsdl:port name="BasicHttpBinding_ICalculator" binding="tns:BasicHttpBinding_ICalculator">
    <soap:address location="http://localhost:2109/Calculator.svc"/>
  </wsdl:port>
</wsdl:service>
```

This element in the XML document indicates that to consume the service, the end user must use SOAP over HTTP. This is indicated through the use of the soap:address element

##Building the WCF Consumer##

The consumer sends its request via HTTP using SOAP.

Adding a Service Reference; select Add Service Reference

The Add Service Reference dialog box asks you for two things: the Service URI or Address (basically a pointer to the WSDL file) and the name you want to give to the reference.

The name you provide the reference is the name that will be used for the instantiated object that enables you to interact with the service.

the Service Reference folder is added and a series of files are contained within this folder.

The other important addition to note is the System.ServiceModel reference, made for you in the References folder.

##Configuration File Changes##

Looking at the web.config file, you can see that Visual Studio has placed information about the service inside the document,

```
<system.serviceModel>         
  <bindings>             
    <basicHttpBinding>                 
      <binding name="BasicHttpBinding_ICalculator" />             
    </basicHttpBinding>         
  </bindings>         
  <client>             
    <endpoint address="http://localhost:2109/Calculator.svc" binding="basicHttpBinding" bindingConfiguration="BasicHttpBinding_ICalculator" contract="CalcServiceReference.ICalculator" name="BasicHttpBinding_ICalculator" />
  </client>
</system.serviceModel>
```

The important part of this configuration document is the <client> element. This element contains a child element called <endpoint> that defines the where and how of the service consumption process.

The endpoint element provides the address of the service — http://localhost:2109/Calculator.svc — and it specifies which binding of the available WCF bindings should be used.

In this case, the basicHttpBinding is the binding used.

##Writing the Consumption Code##

```
CalcServiceReference.CalculatorClient ws = new CalcServiceReference.CalculatorClient();
int result = ws.Add(int.Parse(TextBox1.Text), int.Parse(TextBox2.Text));
Label1.Text = result.ToString();
ws.Close();
```

As before, the requests and responses are sent over HTTP as SOAP.

##Working with Data Contracts##

Thus far, when building the WCF services, the defined data contract has relied upon simple types or primitive data types.

In the case of the earlier WCF service, a .NET type of Integer was exposed, which in turn was mapped to an XML schema (XS) type of int.

Although you may not be able to see the input and output types defined in the WSDL document provided via the WCF-generated one, they are there. When using a single WSDL file, the types are exposed from within the single WSDL document.

If you are not using a single WSDL file, the XML schema types are defined through an imported .xsd document (Calculator.xsd and Calculator1.xsd).

```
<wsdl:types>
  <xsd:schema targetNamespace="http://tempuri.org/Imports">
    <xsd:import namespace="http://tempuri.org/" schemaLocation="http://localhost:2110/Calculator.svc?xsd=xsd0"/>
    <xsd:import namespace="http://schemas.microsoft.com/2003/10/Serialization/" schemaLocation="http://localhost:2110/Calculator.svc?xsd=xsd1"/>
  </xsd:schema>
</wsdl:types>
```

Typing in the XSD location of http://localhost:2110/Calculator.svc?xsd=xsd0 gives you the input and output parameters of the service.

For instance, looking at the definition of the Add() method, you will see the following bit of code,

Defining the required types in the XSD:

```
<xs:element name="Add">
  <xs:complexType>
    <xs:sequence>
      <xs:element minOccurs="0" name="a" type="xs:int" />
      <xs:element minOccurs="0" name="b" type="xs:int" />
    </xs:sequence>
  </xs:complexType>
  </xs:element>
    <xs:element name="AddResponse">
      <xs:complexType>
        <xs:sequence>
          <xs:element minOccurs="0" name="AddResult" type="xs:int" />
        </xs:sequence>
      </xs:complexType>
    </xs:element>
```

As a builder of this WCF service, you did not have to build the data contract because this service used simple types. When using complex types, you have to create a data contract in addition to your service contract.

##Building a Service with a Data Contract##

You still need an interface that defines your service contract, and then another class that implements that interface. In addition to these items, you also need another class that defines the data contract.

The data contract uses the [DataContract] and [DataMember] attributes.

make a reference to the System.Runtime.Serialization namespace

```
using System.Runtime.Serialization;   
using System.ServiceModel;                
[DataContract]   
public class Customer   
{
  [DataMember]
  public string Firstname;

  [DataMember]
  public string Lastname;
}

[ServiceContract]
public interface IMyCustomDataContractService
{
  [OperationContract]
  string HelloFirstName(Customer cust);
 
  [OperationContract]
  string HelloFullName(Customer cust);
}
```

You specify a class as a data contract through the use of the DataContract attribute:

Now, any of the properties contained in the class are also part of the data contract through the use of the DataMember attribute:

Finally, the Customer object is used in the interface, as well as the class that implements the IMyCustomDataContractService interface,

```
public class MyCustomDataContractService : IMyCustomDataContractService
{
  public string HelloFirstName(Customer cust)
  {
    return "Hello " + cust.Firstname;
  }
  public string HelloFullName(Customer cust)
  {
    return "Hello " + cust.Firstname + " " + cust.Lastname;
  }
}
```

##Building the Consumer##

Add Service Reference

add the location of the WSDL file for the service and click OK.

This adds the changes to the references and the web.config file just as before, enabling you to consume the service.

```
MyCustomDataContractServiceReference.MyCustomDataContractServiceClient ws = new MyCustomDataContractServiceReference.MyCustomDataContractServiceClient();
MyCustomDataContractServiceReference.Customer myCustomer = new MyCustomDataContractServiceReference.Customer(); 
myCustomer.Firstname = "Jason";
myCustomer.Lastname = "Gaylord";       
Label1.Text = ws.HelloFullName(myCustomer);       
ws.Close();

```

Looking at WSDL and the Schema for MyCustomDataContractService

When you make a reference to the MyCustomDataContract service, you will find the following XSD imports in the WSDL:


```
<xsd:schema targetNamespace="http://tempuri.org/Imports">
  <xsd:import namespace="http://tempuri.org/" schemaLocation="http://localhost:2109/MyCustomDataContractService.svc?xsd=xsd0"/>
  <xsd:import namespace="http://schemas.microsoft.com/2003/10/Serialization/" schemaLocation="http:/ localhost:2109/MyCustomDataContractService.svc?xsd=xsd1"/>
  <xsd:import namespace="http://schemas.datacontract.org/2004/07/" schemaLocation="http://localhost:2109/MyCustomDataContractService.svc?xsd=xsd2"/>
</xsd:schema>
</wsdl:types>
```

http://localhost:2109/MyCustomDataContractService.svc?xsd=xsd2 provides the details on your Customer object. Here is the code from this file:

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:tns="http://schemas.datacontract.org/2004/07/" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  targetNamespace="http://schemas.datacontract.org/2004/07/" 
  elementFormDefault="qualified">
    <xs:complexType name="Customer">
      <xs:sequence>
        <xs:element name="Firstname" type="xs:string" nillable="true" minOccurs="0"/>
        <xs:element name="Lastname" type="xs:string" nillable="true" minOccurs="0"/>
      </xs:sequence>
    </xs:complexType>
    <xs:element name="Customer" type="tns:Customer" nillable="true"/>
</xs:schema>
```

This code is an XSD description of the Customer object. Making a reference to the WSDL includes the XSD description of the Customer object and enables you to create local instances of this object.

##Defining Namespaces##

Note that the services built in the chapter have no defined namespaces.

the namespace provided is http://tempuri.org

the interface’s ServiceContract attribute enables you to set the namespace,

```
[ServiceContract(Namespace="http://jasongaylord.com/ns/")]
public interface IMyCustomDataContractService
{
  [OperationContract]
  string HelloFirstName(Customer cust); 

  [OperationContract]
  string HelloFullName(Customer cust);
}
```


##Using WCF Data Services##

The WCF Data Services framework. This feature enables you to easily create an interface to your client applications that provides everything from simple read capabilities to a full CRUD model

This feature was previously referred to as ADO.NET Data Services.

> *NOTE* WCF Data Services is commonly known as exposing data using OData and WCF. Although it is not the only way to expose data, it is certainly the easiest. You see later in this chapter how to use this syntax in the URL to construct filters.

WCF Data Services work to create a services layer to your backend data source.

WCF Data Services enables you to get a service layer that is URI-driven.

The WCF Data Services layer is not the layer that interacts with the database. Instead, you are working with an EDM layer that is the mapping layer between the data store and the cloud-based interface.

WCF Data Services allow you to quickly expose interactions with the application’s underlying data source as RESTful-based services.

The current version of WCF Data Services enables you to work with the data stores using JSON or Atom-based XML.

##Creating Your First Service##

To build a services layer, first create a standard ASP.NET Web Application

add the AdventureWorks database as you previously used. Place this database within the App_Data

###Adding Your Entity Data Model###

create an Entity Data Model that WCF Data Services will work with.

add an ADO.NET Entity Data Model to your project.

by clicking Add, the Entity Data Model Wizard appears,

###Creating the Service###

add your WCF Data Service.

select Add New Item

select WCF Data Service

```
using System;   
using System.Data.Services;   
using System.Data.Services.Common;   
using System.Collections.Generic;   
using System.Linq;   using System.ServiceModel.Web;      

public class AdventureWorksDataService :       
  DataService< /* TODO: put your data source class name here */ >
{
  // This method is called only once to initialize
  //     service-wide policies.       

  public static void InitializeService(DataServiceConfiguration config)
  {
    // TODO: set rules to indicate which entity sets and
    //     service operations are visible, updatable, etc.
    // Examples:
    // config.SetEntitySetAccessRule("MyEntityset", EntitySetRights.AllRead);
    // config.SetServiceOperationAccessRule("MyServiceOperation", ServiceOperationRights.All);
    config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
  }
}
```

The code generated here is the base framework for what you are going to expose through WCF Data Services.

The first step is to put in the name of the EDM instance

```
public class AdventureWorksDataService : DataService<AdventureWorksEntities>
{
  // Code removed for clarity
}
```

Now your application is at a state in which the database, the EDM, and the service to work with the EDM are in place. Upon compiling and pulling up the AdventureWorksDataService.svc file in the browser, you are presented with the following bit of XML:

```
<?xml version="1.0" encoding="UTF-8"?>
<service xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns="http://www.w3.org/2007/app"
  xml:base="http://localhost:5526/AdventureWorksDataService.svc/">
  <workspace>
    <atom:title>Default</atom:title>
  </workspace>
</service>
```

> NOTE If you don’t see this XML, you need to turn off the feed reading capabilities of your Internet Explorer browser by selecting Tools Internet Options.

The result of the earlier XML is supposed to be a list of all the available sets that are present in the model, but by default, WCF Data Services locks everything down.

To unlock these sets from the model, go back to the InitializeService() function and add the following

```
public static void InitializeService(DataServiceConfiguration config)
{
  config.SetEntitySetAccessRule("*",  EntitySetRights.AllRead);
}
```

In this case, every table is opened up to access. Everyone who accesses the tables has the ability to read from them, but no writing or deleting abilities.

All tables are specified through the use of the asterisk (*),

Now, when you compile and run this service in the browser, you see

```
<?xml version="1.0" encoding="UTF-8"?>
<service xmlns="http://www.w3.org/2007/app" xmlns:atom="http://www.w3.org/2005/Atom" xml:base="http://localhost:5526/AdventureWorksDataService.svc/">
   <workspace>
      <atom:title>Default</atom:title>
      <collection href="BuildVersions">
         <atom:title>BuildVersions</atom:title>
      </collection>
      <collection href="ErrorLogs">
         <atom:title>ErrorLogs</atom:title>
      </collection>
      <collection href="Addresses">
         <atom:title>Addresses</atom:title>
      </collection>
      <collection href="Customers">
         <atom:title>Customers</atom:title>
      </collection>
      <collection href="CustomerAddresses">
         <atom:title>CustomerAddresses</atom:title>
      </collection>
      <collection href="Products">
         <atom:title>Products</atom:title>
      </collection>
      <collection href="ProductCategories">
         <atom:title>ProductCategories</atom:title>
      </collection>
      <collection href="ProductDescriptions">
         <atom:title>ProductDescriptions</atom:title>
      </collection>
      <collection href="ProductModels">
         <atom:title>ProductModels</atom:title>
      </collection>
      <collection href="ProductModelProductDescriptions">
         <atom:title>ProductModelProductDescriptions</atom:title>
      </collection>
      <collection href="SalesOrderDetails">
         <atom:title>SalesOrderDetails</atom:title>
      </collection>
      <collection href="SalesOrderHeaders">
         <atom:title>SalesOrderHeaders</atom:title>
      </collection>
   </workspace>
</service>

```

The output of this XML is in the AtomPub format,

other format is JSON, which is used most commonly with JavaScript.

the following header being in place:

```
GET http://localhost:5526/AdventureWorksDataService.svc/ HTTP/1.1
  Accept: text/html, application/xhtml+xml, */*
  Accept-Language: en-US     
  User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0)     
  Accept-Encoding: gzip, deflate     
  Host: localhost:5526     
  DNT: 1     
  Connection: Keep-Alive     
  Pragma: no-cache
```

Changing the Accept header to read application/json,

give you the following response:


```
{
   "d":{
      "EntitySets":[
         "BuildVersions",
         "ErrorLogs",
         "Addresses",
         "Customers",
         "CustomerAddresses",
         "Products",
         "ProductCategories",
         "ProductDescriptions",
         "ProductModels",
         "ProductModelProductDescriptions",
         "SalesOrderDetails",
         "SalesOrderHeaders"
      ]
   }
}
```

###Querying the Interface###

You query the interface using three components: the URI, the action of the HTTP header, and the HTTP verb that you are using in the query.

to perform a read operation

```
GET http://localhost:5526/AdventureWorksDataService.svc/Customers HTTP/1.1     
  Accept: text/html, application/xhtml+xml, */*     
  Accept-Language: en-US     
  User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; WOW64; Trident/6.0)     
  Accept-Encoding: gzip, deflate     
  Host: localhost:5526     
  DNT: 1     
  Connection: Keep-Alive     
  Pragma: no-cache
```

The result that is returned in this case is based on what is returned within the Accept HTTP header.

The method that you are calling is determined by the URI used.

/AdventureWorksDataService.svc/Customers,

also a read statement because the HTTP verb that is used is a GET statement.

list of HTTP verbs and how they map to the data access type.

|HTTP VERB | DATA ACCESS TYPE|
|--|--|
| POST | Create|
| GET | Read|
| PUT | Update|
| DELETE | Delete|

###Reading a Table of Data###

Reading an entire table of contents is based on the URI that is passed in.

http://localhost:5526/AdventureWorksDataService.svc/Customers

In this case, you are requesting the entire contents of the Customers table

http://localhost: 5526/AdventureWorksDataService.svc/Products

you will receive a complete list of products

If you look at the table-level information that is available from the URI call,

```
<id>http://localhost:4113/AdventureWorksDataService.svc/Products</id>
<title type="text">Products</title>
<updated>2012-11-28T04:43:40Z</updated>
<link rel="self" title="Products" href="Products" />
```

receive a title (the entity name),

full URI as the  id  element.

timestamp of when the query was run in the <updated> element.

a link referencing the item itself

###Reading a Specific Item from the Table###

If you look at one of the product items contained within the result collection, you will see

```
<?xml version="1.0" encoding="UTF-8"?>
<entry xmlns="http://www.w3.org/2005/Atom" xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" xml:base="http://localhost:5526/AdventureWorksDataService.svc/">
   <id>http://localhost:5526/AdventureWorksDataService.svc/Products(710)</id>
   <category term="AdventureWorksModel.Product" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" />
   <link rel="edit" title="Product" href="Products(710)" />
   <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/ProductCategory" type="application/atom+xml;type=entry" title="ProductCategory" href="Products(710)/ProductCategory" />
   <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/ProductModel" type="application/atom+xml;type=entry" title="ProductModel" href="Products(710)/ProductModel" />
   <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/SalesOrderDetails" type="application/atom+xml;type=feed" title="SalesOrderDetails" href="Products(710)/SalesOrderDetails" />
   <title />
   <updated>2012-11-28T04:49:26Z</updated>
   <author>
      <name />
   </author>
   <content type="application/xml">
      <m:properties>
         <d:ProductID m:type="Edm.Int32">710</d:ProductID>
         <d:Name>Mountain Bike Socks, L</d:Name>
         <d:ProductNumber>SO-B909-L</d:ProductNumber>
         <d:Color>White</d:Color>
         <d:StandardCost m:type="Edm.Decimal">3.3963</d:StandardCost>
         <d:ListPrice m:type="Edm.Decimal">9.5000</d:ListPrice>
         <d:Size>L</d:Size>
         <d:Weight m:type="Edm.Decimal" m:null="true" />
         <d:ProductCategoryID m:type="Edm.Int32">27</d:ProductCategoryID>
         <d:ProductModelID m:type="Edm.Int32">18</d:ProductModelID>
         <d:SellStartDate m:type="Edm.DateTime">2001-07-01T00:00:00</d:SellStartDate>
         <d:SellEndDate m:type="Edm.DateTime">2002-06-30T00:00:00</d:SellEndDate>
         <d:DiscontinuedDate m:type="Edm.DateTime" m:null="true" />
         <d:ModifiedDate m:type="Edm.DateTime">2004-03-11T10:01:36.827</d:ModifiedDate>
      </m:properties>
   </content>
</entry>
```

If you look at the <id> value of this product, you will find the following:

http://localhost:5526/AdventureWorksDataService.svc/Products(710)

reference to this particular product is Products(710),

If you review the XML, you will find that the <content> element contains all the data from the specific product that you are looking at. This is constructed as a properties collection.

Although you see a list of properties for this customer, you are also able to get at individual properties themselves through URI declarations such as:

http://localhost:5526/AdventureWorksDataService.svc/Products(710)/Name

```
<?xml version="1.0" encoding="UTF-8"?>
<d:Name xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata">Mountain Bike Socks, L</d:Name>
```

It is important to realize that this number reference from Products(710) is not an index reference but the ID reference.

###Working with Relationships###

the Customers object has a relationship with the SalesOrderObjects object

navigate to: http://localhost:5526/AdventureWorksDataService.svc/Customers(1)

<link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/CustomerAddresses" 
  type="application/atom+xml;type=feed"
  title="CustomerAddresses" href="Customers(1)/CustomerAddresses" />
<link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/related/SalesOrderHeaders" 
  type="application/atom+xml;type=feed" title="SalesOrderHeaders" href="Customers(1)/SalesOrderHeaders" />

This snippet shows the two relationships that are in place for this customer. The second is a reference to the SalesOrderHeaders relationship.

You can see this statement through the rel attribute as well as the title attribute that is in place within this particular link element.

a link to the relationship itself through the href attribute of the link element.

Customers(1)/SalesOrderHeaders.

type the following URI in the browser:

http://localhost:5526/AdventureWorksDataService.svc/Customers(1)/SalesOrderHeaders

###Expanding on Associations###

You are also able to pull these associations out in the same query if you want.

through the use of the some query string parameters

http://localhost:5526/AdventureWorksDataService.svc/Products(710)

notice that one of the links shown is to the ProductCategory entity set.

http://localhost:5526/AdventureWorksDataService.svc/Products(710)/ProductCategory

However, if you want to get this related set of data points for the product in a single call, you can use the expand keyword in your URI query:

```
http://localhost:5526/AdventureWorksDataService.svc/Products(710)?$expand=ProductCategory
```

```
<?xml version="1.0" encoding="UTF-8"?>
<entry xmlns="http://www.w3.org/2005/Atom" xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" xml:base="http://localhost:5526/AdventureWorksDataService.svc/">
   <id>http://localhost:5526/AdventureWorksDataService.svc/Products(710)</id>
   <category term="AdventureWorksModel.Product" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" />
   <link rel="edit" title="Product" href="Products(710)" />
   <link rel="http://schemas.microsoft.com/ado/2007/08/dataservices/           related/ProductCategory" type="application/atom+xml;type=entry" title="ProductCategory" href="Products(710)/ProductCategory">
      <m:inline>
         <entry>
            <id>http://localhost:5526/AdventureWorksDataService.svc/                       ProductCategories(27)</id>
            <category term="AdventureWorksModel.ProductCategory" scheme="http://schemas.microsoft.com/ado/                       2007/08/dataservices/scheme" />
            <link rel="edit" title="ProductCategory" href="ProductCategories(27)" />
            <link rel="http://schemas.microsoft.com/ado/ 2007/08/dataservices/related/Products" type="application/atom+xml;type=feed" title="Products" href="ProductCategories(27)/Products" />
            <link rel="http://schemas.microsoft.com/ado/                       2007/08/dataservices/related/ProductCategory1" type="application/atom+xml;type=feed" title="ProductCategory1" href="ProductCategories(27)/ProductCategory1" />
            <link rel="http://schemas.microsoft.com/ado/                       2007/08/dataservices/related/ProductCategory2" type="application/atom+xml;type=entry" title="ProductCategory2" href="ProductCategories(27)/ProductCategory2" />
            <title />
            <updated>2012-11-28T05:47:51Z</updated>
            <author>
               <name />
            </author>
            <content type="application/xml">
               <m:properties>
                  <d:ProductCategoryID m:type="Edm.Int32">27</d:ProductCategoryID>
                  <d:ParentProductCategoryID m:type="Edm.Int32">3</d:ParentProductCategoryID>
                  <d:Name>Socks</d:Name>
                  <d:rowguid m:type="Edm.Guid">701019c3-09fe-4949-8386-c6ce686474e5</d:rowguid>
                  <d:ModifiedDate m:type="Edm.DateTime">1998-06-01T00:00:00</d:ModifiedDate>
               </m:properties>
            </content>
         </entry>
      </m:inline>
   </link>
   <link rel="http://schemas.microsoft.com/ado/           2007/08/dataservices/related/ProductModel" type="application/atom+xml;type=entry" title="ProductModel" href="Products(710)/ProductModel" />
   <link rel="http://schemas.microsoft.com/ado/           2007/08/dataservices/related/SalesOrderDetails" type="application/atom+xml;type=feed" title="SalesOrderDetails" href="Products(710)/SalesOrderDetails" />
   <title />
   <updated>2012-11-28T05:47:51Z</updated>
   <author>
      <name />
   </author>
   <content type="application/xml">
      <m:properties>
         <d:ProductID m:type="Edm.Int32">710</d:ProductID>
         <d:Name>Mountain Bike
Socks, L</d:Name>
         <d:ProductNumber>SO-B909-L</d:ProductNumber>
         <d:Color>White</d:Color>
         <d:StandardCost m:type="Edm.Decimal">3.3963</d:StandardCost>
         <d:ListPrice m:type="Edm.Decimal">9.5000</d:ListPrice>
         <d:Size>L</d:Size>
         <d:Weight m:type="Edm.Decimal" m:null="true" />
         <d:ProductCategoryID m:type="Edm.Int32">27</d:ProductCategoryID>
         <d:ProductModelID m:type="Edm.Int32">18</d:ProductModelID>
         <d:SellStartDate m:type="Edm.DateTime">2001-07-01T00:00:00</d:SellStartDate>
         <d:SellEndDate m:type="Edm.DateTime">2002-06-30T00:00:00</d:SellEndDate>
         <d:DiscontinuedDate m:type="Edm.DateTime" m:null="true" />
         <d:ThumbNailPhoto m:type="Edm.Binary">R0lGODlhUAAxAPcAAAAAAIAAAACAAICAAAAAgIAAgACAgICAgMDAwP8AAAD/AP//AAAA//8A/wD//////wAAAAAAAA     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA AAAAAAAAAAAAAAAAAAAAAAAAAAAMwAAZgAAmQAAzAAA/wAzAAAzMwAzZgAzmQAzzAAz/wBmAABmMwBmZgBmmQBmzABm/wCZAACZMwCZZgCZmQCZzACZ/wDMAADMMwDMZgDMmQDMzADM/wD/AAD/MwD/ZgD/mQD/zAD//zMAADMAMzMAZjMAmTMAzDMA/zMzADMzMzMzZjMzmTMzzDMz/zNmADNmMzNmZjNmmTNmzDNm/zOZADOZMzOZZjOZmTOZzDOZ/zPMADPMMzPMZjPMmTPMzDPM/zP/ADP/MzP/ZjP/mTP/zDP//2YAAGYAM2YAZmYAmWYAzGYA/2YzAGYzM2YzZmYzmWYzzGYz/2ZmAGZmM2ZmZmZmmWZmzGZm/2aZAGaZM2aZZmaZmWaZzGaZ/2bMAGbMM2bMZmbMmWbMzGbM/2b/AGb/M2b/Zmb/mWb/zGb//5kAAJkAM5kAZpkAmZkAzJkA/5kzAJkzM5kzZpkzmZkzzJkz/5lmAJlmM5lmZplmmZlmzJlm/5mZAJmZM5mZZpmZmZmZzJmZ/5nMAJnMM5nMZpnMmZnMzJnM/5n/AJn/M5n/Zpn/mZn/zJn//8wAAMwAM8wAZswAmcwAzMwA/8wzAMwzM8wzZswzmcwzzMwz/8xmAMxmM8xmZsxmmcxmzMxm/8yZAMyZM8yZZsyZmcyZzMyZ/8zMAMzMM8zMZszMmczMzMzM/8z/AMz/M8z/Zsz/mcz/zMz///8AAP8AM/8AZv8Amf8AzP8A//8zAP8zM/   8zZv8zmf8zzP8z//9mAP9mM/9mZv9mmf9mzP9m//+ZAP+ZM/   +ZZv+Zmf+ZzP+Z///MAP/MM//MZv/Mmf/MzP/M////AP//M///Zv//mf//zP///yH5BAEAABAALAAAAABQADEAAAj/   AP8JHEiwoMGDCBMqXMiwocOHECNKnEixosWLGDNq3Mixo8ePIEOKHEmypMmTKFOqXJkRBYqBLhfGZPnQ5ct/MxPmpMnQpsCZNm/CfBnTZ86gQ3HeRMoRadGlQpUqJfoUZ9KnVH9GxVhUKtCoVaWKn ZrVK9SmVMPuVHvWrFisPjd+LbuW7tmvb8t6nJuXIFutfbH2lSt07ta/eeOy3clTYuGtjS8yjUy5suXLmDHHdRjWIG     PGIjdDBA3YL2SQVY+mvQsVL16yqLOqfuyWtlHZbTv+nY1 76G67H38DTs068GrSkoMSN+62+fKQqrW2Xe6aem7CSaf6f
q7ceevTmcOLEh9Pvrz58+jTq1/Pvr379+8DAgA7</d:ThumbNailPhoto>
         <d:ThumbnailPhotoFileName>no_image_available_small.gif</d:ThumbnailPhotoFileName>
         <d:rowguid m:type="Edm.Guid">161c035e-21b3-4e14-8e44-af508f35d80a</d:rowguid>
         <d:ModifiedDate m:type="Edm.DateTime">2004-03-11T10:01:36.827</d:ModifiedDate>
      </m:properties>
   </content>
</entry>
```


the link element that was specific for the category is now expanded

you can expand multiple items:

```
http://localhost:5526/AdventureWorksDataService.svc/Products(710)?$expand=ProductCategory,ProductModel
```

You can also keep digging into the nested associated entity sets.

```
http://localhost:5526/AdventureWorksDataService.svc/Products(710)?$expand=ProductCategory/SimilarCategories
```

###Ordering in Resultsets###

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$orderby=Name
```

By default, an ascending order is assigned.

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$orderby=Name asc
```

Notice that there is an actual space between the Name and asc items in the URI.

descending order,

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$orderby=Name desc
```

nested sorting

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$orderby=Color asc, Name asc
```

###Moving around Resultsets###

grab just smaller subsets of the content as pages and to navigate through the page that you need.

two query string commands: top and skip.

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$top=5
```

Here, the top five entities, in this case based on the ID value, are pulled from the database and returned.

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$orderby=Name desc&$top=5
```

the top five products, ordered by the product name, are returned

skip command to basically skip the first set of defined items.


```
http://localhost:5526/AdventureWorksDataService.svc/Products?$skip=5
```

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$skip=10&$top=10
```

This means that you are really grabbing page two of sets that consist of ten items each.

###Filtering Content###

```
http://localhost:5526/AdventureWorksDataService.svc/Products?$filter=Color eq 'Red'
```

within the URI it is important that you are specifying this property in its proper case.

if you used color instead of Color, you would not get any items in the resultset.

lists the logical operators that you are able to use.

|OPERATOR| DESCRIPTION |EXAMPLE|
|--|--|--|
|Eq| Equal| Color eq 'Red' |
|Ne| Not| equal Color ne 'Red' |
|Gt| Greater than |$filter = ListPrice gt 20|
| Ge| Greater than or equal |$filter = ListPrice ge 20 |
|Lt| Less than| $filter = ListPrice lt 20 |
|Le| Less than or equal| $filter = ListPrice le 20| 
|And| Logical and| $filter = ListPrice gt 0 and StandardCost gt 0 |
|Or| Logical or| $filter = ListPrice gt 0 or StandardCost lt 100 |
|Not |Logical not| $filter = ListPrice gt 0 not ProductName eq 'Red'|

In addition to logical operators, you can use a number of arithmetic operators,

|OPERATOR |DESCRIPTION| EXAMPLE|
|--|--|--|
|Add| Add| $filter = ListPrice add 5 gt 20 |
|Sub| Subtract| $filter = ListPrice sub 5 gt 20 
|Mul| Multiply |$filter = ListPrice mul 5 gt 20|
| Div| Divide| $filter = ListPrice div 5 gt 20 |
|Mod| Modulo| $filter = ListPrice mod 100 gt 20|

A long list of string, date, and math functions is also available:

- substringof 
- startswith 
- indexof 
- remove 
- substring 
- toupper 
- concat 
- hour 
- month 
- year 
- floor 
- endswith 
- length 
- insert 
- replace 
- tolower 
- trim 
- day 
- minute 
- second 
- round 
- ceiling

###Consuming WCF Data Services in ASP.NET###

Add Service Reference

Because a WCF Data Service is a standard .svc file, you can make reference to your AdventureWorksDataService.svc

```
public partial class _Default : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    AdventureWorksEntities svc = new AdventureWorksEntities(new Uri("http://localhost:5526/AdventureWorksDataService.svc"));

    GridView1.DataSource = svc.Customers;
    GridView1.DataBind();
  }
}
```

the entire Customers table is returned through the use of svc.Customers.

you can also start using some of the command logic presented earlier in this chapter when using LINQ within your code.

```
AdventureWorksEntities svc = new AdventureWorksEntities(new Uri("http://localhost:5526/AdventureWorksDataService.svc"));

var query = svc.Customers.Where(w => w.CompanyName.Contains("Bike"));

GridView1.DataSource = query;
GridView1.DataBind();
```

#ASP.NET WEB API#

Prior to the ASP.NET 4.5 release, many developers would complain that it took more time to configure WCF to create a RESTful service than it did to develop the service.

So, to assist in exposing application functionality, better known as a web API, Web API was created.

Because Web API is an ASP.NET MVC application that relies heavily on HTTP, developers can make use of HTTP verbs and meaningful routes to build a solid,

##Building Your First Web API##

Visual Studio 2012 has a great template that helps scaffold Web API projects.

create a new ASP.NET MVC 4 project

choose the Web API template.

Next, you must build a new controller. Right-click the Controllers folder and choose Add Controller. Name the new controller ProductsController.

In the controller template, choose “API controller with read/write actions, using Entity Framework,”

The ProductsController file will appear containing the core functionality of the API, as shown

each method has a comment above it informing the developer which HTTP verb should be used for that method

```
public class ProductsController: ApiController {
 private AdventureWorksEntities db = new AdventureWorksEntities();

 // GET api/Products       
 public IEnumerable < Product > GetProducts() {
   var products = db.Products.Include(p => p.ProductCategory)
    .Include(p => p.ProductModel);
   return products.AsEnumerable();
  }
  // GET api/Products/5       
 public Product GetProduct(int id) {
   Product product = db.Products.Find(id);
   if (product == null) {
    throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
   }
   return product;
  }
  // PUT api/Products/5       
 public HttpResponseMessage PutProduct(int id, Product product) {
   if (ModelState.IsValid && id == product.ProductID) {
    db.Entry(product).State = EntityState.Modified;
    try {
     db.SaveChanges();
    } catch (DbUpdateConcurrencyException) {
     return Request.CreateResponse(HttpStatusCode.NotFound);
    }
    return Request.CreateResponse(HttpStatusCode.OK);
   } else {
    return Request.CreateResponse(HttpStatusCode.BadRequest);
   }
  }
  // POST api/Products       
 public HttpResponseMessage PostProduct(Product product) {
   if (ModelState.IsValid) {
    db.Products.Add(product);
    db.SaveChanges();
    HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, product);
    response.Headers.Location = new Uri(Url.Link("DefaultApi", new {
     id = product.ProductID
    }));
    return response;
   } else {
    return Request.CreateResponse(HttpStatusCode.BadRequest);
   }
  }
  // DELETE api/Products/5       
 public HttpResponseMessage DeleteProduct(int id) {
  Product product = db.Products.Find(id);
  if (product == null) {
   return Request.CreateResponse(HttpStatusCode.NotFound);
  }
  db.Products.Remove(product);
  try {
   db.SaveChanges();
  } catch (DbUpdateConcurrencyException) {
   return Request.CreateResponse(HttpStatusCode.NotFound);
  }
  return Request.CreateResponse(HttpStatusCode.OK, product);
 }
 protected override void Dispose(bool disposing) {
  db.Dispose();
  base.Dispose(disposing);
 }
}

```

##Understanding Web API Routing##

You may notice a few things are different with the Web API controllers. Instead of inheriting from Controller, the class is inheriting from ApiController.

Next, you’ll notice that the methods do not use an HTTP verb attribute. Rather, the HTTP verbs are placed as the first part in your method names.

The URL is generated based on the route in place for the Web API. The default Web API route is shown

```
public static class WebApiConfig {
 public static void Register(HttpConfiguration config) {
  config.Routes.MapHttpRoute(
   name: "DefaultApi",
   routeTemplate: "api/{controller}/{id}",
   defaults: new {
    id = RouteParameter.Optional
   }
  );
 }
}```

##Consuming a Web API##

Because the Web API uses HTTP, the client can be anything from a mobile device such as a Windows Phone to a desktop application to a web application built using another technology.

access your Web API using http://localhost:43059/api/products/710.

In this case, the file that is ready to download is a JSON file,

```
HTTP/1.1 200 OK   
Cache-Control: no-cache   
Pragma: no-cache   
Content-Type: application/json; charset=utf-8   
Expires: -1   
Server: Microsoft-IIS/8.0   
X-AspNet-Version: 4.0.30319   
X-SourceFiles: =?UTF-8?B?QzpcVXNlcnNcSmFzb25HYXlsb3JkXERvY3VtZW50c1xWaXN1Y WwgU3R1ZGlvIDIwMTJcUHJvamVjdHNcQ2hhcHRlcjEzLUNTXE91ckZpcnN0V2ViQXBpLUNTXGFwaVxwc m9kdWN0c1w3MTA=?=   
X-Powered-By: ASP.NET   
Date: Wed, 28 Nov 2012 21:48:16 GMT   
Content-Length: 1968      
{
   "ProductID":710,
   "Name":"Mountain Bike Socks, L",
   "ProductNumber":"SO-B909 -L",
   "Color":"White",
   " StandardCost":3.3963,
   "ListPrice":9.5000,
   "Size":"L",
   "Weight":null,
   "ProductCategoryID":27,
   "Product ModelID":18,
   "SellStartDate":"2001-07-01T00:00:00",
   "SellEndDate":"2002-06-30T00:00:00",
   "Discont inuedDate":null,
   "ThumbNailPhoto":"R0lGODlhUAAxAPcAAAAAAIAAetc",
   "ThumbnailPhotoFileName":"no_image_available_small. gif",
   "rowguid":"161c035e-21b3-4e14-8e44-af508f35d80a",
   "ModifiedDate":"2004-03-11T10:01:36.827",
   "ProductCategory":null,
   "ProductModel":null,
   "SalesOrderDetails":[
   ]
}
```


> *NOTE* If you happen to get an exception within the response that reads The 'ObjectContent'1' type failed to serialize the response body for content type 'application/json;', you can update your controller’s default construct to turn off EF proxy creation by adding the following: db.Configuration.ProxyCreationEnabled = false;.

In most cases, you would consume your Web API using jQuery or another JavaScript library

If you are using ASP.NET Web Forms or ASP.NET MVC and you want to connect to your Web API using server-side code, you can do so by using an HttpClient

> *NOTE* If you do not have the Web API Client library referenced in this project, you can either download it from the NuGet Package Manager Console or update the projects that have this package installed if it has already been downloaded as part of your solution.

To demonstrate, create a new ASP.NET Web Forms project called ApiConsumer.

Because you are going to consume one of the tables from your model, you need to create a class to cast the JSON result to.

```
public class Product   
{       
  public string Name { get; set; }       
  public string Color { get; set; }   
}
```

Using HttpClient, pass the URI for /api/products/710.

```
HttpClient client = new HttpClient();
client.BaseAddress = new Uri("http://localhost:43059/");
client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
HttpResponseMessage response = client.GetAsync("api/products/710").Result;
if (response.IsSuccessStatusCode) {
 var product = response.Content.ReadAsAsync < Product > ().Result;
 NameLabel.Text = product.Name;
 ColorLabel.Text = product.Color;
} else {
 ErrorLabel.Text = response.ReasonPhrase;
}```

The most popular tool for testing the Web API is Fiddler.
