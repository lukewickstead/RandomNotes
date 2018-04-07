#CHAPTER 19 Dispatching Requests#

##Understanding Request Dispatching##

Three classes coordinate the way that Web API handles HTTP requests, known collectively as the message handlers.

The term message handler arises because all three classes are derived from the abstract HttpMessageHandler class in the System.Web.Http namespace.

The three MessageHandler classes that I describe in this chapter are the gatekeepers to the world of Web API.

Message handlers are organized into a chain, and each handler processes the request in turn, which gives handlers the chance to modify or enhance the HttpRequestMessage object.

The last message handler in the chain creates the HttpResponseMessage, which then passes back along the list, allowing each message handler to modify the response before it is sent to the client.

Web API defines a number of interfaces that are used by the message handlers to hand off important tasks. The use of interfaces means that the dispatch process can be customized,

Table 19-2. The Dispatcher Interfaces and Default Implementation Classes

|Name| Description|
|--|--|
|HttpServer| The first message handler to receive new HttpRequestMessage objects. |
|HttpRoutingDispatcher| The second message handler, which creates routing data for the request.|
|HttpControllerDispatcher| The third and final message handler, which selects, activates, and executes a controller to create an HttpResponseMessage object.|
|IHttpControllerSelector| The interface that the HttpControllerDispatcher class uses to delegate controller selection. The default implementation is the DefaultHttpControllerSelector class.|
|IHttpControllerTypeResolver| The interface used by the DefaultHttpControllerSelector class to locate the controller classes in the application. The default implementation is the DefaultHttpControllerTypeResolver.|
|IAssembliesResolver| The interface used to locate the assemblies in the application so that the IHttpControllerTypeResolver implementation can search them for controllers. The default implementation is the DefaultAssembliesResolver class.|
|IHttpControllerActivator| The interface used by the HttpControllerDispatcher class to delegate creating an instance of the selected controller. The default implementation is the DefaultHttpControllerActivator class.|
|IHttpController| The interface used to denote a controller. I describe controllers fully in Chapter 22, but most controllers are derived from the ApiController class, which implements the IHttpController interface.|

Web API uses the dispatch process to receive an HttpRequestMessage object representing an HTTP request and to produce a corresponding HttpResponseMessage object that will be used to generate the response sent to the client.

The dispatch process is automatically applied to all incoming HTTP requests in a Web API application and requires no explicit action.

The dispatch process is managed by three message handler classes. The HttpServer class receives requests from the hosting environment, the HttpRoutingDispatcher integrates URL routing, and the HttpControllerDispatcher selects a controller to handle the request.

##Understanding the HttpServer Class##

The first message handler in the chain is an instance of the HttpServer class, which acts as the contact point between the hosting environment and Web API.

The HttpServer class has a simple job: it receives an HttpRequestMessage object, prepares it for use in a Web API application, and passes it on to the next message handler in the chain. The preparation involves associating a security principal with the request, creating the HttpRequestContext object, and setting up the classes that will deal with any errors when the HttpResponeMessage comes back along the chain.

The HttpServer class is instantiated by the GlobalConfiguration class during the configuration phase of the application life cycle.

Table 19-4. The GlobalConfiguration Properties That Relate to the HttpServer Class

|Name| Description|
|--|--|
|DefaultHandler| Returns the HttpMessageHandler implementation that the HttpServer class should pass the HttpRequestMessage object to when it has finished its preparations. By default, this is the HttpRoutingDispatcher class, which I describe in the next section. You can add custom message handlers to the chain, which I describe in the “Customizing the Dispatch Process” section. |
|DefaultServer| Returns the HttpMessageHandler implementation that is the entry point into Web API, which is the HttpServer class.|

##Understanding the HttpRoutingDispatcher Class##

The second message handler in the chain is an instance of the HttpRoutingDispatcher class, which integrates URL routing into the Web API request handling pipeline. The HttpRoutingDispatcher class is defined in the System.Web.Http.Dispatcher namespace.

The URL routing system has one purpose: to inspect the request in order to produce data that other components will need to process further along the message handler chain.

The purpose of the HttpRoutingDispatcher class uses the routing system to inspect the HttpRequestMessage object and produce routing data, which is then associated with the HttpRequestContext object associated with the request and made accessible through the HttpRequestContext.RouteData property.

##Understanding the Default URL Routing Configuration##

There are two ways in which to define Web API routes.

The first is to use convention-based routing, which means that routes are configured in a single location and are written to match as many requests as possible.

The other way to define routes is direct routing or attribute-based routing.

There are no default direct routes defined in a Web API application,

Web API routing is set up in the WebApiConfig.cs file, as follows:

```cs
config.MapHttpAttributeRoutes();
config.Routes.MapHttpRoute(
  name: "DefaultApi", routeTemplate: "api/{controller}/{id}", defaults: new { id = RouteParameter.Optional
```

> **Tip**  Web API and MVC framework URL routing work in similar ways but do not share a common class hierarchy or configuration files. Applications that use both frameworks have two separate routing configurations.

Figure 19-4. Revising the pipeline diagram to include the HttpRoutingDispatcher class

##Understanding the HttpControllerDispatcher Class##

The third and final built-in message handler class is HttpControllerDispatcher, and it is responsible for locating a controller class, creating an instance of it, and asking it to process the request to produce the HttpResponseMessage that will be passed back to the hosting environment via the other message handlers in the chain.

##Selecting the Controller##

The HttpControllerDispatcher class delegates the selection of the controller class to an implementation of the IHttpControllerSelector interface, which is defined in the System.Web.Http.Dispatcher namespace.

Instead, it is the SelectController method that is important, and it is called by the HttpControllerDispatcher to obtain an HttpControllerDescriptor object that describes the controller that can handle the request.

Table 19-6. The Members Defined by the HttpControllerDescriptor Class

|Name| Description|
|--|--|
|Configuration| Returns the HttpConfiguration object associated with the controller. Controllers can have their own configurations, as I explain in Chapter 22. |
|ControllerName| Returns the name of the controller. ControllerType Returns the Type of the controller. |
|CreateController(request)| Creates an instance of the controller that will handle the specified HttpRequestMessage object. |
|GetCustomAttributes<T>() |Returns the collection of attributes of type T that have been applied to the controller class.|
|GetFilters()| Returns the filters that have been applied to the class. I describe Web API filters in Chapters 23 and 24|

The default implementation of the IHttpControllerSelector interface is the DefaultHttpControllerSelector class, which is defined in the System.Web.Http.Dispatcher namespace.

During application startup, the DefaultHttpControllerSelector builds a list of all the controller classes in the application, which is later used as the basis for selecting a controller to handle each request.

It delegates the identification of controllers to the IHttpControllerTypeResolver interface,

The IHttpControllerTypeResolver interface defines the GetControllerTypes method, which is required to return a collection of all the controller types in the application.

The GetControllerTypes method is passed an implementation of the IAssembliesResolver interface.

This interface defines the GetAssemblies method, which is responsible for returning a collection of all the assemblies in the application,

DefaultAssembliesResolver class implements the IAssembliesResolver interface and returns all the assemblies in the application domain.

The default implementation of the IHttpControllerTypeResolver interface is the DefaultHttpControllerTypeResolver class, and it inspects the classes in the assemblies returned by the IAssembliesResolver interface and identifies those that are controllers.

Controllers are identified by three characteristics:

They are classes that implement the IHttpController interface. The name of the class has the Controller suffix (for example, ProductsController). The class is public and is not abstract.

The DefaultHttpControllerSelector class creates a cache of HttpControllerDescriptor objects for each controller class that the IHttpControllerTypeResolver implementation identifies.

> **Tip**  The controller classes are inspected at startup because it can be a slow process, especially for large projects. The set of controller classes that the DefaultHttpControllerSelector locates is cached so that the process is performed only when the application first starts.

##Activating the Controller##

The next step is to instantiate the controller class, a process known as activation.

Activation is performed by calling the CreateController method of the HttpControllerDescriptor class, which in turn delegates the process to an implementation of the IControllerActivator interface.

The default IHttpControllerActivator implementation is the DefaultHttpControllerActivator class, which is defined in the System.Web.Http.Dispatcher namespace.

##Executing the Controller##

The IHttpController interface defines the ExecuteAsync method, which is passed an HttpControllerContext and a CancellationToken. The purpose of the method is to asynchronously process the request using the information provided by the HttpControllerContext and return a Task that produces an HttpResponseMessage object when it completes.

The HttpControllerContext object is created by the HttpControllerDispatcher class in order to provide the controller with all the details it needs to do its work.

Table 19-7. The Properties Defined by the HttpControllerContext Class

|Name| Description|
|--|--|
|Configuration| Returns the HttpConfiguration object that should be used to service the request. As I explain in Chapter 22, controllers can be given their own configuration to work with. |
|Controller| Returns the IHttpController instance. This is not entirely useful when the HttpControllerContext is being passed an argument to the controller but is more useful when used for other tasks such as action method selection (which I describe in Chapter 22).|
|ControllerDescriptor| Returns the HttpControllerDescriptor that led to the controller being instantiated.|
|Request| Returns the HttpRequestMessage that describes the current request. |
|RequestContext| Returns the HttpRequestContext that provides additional information about the request.|
|RouteData| Returns the IHttpRouteData object that contains the routing data for the request. See Chapters 20 and 21 for details.|

Figure 19-5. The end-to-end Web API dispatch process

##Customizing the Dispatch Process##

The reason that there are so many interfaces involved in the dispatch process is so that the way requests are handled can be customized.

Table 19-8. The Extension Methods That Obtain Dispatcher Objects from the Services Collection

|Name| Description|
|--|--|
|GetAssembliesResolver() |Returns an implementation of the IAssembliesResolver interface|
|GetHttpControllerActivator() | Returns an implementation of the IHttpControllerActivator interface|
|GetHttpControllerSelector()| Returns an implementation of the IHttpControllerSelector interface|
|GetHttpControllerTypeResolver()| Returns an implementation of the IHttpControllerTypeResolver interface|

These extension methods are defined in the System.Web.Http namespace and operate on the ServicesContainer class.

```csharp
GlobalConfiguration.Configuration.Services.GetHttpControllerSelector()
```

The fact that implementation classes are located via the services collection means that it is easy to create and use custom classes to replace the defaults and that, if you do, you can take advantage of the services in your own classes so that you don’t have to reimplement the entire dispatch process.

The default dispatch process is suitable for most Web API applications, but customizations can be useful for integrating custom systems into Web API (such as custom authentication) or to support unusual or legacy clients.

You can use custom message handlers to adapt requests from difficult clients to the standard Web API model or to stop requests from being processed. Finer-grained customizations are possible by reimplementing the interfaces that are used to locate and select controller classes.

##Creating Custom Message Handlers##

Web API allows custom message handlers to be added to the chain between the HttpServer and HttpRoutingDispatch classes.

Custom message handlers are similar to traditional ASP.NET modules and can be used to prepare an HttpRequestMessage for process or modify an HttpResponseMessage before it is used to produce a response to the client.

Custom message handlers are derived from the DelegatingHandler class, which is derived from MessageHandler, but adds support for an inner handler, which is the next handler in the chain.

A custom handler can call the inner handler to advance the request to the next stage in the dispatch pipeline or generate a response itself to terminate the request handing process. As a demonstration, I created a folder called Infrastructure and added to it a class file called CustomMessageHandler.cs. Listing 19-6 shows the custom message handle that I created.

Listing 19-6. The Contents of the CustomMessageHandler.cs File

```csharp
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
namespace Dispatch.Infrastructure {
 public class CustomMessageHandler: DelegatingHandler {
  protected async override Task < HttpResponseMessage > SendAsync(HttpRequestMessage request, CancellationToken cancellationToken) {
   if (request.Method == HttpMethod.Post) {
    return request.CreateErrorResponse(HttpStatusCode.MethodNotAllowed, "POST Not Supported");
   } else {
    return await base.SendAsync(request, cancellationToken);
   }
  }
 }
}
```

Table 19-10. The Methods for Creating HttpResponseMessage Objects from an HttpRequestMessage

|Method| Description|
|--|--|
|CreateResponse() |Creates a basic HttpResponseMessage with the 200 (OK) status code and no content.|
|CreateResponse(status) |Creates an HttpResponseMessage with the specified status code, which is expressed as an HttpStatusCode value. |
|CreateResponse(data)| Creates an HttpResponseMessage with the 200 (OK) status code and the specified data object as the content. The data object is encoded using the content negotiation process that I described in Part 2.|
|CreateResponse(status, data) |Creates an HttpResponseMessage with the specified status code and data object. The status code is expressed as an HttpStatusCode, and the data object is encoded using the content negotiation process I described in Part 2.|
|CreateResponse(status, data, mime) |Creates an HttpResponseMessage with the specified status code and data object. The status code is expressed as an HttpStatusCode, and the data object is encoded using the specified MIME type using the media type formatter process I described in Part 2. |
|CreateErrorResponse(status, message) |Creates an HttpResponseMessage with the specified status code and error message. The status code is expressed using HttpStatusCode, and the message is a string. I describe Web API error handling in Part 2.|
|CreateErrorResponse(status, error) |Creates an HttpResponseMessage with the specified status code and error. The status code is expressed using HttpStatusCode, and the error is an HttpError. I describe Web API error handling in Chapter 25|

A message handle that returns an HttpResponseMessage from its SendAsync method terminates the normal process of the HttpRequestMessage through the chain of message handlers.

If a handler wants to pass on a request to the next handler in the chain, then it calls the SendAsync method of the base class and returns the result, like this:

```csharp 
return await base.SendAsync(request, cancellationToken);
```

Listing 19-7. Registering a Custom Message Handler in the WebApiConfig.cs File

```csharp 
config.MessageHandlers.Add(new CustomMessageHandler());
```

The MessageHandlers collection contains only custom message handlers, which are always placed after HttpServer and before HttpRoutingDispatcher in the message handler chain.

> **Caution**  A single instance of the message handler class is created and used to service all of the requests that the Web API application receives. This means your code must be thread-safe and must be able to deal with concurrent execution of the SendAsync method.

##Modifying Requests or Responses in a Message Handler##

The standard demonstration for message handlers is to add support for the X-HTTP-Method-Override header, which isn’t supported by Web API by default.

Listing 19-8. Supporting a Nonstandard Header in the CustomMessageHandler.cs

```csharp 
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Linq;
namespace Dispatch.Infrastructure {
 public class CustomMessageHandler: DelegatingHandler {
  protected async override Task < HttpResponseMessage > SendAsync(HttpRequestMessage request, CancellationToken cancellationToken) {
   if (request.Method == HttpMethod.Post && request.Headers.Contains("X-HTTP-Method-Override")) {
    HttpMethod requestedMethod = new HttpMethod(request.Headers.GetValues("X-HTTP-Method-Override").First());
    if (requestedMethod == HttpMethod.Put || requestedMethod == HttpMethod.Delete) {
     request.Method = requestedMethod;
    } else {
     return request.CreateErrorResponse(HttpStatusCode.MethodNotAllowed, "Only PUT and DELETE can be overridden");
    }
   }
   return await base.SendAsync(request, cancellationToken);
  }
 }
}
```


##UNDERSTANDING THE X-HTTP-METHOD-OVERRIDE HEADER##

The X-HTTP-Method-Override header allows clients to tell the web service that the request should be handled as though it has a different HTTP verb. For example, if the server receives an HTTP POST request with the X-HTTP-Method-Override set to PUT, then the request should be handled as though the PUT verb had been used. The X-HTTP-Method-Override arose to work around limitations in some clients that could send only GET or POST requests or to work around firewalls that blocked any verb except GET or POST. Using the X-HTTP-Method-Override allows clients to work around these limitations and take full advantage of a RESTful web service. As helpful as the X-HTTP-Method-Override header can be, it requires coordination between the client and the server: the client needs to know that the server is looking for the header and will honor it. If the client and server are not coordinated, then the header will be ignored, and POST requests will always be taken as POST requests, even if the X-HTTP-Method-Override header specifies a different verb. In addition, clients have no way of knowing whether there are verbs that cannot be used; there is no way of detecting the policy of a corporate firewall, for example. In short, the X-HTTP-Method-Override has some issues, and I recommend avoiding it if at all possible. It is no accident that neither Web API nor the MVC framework supports the header.

```csharp
if (verb != "GET" && verb != "POST") {
 config.type = "POST";
 config.headers = {
  "X-HTTP-Method-Override": verb
 };
}
```

##Using Message Handlers as Diagnostic Tools##

I find message handlers most useful as a diagnostic tool for when I can’t figure out the cause of a problem and I start to lose trust in my tools.

You can manually apply breakpoints to your application code, but a request handler can break the debugger while the request has just entered the world of Web API.

Listing 19-10. Creating a Diagnostic Tool in the CustomMessageHandler.cs File

```csharp
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using System.Linq;
namespace Dispatch.Infrastructure {
 public class CustomMessageHandler: DelegatingHandler {
  protected async override Task < HttpResponseMessage > SendAsync(HttpRequestMessage request, CancellationToken cancellationToken) {
   if (request.Method == HttpMethod.Post) {
    System.Diagnostics.Debugger.Break();
   }
   return await base.SendAsync(request, cancellationToken);
  }
 }
}
```

The System.Diagnostics.Debugger class controls the debugger, and the Break method stops execution of the application and hands it control.

##Customizing Other Dispatch Components##

You can create custom implementations of all the interfaces that I described in this chapter, but there is little point in doing so because the Web API default implementations are serviceable for most applications.

#CHAPTER 20 URL Routing: Part I#

##Understanding URL Routing##

The purpose of URL routing is to match HTTP requests to routes, which contain instructions for producing routing data that is consumed by other components.

The HttpRoutingDispatcher message handler is responsible for processing HttpRequestMessage objects in order to produce routing data and assign it to the HttpRequestContext.RouteData property.

##Understanding the Routing Classes and Interfaces##

There are four important types within URL routing: the IHttpRoute and IHttpRouteData interfaces and the HttpRouteCollection class.

The IHttpRoute interface describes a route, and Web API provides a default implementation—the HttpRoute class—that is used in most applications.

Table 20-3. The Most Important URL Routing Classes and Interfaces 

|Name| Description|
|--|--|
|IHttpRoute| This interface describes a route. See the “Understanding the IHttpRoute Interface” section.|
|HttpRoute| This is the default implementation of the IHttpRoute interface. IHttpRouteData This interface describes the collection of data values extracted from a request. See the “Understanding the IHttpRouteData Interface” section.|
|HttpRouteData| This is the default implementation of the IHttpRouteData interface. IHttpRouteConstraint This interface defines a restriction that limits the requests that a route will match. See the “Using Routing Constraints” section.|
|HttpRouteCollection| This is the class with which routes are registered and which receives requests from the|
|HttpRoutingDispatcher.| See the “Understanding the HttpRouteCollection Class” section.|
|HttpRoutingDispatcher| This message handler class integrates routing into the dispatch process. See Chapter 19.|
|RouteAttribute |This class defines the Route attribute used to create direct routes on controller classes and action methods. See Chapter 21.|
|RouteFactoryAttribute| This class allows custom attributes to be defined that customize the generation of direct routes. See Chapter 21. RoutePrefix This attribute is used to define a route template prefix that applies to all of the direct routes defined on a controller. See Chapter 21|

Figure 20-3. Updating the dispatch diagram

##Understanding the IHttpRouteData Interface##

The IHttpRouteData interface describes the collection of data values that are extracted from a request when it is processed.

Table 20-4. The Properties Defined by the IHttpRouteData Interface

|Name| Description|
|--|--|
|Route| Returns the IHttpRoute object that generated the route data|
|Values| Returns an IDictionary<string, object> that contains the routing data|

An implementation of the IHttpRouteData interface is the result of the URL routing process and the means by which the routing system provides data about the request for other components to consume.

The Values property is used to access the routing data that has been extracted from a request.

##Understanding the IHttpRoute Interface##

Routes are described by the IHttpRoute interface,

Table 20-5. The Methods and Properties Defined by the IHttpRoute Interface

|Name| Description|
|--|--|
|RouteTemplate| Returns the template used to match requests. See the “Using Route Templates” section.|
|Defaults| Returns an IDictionary<string, object> used to provide default values for routing data properties when they are not included in the request. Defaults are usually defined as a dynamic object, as demonstrated in the “Using Routing Data Default Values” section. |
|Constraints| Returns an IDictionary<string, object> used to restrict the range of requests that the route will match. Constraints are usually defined as a dynamic object, as demonstrated in the “Using Routing Constraints” section.|
|DataTokens| Returns an IDictionary<string, object> with data values that are available to the routing handler. See Chapter 21. |
|Handler| Returns the HttpMessageHandler onto which the request will be passed. This property overrides the standard dispatch process.|
|GetRouteData(path, request) |Called by the routing system to generate the routing data for the request.|

##Understanding the HttpRouteCollection Class##

The HttpRouteCollection class orchestrates the entire routing process, and as a consequence, it plays several different roles.

First, the HttpRouteCollection provides the CreateRoute method that creates new routes using the HttpRoute class, which is the default implementation of the IHttpRoute interface.

Table 20-6. The HttpRouteCollection Methods for Creating New Routes

|Name| Description|
|--|--|
|CreateRoute(template,defaults, constraints)| Returns an IHttpRoute implementation object that has been configured with the specified template, defaults, and constraints |
|CreateRoute(template, defaults,constraints, tokens) |
|Returns an IHttpRoute implementation object that has been configured with the specified template, defaults, constraints, and tokens|
|CreateRoute(template, defaults,constraints, tokens, handler) |Returns an IHttpRoute implementation object that has been configured with the specified template, defaults, constraints, tokens, and message handler|

The CreateRoute method creates the route, but it doesn’t register it so that it will be used to match requests.

The second role that the HttpRouteCollection class plays is to provide a collection that is used to register routes for use with an application.

Table 20-7. The Collection Members Defined by the HttpRouteCollection Class

|Name| Description|
|--|--|
|Count| This returns the number of routes in the collection.|
|Add(name, route) This adds a new route to the collection. |
|Clear() |This removes all the routes from the collection. |
|Contains(route)| This returns true if the collection contains the specified route. |
|ContainsKey(name) |This returns true if the collection contains a route with the specified name.|
|Insert(index, name, route)| This inserts a route with the specified name at the specified index.|
|Remove(name)| This removes the route with the specified name from the collection.|
|TryGetValue(name, out route) | This attempts to retrieve a route with the specified name from the collection. If there is a route with that name, the method returns true and assigns the route to the out parameter.|
|this[int]| The HttpRouteCollection class defines an array-style indexer that retrieves routes by their position in the collection. |
|this[name]| The HttpRouteCollection class defines an array-style indexer that retrieves routes by their name.|

> **Note**  As you will learn, routes are tested to see whether they can match a request, which means that the order in which the routes are added to the collection is important.

Just as with the MVC framework, you should add the most specific routes first so that they are able to match requests before more general routes.

Table 20-8. The HttpRouteCollection Extension Methods

|Name| Description|
|--|--|
|IgnoreRoute(name, template)| Creates and registers a route with the specified name and template that prevents a request from being handled by Web API |
|IgnoreRoute(name, template,constraints)| Creates and registers a route with the specified name, template, and constraints that prevents a request from being handled by Web API|
|MapHttpBatchRoute(name,template handler)| Creates and registers a route for the batch handling of HTTP requests|
|MapHttpRoute(name, template)| Creates and registers a route with the specified name and template |
|MapHttpRoute(name, template,defaults)|  Creates and registers a route with the specified name, template, and defaults|
|MapHttpRoute(name, template,defaults, constraints)|  Creates and registers a route with the specified name, template, defaults, and constraints |
|MapHttpRoute(name, template,defaults, constraints, handler) |Creates and registers a route with the specified name, template, defaults, constraints, and message handler|

##Understanding the Route Attributes##

The Route attribute—defined as the RouteAttribute class in the System.Web.Http.Routing namespace—is applied directly to classes and methods. This is the direct or attribute style of routing, where the routes are more specific than those in the WebConfig.cs file and are defined alongside the code that will handle the request.

##Working with Convention-Based Routing##

Convention-based routing defines URL routes in a single location—the WebApiConfig.cs file—for the entire application. The alternative is to define routes by applying attributes to classes and methods,

The default routing configuration relies on matching action methods based on the HTTP verb.

##Using Route Templates##

Templates are at the heart of the routing system and are the start point for matching requests and extracting information from the URL. Web API route templates work in the same way as those in the MVC framework, and you can see an example of a Web API route template in the WebApiConfig.cs

``csharp
config.Routes.MapHttpRoute(name: "DefaultApi", routeTemplate: "api/{controller}/{id}", 
  defaults: new { id = RouteParameter.Optional
});
```

Routing templates match requests based on the segments in the URL that has been asked for using a system of fixed (or static) and variable segments.

Fixed segments will match URLs only if they have the same text in the corresponding segment.

> **Tip**  Route templates are defined without a leading / character. If you do put in a leading /, then an exception will be thrown when the application is started.

The template variable segments will match any URL that has a corresponding segment, irrespective of what the value of the segment is. Variable segments are denoted with the { and } characters, and the value of the URL segment is assigned to a variable of the specified name in the routing data, known—confusingly—as segment variables.

```csharp
routeTemplate: "api/{controller}/{id}",
```

##Routing to the New Controller##

Two segment variables have special importance in Web API: controller and action.

This is because Web API uses the HTTP verb from the request to select an action method by default.

##Mapping Request Verbs to Action Methods##

One way to give the action method selection mechanism the information it requires is to specify which HTTP verbs an action method can handle.

```csharp
[HttpGet]
public string DayOfWeek() {
  return DateTime.Now.ToString("dddd");
```

There are attributes for different HTTP verbs: HttpGet, HttpPost, HttpPut, and so on.

You don’t need to use these attributes if the action methods in your controller follow the Web API RESTful pattern,

However, caution is required because it is easy to create an unwanted effect. Using a verb attribute allows the default route to direct requests to the DayOfWeek action method, but it does so using only part of the URL that has been requested.

Listing 20-7. Adding a New Action Method to the TodayController.cs File

```csharp
using System;
using System.Web.Http;
namespace Dispatch.Controllers {
 public class TodayController: ApiController {

  [HttpGet] public string DayOfWeek() {
   return DateTime.Now.ToString("dddd");
  }
  
  [HttpGet] public int DayNumber() {
   return DateTime.Now.Day;
  }
 }
}
```

you will see a 500 (Internal Server Error) message reported.

Multiple actions were found that match the request

It is impossible to differentiate between the action methods when only the controller routing variable and the verb specified by the attributes are available with which to make a decision.

##Creating a Custom Route Template##

a better solution to this problem is to define a custom route that has a template that uses all of the information in the URL sent by the client.

Listing 20-8. Defining a Custom Route in the WebApiConfig.cs File

```csharp

config.Routes.MapHttpRoute(
  name: "IncludeAction",
  routeTemplate: "api/{controller}/{action}"
);
```

> **Caution**  The route that I have added in Listing 20-8 contains a common problem that prevents requests to the Products controller from working correctly. I explain what the problem is and how to avoid it in Chapter 22

A route variable called action. This is one of the special variables—along with controller—that

If the route data contains an action value, then it is used in preference to the HTTP verb to select the action method.

> **Tip**  Route template segments usually match exactly one URL segment, but you can make the last segment in a template match multiple URL segments by prefixing it with an asterisk, such as {*catchall}. This feature isn’t often needed in web services because the request URL generally contains the segments needed to target the controller (and, optionally, the action method) and the data required for parameter binding

The URL routing system evaluates routes in the order in which they are defined in the HttpRouteCollection, and the evaluation process stops as soon as a route is found that matches the current request.

##SPECIFYING ROUTE PARAMETER NAMES##

##UNDERSTANDING THE URL PREFIX##

The convention is to prefix Web API URLs with /api, which is why the route templates I define in this chapter begin with a fixed /api segment.

Web API has its own implementation of the routing system, but when the application is hosted by IIS—which is required when using the MVC framework as well—then the Web API routes are consolidated with the MVC routes into a single collection.

The order in which the Web API and MVC framework routes are arranged depends on the Application_Start method defined in the Global.asax file.

You can change the order so that the MVC routes are defined first if you prefer. Whichever way the routes are set up, you must ensure that requests are routed to the right part of the application—and that is where the /api prefix helps, by defining a fixed segment that clearly denotes web service requests and allows them to be captured by the Web API

##Controlling Route Matching##

Controlling route matching can be useful in a complex application where it is difficult to direct requests to the correct controller and action method.

If you rely heavily on defaults and constraints to match requests, then it may be worth reconsidering the design of the application. Complex route configurations are rarely required in a Web API application and can suggest a structural problem that might be addressed by simplifying and consolidating the web service controllers.

##Using Routing Data Default Values##

##Using Segment Defaults to Restrict Matches##

The most direct way to limit the set of URLs that a route will match is to increase the number of fixed segments.

Listing 20-9. Fixing the Controller Segment in the Custom Route in the WebApiConfig.cs

```csharp
config.Routes.MapHttpRoute(
  name: "IncludeAction",
  routeTemplate: "api/today/{action}",
  defaults: new { controller = "today" }
);
```

Using Optional Segments to Widen Matches

Listing 20-10. Using Optional Segments in the WebApiConfig.cs File

```csharp
config.Routes.MapHttpRoute(
  name: "IncludeAction",
  routeTemplate: "api/today/{action}/{day}",
  defaults: new {
    controller = "today",
    day = RouteParameter.Optional
  }
);
```

```csharp
[HttpGet]
public string DayOfWeek(int day) {
  return Enum.GetValues(typeof(DayOfWeek)).GetValue(day).ToString();
}
```

```csharp
[HttpGet]
public int DayNumber() {
  return DateTime.Now.Day;
}
```

> **Tip**  Notice that I still have to apply the HttpGet attribute. The action route data variable helps the action method selection process, but Web API still checks for the attribute that corresponds to the HTTP verb as a precaution before executing the method.

When the action method is selected, the presence of a day variable in the route data will determine the version of the method chosen.

##Using Default Segment Values to Widen Matches##

The standard use of default values is to allow a range of URLs to be mapped to a single action method by providing a value for the routing data that is used when a segment isn’t defined in the request URL.

Listing 20-12. Setting a Default Value for a Custom Route in the WebApiConfig.cs File

```csharp

config.Routes.MapHttpRoute(
  name: "IncludeAction",
  routeTemplate: "api/today/{action}/{day}",
  defaults: new {
    controller = "today",
    day = 6
  }
);
```

##Using Routing Constraints##

Routing constraints allow you to narrow the range of requests that a route will match by adding additional checks beyond matching the routing template.

> **Caution**  Use constraints only to control route matching and not to perform validation of the data values that will be used as action method parameters or by the parameter binding process

Using routing constraints to perform validation will cause the client to receive a 404 (Not Found) response for requests

##Understanding Constraints##

Aonstraints are expressed using implementations of the IHttpRouteConstraint interface, which is defined in the System.Web.Http.Routing namespace.

The IHttpRouteConstraint interface defines the Match method, which is passed arguments required to constrain the match: the HttpRequestMessage object that represents the request, the IHttpRoute object that is trying to match the request, the name of the parameter that the constraint is being applied to, and a dictionary containing the data matched from the request.

The final parameter is an HttpRouteDirection value, which is used to indicate whether the route is being applied to an incoming request or being used to generate an outgoing URL.

##Creating a Custom Constraint##

Listing 20-13. The Contents of the UserAgentConstraint.cs File

```csharp
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web.Http.Routing;
namespace Dispatch.Infrastructure {
 public class UserAgentConstraint: IHttpRouteConstraint {

  private string requiredUA;

  public UserAgentConstraint(string agentParam) {
   requiredUA = agentParam.ToLowerInvariant();
  }

  public bool Match(HttpRequestMessage request, IHttpRoute route, string parameterName, IDictionary < string, object > values, HttpRouteDirection routeDirection) {
   return request.Headers.UserAgent.Where(x => x.Product != null && x.Product.Name != null && x.Product.Name.ToLowerInvariant().Contains(requiredUA)).Count() > 0;
  }
 }
}
```

Listing 20-14. Defining Routes in the WebApiConfig.cs File

```csharp
config.Routes.MapHttpRoute(name: "ChromeRoute", routeTemplate: "api/today/DayOfWeek", 
  defaults: new {
    controller = "today", action = "dayofweek"
  }, constraints: new {
     useragent = new UserAgentConstraint("Chrome")
});

config.Routes.MapHttpRoute(name: "NotChromeRoute", routeTemplate: "api/today/DayOfWeek", defaults: new {
 controller = "today", action = "daynumber"
});
```

##Using the Built-in Constraints##

The System.Web.Http.Routing.Constraints namespace contains classes that provide a range of built-in constraints.

Table 20-11. The Built-in Route Constraint Classes

|Name| Description|
|--|--|
|AlphaRouteConstraint| Matches a route when the segment variable contains only alphabetic characters.|
|BoolRouteConstraint | Matches a route when the segment variable contains only true or false.|
|DateTimeRouteConstraint|  Matches a route when the segment variable can be parsed as a DateTime object.|
|DecimalRouteConstraint, DoubleRouteConstraint,  FloatRouteConstraint,  IntRouteConstraint,  LongRouteConstraint| Matches a route when the segment variable can be parsed as a decimal, double, float, int, or long value.|
|HttpMethodConstraint| Matches a route when the request has been made with a specific verb. (This class is defined in the System.Web.Http.Routing namespace.) |
|MaxLengthRouteConstraint,  MinLengthRouteConstraint| Matches a route when the segment variable is a string with a maximum or minimum length.|
|MaxRouteConstraint MinRouteConstraint| Matches a route when the segment variable is an int with a maximum or minimum value.|
|RangeRouteConstraint|  Matches a route when the segment variable is an int within a range of values.|
|RegexRouteConstraint| Matches a route when the segment variable matches a regular expression.|

```csharp
config.Routes.MapHttpRoute(name: "ChromeRoute", routeTemplate: "api/today/{action}", defaults: new {
 controller = "today"
}, constraints: new {
 useragent = new UserAgentConstraint("Chrome"), action = new RegexRouteConstraint("daynumber|othermethod")
});
```

> **Notice** that I have assigned the RegexRouteConstraint object to a property called action in the dynamic object used to set the constraints property. This is how you tell the routing system which route data variable the constraint applies to.