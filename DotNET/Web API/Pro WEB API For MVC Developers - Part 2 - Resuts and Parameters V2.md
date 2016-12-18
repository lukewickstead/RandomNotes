#CHAPTER 9 The Anatomy of ASP.NET Web API#

##Understanding the Web API Namespaces and Types##

Table 9-1. Commonly Used MVC Framework Classes and Their Web API Counterparts

|MVC Class or Interface| Web API Equivalent|
|--|--|
|System.Web.Mvc.IController| System.Web.Http.Controllers.IHttpController|
|System.Web.Mvc.Controller| System.Web.Http.ApiController|
|System.Web.HttpContext |System.Web.Http.Controllers.HttpRequestContext |
|System.Web.HttpRequest | System.Net.Http.HttpRequestMessage |
|System.Web.HttpResponse |System.Net.Http.HttpResponseMessage |
|System.Web.HttpApplication |System.Web.Http.HttpConfiguration|

Web API builds on the System.Net.Http namespace, which was introduced in .NET 4.5 and provides a set of classes that allow any .NET application to support HTTP by providing objects that describe HTTP in a neutral way.

Functionality that is specified to Web API is contained in the System.Web.Http namespace and its children, defined as regular interfaces and classes or defined as extension methods that operate on System.Net.Http classes.

The engine for this change is a standard called Open Web Interface for .NET (OWIN) that allows more flexibility in how Web API applications are hosted.

Table 9-2. The Main Web API Namespaces

|Namespace |Description |
|--|--|
|System.Net.Http| This namespace defines types that represent HTTP requests and responses.|
|System.Net.Http.Formatting |This namespace contains the media type formatters, which are used to serialize data sent to the client and to create model objects from requests. See Chapters 12–17 for details.|
|System.Web.Http |This is the top-level Web API namespace. The most important class for most projects is ApiController, which is the base for Web API controllers and which I describe in Chapter 22, but there are many other useful classes in this namespace.|
|System.Web.Http.Controllers |This namespace contains the interface that defines a controller (IHttpController) and all of the support classes that the most common controller base class—ApiController—requires. See Chapter 22 for details of how controllers are used in Web API, and see the chapters in this part of the book for details of the features that ApiController brings conveniently together.|
|System.Web.Http.Dependencies| This namespace contains the classes that provide dependency injection, which I describe in Chapter 10. |
|System.Web.Http.Dispatcher |This namespace contains the classes that manage the Web API request dispatch process from receiving a request from the hosting platform through to selecting and executing a controller. I describe the dispatch process in Part 3 of this book.|
|System.Web.Http.Filters |This namespace contains the filters support, which allows for additional logic to be inserted into the dispatch process. I describe filters in Chapters 23 and 24.|
|System.Web.Http.Metadata |This namespace contains classes that provide descriptions of model classes. These classes are not used directly but are presented through context objects in the dispatch process (which is the topic of Part 3 of this book) or when data provided by a client is being validated (which I describe in Chapter 18).|
|System.Web.Http.ModelBinding |This namespace contains classes responsible for creating objects and values from HTTP requests that can be used by action methods. I describe the model binding process in Chapter 14 and explain how the process works in detail in Chapters 15–17.|
|System.Web.Http.Results| This namespace contains classes that implement the IHttpActionResult interface, which is used by action methods to describe the responses that will be sent to a client. I describe action method results in Chapter 11.|
|System.Web.Http.Routing |This namespace contains the Web API URL routing classes, which I describe in Chapters 20 and 21.|
|System.Web.Http.Validation|This namespace contains the classes that are used to validate data sent from a client, a process I describe in Chapter 18.|
|System.Web.Http.ValueProviders|This namespace contains classes that are used to retrieve values from requests so that they can be used with action methods. I describe this process in Chapters 14–17.|

##Understanding the Web API Context Objects##

Web API provides a set of objects that provide context about the state of the application and the request that is being handled.

##Properties defined by the ApiController##

Table 9-3. The Context Properties Defined by the ApiController Class

|Name |Description|
|--|--|
|Configuration| Returns an HttpConfiguration object, which provides information about the configuration of the application. See Chapter 10. |
|ControllerContext |Returns the HttpControllerContext object that was passed to the controller’s ExecuteAsync method. See Table 9-6.|
|ModelState |Returns the object used for model binding validation. See Chapter 18.|
|Request| Returns the HttpRequestMessage that describes the current request. See Table 9-4.|
|RequestContext |Returns an HttpRequestContext object that provides Web API–specific information about the current request. See Table 9-5.|
|User |Returns details of the user associated with the current request. See Chapters 5, 23, and 24.|

##Getting Information About the Request##

Table 9-4. The Properties Defined by the HttpRequestMessage Class

|Name| Description |
|--|--|
|Content| Returns an HttpContent object that contains the content of the HTTP request. Request content is generally accessed through the model binding feature, which I describe in Chapter 14.|
|Headers | Returns an HttpRequestHeaders object that contains the headers sent by the client. I use request headers to demonstrate several features, including data binding (in Chapter 14) and URL routing (in Chapters 20 and 21). |
|Method| Returns an HttpMethod object that describes the HTTP method/verb for the request. |
|Properties| Returns a collection that contains objects provided by the hosting environment or by components that need to communicate with one another. Many of the objects that Web API uses to provide context information define a Properties property, but the only one that I use in this book is the one defined by the HttpRequestMessage object in Chapter 23.|
|RequestUri| Returns the URL requested by the client, expressed as an Uri object.|
|Version| Returns the version of HTTP that was used to make the request, expressed as a System.Version object.|

The HttpRequestMessage class provides a generalized view of an HTTP request, without any detail that is specific to web services.

Web API supplements the HttpRequestMessage class with the HttpRequestContext class,

Table 9-5. The Properties Defined by the HttpRequestContext Class


|Name| Description |
|--|--|
|Configuration |This property returns the HttpConfiguration object associated with the current request. I describe the HttpConfiguration class in Chapter 10 and explain how to apply custom configurations to individual controllers in Chapter 22. |
|IncludeErrorDetail |This property is used to control the amount of information sent to the client when an exception is thrown and in an action method or filter and left unhandled. See Chapter 25 for details. |
|IsLocal |This property returns true if the request originates from the local computer.|
|Principal| This property returns the IPrincipal implementation object that describes the user associated with the request. I used this property in Chapters 6 and 7 for the SportsStore application, and I demonstrate how to create a custom—albeit simple—authentication mechanism in Chapters 23 and 24.|
|RouteData| This property returns the routing data associated with the request. See Chapters 20 and 21|

##Getting Information About the Controller##

The HttpControllerContext class provides access to much of the same context data as the HttpRequestContext class but also describes the controller.

Table 9-6. The Properties Defined by the HttpControllerContext Class

|Name| Description|
|--|--|
|Configuration |Returns a System.Web.Http.HttpConfiguration object, which provides information about the configuration of the application. See Chapter 10.|
|Controller| Returns the System.Web.Http.Controllers.IHttpController implementation that is handling the request. See Chapter 22.|
|ControllerDescriptor | Returns a System.Web.Http.Controllers.HttpControllerDescriptor object that provides information about the controller, which can be used to select controllers to handle a request, as described in Chapter 19.|
|Request| Returns a System.Net.Http.HttpRequestMessage that provides information about the request being handled. See Table 9-4. |
|RequestContext | Returns a System.Web.Http.Controllers.HttpRequestContext object that provides Web API–specific information about the request, including details of the user identity associated with the request. See Table 9-5 for details.  |
| RouteData | Returns a System.Web.Http.Routing.IHttpRouteData implementation that provides information about how the request was routed. See Chapters 20 and 21 for details of Web API routing.|

##Getting Information About Everything Else##

Table 9-7. The Web API Context Classes

|Name| Description|
|--|--|
|ExceptionHandlerContext |This class is used to provide context information to global exception handlers. See Chapter 25.|
|ExceptionLoggerContext |This class is used to provide context information to global exception loggers. See Chapter 25. |
|HttpActionContext |This class is used to describe an action method and is employed as part of the data binding process. See Chapter 15.|
| HttpActionDescriptor| This class is used to describe an action method and is employed as part of the data binding process. See Chapter 15.|
|HttpActionExecutedContext| This class is used to provide context information to exception filters. See Chapter 24.|
|HttpAuthenticationChallengeContext |This class is used to provide context information to authentication filters. See Chapter 23. |
|HttpAuthenticationContext |This class is used to provide context information to authentication filters. See Chapter 23.| 
|HttpControllerContext| This class is used to provide a controller with the information it needs to process a request. See Chapter 19.|
|HttpControllerDescriptor| This class is used during the selection of a controller to process a request. See Chapter 19.| 
|HttpParameterDescriptor| This class is used to describe an action method parameter during the data binding process. See Chapter 15.|
|HttpRequestContext| This class is used to provide context information about a request. See Table 9-5.|
|ModelBindingContext| This class is used to provide context information about a model class during the data binding process. See Chapter 16|

##Understanding the Web API Components##

###Application Configuration###

Configuration is performed in the App_Start/WebApiConfig.cs

URL routing—to the Register method,

Remember not to do any configuration in the Global Application Class (the Global.asax.cs file) because it isn’t supported for all Web API deployment options.

##Controllers, Actions, and Results##

Web services are defined through controllers. The most common way to create a controller is to derive a class from ApiController, which is defined in the System.Web.Http namespace.

You can also implement your own approach to processing requests by implementing the IHttpController interface.

##Services##

ASP.NET Web API defines a set of interfaces and classes that are used to process requests, and these are known as services.

Services are either single-instance or multiple-instance. For single-instance services, there is a single implementation of the service interface used across the entire application. An example of a single-instance service interface is IHttpActionInvoker, which I describe in Chapter 22 and which is responsible for invoking action methods in Web API controllers.

For multiple-instance services, several implementations are available, presenting a choice about which one is used. An example is the ModelBinderProvider class, which I describe in Chapter 16 and which provides a model binder for a given type.

Services are set up and accessed through the HttpConfiguration.Services property; this property returns an instance of the ServicesContainer class, which is defined in the System.Web.Http.Controllers namespace.

Table 9-8. The Methods Defined by the ServicesContainer Class

|Name| Description|
|--|--|
|Add(service, impl)| Adds a new implementation of the specified service interface to the collection. There is also an AddRange method that allows multiple implementation objects to be added in a single method call.|
|AddRange(service, impls) |Adds an enumeration of implementations of the specified interface to the collection. |
|Clear(service) |Removes all implementations of the specified service interface from the collection. |
|GetService(service)| Gets an implementation of the specified single-instance service. |
|GetServices(service)| Gets the implementations of the specified multiple-instance service. |
|Insert(service, index,     impl) | Inserts an implementation of a multiple-instance service into the collection at a specific index. There is also an InsertRange method that allows multiple implementation objects to be inserted in a single method call. |
|IsSingleService(service) |Returns true if the specified service interface is single-instance and false if it is a multiple-instance service. |
|Remove(service, impl) | Removes the specified implementation of a service interface from the collection. There are also RemoveAll and RemoveAt methods that allow multiple implementation objects to be removed or an object at a specified index to be removed. |
|Replace(service, impl) |Replaces the implementation object for the specified service in the collection. This method works for single- and multiple-instance services.|

> **Tip**  Implementations of the service interfaces can also be provided through dependency injection, which I describe in Chapter 10.

Web API provides a set of extension methods that provide strongly typed access to specific services.

Table 9-9. The Extension Methods Defined for the ServicesContainer Class

|Name| Description |
|--|--|
|GetActionInvoker| This method returns an implementation of the IHttpActionInvoker interface, which is responsible for executing an action method. See Chapter 22. GetActionSelector This method returns an implementation of the IHttpActionSelector interface, which is responsible for selecting an action method. See Chapter 22. |
|GetActionValueBinder| This method returns an implementation of the IActionValueBinder interface, which is used to bind values for action method parameters. See Chapter 17.|
|GetAssembliesResolver |This method returns an implementation of the IAssembliesResolver interface, which is used to locate controller classes when the application starts. See Chapter 19.|
|GetContentNegotiator |This method returns an implementation of the IContentNegotiator interface, which is used to select a media type formatter to serialize the data in a response. See Chapter 11.|
|GetExceptionHandler | This method returns an implementation of the IExceptionHandler interface, which is used to define the way that unhandled exceptions are processed to create client responses. See Chapter 25. |
|GetExceptionLoggers| This method returns all of the registered implementations of the IExceptionLogger interface, which are used to record unhandled exceptions. See Chapter 25. |
|GetHttpControllerActivator| This method returns an implementation of the IHttpControllerActivator interface, which is used to instantiate controller classes. See Chapter 19.|
|GetHttpControllerSelector |This method returns an implementation of the IHttpControllerSelector interface, which is used to select controllers. See Chapter 19. |
|GetHttpControllerTypeResolver | This method returns an implementation of the IHttpControllerTypeResolver, which is used to locate controller classes when the application starts. See Chapter 19. 
| GetModelBinderProviders | This method returns all of the registered classes that are derived from the abstract ModelBinderProvider class, which are used during the model binding process. See Chapter 16. |
|GetValueProviderFactories | This method returns all of the registered classes that are derived from the abstract ValueProviderFactory class, which are used during the parameter binding process. See Chapter 15|

##Dispatchers and Handlers##

Web API has a well-defined model for processing requests, which I describe in Part 3 of this book.

#CHAPTER 10 Creating and Configuring a Web API Application#

##Preparing the Example Project##

Select the ASP.NET Web Application project type, and set the name to ExampleApp. Click the OK button to advance through the wizard, selecting the Empty project template and checking the options to add the core references for MVC and Web API,

After Visual Studio finishes creating the project, enter the following commands into the Package Manager Console to get the NuGet packages that are required:

```
Update-Package microsoft.aspnet.mvc -version 5.1.1 
Update-Package microsoft.aspnet.webapi -version 5.1.1 
Update-Package Newtonsoft.json -version 6.0.1 

Install-Package jquery -version 2.1.0 
Install-Package bootstrap -version 3.1.1 
Install-Package knockoutjs –version 3.1.0
```

##Creating the Model and Repository##

Listing 10-1. The Contents of the Product.cs File

```cs
namespace ExampleApp.Models {
  public class Product {
    public int ProductID { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
  }
}
```

Listing 10-2. The Contents of the Repository.cs File

```cs 
using System.Collections.Generic;

namespace ExampleApp.Models {
 public class Repository {
  private Dictionary < int, Product > data;
  private static Repository repo;
  
  static Repository() {
   repo = new Repository();
  }
  
  public static Repository Current {
   get { return repo; }
  }

  public Repository() {

   Product[] products = new Product[] {
    new Product {
     ProductID = 1, Name = "Kayak", Price = 275 M
    }, new Product {
     ProductID = 2, Name = "Lifejacket", Price = 48.95 M
    }, new Product {
     ProductID = 3, Name = "Soccer Ball", Price = 19.50 M
    }, new Product {
     ProductID = 4, Name = "Thinking Cap", Price = 16 M
    },
   };

   data = new Dictionary < int, Product > ();

   foreach(Product prod in products) {
    data.Add(prod.ProductID, prod);
   }
  }
  
  public IEnumerable < Product > Products {
   get { return data.Values; }
  }
  
  public Product GetProduct(int id) {
   return data[id];
  }
  
  public Product SaveProduct(Product newProduct) {
   newProduct.ProductID = data.Keys.Count + 1;
   return data[newProduct.ProductID] = newProduct;
  }
  
  public Product DeleteProduct(int id) {
   Product prod = data[id];
   if (prod != null) {
    data.Remove(id);
   }
   return prod;
  }
 }
}
```

##Creating an HTTP Web Service##

Right-clicked the Controllers folder, selected Add Controller from the pop-up menu, and selected Web API 2 Controller – Empty from the list of controller types.

> **Tip**  By default, the action method is targeted with an HTTP GET request sent to the /api/products URL. I explain how this is handled in Chapter 22.

Listing 10-3. The Contents of the ProductsController.cs File 

```cs
using System.Collections.Generic;
using System.Web.Http;
using ExampleApp.Models;

namespace ExampleApp.Controllers {
 public class ProductsController: ApiController {

  Repository repo;

  public ProductsController() {
   repo = Repository.Current;
  }

  public IEnumerable < Product > GetAll() {
   return repo.Products;
  }
 }
}
```


##Configuring a Web API Application##

Web API applications are configured in a new and different way.

When hosting Web API in IIS, either hosted locally or on Azure, the starting point for the configuration process is the Global Application Class, just as it is for the MVC framework. However, not all Web API deployment options have a global application class, and it is used only to bootstrap the configuration process.

Listing 10-8. The Contents of the Global.asax.cs File

```cs
void Application_Start(object sender, EventArgs e) {
  AreaRegistration.RegisterAllAreas();
  GlobalConfiguration.Configure(WebApiConfig.Register);
  RouteConfig.RegisterRoutes(RouteTable.Routes);
```

The important statement is this one, which kicks off the Web API configuration process:

Table 10-3. The Members Defined by the GlobalConfiguration Class

|Name| Description|
|--|--|
|Configuration| Returns an HttpConfiguration object that represents the Web API configuration. See Table 10-4 for details.|
|DefaultHandler |Returns the HttpMessageHandler that is used to handle requests by default. See Chapter 19.|
|Configure(callback) |Registers a callback method that will be invoked to configure the application.|

>**Caution**  Do not add configuration statements for Web API components to the Global Application Class because it won’t be available if you deploy your web service outside of IIS or Azure.

The Configure method allows a callback method to be specified that will be passed a System.Web.Http.HttpConfiguration object so that Web API can be configured.

> **Tip**  An instance of the HttpConfiguration class is accessible throughout the application via the static GlobalConfiguration.Configuration property

The default configuration statements in the WebApiConfig.cs file sets up the URL routing,

> **Tip**  Notice that the routing configuration for Web API is kept separate from the RouteConfig.cs file used to configure routes for MVC framework and Web Forms applications.

##Understanding the Configuration Object##

The Web API configuration is managed through an instance of the HttpConfiguration class, which presents a series of properties that return objects that determine how Web API will handle HTTP requests.

Table 10-4. The Properties Defined by the HttpConfiguration Class

|Name| Description|
|--|--|
|DependencyResolver| Gets or sets the class used for dependency injection. See the “Configuring Web API Dependency Injection” section of this chapter. |
|Filters| Gets or sets the request filters, which I describe in Chapters 23 and 24.|
|Formatters| Gets or sets the media type formatters, which I describe in Chapters 12 and 13.|
|IncludeErrorDetailPolicy| Gets or sets whether details are included in error messages. See Chapter 25. |
|MessageHandlers| Gets or sets the message handlers, which I describe in Chapter 19.|
|ParameterBindingRules| Gets the rules by which parameters are bound, as described in Chapter 14.|
|Properties |Returns a ConcurrentDictionary<object, object> that can be used as a general property bag to coordinate the behavior of components. |
|Routes| Gets the set of routes configured for the application. See Chapters 20 and 21. Services Returns the Web API services, as described in Chapter 9.|

> **Tip**  You can also define configurations for individual controllers. See Chapter 22 for details.

##Configuring Web API Dependency Injection##

Although DI plays the same role for Web API as it does in the MVC framework, the approach required is different and a slight improvement, but there are some issues to be aware of, especially when it comes to creating instances of objects for each HTTP request.

##Preparing for Dependency Injection##

###Understanding the Web API Dependency Interfaces###

Dependency injection in Web API is handled by the IDependencyResolver and IDependencyScope interfaces, which are defined in the System.Web.Http.Dependencies namespace.

Listing 10-13. The Definition of the IDependencyResolver Interface

```cs 
namespace System.Web.Http.Dependencies {
  public interface IDependencyResolver : IDependencyScope {
  IDependencyScope BeginScope();
  }
}
```

Listing 10-14. The Definition of the IDependencyScope Interface

```cs
using System.Collections.Generic; namespace System.Web.Http.Dependencies {
  public interface IDependencyScope : IDisposable {
    object GetService(Type serviceType);
    IEnumerable<object> GetServices(Type serviceType);
  }
}
```

The GetService method is called when the Web API infrastructure needs a concrete type (such as a controller) or needs to use an interface for which there should be only one implementation (such as the IHttpActionInvoker interface,

The GetServices method is used when the Web API infrastructure expects there to be multiple implementations of an interface, all of which are required (such as IFilter,

###THE RELATIONSHIP BETWEEN THE DEPENDENCY INTERFACES###

The inheritance relationship between the interfaces can be confusing, but it starts to make sense when you understand that the Web API developers were trying to make it easier to deal with the two most common dependency injection scenarios in a web application: creating objects that are used for the life of the application and creating objects that are used for a single request.

When the application starts, a single instance of the IDependencyResolver implementation object is created and kept by Web API for the life of the application, and its GetService and GetServices methods are used whenever an object is required for the Web API infrastructure. In practice, this means it is used to create a lot of objects when the application is started (filters, data formatters, and so on) and then not used again.

When Web API needs an object that will be used for a single request, such as a controller or a database context class, then it calls the BeginScope method of the IDependencyResolver object in order to get an implementation of the IDependencyScope interface and uses the GetService and GetServices methods to create the instances it needs.

When the request has been handled and the objects that have been created are no longer required, Web API calls the Dispose method on the IDependencyScope object (because it implements IDisposable) so that the objects that have been created can be prepared for destruction.

Most DI containers rely on the System.Web.HttpContext class to support per-request object life cycles, which can be a problem with Web API because you cannot rely on the System.Web classes.

###Installing the Dependency Injection Container###

```
Install-Package Ninject -version 3.0.1.10 
Install-Package Ninject.Extensions.ChildKernel -Version 3.0.0.5
```

###Implementing the Dependency Interfaces###

Ninject makes it easy to support the two Web API resolution interfaces, and although it may seem odd, the easiest way to do so is by creating a single class.

Listing 10-15. The Contents of the NinjectResolver.cs File

```cs
using System;
using System.Collections.Generic;
using System.Web.Http.Dependencies;
using ExampleApp.Models;
using Ninject;
using Ninject.Extensions.ChildKernel;
namespace ExampleApp.Infrastructure {

 public class NinjectResolver: IDependencyResolver {

  private IKernel kernel;

  public NinjectResolver(): this(new StandardKernel()) {}

  public NinjectResolver(IKernel ninjectKernel, bool scope = false) {
   kernel = ninjectKernel;
   if (!scope) {
    AddBindings(kernel);
   }
  }

  public IDependencyScope BeginScope() {
   return new NinjectResolver(AddRequestBindings(new ChildKernel(kernel)), true);
  }

  public object GetService(Type serviceType) {
   return kernel.TryGet(serviceType);
  }

  public IEnumerable < object > GetServices(Type serviceType) {
   return kernel.GetAll(serviceType);
  }

  public void Dispose() {
   // do nothing  
  }

  private void AddBindings(IKernel kernel) {
   // singleton and transient bindings go here
  }

  private IKernel AddRequestBindings(IKernel kernel) {
   kernel.Bind < IRepository > ().To < Repository > ().InSingletonScope();
   return kernel;
  }
 }
}
```

###UNDERSTANDING OBJECT SCOPES###

When working with dependency injection in web applications, there are three types of objects you need to create: singleton objects, request objects, and transient objects.

Singleton objects are instantiated the first time they are required, and all classes that depend on them share the same instance.

Singleton objects have to be written to deal with their long life and the need to protect their state against multiple concurrent callers.

Transient objects are instantiated every time there is a dependency on them. Transient, a new instance would be created each time

Transient objects are not reused by the dependency injection container, and their life is generally tied to the life of the object they are injected into.

Request objects are somewhere in the middle. A new instance is created for each request that the web application receives and is reused to resolve dependencies declared by all of the objects created by the Web API infrastructure to process that request.

Or, to put it another way, the objects created to process a single request share a single instance of the request object. The request object is discarded after the request has been handled.

Repository classes are usually configured as request objects, which allows all of the objects that deal with a single request to share a common view of the model, and all see the changes that the request causes.

> **Caution**  A number of NuGet packages extend Ninject in order to integrate the DI functionality into different environments. As I write this, there are several that are aimed at ASP.NET Web API, but they all assume you will be deploying your application to IIS, and they rely on the ASP.NET platform module feature to manage per-request object life cycles.

This class acts as the touch point between Web API and Ninject. It implements both of the Web API dependency interfaces (NinjectResolver implements IDependencyResolver, which is derived from IDependencyScope) and responds to the BeginScope method by creating a child kernel, which allows me to use Ninject to create objects scopes for each request.

There is only one dependency mapping in the example application, which I set up as follows:

```cs
kernel.Bind<IRepository>().To<Repository>().InSingletonScope();
```

The final part of the mapping statement is a call to the InSingletonScope method, which specifies the scope for the instances of the class that are created to resolve dependencies on the interface.

This is where things get a little confusing because of the way that the NinjectResolver class works: I create a request scope by creating a child kernel for each request and creating a singleton scope on the child kernel, ensuring that there is only one instance of the object created for each request.

Table 10-6. Creating Web API Object Scopes with Ninject

|Scope| Method| Example|
|--|--|--|
|Singleton |AddBindings| kernel.Bind<IRepository>().To<Repository>().InSingletonScope(); |
|Request| AddRequestBindings |kernel.Bind<IRepository>().To<Repository>().InSingletonScope();|
|Transient |AddBindings |kernel.Bind<IRepository>().To<Repository>();|

> **Tip**  The singleton and request bindings are both created with the InSingletonScope method, but request scopes are set up in the AddRequestBindings method, which is called on the child Ninject kernels created when the BeginScope method is called.

##Configuring Web API##

The final step is to configure the Web API to use the NinjectResolver class to resolve dependencies.

Listing 10-16. Configuring Dependency Injection in the WebApiConfig.cs File

```cs
public static class WebApiConfig {
  public static void Register(HttpConfiguration config) {
    config.DependencyResolver = new NinjectResolver();
```

##Configuring Dependency Injection for Web API and MVC##

I am going to show you how to set up dependency injection for an application that contains Web API and MVC components.

This is a simple process because the MVC framework can be hosted only on the ASP.NET platform, which means that the request scope support that DI containers such as Ninject provide can be used, even in the Web API components.

> **Note** Using the technique in this section ties your web services the ASP.NET platform because it relies on the System.Web.HttpContext class being instantiated and providing access to an HttpRequest object that describes the current request. These classes are not part of the Web API namespaces, and using them prevents Web API components from being deployed outside of IIS.

Installing the Dependency Injection Packages

```
Install-Package Ninject.Web.Common -version 3.0.0.7 
Install-Package Ninject.MVC3 -Version 3.0.0.6
```

The Ninject.Web.Common package contains support for integrating dependency injection with the ASP.NET platform so that dependencies on modules and handlers can be resolved.

The Ninject.MVC3 package adds additional features required by the MVC framework

This package adds a NinjectWebCommon.cs file to the App_Start folder that contains code to set up dependency injection for ASP.NET modules and handlers.

##Adding MVC Support to the Resolver##

MVC framework dependency resolution is handled by the System.Web.Mvc.IDependencyResolver interface,

Table 10-7. The Methods Defined by the MVC IDependencyResolver Interface

|Name| Description|
|--|--|
|GetService(type)| Resolves a type for which one implementation is registered |
|GetServices(type)| Resolves a type for which multiple implementations are registered|

These methods match the ones defined by the Web API IDependencyScope interface, which I listed in Listing 10-14. This duplication allows me to extend the NinjectResolver class to support both Web API and the MVC framework,

Listing 10-19. Adding MVC Framework Support to the NinjectResolver.cs File

```cs
using System; using System.Collections.Generic; 
using System.Web.Http.Dependencies; 
using ExampleApp.Models; 
using Ninject; 
using Ninject.Extensions.ChildKernel; 
using Ninject.Web.Common; 

namespace ExampleApp.Infrastructure {
  public class NinjectResolver : System.Web.Http.Dependencies.IDependencyResolver, System.Web.Mvc.IDependencyResolver {
  
    private IKernel kernel;
    
    public NinjectResolver() : this (new StandardKernel()) {}
    
    public NinjectResolver(IKernel ninjectKernel) {
      kernel = ninjectKernel;
      AddBindings(kernel);
    }
    
    public IDependencyScope BeginScope() {
      return this;
    }         
    
    public object GetService(Type serviceType) {
      return kernel.TryGet(serviceType);
    }         
    
    public IEnumerable<object> GetServices(Type serviceType) {
      return kernel.GetAll(serviceType);         
    }
    
    public void Dispose() {
      // do nothing
    }         
    
    private void AddBindings(IKernel kernel) {             
      kernel.Bind<IRepository>().To<Repository>().InRequestScope();
    }
  } 
}
```

The Web API and MVC framework interfaces have the same name, so I have to use the fully qualified names in the class definition in order to implement both interfaces.

Being able to rely on the ASP.NET platform means that Ninject is able to provide the InRequestScope method, which configures bindings so that the objects they create are scoped to the request.

This allows me to support the Web API BeginScope method without using child kernels and, in turn, to consolidate my bindings into a single method.

But this simpler and more elegant approach comes at the cost of depending on the ASP.NET platform, which limits the deployment options for the application,

Table 10-8. Creating Web API and MVC Object Scopes with Ninject

|Scope| Method| Example|
|--|--|
|Singleton| AddBindings| kernel.Bind<IRepository>().To<Repository>().InSingletonScope(); |
|Request| AddBindings| kernel.Bind<IRepository>().To<Repository>().InRequestScope(); |
|Transient| AddBindings| kernel.Bind<IRepository>().To<Repository>();|


##Configuring the MVC Framework##

The final step is to configure the MVC framework so that the NinjectResolver class is used to create objects and resolve dependencies.

Listing 10-20. Configuring Dependency Injection in the Global.asax.cs File

```cs
public class Global : HttpApplication {
  void Application_Start(object sender, EventArgs e) {
    AreaRegistration.RegisterAllAreas();
    GlobalConfiguration.Configure(WebApiConfig.Register);
    RouteConfig.RegisterRoutes(RouteTable.Routes);
    System.Web.Mvc.DependencyResolver.SetResolver((System.Web.Mvc.IDependencyResolver) GlobalConfiguration.Configuration.DependencyResolver);
  }
}
```

The statement I added uses the GlobalConfiguration.Configuration property to obtain an instance of the HttpConfiguration class, reads the DependencyResolver to get the NinjectResolver instance, and uses it as the argument to the DependencyResolver.SetResolver method to configure the MVC framework.

The effect is to apply a single instance of the NinjectResolver class as the resolver for the entire application so that the MVC framework and Web API share the same set of singleton objects and have access to the same set of request and transient objects.

#CHAPTER 11 Action Method Results#

Web API has convenient features that use the standard characteristics of C# methods to express results, which makes generating the most common types of results easy.

##Understanding Action Method Results##

The goal of a controller is to use an action method to process an HttpRequestMessage object in order to create an HttpResponseMessage object.

The controller provides the action method with the data contained in the request using model binding, which I describe in Chapters 14–17, and about the request itself through the HttpRequestMessage object.

Table 11-2. The Properties Defined by the HttpRequestMessage Class

|Name| Description|
|--|--|
|Content| Returns an HttpContent object that contains the content of the HTTP request. Request content is accessed through the model binding feature, which I describe in Chapters 14 –17. |
|Headers| Returns an HttpRequestHeaders object that contains the headers sent by the client.|
|Method| Returns an HttpMethod object that describes the HTTP method/verb for the request. |
|Properties| Returns a dictionary that contains objects provided by the hosting environment.|
|RequestUri |Returns the URL requested by the client, expressed as an Uri object.|
|Version| Returns the version of HTTP that was used to make the request, expressed as a System.Version object.|

Action methods can return C# objects that represent model data or by creating an HttpResponseMessage object directly.

Web API has some nice features that hide away the details of creating HTTP responses for common outcomes,

##Returning No Result##

As an example, a request to delete an object from the repository may not require any data to be returned to the client because the HTTP status code will indicate whether the operation was successful.

A status code in the 200 range will indicate success, and a code in the 400 or 500 range will indicate a failure.

Listing 11-2. Adding an Action Method That Returns void in the ProductsController.cs

```cs
public void Delete(int id) {
   repo.DeleteProduct(id);
}
```

Status code 204 is the No Data code, which is defined as follows:

The server has fulfilled the request but does not need to return an entity-body.

You can see the full W3C definition of status codes at www.w3.org/Protocols/rfc2616/rfc2616-sec10.html

##Consuming a No Result Action Method##

jQuery treats any HTTP status code in the 200 range as a success, so dealing with action methods that don’t return data is a matter of defining a success callback function that updates the client-side data model to reflect the operation that has been performed.

```JavaScript
deleteProduct = function (data) {
  $.ajax("/api/products/" + data.ProductID, {
    type: "DELETE",
    success: function () {
    products.remove(data);
    }
  })
};
```

##AVOIDING THE URL VS. BODY PITFALL##

You might expect to be able to include the value of the ProductID property in the request body,

This will result in an error because the Delete method in the Products controller is targeted based on the URL without taking into account the data contained in the request body.

The key point for this chapter is that you must ensure that the URLs you request uniquely identify the object or objects you want to operate on.

##Returning an Action Result##

The next step up from returning no result is to return an implementation of the IHttpActionResult interface, which is roughly equivalent to the ActionResult class in the MVC framework.

The IHttpActionResult interface allows an action method to specify how HttpResponseMessage objects should be generated as instructions, which are then executed to produce the HttpResponseMessage that is used to respond to the client.

Allow you to take control over the HTTP response that will be returned to the client and, in particular, specify the status code that will be used. Returning void from an action method generates a 204 code, and returning model data (which I describe later in this chapter) generates a 200 code.

For all other status codes (or for action methods that need to decide which status code to return dynamically), action results are required.

The ApiController class defines a set of convenience methods that create IHttpActionResult implementation objects for most common HTTP status codes.

##Understanding the IHttpActionResult Interface##

The IHttpActionResult interface is used to separate an action method from the HttpResponseMessage object that represents its results.

This is an example of the command pattern,

Which makes it easier to isolate and test an action method and the action result separately.

Listing 11-5. The Definition of the IHttpActionResult Interface

```cs
using System.Net.Http; using System.Threading;
using System.Threading.Tasks; namespace System.Web.Http {
  public interface IHttpActionResult {
    Task<HttpResponseMessage> ExecuteAsync(CancellationToken cancellationToken);
  }
}
```

##CANCELLING ASYNCHRONOUS TASKS##

You will see that many of the interfaces that describe Web API components are asynchronous and return Task objects that produce other Web API or System.Net.Http types.

Most of the important methods receive a CancellationToken argument, which is used by the caller to signal that the operation has been cancelled, allowing your implementation classes to avoid doing work that will just be discarded when it is complete.

By reading the CancellationToken.IsCancellationRequested

Table 11-5. The Properties Defined by the HttpResponseMessage Class

|Name| Description|
|--|--|
|Content| Gets or sets the content of the response, expressed as an HttpContent object |
|Headers| Gets the HttpResponseHeaders objects that are used to collect the headers for the response|
|IsSuccessStatusCode |Returns true if the result of the StatusCode property is between 200 and 299, inclusive|
|ReasonPhrase| Gets or sets the explanatory phrase associated with the status code, expressed as a string |
|RequestMessage| Gets or sets the HttpRequestMessage that the HttpResponseMessage is associated with |
|StatusCode| Gets or sets the status code using the values defined in the HttpStatusCode class |
|Version| Gets or sets the HTTP version, expressed as a System.Version|

##Using the ApiController Action Result Methods##

The ApiController class, which is the default base for Web API controllers, defines a set of convenience methods that make it easy to create a range of IHttpActionResult implementation objects,

These methods instantiate classes defined in the System.Web.Http.Results namespace.

Table 11-6. The ApiController Methods That Return Objects That Implement the IHttpActionResult Interface

|Name| Description |
|--|--|
|BadRequest() |Creates a BadRequest object that uses status code 400.|
|BadRequest(message) |Creates a BadRequestErrorMessageResult, which uses a status code of 400 and contains the specified message in the response body.|
|BadRequest(modelstate) | Creates an InvalidModelStateResult that uses status code 400 and includes validation information in the response body. See Chapter 18 for details of Web API data validation.|
|Conflict() |Creates a ConflictResult, which uses status code 409. This status code is used when the request contravenes the internal rules defined by the web service. The standard example is trying to upload an older version of a file than is already stored by the web service, but this is a rarely used result. |
|Content(status, data) |See the “Bypassing Content Negotiation” section of this chapter for details. Created(url, data) See the “Creating Negotiable Action Results” section of this chapter for details.|
|CreatedAtRoute(name, vals, data) |See the “Creating Negotiable Action Results” section of this chapter for details. InternalServerError() Creates an InternalServerError, which uses status code 500.|
|InternelServerError(exception)| Creates an ExceptionResult, which uses status code 500 and which details of the specified exception in the response body.|
|NotFound() |Creates a NotFoundResult, which uses status code 404. |
|Ok() |Creates an OkResult, which uses status code 200. |
|Ok(data)| See the “Creating Negotiable Action Results” section of this chapter for details. |
|Redirect(target) |Creates a RedirectResult, which uses status code 302 to redirect the client to the URL, which can be specified as a string or a Uri. |
|RedirectToRoute(name, props) |Creates a RedirectToRouteResult, which generates a URL from the routing configuration and uses it to send a 302 response to the client. See Chapters 20 and 21 for details of Web API routing.|
|ResponseMessage(message) | Creates a ResponseMessageResult, which is a wrapper around an existing HttpResponseMessage object. See the “Creating an HttpResponseMessage Object” section.|
|StatusCode(code) |Creates a StatusCodeResult, which uses the specified status code, expressed as a value from the HttpStatusCode class. See the “Creating an HttpResponseMessage Object” section.|
|Unauthorized(headers)| Creates a UnauthorizedResult, which uses the 401 status code. See Chapters 23 and 24 for the details of authentication.|

The methods that return objects that include information in the response body, such as BadRequest(message) and InternalServerError(exception), rely on the media formatting and content negotiation features to format the response content so that it can be processed by the client.

I explain these features in the “Understanding Content Negotiation” section.

```cs
[HttpGet]
[Route("api/products/noop")]
public IHttpActionResult NoOp() {
  return Ok();
}
```

Table 11-7. ApiController Action Result Methods by HTTP Status Code

|Status Code| Meaning| Method|
|--|--|
|200| Operation successful |Ok() Ok(data)|
|302| Temporary redirection |Redirect(target) RedirectToRoute(name, props)|
|400| Bad request |BadRequest() BadRequest(message) BadRequest(model)|
|404| Not found |NotFound()|
|409| Conflict |Conflict() |
|500| Internal server error |InternalServerError() InternalServerError(exception)|

##Returning Other Status Codes##

###Creating a StatusCodeResult Object###

The simplest approach is to use the StatusCode method, which returns a StatusCodeResult object whose ExecuteAsync method yields an HttpResponseMessage with an arbitrary HTTP status code,

Listing 11-7. Using a StatusCodeResult in the ProductsController.cs File

```cs 
return StatusCode(HttpStatusCode.NoContent);
```

The set of status codes that you can use is defined by the System.Net.HttpStatusCode class, which has properties for each code.

###Creating an HttpResponseMessage Object###

You can use the ResponseMessage method as an IHttpActionResult wrapper around an HttpResponseMessage that you have already created or obtained.

```cs
return ResponseMessage(new HttpResponseMessage(HttpStatusCode.NoContent));
```

###Creating a Custom Action Result###

If you frequently need to return a result for which there is no controller convenience method, then you can define a custom implementation of the IHttpActionResult interface that yields the response you need.

```cs
public class NoContentResult : IHttpActionResult {
  public Task<HttpResponseMessage> ExecuteAsync(CancellationToken cancellationToken) {
    return Task.FromResult(new HttpResponseMessage(HttpStatusCode.NoContent));
  }
}
```

Task.FromResult method allows you to create a Task wrapper that yields the object you provide as the argument.

```cs
return new NoContentResult();
```

##Returning Model Data##

One of the headline features of Web API is the ability to return model data objects and have them serialized and sent the client automatically.

You should use this feature whenever you need to return data to a client with a 200 status code.

The data format used to serialize the data is selected based on a process called content negotiation, which relies on the client sending an HTTP Accept header.

###Understanding the Default Behavior###

```cs
public IEnumerable<Product> GetAll() {
  return repo.Products;
}
```

The action method returns an enumeration of Product objects, which Web API has serialized as a JSON array.

Understand. If you request the /api/products URL using Google Chrome,

This time, the enumeration of Product objects has produced XML data, which happens because Google Chrome sent headers as part of the HTTP request that expressed a preference for XML.

There are two important Web API features at work here.

Web API inspects the request and uses the information it contains to figure out what data formats the client can process.

The second feature is media formatting, where Web API serializes the data into the format that has been identified—JSON and XML in these examples—so

##Understanding the Content Negotiation Process##

Content negotiation is the process by which an appropriate format is selected for serializing the data format.

The client includes an Accept header in the HTTP request that describes the data formats that it can handle, expressed as MIME types

with information about the order of preference.

(There are other headers that clients use to express preferences—Accept-Charset, Accept-Encoding and Accept-Language—but

you can use any header for negotiation.)

```
Accept: text/html, application/xhtml+xml, application/xml;q=0.9, image/webp, */*;q=0.8
```

Each content type has a q value, which is a measure of preference, and greater q values indicate more preferable formats.

A value of 1.0—the maximum value—is implied when a q value isn’t expressed.

This header is interpreted as follows:

Chrome prefers the text/html (HTML), application/xhtml+xml (XHTML), and image/webp formats above all others. If HTML, XHTML, and image/webp are not available, then XML is the next most preferred format. If none of the preferred formats is available, then Chrome will accept any format (expressed as */*).

Web API has built-in support for JSON, BSON, and XML. (JSON and XML are widely used and understood. BSON is Binary JSON, which isn’t supported by browser-based clients.)

Postman sets the Accept header to */* by default, so it receives the default Web API data format, which is JSON.

The Accept header for jQuery Ajax requests is controlled through the accept setting (as described in Chapter 3) and is also set to */* by default. This is why clicking the Refresh button rendered by the Index.cshtml view obtains JSON data, even though requesting the same URL directly through Chrome produces XML data.

###Implementing a Custom Content Negotiator###

The content negotiator is the class responsible for examining requests and identifying the format that best suits the client.

The content negotiator is not responsible for formatting the data; that’s the job of the media formatter,

Listing 11-11. The IContentNegotiator Interface

```cs
namespace System.Net.Http.Formatting {
  public interface IContentNegotiator {
    ContentNegotiationResult Negotiate(
      Type type, HttpRequestMessage request, IEnumerable<MediaTypeFormatter> formatters);
  }
```

The Negotiate method is called to examine a request and is passed the Type of the data to be serialized, the HttpRequestMessage that represents the HTTP request from the client, and an enumeration of the available media formatters, which are responsible for serializing content and are derived from the MediaTypeFormatter class

Table 11-9. The Properties Defined by the ContentNegotiationResult

| Name|  Description|
|--|--|
|Formatter| Returns the instance of the MediaTypeFormatter that will be used to serialize the data. I describe media formatters in Chapter 12.|
|MediaType| Returns an instance of the MediaTypeHeaderValue class, which details the headers that will be added to the response to describe the selected format.|

> **Tip**  Returning null from the Negotiate method in a custom negotiator returns a 406 (Unacceptable) response to the client, indicating that there is no overlap between the data formats that the web service can produce and that the client can process.

able 11-10. The Members Defined by the MediaTypeHeaderValue

|Name| Description|
|--|--|
|CharSet| Gets or sets the character set component of the Content-Type header.|
|MediaType| Gets or sets the MIME type that will be used in the Content-Type header.|
|Parameters | Returns a collection that can be used to add properties to the Content-Type header. |
|Parse(header) | A static method that parses a header string and returns a MediaTypeHeaderValue object. This method is used by the model binding feature, which I described in Chapters 14–17. |
|TryParse(header, output)|  A static method that attempts to parse the header string and populates the output argument, which is a MediaTypeHeaderValue parameter decorated with the out keyword. This method is used by the model binding feature, which I described in Chapters 14–17 |

Web API includes a default content negotiator class, called DefaultContentNegotiator,

I am going to create a custom negotiator that builds on the default behavior but ensures that requests from Chrome receive JSON responses rather than XML.

Listing 11-12. The Contents of the CustomNegotiator.cs File

```cs
public class CustomNegotiator: DefaultContentNegotiator {
 public override ContentNegotiationResult Negotiate(Type type, HttpRequestMessage request, IEnumerable<MediaTypeFormatter > formatters) {
  if (request.Headers.UserAgent.Where(x => x.Product != null && x.Product.Name.ToLower().Equals("chrome")).Count() > 0) {
   return new ContentNegotiationResult(new JsonMediaTypeFormatter(), new MediaTypeHeaderValue("application/json"));
  } else {
   return base.Negotiate(type, request, formatters);
  }
 }
}
```

##WORKING WITH REQUEST HEADERS##

The headers sent by a client in an HTTP request are available through the HttpRequestMessage.Headers property,

The HttpRequestHeaders class defines properties for each of the headers defined by the HTTP standard, such as Accept and UserAgent, as well as Contains and GetValues methods that let you check to see whether a header is present and get the value of an arbitrary header.

The header values are processed to make them easier to work with.

In the case of the User-Agent header, for example, the HttpRequestHeaders.UserAgent property returns an HttpHeaderValueCollection<ProductInfoValueHeader>, which is essentially an enumeration of ProductInfoValueHeader objects, each of which represents part of the User-Agent header.

###Configuring the Content Negotiator###

Tell Web API that I want to use my custom content negotiator.

Listing 11-13. Registering a Custom Content Negotiator in the WebApiConfig.cs File

```cs 
config.Services.Replace(typeof(IContentNegotiator), new CustomNegotiator());
```

###Bypassing Content Negotiation###

The ApiController class defines a group of methods that allow action methods to override the regular content negotiation process and specify the data format that should be used,

Table 11-11. The ApiController Methods That Bypass Content Negotiation

|Name| Description|
|--|--|
|Json(data)| Returns a JsonResult, which serializes the data as JSON, irrespective of the preferences expressed by the client. |
|Content(status, data, formatter)| Returns a FormattedContentResult, which bypasses the content negotiation process and uses the specified formatter to serialize the data. The specified status code is used in the response. The formatter is responsible for setting the value of the Content-Type header.|
|Content(status, data, formatter, mimeType)| Like the previous method but uses the specified MIME type, expressed as a MediaTypeHeaderValue object, for the Content-Type header in the response.|
|Content(status, data, formatter, mimeString) | Like the previous method but uses the specified MIME type, expressed as a string, for the Content-Type header in the response.|

Bypassing the content negotiation process is not a decision to make lightly because it exists to ensure that clients get content they can process, based on the preferences they express.

##Returning Negotiable Action Results##

Being able to return model objects and let Web API figure out what to do with them is, without a doubt, a helpful and elegant feature, but it does assume that you will return the data to the client with a 200 (OK) status code in the response.

A negotiable action result is one that allows you to produce a different HTTP status code but still take advantage of the content negotiation and data formatting features.

Should you use it? Use a negotiable action result whenever you need to send data to the client with a status code other than 200.

##Creating Negotiable Action Results##

Table 11-13. The ApiController Methods That Return Negotiable Action Results

|Name| Description|
|--|--|
|Ok(data)| This method returns an OkNegotiatedContentResult object, which sets the result status code to 200 and is equivalent to returning the model objects as the result of the action method.|
|Created(url, data)| This method returns a CreatedNegotiatedContentResult object, which sets the response status code to 201, indicating that a new resource has been created as a consequence of the request. The url argument is used to specify the URL that can be used to request the new object.|
|CreatedAtRoute(name, values, data) | This method returns a CreatedAtRouteNegotiatedContentResult object, which uses a 201 status code and generates the URL that refers to the new object using the named route and route values. See Chapters 20 and 21 for details of Web API routing.|
|Content(staus, data) | This method creates a NegotiatedContentResult object, which allows an arbitrary status code to be set for the HTTP response. |

You will rarely need to use these methods, and so far, the only time I have found them useful is when replacing a legacy web service that made unusual—and entirely nonstandard—use of HTTP status codes to signal service status to its equally nonstandard clients.

```cs
return Ok(repo.Products);
```

##RETURNING 200 OR 201 RESULTS FROM POST REQUESTS##

The Created and CreatedAtRoute methods are interesting because they touch on a design decision about how a RESTful web service responds to POST requests. Most web services will return a 200 status code and include the new data object in the response to the client. The new object will, at least, contain the unique key that can be used to refer to the object and a set of HATEOAS links if that pattern is being followed.

This is the most common approach, but it doesn’t follow the HTTP specification that states that the web service should return a 201 response that contains a Location header with a URL that can be requested to get the newly created resource. The client can then request this URL to retrieve the new data item.

The reason that most web services return a 200 response that includes the newly created object is because most clients will display newly created data items to the user, and including the data in the response preempts the obvious next task for the client, avoiding an additional request.



























#CHAPTER 12 Creating Media Type Formatters#

Media type formatters are the component responsible for serializing model data so that it can be sent to the client.

##Creating a Media Type Formatter##

Deriving from the abstract MediaTypeFormatter class defined in the System.Net.Http.Formatting namespace.

need to pick a MIME type so that I can set the Accept request header and Content-Type response header.

> application/x.product

> **Tip**  MIME types are expressed in the form <type>/<subtype>, and prefixing the subtype with x. indicates a private content type. The MIME type specification—RFC 6838—discourages the use of private content types, but they remain useful for custom data formats and are still widely used. Older versions of the standard allowed a x- prefix, which is no longer supported.

See http://tools.ietf.org/html/rfc6838#section-3.4 for details.

##Implementing a Basic Media Type Formatter##

Listing 12-3. The Contents of the ProductFormatter.cs File

```cs
public class ProductFormatter: MediaTypeFormatter {

 public ProductFormatter() {
  SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/x.product"));
 }

 public override bool CanReadType(Type type) {
  return false;
 }

 public override bool CanWriteType(Type type) {
  return type == typeof(Product) || type == typeof(IEnumerable < Product > );
 }

 public override async Task WriteToStreamAsync(Type type, object value, Stream writeStream, HttpContent content, TransportContext transportContext) {

  List < string > productStrings = new List < string > ();

  IEnumerable < Product > products = value is Product ? new Product[] {
   (Product) value
  } : (IEnumerable < Product > ) value;

  foreach(Product product in products) {
   productStrings.Add(string.Format("{0},{1},{2}", product.ProductID, product.Name, product.Price));
  }

  StreamWriter writer = new StreamWriter(writeStream);
  await writer.WriteAsync(string.Join(",", productStrings));
  writer.Flush();
 }
}

```

The MediaTypeFormatter class defines a SupportedMediaTypes collection, which is used by the content negotiator to match MIME types in the client Accept header to a formatter.

##Indicating Type Support##

There are only two methods that custom media type formatters must implement because they are marked as abstract by the base class: CanReadType and CanWriteType.

The CanWriteType method is called by the content negotiator to see whether the formatter is able to serialize a specific type.

##Serializing Model Data##

request. The WriteToStreamAsync method is where the real work happens and is called when the content negotiator has selected the formatter for serializing the model objects returned by the action method.

Table 12-3. The Argument Types Accepted by the WriteToStreamAsync Method

|Argument Type| Description |
|--|--|
|Type| The type of the model data as returned by the action method. |
|object| The data to serialize. Stream The stream to which the serialized data should be written. You must not close the stream. |
|HttpContent| A context object that provides access to the response headers. You must not modify this object.| 
|TransportContext |A context object that provides information about the network transport, which can be null.|

##Registering the Media Type Formatter##

The set of media type formatter classes is accessed through the HttpConfiguration.Formatters property, which returns an instance of the System.Net.Http.MediaTypeFormatterCollection class.

Listing 12-4. Registering a Media Type Formatter in the WebApiConfig.cs File

```cs
config.Formatters.Add(new ProductFormatter());
```

##Using the Custom Formatter##

Testing the custom formatter is easy with Postman. Click the Headers button and add an Accept header with a value of application/x.product.

Set the verb to GET and set the URL so that it targets the /api/products

##Consuming the Formatted Data with jQuery##

jQuery makes it easy to target custom formatters by setting the Accept header in Ajax requests, although using a custom data format means that the data returned by the web service won’t be automatically converted into JavaScript objects like it is for JSON.

```JavaScript
getProducts = function() {
        $.ajax("/api/products", {
            dataType: "text",
            accepts: {
                text: "application/x.product"
            },
            success: function(data) {
                products.removeAll();
                var arr = data.split(",");
                for (var i = 0; i < arr.length; i += 3) {
                    products.push({
                        ProductID: arr[i],
                        Name: arr[i + 1],
                        Price: arr[i + 2]
                    });
                }
            }
        })
```


##Refining the Custom Formatter##

Now that I have the basic functionality in place, I can use some of the more advanced formatter features to refine the way that the formatter is matched to requests and the serialized data produced by the formatter.

##Supporting Content Encodings##

> **Tip**  If you are not familiar with text encoding, then see the useful Wikipedia article at http://en.wikipedia.org/wiki/Character_encoding for an introduction.

The MediaTypeFormatter class defines a SupportedEncodings property, which returns a Collection<System.Text.Encoding> object that custom formatters can populate with details of the encodings they support.

Listing 12-6. Supporting a Specific Encoding in the ProductFormatter.cs File

```cs
SupportedEncodings.Add(Encoding.Unicode);
SupportedEncodings.Add(Encoding.UTF8);
```

```cs
public override bool CanWriteType(Type type) {
  ...
  Encoding enc = SelectCharacterEncoding(content.Headers);
  StreamWriter writer = new StreamWriter(writeStream, enc ?? Encoding.Unicode);
```

> **Tip**  The HTML5 specification recommends using the UTF-8 encoding for all web content. See https://www.w3.org/International/questions/qa-choosing-encodings for more details.

##Setting the HTTP Response Headers##

Web API sets the HTTP response headers based on the media type and character encoding that have been selected.

You can change the headers that are added to the response by overriding the SetDefaultContentHeaders method and either set different headers or supplement the ones defined by the base class.

Listing 12-7. Setting the HTTP Response Headers in the ProductFormatter.cs File

```cs
public class ProductFormatter: MediaTypeFormatter {
  public ProductFormatter() {
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/x.product"));
   SupportedEncodings.Add(Encoding.Unicode);
   SupportedEncodings.Add(Encoding.UTF8);
  }
  public override bool CanReadType(Type type)
```

```cs
public override void SetDefaultContentHeaders(Type type, HttpContentHeaders headers, MediaTypeHeaderValue mediaType) {
 base.SetDefaultContentHeaders(type, headers, mediaType);
 headers.Add("X-ModelType", type == typeof(IEnumerable < Product > ) ? "IEnumerable<Product>" : "Product");
 headers.Add("X-MediaType", mediaType.MediaType);
}
```

I have called the base implementation of the method to set the Content-Type header and used the method arguments to add two nonstandard headers to the response (headers whose names start with X- are nonstandard).


##Participating in the Negotiation Process##

Formatters can take a more active role in the negotiation process by defining one or more implementations of the abstract MediaTypeMapping class, which is used to decide how the MIME types supported by the formatter fit into the client preferences for each request.

##Creating a Media Type Mapping##

Listing 12-8. The Contents of the ProductMediaMapping.cs File


```cs
public class ProductMediaMapping: MediaTypeMapping {
 public ProductMediaMapping(): base("application/x.product") {}
 public override double TryMatchMediaType(HttpRequestMessage request) {
  IEnumerable < string > values;
  return request.Headers.TryGetValues("X-UseProductFormat", out values)
    && values.Where(x => x == "true").Count() > 0 ? 1 : 0;
 }
}
```

The MediaTypeMapping class defines a constructor that accepts the MIME type that the mapping relates to. The TryMatchMediaType method is passed the HttpRequestMessage object that represents the current request and is responsible for returning a double value that indicates the client preference for the specified MIME type.

The double has the same effect as the q values in the Accept header sent by the client.

Listing 12-9. Using a MediaTypeMapping in the ProductFormatter.cs File


```cs

public ProductFormatter() {
  SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/x.product"));
  SupportedEncodings.Add(Encoding.Unicode);
  SupportedEncodings.Add(Encoding.UTF8);
  MediaTypeMappings.Add(new ProductMediaMapping());
}
```

##Testing the Negotiation Process##

Table 12-8. The Request Headers and Values Required to Test the MediaTypeMapping Implementation

|Header| Value|
|--|--|
|Accept| application/json;q=0.9|
|X-UseProductFormat| true|

##Adding Headers to jQuery Ajax Requests##

```JavaScript
$.ajax("/api/products", {
            headers: {
                "X-UseProductFormat": "true"
            },
            dataType: "text",
            accepts: {
                text: "application/x.product"
            },
            success: function(data) {
```

##Using the Mapping Extension Methods##

Deriving from the MediaTypeMapping class allows you to dig right into the details of the request as part of the negotiation process, but Web API also provides some convenient extension methods that make it easy to set up the most common mappings.

Table 12-9. The Extension Methods for Mapping Media Types to Requests

|Method| Description|
|--|--|
|AddQueryStringMapping(name, value, mimeType)| Selects the specified mimeType when the request query string contains the name property with the specified value. |
|AddRequestHeaderMapping(name, value,comparison, substring, mimeType) | Selects the specified mimeType when the request contains a name header with the specified value. The comparison argument is a System.StringComparison value used to compare the request value, which will accept substrings is the substring argument is true.|
|AddUriPathExtensionMapping(extension, mimeType)| Selects the specified mimeType if the request URL has the specified extension.|

Listing 12-11. Using Media Type Formatter Mapping Methods in the WebApiConfig.cs File

```cs
MediaTypeFormatter prodFormatter = new ProductFormatter();
prodFormatter.AddQueryStringMapping("format", "product", "application/x.product");
prodFormatter.AddRequestHeaderMapping("X-UseProductFormat", "true", StringComparison.InvariantCultureIgnoreCase, false, "application/x.product");
prodFormatter.AddUriPathExtensionMapping("custom", "application/x.product");
config.Formatters.Add(prodFormatter);
}
```

The AddQueryStringMapping extension method gives preference to a media type formatter when a query string contains a specific property and value.

I used the AddRequestHeaderMapping extension method to achieve the same effect I created with the ProductMediaMapping class

The AddUriPathExtensionMapping method is a little more complex than the others and requires a URL route to be defined. This method registers a mapping that looks for a routing segment variable called ext, which is the convention for capturing file extensions but which can be used to match any URL segment.

##Creating Per-Request Media Type Formatters##

A single instance of a media type formatter class is usually used to serialize data for multiple requests, but an alternative approach is to override the GetPerRequestFormatterInstance method defined by the MediaTypeFormatter class.

##Creating the Formatter Instance##

The GetPerRequestFormatterInstance method is passed the Type of the data that is to be serialized, the HttpRequestMessage that represents the current request, and a MediaTypeHeaderValue that provides details of the required MIME type and character set encoding.

The result of the GetPerRequestFormatterInstance method is a MediaTypeFormatter object that will be used for a single request.

Listing 12-12. Creating Per-Request Media Type Formatters in the ProductFormatter.cs File

```cs
public class ProductFormatter: MediaTypeFormatter {
 private string controllerName;

 public ProductFormatter() {
  //SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/x.product"));
  SupportedEncodings.Add(Encoding.Unicode);
  SupportedEncodings.Add(Encoding.UTF8);
  MediaTypeMappings.Add(new ProductMediaMapping());
 }

 public ProductFormatter(string controllerArg): this() {
  controllerName = controllerArg;
 }

 public override bool CanReadType(Type type) {
  return false;
 }

 public override bool CanWriteType(Type type) {
  return type == typeof(Product) || type == typeof(IEnumerable < Product > );
 }

 public override void SetDefaultContentHeaders(Type type, HttpContentHeaders headers, MediaTypeHeaderValue mediaType) {
  base.SetDefaultContentHeaders(type, headers, mediaType);
  headers.Add("X-ModelType", type == typeof(IEnumerable < Product > ) ? "IEnumerable<Product>" : "Product");
  headers.Add("X-MediaType", mediaType.MediaType);
 }

 public override MediaTypeFormatter GetPerRequestFormatterInstance(Type type, HttpRequestMessage request, MediaTypeHeaderValue mediaType) {
  return new ProductFormatter(request.GetRouteData().Values["controller"].ToString());
 }

 public override async Task WriteToStreamAsync(Type type, object value, Stream writeStream, HttpContent content, TransportContext transportContext) {

  List < string > productStrings = new List < string > ();

  IEnumerable < Product > products = value is Product ? new Product[] {
   (Product) value
  } : (IEnumerable < Product > ) value;

  foreach(Product product in products) {
   productStrings.Add(string.Format("{0},{1},{2}", product.ProductID, controllerName == null ? product.Name : string.Format("{0} ({1})", product.Name, controllerName), product.Price));
  }

  Encoding enc = SelectCharacterEncoding(content.Headers);
  StreamWriter writer = new StreamWriter(writeStream, enc ? ? Encoding.Unicode);
  await writer.WriteAsync(string.Join(",", productStrings));
  writer.Flush();
 }
}
}
```

#CHAPTER 13 Using the Built-in Media Formatters#

##Working with the Built-in Media Type Formatters##

Web API includes a set of four built-in media formatters.

All of the built-in media type formatters participate in the model binding process I describe in Chapters 14–17, but there are two that are interesting in this chapter because they are used to serialize object to generate JSON or XML data so it can be sent to the client.

These media type formatters are configured for use by default and will be selected by the content negotiation process,

Listing the Built-in Media Type Formatters

HttpConfiguration.Formatters property.

Table 13-3. The Convenience Properties Defined by the MediaTypeFormattingCollection Class

|Name| Description|
|--|--|
|FormUrlEncodedFormatter |Returns an instance of the FormUrlEncodedMediaTypeFormatter class, which is used to parse form data in the model binding process |
|JsonFormatter| Returns an instance of the JsonMediaTypeFormatter class, which serializes data into the JSON format|
|XmlFormatter| Returns an instance of the XmlMediaTypeFormatter class, which serializes data into the XML format|

```cs
public ActionResult Index() {
  return View(GlobalConfiguration.Configuration.Formatters);
  }
```

##WHAT ABOUT BSON?##

BSON is binary JSON and is, as its name suggests, a binary variation on the JSON specification. BSON is used most widely by the MongoDB database but has been proposed as a more efficient and expressive alternative to JSON—a proposal that has not been universally welcomed, and, as I write this, there are active and heated discussions about the efficiency benefits. You can learn more about the BSON specification at http://bsonspec.org

BSON may find a wider role in the future, but the limiting factor at the moment is that there is little support for BSON in clients,

Web API includes a BSON media formatter (the BsonMediaTypeFormatter class in the System.Net.Http.Formatting namespace), but it is disabled by default.

##Dealing with Type Matching During Negotiation##

There is a confusing quirk in the content negotiation process that relies on the order in which the formatters appear in the list

the default content negotiator does something odd when there is no match between the data formats

The default content negotiator class has responded with JSON data,

The DefaultContentNegotiator class, which I described in Chapter 11, has a feature called match-on-type that is enabled by default and is used to select a formatter when there the Accept header doesn’t specify a format that Web API can work with.

The content negotiator calls the CanWriteType method of each of the available formatters and will use the first one that returns true for the data type that is to be serialized.

As Figure 13-1 shows, the JSON media type formatter is first on the list, and that’s why the request for the application/x.product MIME type produced JSON data, even though it isn’t a format that the client would accept.

##Changing the Media Formatter Order##

You can change the data format that is selected by the match-on-type feature by re-ordering the media formatters in the MediaTypeFormatterCollection collection,

Table 13-4. The Methods Defined by the MediaTypeFormattingCollection for Manipulating the Collection

|Name| Description|
|--|--|
|Add(formatter)| Adds a new formatter to the collection |
|Insert(index, formatter) |Inserts a formatter at the specified index |
|Remove(formatter) |Removes the specified formatter |
|RemoveAt(index)| Removes the formatter at the specified index|

Listing 13-5. Changing the Order of the Media Type Formatters in the WebApiConfig.cs File

```cs
MediaTypeFormatter xmlFormatter = config.Formatters.XmlFormatter;
config.Formatters.Remove(xmlFormatter);
config.Formatters.Insert(0, xmlFormatter);
```

> **Tip**  Working with the MediaTypeFormatterCollection object is awkward. The convenience properties return the instances of the formatters that are created automatically during the Web API configuration process. If you remove or replace a formatter, the corresponding convenience property will return null.

##Disabling the Match-on-Type Feature##

Changing the order of the formatters doesn’t address the underlying problem with the match-on-type feature, which is sending a format to the client that it may not be able to process.

Few web service clients check to see whether the format they received is the one that they asked for.

One of the reasons that web services don’t check the received data format is that the match-on-type feature doesn’t follow the HTTP specification, which states that the web service should send the client a 406 (Not Acceptable) response if there is no match between the data formats in the Accept header and the ones supported by the application.

The DefaultContentNegotiator class defines a constructor argument that disables the match-on-type feature.

Listing 13-6. Disabling the Match-on-Type Feature in the NinjectResolver.cs File

```cs
kernel.Bind<IContentNegotiator>().To<DefaultContentNegotiator>().WithConstructorArgument("excludeMatchOnTypeOnly", true);
```

equivalent to calling this:

```cs
new DefaultContentNegotiator(true)
```

A true value for the constructor argument disables the match-on-type feature and causes the web service to send a 406 (Not Acceptable) message to the client,

Listing 13-7. Disabling the Match-on-Type Feature in the WebApiConfig.cs File

```cs
config.Services.Replace(typeof(IContentNegotiator), new DefaultContentNegotiator(true));
```

##Handling a Not Acceptable Response in the Client##

To deal with 406 (Not Acceptable) responses, I need to add support for displaying errors to the user.

```JavaScript
var errors = ko.observableArray();
```

```xml
<div class="alert alert-danger" data-bind="visible: errors().length">
  <p><strong>Something has gone wrong:</strong></p>
  <ul data-bind="foreach: errors">
    <li data-bind="text: $data"></li>
  </ul>
</div>
```

```JavaScript
getProducts = function() {
    errors.removeAll();
    $.ajax("/api/products", {
        headers: {
            "X-UseProductFormat": "true"
        },
        //dataType: "text",
        accepts: {
            "*": "application/x.product"
        },
        success: function(data) {
            products.removeAll();
            var arr = data.split(",");
            for (var i = 0; i < arr.length; i += 3) {
                products.push({
                    ProductID: arr[i],
                    Name: arr[i + 1],
                    Price: arr[i + 2]
                });
            }
        },
        error: function(jqXHR) {
            switch (jqXHR.status) {
                case 406:
                    errors.push("Request not accepted by server");
                    break;
            }
        }
    })
};
```

##Working with the JSON Media Type Formatter##

The JsonMediaTypeFormatter class is responsible for producing JSON data.

Behind the scenes, the JSON data is generated by the Json.Net package, which is an open source library that has become the most popular JSON package for .NET applications.

There are a number of options that can be specified to control the JSON that the Json.Net package produces, which can be useful for ensuring compatibility with clients that expect JSON to be structured in a specific way.

###Configuring the JSON Media Type Formatter###

The default settings are fine most of the time, but you will find that some older clients can be picky about the data they process,

Table 13-6. The JsonMediaTypeFormatter Configuration Methods

|Name| Description|
|--|--|
|Indent| When set to true, the JSON will be indented, making it easier to read. MaxDepth Sets the maximum depth of object allowed when reading JSON data during the model binding process.|
|UseDataContractJsonSerializer |When set to true, the DataContractJsonSerializer, rather than the Json.Net package, will be used to produce JSON data. |
|SerializerSettings| Gets or sets the JsonSerializerSettings object used to configure serialization.|
|CreateDefaultSerializerSettings() |Creates a JsonSerializerSettings object configured with the defaults used by the media type formatter.|

###Changing the Underlying JSON Serializer###

You can replace the Json.Net package with the Microsoft DataContractJsonSerializer class by setting the UseDataContractJsonSerializer property to true.

it can be useful if you are re-implementing a legacy web service that used the DataContractJsonSerializer class and you want to preserve the quirks of its JSON formatting

###Indenting the JSON Data###

Listing 13-10. Configuring the JSON Media Type Formatter in the WebApiConfig.cs File

```cs
JsonMediaTypeFormatter jsonFormatter = config.Formatters.JsonFormatter;
jsonFormatter.Indent = true;
```

###Configuring Json.Net###

the SerializerSettings property and the CreateDefaultSerializerSettings method operate directly on the Json.Net.JsonSerializerSettings class, which is part of the Json.Net package and not part of Web API at

The Json.Net classes are defined in the Newtonsoft.Json namespace.

Table 13-7. The Most Useful SerializerSettings Properties

| Name|  Description|
|--|--|
|DateFormatHandling| Specifies how dates are written in JSON, expressed as a value from the DateFormatHandling enumeration. The values are IsoDateFormat (the default), which writes dates as 2015-01-20T09:20Z, and MicrosoftDateFormat, which preserves compatibility with earlier Microsoft web services. See the “Handling JSON Dates” section for details. |
|DateFormatString |Overrides the DateFormatHandling property and sets a custom format for dates. The value used when DateFormatHandling is IsoDateFormat is yyyy'-'MM'-'dd'T'HH':'mm':'ss.FFFFFFFK.|
|DefaultValueHandling| Specifies how default values are handled, expressed using the DefaultValueHandling enumeration. The default value is Include, but see the “Handling Default Values” section for further details.|
|NullValueHandling| Specifies whether properties that are null are included in JSON data, using a value from the NullValueHandling enumeration. The default value is Include, meaning that the properties are included. The other value available is Ignore, which omits such properties from the JSON data. |
|StringEscapeHandling| Specifies how string values are escaped in the JSON data, using a value from the StringEscapeHandling enumeration.  The default value is Default, but see the “Handling String Escaping” section for more details.|

> **Tip**  See http://james.newtonking.com/json/help/index.html for full details of the properties defined by the JsonSerializerSettings class, including the ones that I have not included in this chapter.

###Handling JSON Dates###

Dates are a source of difficulty in any environment because of the multitude of ways that they can be expressed and the endless permutations of regional calendars and time zones.

The situation is made worse only when using JSON because the format acts as a neutral interchange between two different programming languages and has no definitive definition for how dates should be expressed.

The best approach—and the one most widely used in web services—is to express dates so they are easily processed in JavaScript.

This is the default option used by the Json.Net package,

Listing 13-14. Processing a Date Value in the Formats.cshtml File

```JavaScript
$.ajax("/api/formats", {
            success: function(data) {
                dataObject = ko.observable(data);
                var date = new Date(data.Time);
                dataObject().Time = date.toLocaleTimeString();
                ko.applyBindings();
            }
```

The SerializerSettings.DateFormatHandling setting can be set to the DateFormatHandling.MicrosoftDateFormat value if you need to generate dates for compatibility with clients that rely on an older format that Microsoft used to promote, where dates are expressed like this:

```JSON
{ "Time": "\/Date(1396385762063+0100)\/", "Text": "Joe <b>Smith</b>", "Count": 0}
```

Listing 13-15 shows how I have enabled the Microsoft date format in the WebApiConfig.cs file.

```cs
jsonFormatter.SerializerSettings.DateFormatHandling                 = DateFormatHandling.MicrosoftDateFormat;
```

Listing 13-16. Processing a Microsoft Date Value in the Formats.cshtml File

```JavaScript
$.ajax("/api/formats", {
            success: function(data) {
                dataObject = ko.observable(data);
                var date = new Date(parseInt(data.Time.replace("/Date(", "").replace(")/", ""), 10));
                dataObject().Time = date.toLocaleTimeString();
                ko.applyBindings();
            }
```

###Handling String Escaping###

By default, only control characters are escaped in string values when generating JSON data.

Table 13-8. The Values Defined by the StringEscapeHandling Enumeration

|Value| Description|
|--|--|
|Default |Only control characters are escaped.|
|EscapeNonAscii| Control characters and non-ASCII characters are escaped.|
|EscapeHtml | HTML characters and control characters are escaped.|

The Knockout text binding automatically escapes dangerous HTML characters,

Relying on the client to escape dangerous HTML characters isn’t enough when working with web services.

Listing 13-17. Enabling HTML Character Escaping in the WebApiConfig.cs File

```cs
JsonMediaTypeFormatter jsonFormatter = config.Formatters.JsonFormatter;
jsonFormatter.Indent = true;
jsonFormatter.SerializerSettings.DateFormatHandling = DateFormatHandling.MicrosoftDateFormat;             jsonFormatter.SerializerSettings.StringEscapeHandling = StringEscapeHandling.EscapeHtml;
```

> **Tip**  Postman formats HTML content in the Pretty view of the result data. Be sure to select the Raw view to see the characters sent by the web service.

###Handling Default Values###

Default values are null for object and nullable properties, zero for numeric properties, and false for bool properties.

Table 13-9. The Values Defined by the DefaultValueHandling Enumeration

|Value| Description|
|--|--|
|Include| This is the default value, and it includes properties with default values in the JSON data.|
|Ignore| This setting excludes properties with default values from the JSON data.|
|Populate| This setting is used when deserializing JSON data. It sets the default value for properties in C# objects when there is no corresponding property in the JSON data. Deserialization is part of the model binding process, which I describe in Chapter 14.|
|IgnoreAndPopulate| This setting combines the Ignore and Populate values.|

> **Tip**  There is also a NullValueHandling setting that applies only to null values.

The Include value is the default, which means that the Count property in my example data object is included in the JSON that the web service generates, even though its value is zero.

Listing 13-18. Ignoring Default Values in the WebApiConfig.cs File

```cs
JsonMediaTypeFormatter jsonFormatter = config.Formatters.JsonFormatter;
jsonFormatter.Indent = true;
jsonFormatter.SerializerSettings.DateFormatHandling = DateFormatHandling.MicrosoftDateFormat;             jsonFormatter.SerializerSettings.StringEscapeHandling = StringEscapeHandling.EscapeHtml;             jsonFormatter.SerializerSettings.DefaultValueHandling = DefaultValueHandling.Ignore;
```

Listing 13-19. Re-creating Missing Properties in the Formats.cshtml File

```cs
if (!("Count" in data)) {
  data.Count = 0;
}
```

##Using the XML Media Type Formatter##

The XmlMediaTypeFormatter class is responsible for serializing model objects into XML data,

it relies on other classes to generate the serialized data. In this case, the System.Runtime.DataContractSerializer class is used by default.

XML support in Web API is largely so that web services can support clients originally developed to consume web services created with legacy Microsoft web service tools.

##WHAT HAPPENED TO XML WEB SERVICES?##

The term XML web services was used in the early 2000s to describe heavily structured web services that were carefully described by different XML documents and standards, including the Simple Object Access Protocol (SOAP) and the Web Service Description Language (WSDL). These standards were used to create loosely coupled clients and services but required complex XML documents that were difficult to work with. These days, those web services that still use XML use the format only to describe fragments of data without the overhead of precise type and service descriptions—rather like the JSON strings that you have seen in other examples but expressed using XML elements and attributes instead of JavaScript-style objects and properties.

##Configuring the XML Media Type Formatter##

Table 13-11. The XmlMediaTypeFormatter Configuration Methods

|Name| Description|
|--|--|
|Indent| When set to true, the XML will be indented, making it easier to read (but more verbose).|
|MaxDepth| Sets the maximum depth of object allowed when reading XML data during the model binding process.|
|UseXmlSerializer| When set to true, the XmlSerializer class will be used to produce XML data.|
|WriterSettings| Gets the XmlWriterSettings object used to configure serialization.|

The DataContractSerializer class was introduced in .NET 3.0 and is the default serializer used by the XmlMediaTypeFormatter class to create XML.

You can configure the serializer by changing the property values of the XmlWriterSettings object returned by the WriterSettings property—although

You can find a complete list of the properties defined by the XmlWriterSettings class at http://goo.gl/iMDEFZ.

If you set the WriterSettings property to true, the XmlMediaTypeFormatter will use the XmlSerializer class, which has been around since .NET 1.1.

There is an old, but still useful, comparison of the two XML serializer classes at http://goo.gl/gz0lyH that can help you understand the strengths and (many) weaknesses of each class.

The first task is to get the XmlMediaTypeFormatter class working because at the moment it isn’t able to serialize the data returned

you can’t return dynamic objects from action methods.

This means you need to create the equivalent of view model classes in the MVC framework to return results from action methods.

###Updating the Client JavaScript Code###

jQuery automatically parses XML data received from Ajax to create an XMLDocument object, which—as the name suggests—is a representation of an XML document, provided by the browser.

The API for XMLDocument is awkward to work with, and the simplest way to create JavaScript objects from XML data is to use jQuery methods that are usually used to handle HTML.

```JavaScript
$.ajax("/api/formats", {
            dataType: "xml",
            success: function(data) {
                var props = ["Time", "Text", "Count"];
                var jsObject = {};
                for (var i = 0; i < props.length; i++) {
                    jsObject[props[i]] = $(data).find(props[i]).text();
                }
                dataObject = ko.observable(jsObject);
                ko.applyBindings();
            }
```

The $(data) part creates a jQuery wrapper around the XMLDocument object, which means that the jQuery methods can be used.

The find method locates all of the elements of a specific type, and the text method returns the combined text content of the matching elements.

#CHAPTER 14 Understanding Parameter and Model Binding#

In the MVC framework, model binding is the process used to extract values from the HTTP request to provide values for the arguments needed to invoke action methods.

In Web API, there are two processes that do this work: parameter binding and model binding.

They work in loosely the same way model binding in the MVC framework works, but they are optimized to improve the performance

##Creating the Controller##

I need to define a new web service that doesn’t follow the RESTful convention so that I can separate the parameter and model binding processes from other Web API features.

Listing 14-1. The Contents of the BindingsController.cs File

```cs
public class BindingsController : ApiController {

  [HttpGet]
  [HttpPost]
  public int SumNumbers(int first, int second) {
    return first + second;
  }
```

```JavaScript
var sendRequest = function() {
    $.ajax("/api/bindings/sumnumbers", {
        type: "GET",
        data: viewModel(),
        success: function(data) {
            gotError(false);
            response("Total: " + data);
        },
        error: function(jqXHR) {
            gotError(true);
            response(jqXHR.status + " (" + jqXHR.statusText + ")");
        }
    });
};
```

> **Tip**  I have to specify the action method as part of the URL, since I did not follow the RESTful convention in the Bindings controller.

##Adding a New Route##

For some of the examples in this chapter, I need to define a new URL route that will let me target the SumNumbers action method in the Bindings controller with a URL like this one:

http://localhost:29844/api/bindings/sumnumbers/10/12

Listing 14-5. Tidying Up the WebApiConfig.cs File and Defining a New URL Route

```cs
config.Routes.MapHttpRoute( 
  name: "Binding Example Route",
  routeTemplate: "api/{controller}/{action}/{first}/{second}"
);
```

###Understanding the Default Binding Behavior###

Parameter binding and model binding both extract data from the request so that it can be used as arguments to invoke action methods.

The result is that you can define action methods that accept .NET types as parameters and let Web API worry about how to get values for them behind the scenes.

The alternative is to get the data values you need directly from the HttpRequestMessage object, but this can be awkward, duplicative, and error-prone and prevents you from benefitting from features such as model validation,

Note  Strictly speaking, the term parameter describes the definition of a variable that a method or function accepts, and an argument is the value of that variable when the method or function is invoked.

Bindings are used automatically when you define an action method that has parameters.

Parameter binding is used to locate values for simple .NET types but will do so only using the request URL. Model binding is used to create complex .NET types but will do so only using the request body.


###Understanding Parameter Binding###

Parameter binding is used when an parameter is a simple type, which means it is a TimeSpan, DateTime, or Guid object or one of the .NET primitive types: string, char, bool, int, uint, byte, sbyte, short, ushort, long, ulong, float, double, and decimal.

By default, parameter binding obtains values only from the request URL, which means there are two sources of data values: the routing segments in the URL that has been requested and the query string.

###Understanding the Parameter Binding Pitfall###

By default, parameter binding will only extract values from the URL, which leads to the most common binding problem: trying to bind simple types from the request body.

This problem usually occurs because jQuery adapts the way it uses the string generated from the data setting based on the HTTP verb.

For GET requests, the string is appended to the URL as the query string, which matches the way that parameter binding works.

For other HTTP verbs, jQuery puts the data string in the request body.

This problem comes up at some point in most complex Web API projects, either because you need to change the verb used for a particular kind of request or because you want to make a POST or DELETE request that targets an action method that receives simple data types.

There are two ways to solve this problem.

The first is to explicitly add values that correspond to simple data type action method parameters to the query string, rather than allowing jQuery to handle the data for you.

Listing 14-7. Explicitly Setting the Query String in the bindings.js File

```JavaScript
var sendRequest = function () {
  $.ajax("/api/bindings/sumnumbers?" + $.param(viewModel()), {
```

The second technique is to let jQuery put the data in the body and use model binding to extract the values for the action method arguments, overriding the default behavior.

###Understanding Model Binding###

Model binding is the counterpart to parameter binding and is used for complex types—which

Since model binding works only on complex types, I need to add a model

Listing 14-8. The Contents of the BindingModels.cs File

```cs
public class Numbers {
  public int First { get; set; }
  public int Second { get; set; }
}
```

Listing 14-9. Using a Model Class in the BindingsController.cs File

```cs
[HttpPost]
public int SumNumbers(Numbers calc) {
  return calc.First + calc.Second;
}
```

I also updated the sendRequest method in the bindings.js file so that the client sends a request that can be processed by model binding,

Listing 14-10. Sending a Complex Type in the bindings.js File

```JavaScript
var sendRequest = function() {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    data: viewModel(),
```

Model binding doesn’t require the client to have any knowledge about the data type that the action method requires. Instead, all of the work to create an object of the type required by the action method is performed at the web service.

Web API looks at the URL routing information and determines that the request is intended to target the SumNumbers action method, which requires a Numbers object.

###Understanding the Model Binding Pitfall###

The obvious pitfall with model binding is that it can create objects only from data in the request body, which is the mirror of the most common parameter binding problem.

This means that, by default, you can’t use a complex type parameter to receive data from a GET request,

The second pitfall is that model binding can extract only one object from the request body.

In the MVC framework, the entire request body is processed and stored in memory before request processing starts. The data in the request is available as a collection of name-value pairs that can be used to create as many objects as you need, even to the extent that different objects can be created from the same data items.

The body of Web API requests isn’t read into memory before the model binding process. Instead, the data is available as a stream, and once a model binder has read the data from the stream, it is no longer available for further use.

I show you many different ways of customizing and controlling the model binding process in this chapter and the ones that follow, but there is no neat way to step around the one-object-per-request limit.

This problem usually appears when you need to extend the functionality of an action method.


```cs
[HttpGet]
[HttpPost]
public int SumNumbers(Numbers calc, Operation op) {
  int result = op.Add ? calc.First + calc.Second : calc.First - calc.Second;
  return op.Double ? result * 2 : result;
}
```

Although the client will now send all of the data values required to create a Numbers object and an Operation object, the limitation of one object per request body will stop that from happening.

The only way to resolve this problem with the default binding behavior is to create a single complex type that contains all the data values that the action method requires—in

###Performing Binding Customizations###

Binding data values to action method parameters in Web API is flexible and fully featured, but it requires more work than the MVC framework to get control of the process.

The FromUri and FromBody attributes can be used to override the default parameter and model binding behavior and specify a location for the binding data. A binding rule can be used to create the same effect for all Web API controllers in the application.

Use these attributes when the default behavior does not match the location of the data in the requests that you receive from clients.

There are limitations with both attributes. In particular, the FromBody attribute requires the request body to be in a specific format that contains only one data value. The FromUri attribute is more useful but should be used with caution because it can create a tight coupling between the client and the web service.

###Binding Complex Types from the Request URL###

This customization is performed by applying the FromUri attribute, defined in the System.Web.Http namespace, to the parameters you created from the data in the URL.

Listing 14-14. Getting Values for a Complex Type from the Request URL in the BindingsController.cs

```cs
[HttpGet]
[HttpPost]
public int SumNumbers([FromUri] Numbers calc, [FromUri] Operation op) {
  int result = op.Add ? calc.First + calc.Second : calc.First - calc.Second;
  return op.Double ? result * 2 : result;
}
```

I have applied the FromUri attribute to both parameters, which means that the data extracted from the URL segments by the routing configuration or from the query string will be used

It is usually a sign of a problem if you are mixing and matching the locations for the data used for different parameters.

###USING THE FROMURI ATTRIBUTE###

For GET requests, the FromUri attribute should be applied to all of the complex data type parameters because the client expects to put its data into the query string,

For other HTTP verbs, the FromUri attribute should not be used at all.

applying the FromUri attribute to some parameters and not others means that the client has to know where the web service is going to look for different pieces of information, which causes the tight-coupling problem

One common reason for using the FromUri attribute for non-GET requests is to create objects from the URL that can be validated using the model binding process,

The problem with this approach is that the client is then required to differentiate between model errors that relate to the data item contained in the body and model errors that relate to some opaque aspect of the URL.

Use URL routing (as described in Chapters 20 and 21) to enforce URL structure and use standard HTTP status codes to tell the client when a request can’t be processed

###Binding Simple Types from the Request Body###

The FromBody attribute allows simple types to be obtained from the request body, rather than the URL.

The FromBody attribute doesn’t work around the one-object-per-request limit, which means you can get one simple type or one complex type from the request body—and that means you can apply the attribute only to a single action method parameter.

The FromBody attribute is almost useless for reading simple types because it is so limited in the way that it reads values from the request body.

Listing 14-16. Using the FromBody Attribute in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public int SumNumbers([FromBody] int number) {
return number * 2;
}
```


Listing 14-17. Targetting an Action Method with the FromBody Attribute in the bindings.js File

```JavaScript
var sendRequest = function() {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    data: {
                        '': viewModel().first
                    },
                    success: function(data) {
                        gotError(false);
                        response("Total: " + data);
                    },
```

This awkward hack causes jQuery to create a request body like this, assuming that the first property has a value of 50:

> =050

This is the format that the FromBody attribute requires. There can be only one value, it cannot be assigned a name, and it must be prefixed with the equal sign (=).

###Defining a Binding Rule###

The FromUri and FromBody attributes let you specify the source of the data for a binding, but they need to be applied to every action method parameter, which is just the sort of thing you can easily forget to do consistently across an application.

An alternative is to define a binding rule, which tells Web API how to bind parameters of a specific type throughout an application.

The HttpConfiguration.ParameterBindingRules property returns a collection of parameter binding rules.

Binding rules are added to the collection during the configuration stage

When you define a new rule, you need to define a method that receives a description of an action method parameter and returns an object that will be able to bind a value for it.

The description is provided by an HttpParameterDescriptor object, and the binding is performed by an HttpParameterBinding object.

for the simple rules you can use an extension method defined in the System.Web.Http.Controllers namespace, which operates on an instance of the HttpParameterDescriptor class and creates an HttpParameterBinding object that applies either the FromUri or FromBody attribute throughout the application.

Listing 14-18. Defining a Binding Rule in the WebApiConfig.cs File

```cs
config.ParameterBindingRules.Insert(0, typeof(Numbers), x => x.BindWithAttribute(new FromUriAttribute()));
```

All Numbers parameters should be treated as though they have the FromUri attribute applied directly.

The rules in the collection are evaluated in order, and using the Insert method allows control over how binding is performed.

Complex binding rules can match parameters using fine-grained detail about the action method and controller that contain them, but for simple rules it is best to insert them at position zero to be sure that no other rules take precedence.

The Insert method takes three arguments:

- The position in the collection
- The type to which the rule will apply
- A function that takes an HttpParameterDescriptor object and returns an HttpParameterBinding object. The BindWithAttribute extension method sidesteps the need to write the function.

> **Tip**  Applying the FromUri or FromBody attribute to a parameter overrides the binding rules. You can use a binding rule to define a default behavior and then change it for specific parameters.

##Manually Obtaining Request Values##

My advice is to use the binding features wherever you can, but working directly with the request can be useful if you have multiple generations of clients targeting the same action method with different data—and,

```cs
Request.GetQueryNameValuePairs().ToDictionary(x => x.Key, x => x.Value);
```

The easiest way to get the query string data is to use one of the extension methods that Web API adds to the System.Net namespace that operate on the HttpRequestMessage object that represents the request,

The Request property is defined by the ApiController class and returns the HttpRequestMessage object.

##Handling POST Requests##

The key to working with the request body is the HttpContent class, which is defined in the System.Net.Http namespace.

An instance of the HttpContent class is returned by the HttpRequestMessage.Content

The methods and properties of the HttpContent class are supplemented by Web API extension methods that make it easier to work with different types of request.

Table 14-5. The Descriptive Members Defined by HttpContent

|Name| Description|
|--|--|
|Headers| Returns an HttpContentHeaders object that contains the headers in the request |
|IsFormData() | Returns true if the Content-Type header is application/x-www-form-urlencoded | 
|IsMimeMultipartContent() | Returns true if the Content-Type header indicates that MIME multipart encoding has been used for the request body|

The methods described in Table 14-5 operate on the request headers. The request body isn’t read until it is required—which is why there is a limit of one value when using the binding features.

Table 14-6. The Methods Defined by HttpContent for Reading the Request Body

|Name| Description|
|--|--|
|ReadAsStreamAsync() | Returns a Stream that can be used to read the raw contents of the request body|
|ReadAsStringAsync() | Returns the contents of the request body as a string | 
|ReadAsFormDataAsync() |Returns a NameValueCollection containing name-value pairs parsed from x-www-form-urlencoded data|
|ReadAsMultipartAsync() | Returns a MultipartMemoryStreamProvider that parses the contents of a MIME multipart encoded body|

jQuery will set the Content-Type header to application/x-www-form-encoded, which is normal for web applications sending form data,

Listing 14-24. Reading Data from the Request Body in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public async Task<IHttpActionResult> SumNumbers() {
  if (Request.Content.IsFormData()) {
    NameValueCollection jqData = await Request.Content.ReadAsFormDataAsync();
```

#CHAPTER 15 Binding Simple Data Types#

##Preparing the Common Code##

For the first part of this chapter, I focus on customizing the way that simple data types are bound through the parameter binding process.

Web API comes with a complete set of classes that can bind the built-in simple types so that a string or int parameter is matched to a value in the request URL or body,

I am going to show you how to bind parameters to request headers. This isn’t something that is overwhelmingly useful in a real project, but it provides a suitable foundation for demonstrating the customization techniques available.

Listing 15-5. The Contents of the HeadersMap.cs File

```cs
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;

namespace ExampleApp.Infrastructure {
 public class HeadersMap {

  private Dictionary < string, string > headersCollection;

  public HeadersMap(HttpHeaders headers) {
   headersCollection = headers.ToDictionary(x => x.Key.ToLower().Replace("-", string.Empty), x => string.Join(",", x.Value));
  }

  public string this[string header] {
   get {
    string key = header.ToLower();
    return headersCollection.ContainsKey(key) ? headersCollection[key] : null;
   }
  }

  public bool ContainsHeader(string header) {
   return this[header] != null;
  }
 }
}
```

The HttpHeaders class is defined in the System.Net.Http namespace, and I will be obtaining instances through the HttpRequestMessage.Headers property

Table 15-2. The Methods Defined by the HttpHeaders Class

|Method | Description |
|--|--|
|Add(header, IEnumerable<value>) |Adds the specified header with the enumeration of values to the collection |
|Add(header, value) |Adds the specified header and value to the collection |
|Clear() | Removes all the headers from the collection |
|Contains(header) | Returns true if there is a header with the specified name in the collection | 
|GetValues(header)| Returns an IEnumerable<string> containing the values for the specified header |
|Remove(header)| Removes the specified header from the collection|

> **Note**  Some of the methods in Table 15-2 can be used to modify the headers because the HttpHeader class is also used by HttpResponseMessage to define the headers that will be sent in an HTTP response.

> **Tip**  I have omitted some detail in this section. In fact, there are two subclasses of the HttpHeaders class—HttpRequestHeaders and HttpResponseHeaders—that provide additional members that make it easy to get and set the set of headers that the HTTP specification allows in request and response messages.

###Working with Value Providers and Value Provider Factories###

Value providers are responsible for getting a single simple data value.

Value providers are given the name of the data item that is required and return its value.

The value usually comes from the request, but any source of data can be used including the data model.

The name of the data item depends on the context in which the value provider is being used. For parameter binding it will be the name of the action method parameter, and for model binding it will be the name of a property from the class that is being instantiated.

Value provider factories are responsible for creating instances of value providers based on the description of an action method parameter.

A value provider factory is responsible for deciding whether the value provider is able to provide a value and provide an instance of it to Web API.

Use value providers and value provider factories when you want to bind parameter values from parts of the request other than the URL or the body or from some other data source entirely.

###Understanding Value Providers and Value Provider Factories###

Value providers implement the IValueProvider interface, which is defined in the System.Web.Http.ValueProviders namespace.

Listing 15-6. The IValueProvider Interface

```cs
namespace System.Web.Http.ValueProviders {
  public interface IValueProvider {
    bool ContainsPrefix(string prefix);
    ValueProviderResult GetValue(string key);
  }
}
```

GetValue method that is of interest. This method is called when a value is needed, and the result is expressed using an instance of the ValueProviderResult class,

Table 15-4. The Properties and Method Defined by the ValueProviderResult Class

|Name| Description|
|--|--|
|RawValue| This property is used to store the value obtained by the value provider from the request.|
|AttemptedValue| This property is initially set to be the same as RawValue but will be used to contain an error message if there is a model validation error. See Chapter 18 for details of Web API model validation.|
|Culture| Gets the culture for the value. This is used when converting the object returned by the RawValue property and should be set to CultureInfo.InvariantCulture if there are no cultural considerations for a value.|
|ConvertTo(T)| Attempts to convert the value to the specified type. See Chapter 16 for details.|

The RawValue and AttemptedValue properties cause confusion, but you simply set both properties to the value extracted from the request and let Web API change the AttempedValue if there are model validation problems.

Notice that the methods defined by the IValueProvider interface do not provide access to details of the request. This is because instances of IValueProvider are created by ValueProviderFactory classes, which are responsible for giving a value provider access to the context information it requires.

Listing 15-7. The Abstract ValueProviderFactory Class

```cs
namespace System.Web.Http.ValueProviders {
  public abstract class ValueProviderFactory {
    public abstract IValueProvider GetValueProvider(HttpActionContext context);
  }
}
```

> **Caution**  Don’t be tempted to use value providers used to perform data operations.

This breaks the separation of concerns that helps make applications easy to understand and maintain. Use value providers only to—as their name suggests—provide data values and leave the operations where they belong.

The ValueProviderFactory class defines a single abstract method called GetValueProvider, which is called when a value is required for an action method parameter.

An HttpActionContext object is passed to the GetValueProvider, which allows classes derived from ValueProviderFactory to inspect the request and decide whether the IValueProvider implementations for which they are responsible for may be able to provide values for the request.

Table 15-5. The Properties Defined by the HttpActionContext Class

|Name| Description|
|--|--|
|ActionArguments |Returns a Dictionary<string, object> that maps the names of the action method arguments to their types.| 
|ActionDescriptor| Returns an HttpActionDescriptor object that describes the action method that is going to be invoked. See Chapter 22. |
|ControllerContext| Returns an HttpControllerContext object that describes the controller in which the action method is defined. See Chapter 19 for details of this class. |
|ModelState | Returns a ModelStateDictionary object used in the model validation process, which I describe in Chapter 18.|
|Request| Returns the HttpRequestMessage object that describes the current request. | 
|RequestContext|  Returns the HttpRequestContext object that provides supplementary information about the request.|
|Response| Returns the HttpResponseMessage object that will be used to produce the response to the client.|

###Creating a Custom Value Provider and Factory###

The GetValue method defined by a value provider can be called multiple times to obtain values for different parameters, and this means it is sensible to perform any parsing of request data in the value provider constructor inside the GetValueProvider method of the factory class.

Listing 15-8. The Contents of the HeaderValueProvider.cs File

```cs
public class HeaderValueProvider: IValueProvider {
 private HeadersMap headers;
 
 public HeaderValueProvider(HeadersMap map) {
  headers = map;
 }
 
 public ValueProviderResult GetValue(string key) {
  string value = headers[key];
  return value == null ? null : new ValueProviderResult(value, value, CultureInfo.InvariantCulture);
 }
 
 public bool ContainsPrefix(string prefix) {
  return false;
 }
}
```

The GetValue method is not required to return a value, and I return null if there is no corresponding header, indicating that the data that the value provider represents can’t be used to bind to the parameter.

Web API will generally use multiple value provider factories and value providers when trying to perform parameter binding, and when one value provider returns null, Web API moves on to the next one and tries again.

Listing 15-9. The Contents of the HeaderValueProviderFactory.cs File

```cs
public class HeaderValueProviderFactory: ValueProviderFactory {

 public override IValueProvider GetValueProvider(HttpActionContext context) {
  if (context.Request.Method == HttpMethod.Post) {
   return new HeaderValueProvider(new HeadersMap(context.Request.Headers));
  } else {
   return null;
  }
 }
}
```

The job of the factory is to examine the HttpActionContext object and decide whether the value provider it is responsible for can be used to bind values for the current request.

###Applying a Custom Value Provider and Factory###

There are several different ways of configuring the way that the value provider and its factory are used,

###Understanding How Web API Looks for Values###

When Web API needs a value for a simple type parameter, it tries to find one in three different ways. In the sections that follow, I’ll show you each of them

First, Web API checks to see whether a model binding attribute has been applied directly to the attribute.

###FromBody attribute###

If there is no such attribute, Web API looks for a parameter binding rule.

Finally, if there is no directly applied attribute and no parameter binding rule, then Web API acts as though the parameter has been decorated with the FromUri attribute. This is the default behavior and means values are obtained from the request routing or query string if an alternative source for values hasn’t been specified.

Web API can look at the parameter to see whether there is an attribute, check the set of parameter binding rules to see whether there is one for a specific parameter, or decide to use the default behavior, all before the application starts processing requests.

Working out how specific parameters will be bound during the configuration stage allows values to be obtained faster when processing requests because the analysis has already been performed and the results cached, avoiding the need to perform reflection on action methods every time one is invoked.

Caching binding information requires Web API to define a class that describes what the source of a value will be for each parameter, and that is the job of the HttpParameterBinding class, which is defined in the System.Web.Http.Controllers namespace

Table 15-6. The Properties and Method Defined by the HttpParameterBinding Class

|Name| Description|
|--|--|
|Descriptor| Returns the HttpParameterDescriptor object associated with this binding (and which is passed to the constructor).|
|ErrorMessage| Returns a string that is used as an error message if the binding fails. If not overridden, this property will return null.|
|IsValid| Returns true if the binding was successful. If not overridden, this property returns true if the ErrorMessage property returns null. |
|WillReadBody| Returns true if the value for the parameter will be read from the request body. This property is used to detect when more than one parameter value is going to be read from the body so that an error can be reported (as demonstrated in Chapter 14).|
|ExecuteBindingAsync(metadata,context, cancelToken)| This method is called to perform the binding and get a value for the parameter. See the following text for details. |
|SetValue(context, value) | This protected method is used to set the parameter value. The arguments are the HttpActionContext object passed to the ExecuteBindingAsyncMethod and the parameter value. |

The HttpParameterBinding class is abstract and is derived to provide binding implementation classes that override the ExecuteBindingAsync method to provide values from different data sources, including the request URL and body.

each of the techniques that I show you in the sections that follow produces an instance of the HttpParameterBinding class that Web API will cache and then use when it needs a value for a parameter.

###Applying a Value Provider Factory with an Attribute###

The first place that Web API looks when it needs a value is at the attributes that have been applied to the parameter in the action method. In particular, Web API looks for attributes that are derived from the abstract ParameterBindingAttribute class, which is defined in the System.Web.Http.Controllers namespace.

Listing 15-10. The Definition of the ParameterBindingAttribute Class

```cs
namespace System.Web.Http
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Parameter, Inherited = true, AllowMultiple = false)]
public abstract class ParameterBindingAttribute: Attribute {
  public abstract HttpParameterBinding GetBinding(HttpParameterDescriptor parameter);
  }
}
```

The ParameterBindingAttribute defines an abstract GetBinding method, which takes an HttpParameterDescriptor object and returns an HttpParameterBinding that can be cached and then used when Web API handles a request that targets the action method that defines the parameter.

The HttpParameterDescriptor class is used to describe the parameter for which Web API is looking for a binding.

Table 15-7. The Properties Defined by the HttpParameterDescriptor Class

| Name| Description |
|--|--|
|ActionName| Returns the name of the action method. Configuration Returns the HttpConfiguration object.|
|DefaultValue| Returns the default value for the parameter type. IsOptional Returns true if the parameter is optional. (See the “Extending the Default Behavior” section for an interesting aspect of using optional parameters.)|
|ParameterBindingAttribute | Returns the attribute, if any, applied to the parameter to control binding.|
|ParameterName | Returns the name of the parameter. ParameterType Returns the type of the parameter. |
|Prefix| Returns the prefix of the parameter. I explain prefixes in Chapters 16 and 17|

The job of the ParameterBindingAttribute.GetBinding method is to process an HttpParameterDescriptor object that describes a parameter and produce an HttpParameterBinding object that will be able to produce a value for that parameter at runtime.

This pattern—producing an HttpParameterBinding in exchange for an HttpParameterDescriptor—recurs through this part of the chapter because it is the fundamental mechanism that Web API uses to handle parameter binding.

###Using the Built-in Parameter Binding Attribute###

Web API includes a ValueProvider attribute that can be applied to attributes so that values are obtained through a value provider factory.

Listing 15-11. Adding a Parameter Bound by a Value Provider Factory in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers(Numbers numbers, [ValueProvider(typeof(HeaderValueProviderFactory))] string accept) {
  return string.Format("{0} (Accept: {1})", numbers.First + numbers.Second, accept);
  }
}
```

###Creating a Custom Attribute Based on the ModelBindingAttribute Class###

Using the ValueProvider attribute works, but including the name of the value provider factory alongside every parameter leads to code that is hard to read.

Fortunately, it is a simple matter to create a custom attribute class that is tailored to a specific value provider factory by deriving from the ModelBinderAttribute class. (It isn’t possible to derive from the ValueProviderAttribute class because it is sealed.)


Listing 15-12. The Contents of the FromHeaderAttribute.cs File

```cs
public class FromHeaderAttribute : ModelBinderAttribute {

  public override IEnumerable<ValueProviderFactory> GetValueProviderFactories(HttpConfiguration configuration) {             return new ValueProviderFactory[] { new HeaderValueProviderFactory() };
  }
}
```

Listing 15-13. Applying a Custom Binding Attribute in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers(Numbers numbers, [FromHeader] string accept) {
  return string.Format("{0} (Accept: {1})", numbers.First + numbers.Second, accept);
}
```

Creating a Custom Attribute Based on the ParameterBindingAttribute Class

But I am also going to demonstrate how to create an attribute based on the ParameterBindingAttribute class, without the use of any intermediary classes that have other roles within Web API.

Listing 15-14. The Contents of the HeaderValueParameterBinding.cs File

```cs
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http.Controllers;
using System.Web.Http.Metadata;
using System.Web.Http.ValueProviders;
namespace ExampleApp.Infrastructure {

 public class HeaderValueParameterBinding: HttpParameterBinding {

  private HeaderValueProviderFactory factory;

  public HeaderValueParameterBinding(HttpParameterDescriptor descriptor): base(descriptor) {
   factory = new HeaderValueProviderFactory();
  }

  public override Task ExecuteBindingAsync(ModelMetadataProvider metadataProvider, HttpActionContext context, CancellationToken cancellationToken) {

   IValueProvider valueProvider = factory.GetValueProvider(context);

   if (valueProvider != null) {
    ValueProviderResult result = valueProvider.GetValue(Descriptor.ParameterName);
    if (result != null) {
     SetValue(context, result.RawValue);
    }
   }

   return Task.FromResult < object > (null);
  }
 }
}
```

Remember that the goal of a parameter binding is to call the SetValue method to provide the value that will be used for the parameter when its action method is invoked.

The ExecuteBindingAsync method is asynchronous, but all of the classes that I rely on are synchronous, so I satisfy the return type of the method by using the Task.FromResult method, which returns a Task that completes immediately,

This technique is perfectly acceptable for short, simple methods where the cost of creating and starting a Task is likely to require more work and time than performing the work synchronously.

Now that I have a custom derivation of the HttpParameterBinding class, I can update the custom binding attribute, as shown in Listing 15-15

Listing 15-15. Deriving from the ParameterBindingAttribute Class in the FromHeaderAttribute.cs File

```cs
using System.Collections.Generic;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;
using System.Web.Http.Controllers;
namespace ExampleApp.Infrastructure {

 public class FromHeaderAttribute: ParameterBindingAttribute {

  public override HttpParameterBinding GetBinding(HttpParameterDescriptor param) {
   return new HeaderValueParameterBinding(param);
  }
 }
}
```


The FromHeaderAttribute class directly follows the pattern I described earlier: processing an HttpParameterDescriptor object in order to create an HttpParameterBinding object that Web API will cache and use to get values for a parameter when requests target its action method.

###Extending the Default Behavior###

I am going to jump ahead to the third place that Web API looks for a value during parameter binding. If there is no directly applied parameter binding attribute and no binding rule (which I describe in the “Creating a Parameter Binding Rule” section), then binding proceeds as though the parameter had been decorated with the FromUri attribute, even if it has not.

> **Tip**  This applies only to simple type parameters. The default behavior for complex type parameters is to proceed as though the FromBody attribute has been applied.

Listing 15-16. The Definition of the FromUriAttribute Class

```cs
using System.Collections.Generic;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;
namespace System.Web.Http {

 [AttributeUsage(AttributeTargets.Class | AttributeTargets.Parameter, Inherited = true, AllowMultiple = false)] public sealed class FromUriAttribute: ModelBinderAttribute {
  public override IEnumerable < ValueProviderFactory > GetValueProviderFactories(HttpConfiguration configuration) {

   foreach(ValueProviderFactory f in base.GetValueProviderFactories(configuration)) {
    if (f is IUriValueProviderFactory) {
     yield
     return f;
    }
   }
  }
 }
}
```


First, notice that the FromUriAttribute.GetValueProviderFactories implementation gets its data from the base class implementation of the same method.

```cs
foreach (ValueProviderFactory f in base.GetValueProviderFactories(configuration)) {
```

This is important because I want to add my value provider factory to the set used by the FromUri attribute so that it becomes part of the default behavior.

Here is the implementation of the GetValueProviderFactories method in the ModelBinderAttribute class:

```cs
public virtual IEnumerable<ValueProviderFactory> GetValueProviderFactories(HttpConfiguration configuration) {
  return configuration.Services.GetValueProviderFactories(); 
}
```

The second aspect of the way that the FromUri attribute works is the one to watch out for. Not all of the value provider factory classes are used to locate values.

```cs
foreach (ValueProviderFactory f in base.GetValueProviderFactories(configuration)) {
  if (f is IUriValueProviderFactory) {
    yield return f;
  }
}
```

The IUriValueProviderFactory interface defines no methods, and no error will be reported if you don’t declare the interface in a custom factory class; it just won’t be used to get simple type values as part of the default behavior.

###Registering the Value Provider Factory###

Knowing how the FromUri attribute works allows me to easily integrate header values into my application.

First I have to update the HeaderValueProviderFactory class to implement the IUriValueProviderFactory interface,

Listing 15-17. Implementing IUriValueProviderFactory in the HeaderValueProviderFactory.cs File

```cs
using System.Net.Http;
using System.Web.Http.Controllers;
using System.Web.Http.ValueProviders;
namespace ExampleApp.Infrastructure {

  public class HeaderValueProviderFactory: ValueProviderFactory, IUriValueProviderFactory {

   public override IValueProvider GetValueProvider(HttpActionContext context) {

    if (context.Request.Method == HttpMethod.Post) {
     return new HeaderValueProvider(new HeadersMap(context.Request.Headers));
    } else {
     return null;
    }
   }
  }
}
```

Now I can register my value provider factory as part of the services collection, either through the dependency injection system or directly during application configuration.

Listing 15-18. Registering a Value Provider Factory in the WebApiConfig.cs File

```cs
config.Services.Add(typeof(ValueProviderFactory), new HeaderValueProviderFactory());
```

###REGISTERING A FACTORY USING DEPENDENCY INJECTION###

```cs
kernel.Bind<ValueProviderFactory>().To<HeaderValueProviderFactory>(); }
```

###Updating the Controller###

The final step in extending the default behavior is to update the parameter in the action method signature.

There are two required changes: removing the FromHeader attribute that I added in Listing 15-12 and making the parameter optional by assigning a default value, as shown in Listing 15-19.

Listing 15-19. Updating the Action Method Parameter in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers(Numbers numbers, string accept = null) {
 return string.Format("{0} (Accept: {1})", numbers.First + numbers.Second, accept);
}
```

I need to remove the attribute so that Web API will fall back to using the default behavior, as explained at the start of this section.

The need to make the parameter optional is a little more complicated, and it arises because I am doing something that runs counter to an optimization in the way that Web API selection action methods handle requests.

For each request that it receives, Web API needs to select an action method.

Knowing that there are different sources of data—including the request body, which has yet to be read—the optimization checks only the parameters that are the following:

Not optional (a default value is not assigned in the parameter definition) Is one of the simple types I listed in Chapter 14 Has a binding that will obtain a value from provider factory that implements the IUriValueProviderFactory

There are other checks that happen as part of the selection process, but if a parameter meets all three of these conditions, Web API assumes that there must be a value in the query string or routing data in order for the action method to be able to receive the request.

This is a problem for my accept header, which meets all three of the conditions but doesn’t get its value from the URL.

###Creating a Parameter Binding Rule###

Parameter binding rules are functions that receive an HttpParameterDescriptor object and return an HttpParameterBinding object if the binding they represent will be able to provide a value for the parameter.

These functions are called while Web API is being configured and before any requests are processed, which means that the decisions the functions make are based on the definition of the parameter without any request context.

###Relying on the Parameter Name###

Listing 15-20. Adding a Parameter Binding Rule to the WebApiConfig.cs File

```cs
config.ParameterBindingRules.Add(
  x => typeof(HttpRequestHeaders).GetProperty(x.ParameterName) != null  ? new HeaderValueParameterBinding(x) : null);
```

have expressed the parameter binding rule as a lambda expression. I use standard .NET reflection to see whether the HttpRequestHeaders class has a property that matches the parameter name; if it does, I return an instance of the HeaderValueParameterBinding class.

> **Tip**  Parameters bound using the rule shown in Listing 15-21 must still be optional. I have changed the way that values are located for the parameter, but that has no effect on the optimization I described in the action method selection process.

###Handling All Simple Type Values###

The problem with the technique in the previous section is that it creates a list of reserved parameter names. It isn’t a huge problem because you can apply the FromUri attribute to parameters that need to get values from the URL that are also header names, but it can cause confusion for the unwary.

An alternative approach is to provide values for a wider range of parameters but take responsibility for finding values for them even when there is no corresponding header.

Listing 15-21. The Contents of the MultiFactoryParameterBinding.cs File

```cs
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Metadata;
using System.Web.Http.ValueProviders;
namespace ExampleApp.Infrastructure {

 public class MultiFactoryParameterBinding: HttpParameterBinding {

  public MultiFactoryParameterBinding(HttpParameterDescriptor descriptor): base(descriptor) {
   // do nothing
  }

  public override Task ExecuteBindingAsync(ModelMetadataProvider metadataProvider, HttpActionContext actionContext, CancellationToken cancellationToken) {

   foreach(ValueProviderFactory factory in GlobalConfiguration.Configuration.Services.GetValueProviderFactories()) {

    if (factory is HeaderValueProviderFactory || factory is IUriValueProviderFactory) {
     IValueProvider provider = factory.GetValueProvider(actionContext);
     ValueProviderResult result = null;

     if (provider != null && (result = provider.GetValue(Descriptor.ParameterName)) != null) {
      SetValue(actionContext, result.RawValue);
      break;
     }
    }
   }

   return Task.FromResult < object > (null);
  }
 }
}
```

> **Tip**  This class relies on the order in which the value providers are registered in the services collection. This allows you to control the source of data values, but you must ensure that the built-in factories appear before custom ones if you want to give preference to locating data from the request URL.

The ExecuteBindingAsync method gets the set of ValueProviderFactory objects in the services collection and uses a foreach loop to call the GetValueProvider method on each of them to try to get an IValueProvider object and, in turn, get a value for the parameter. This continues until a value is provided, at which point I call the SetValue method and break out of the loop.

? **Tip**  The ExecuteBindingAsync method is asynchronous, which is useful if you need to look up a data value from a database or perform a complex calculation. It is, however, overkill if you are simply obtaining a value from the request. Rather than create a Task to get the data value, I perform the work synchronously and call Task.FromResult<object>(null) to create a completed Task that has no result.

This is the same approach taken by the default behavior I described in the previous section, except that I have added explicit support for the HeaderValueProviderFactory class as well as factories that implement the IUriValueProviderFactory interface. By default, there are three value provider factories that may be able to provide a value—my custom factory and the two built-in factories described in Table 15-8

Table 15-8. The Built-in Value Provider Factory Classes

|Name| Description|
|--|--|
|QueryStringValueProviderFactory |Provides values from the query string.|
|RouteDataValueProviderFactory | Provides values from the routing data. See Chapters 20 and 21 for details of Web API routing.|

The reason that I have added explicit support for the HeaderValueProviderFactory class is so that I can work around the action method selection optimization I described earlier.

can remove the IUriValueProviderFactory interface, and the accept parameter no longer needs to be optional.

Listing 15-22. Removing an Interface in the HeaderValueProviderFactory.cs File

```cs
public class HeaderValueProviderFactory: ValueProviderFactory {
 public override IValueProvider GetValueProvider(HttpActionContext context) {
  if (context.Request.Method == HttpMethod.Post) {
   return new HeaderValueProvider(new HeadersMap(context.Request.Headers));
  } else {
   return null;
  }
 }
}
```

Listing 15-23. Changing a Parameter Definition in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers(Numbers numbers, string accept) {
  return string.Format("{0} (Accept: {1})", numbers.First + numbers.Second, accept); 
}
```

Listing 15-24. Defining a Parameter Binding Rule in the WebApiConfig.cs File

```cs
// ...routing statements omitted for brevity...
config.Services.Add(typeof(ValueProviderFactory), new HeaderValueProviderFactory());
config.ParameterBindingRules.Add(x => {
 return x.ParameterType.IsPrimitive || x.ParameterType == typeof(string) ? new MultiFactoryParameterBinding(x) : null;
});
```

I created the parameter binding rule using the version of the Add method that takes a Func<HttpParameterDescriptor, HttpParameterBinding> argument. When using a lambda expression, this means that the HttpParameterDescriptor goes to an HttpParameterBinding instance, but only if the parameter is one that the rule wants to support. I use the HttpParameterDescriptor.ParameterType property to see whether the property is a primitive type or a string and, if so, return an instance of the MultiFactoryParameterBinding class. If the parameter isn’t a type I want to work with, I return null to signal that I don’t want to provide a binding and that Web API should continue checking other rules.

#CHAPTER 16 Binding Complex Data Types Part I#

Model binders work only with value providers, meaning that data values are obtained from the URL. It is media type formatters that are responsible for create complex types from the data in the request body.

##Preparing the Example Project##

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([FromUri]Numbers numbers) {
  return string.Format("{0}", numbers.First + numbers.Second);
}
```

I start this chapter by showing you how to bind complex type arguments from the URL, so I need to specify that the data values for the Numbers object should not be obtained from the request body.

##Using the Built-in Model Binders##

Model binders build on the foundation of value providers to combine data values from the request into instances of complex types.

Web API comes with a set of built-in model binders that can bind objects in the most common situations.

The classes listed in Table 16-2 are defined in the System.Web.Http.ModelBinding.Binders namespace.

Table 16-2. The Built-in Model Binder Classes

|Name| Description|
|--|--|
|ArrayModelBinder| Binds an array of objects. See the “Binding Collections and Arrays” section for details.|
|CollectionModelBinder| Binds a strongly typed List or Enumerable. See the “Binding Collections and Arrays” section for details.|
|DictionaryModelBinder |Binds key-value pairs to a strongly typed Dictionary. See the “Binding Key-Value Pairs” section for details. |
|MutableObjectModelBinder | Binds objects. See the “Binding Objects” section for details.|
|TypeConverterModelBinder | Binds objects using a type converter, which I describe in the “Using Type Converters” section.|

The built-in model binders are used by Web API to instantiate classes, arrays, and collections using request data values obtained from value providers.

The built-in model binders are used when the FromUri or ModelBinder attribute is used.

Web API includes default model binders that can deal with instantiating and populating most classes. You should need to create a custom binder only when a class requires special care to instantiate.

##Binding Objects##

model binders build on value providers to get multiple values to create an object, and the FromUri attribute can enable this feature for complex type arguments,

```cs
public string SumNumbers([FromUri]Numbers numbers) {
```

FromUri is a model binding attribute, which tells Web API to use the model binder classes to create an instance of the parameter type,

A model binder is a class responsible for using one or more values from the value providers to create an instance of the model type, which is used as an argument when invoking the action method.

The built-in model binder that deals with objects works in two steps:

Use the parameterless constructor to create a new instance of the model type.

Set each property defined by the model type using a value from the value providers.

there is no point in defining a constructor with parameters because it will prevent the model binder from creating an instance and because methods and get-only properties will be ignored by the model binder.

##Binding Multiple Objects##

By default, the object model binder tries to use the name of the parameter as a prefix when asking the value providers for values for each of the properties.

numbers.first and numbers.second in the request.

If the value provides can’t obtain values for the prefixed names, then the model binder will ask for values without the prefix: first and second.

Listing 16-4. Changing the Request Query String in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "GET",
                    data: {
                        "numbers1.first": viewModel().first,
                        "numbers1.second": viewModel().second,
                        "numbers2.first": viewModel().third,
                        "numbers2.second": viewModel().fourth
                    },
                    success: function(data) {
```

> **Tip**  Notice that I have quoted the property names in the data settings object. The dot notation required to express a prefix can’t be used as a literal property name, but JavaScript is flexible enough to be able to define properties as quoted strings.

The changes in Listing 16-4 will send a request with the following URL:

> /api/bindings/sumnumbers?numbers1.first=2&numbers1.second=5&numbers2.first=10     &numbers2.second=100

> **Tip**  If you test the changes now, you will see that everything seems to work but that the result returned from the web service is zero.

The binder makes a best-effort attempt to get values, and it assumes that it isn’t a problem when they don’t exist. You must use the model validation feature if you want to ensure that the request contains certain values.

I need to update the action method so that it has two Numbers parameters whose names correspond to the prefixed included in the request URL,

Listing 16-5. Changing the Action Method Parameters in the BindingsController.cs File

```cs
[HttpGet] 
[HttpPost] 
public string SumNumbers([FromUri] Numbers numbers1, [FromUri] Numbers numbers2) {
  return string.Format("{0}", numbers1.First + numbers1.Second + numbers2.First + numbers2.Second); }
```

##Binding Nested Objects##

Prefixes can also be used to define the structure of more complex objects.

Listing 16-6. Adding a Property to the Numbers Class in the BindingModels.cs File

```cs
namespace ExampleApp.Models {
 
 public class Numbers {
 
  public int First { get; set; }
  public int Second { get; set; }
  public Operation Op { get; set; }
 }

 public class Operation {
  public bool Add { get; set; }
  public bool Double { get; set; }
 }
}
```

Listing 16-7. Changing the Request Query String in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "GET",
                    data: {
                        "numbers.first": viewModel().first,
                        "numbers.second": viewModel().second,
                        "numbers.op.add": viewModel().add,
                        "numbers.op.double": viewModel().double
                    },
                    success: function(data) {
```

These changes create a request like this:

> api/bindings/sumnumbers?numbers.first=2&numbers.second=5&numbers.op.add=true     &numbers.op.double=true

Listing 16-8. Changing the Action Method Parameters in the BindingsController.cs File

```cs
[HttpGet][HttpPost] public string SumNumbers([FromUri] Numbers numbers) {
 var result = numbers.Op.Add ? numbers.First + numbers.Second : numbers.First - numbers.Second;
 return string.Format("{0}", numbers.Op.Double ? result * 2 : result);
}
```

I don’t need to take any special steps to ensure that the model binder populates the properties of the nested Operations object because the model binder tries to locate values for it automatically.

###Broadening the Source of Binding Values###

A model binding attribute is a broker between a set of value provider factories and the model binding classes that can create different types.

In using the FromUri attribute, I activated the model binding process, but I did so with a subset of the available value providers.

As I explained in Chapter 15, the FromUri attribute filters out any value provider factory that doesn’t implement the IUriValueProviderFactory interface. I worked around this in Chapter 15 by implementing the interface in my custom value provider factory so that I could bind simple type parameters from request headers,

there is an alternative approach: you can use the ModelBinder attribute, from which the FromUri attribute is derived.

The only difference between the ModelBinder and FromUri attributes is that ModelBinder uses all of the available value provider factories.

Listing 16-9. Adding a Property to a Model Class in the BindingModels.cs File

```cs
public class Numbers {
  public int First { get; set; }
  public int Second { get; set; }
  public Operation Op { get; set; }
  public string Accept { get; set; }
}
```

Listing 16-10. Removing the HTTP Method Restriction in the HeaderValueProviderFactory.cs File

```cs
using System.Net.Http;
using System.Web.Http.Controllers;
using System.Web.Http.ValueProviders;
namespace ExampleApp.Infrastructure {
 public class HeaderValueProviderFactory: ValueProviderFactory {
  public override IValueProvider GetValueProvider(HttpActionContext context) {
   //if (context.Request.Method == HttpMethod.Post) {
   return new HeaderValueProvider(new HeadersMap(context.Request.Headers)); //} else {
   //    return null;
   //}
  }
 }
}
```

Listing 16-11. Adding Prefix Support in the HeaderValueProvider.cs File

```cs
using System.Globalization;
using System.Web.Http.ValueProviders;
using System.Linq;
namespace ExampleApp.Infrastructure {
 public class HeaderValueProvider: IValueProvider {
  private HeadersMap headers;
  
  public HeaderValueProvider(HeadersMap map) {
   headers = map;
  }
  
  public ValueProviderResult GetValue(string key) {
   string value = headers[key.Split('.').Last()];
   return value == null ? null : new ValueProviderResult(value, value, CultureInfo.InvariantCulture);
  }
  
  public bool ContainsPrefix(string prefix) {
   return false;
  }
 }
}
```

> **Tip**  You might wonder why my GetValue method is asked for numbers.Accept when the ContainsPrefix method always returns false. This happens because the model binder is given access to only a single value provider, so Microsoft has defined a composite provider that consolidates the results from all of the registered value providers. The model binder is told by the consolidated provider that it can produce values with the numbers prefix because the query string value provider says it can—and that affirmation is therefore applied to all of the value providers.

Listing 16-12. Updating the Action Method in the BindingsController.cs

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] Numbers numbers) {
```

The use of the ModelBinder attribute means that all of the value provider factories are used to obtain sources of data, including the custom provider that provides access to the request headers.

> **Tip**  The name of the action method parameter is used as the prefix by default, but you can use the Name property when applying the ModelBinder attribute to specify another prefix.

##Binding Collections and Arrays##

The built-in model binders are able to bind multiple related values to create collections and arrays.

Listing 16-13. Changing the Request Data in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
  $.ajax("/api/bindings/sumnumbers", {
     type: "GET",
     data: {
      numbers: [viewModel().first, viewModel().second, viewModel().third]
     },
     success: function(data) {
```

These changes produce a request that targets the following URL:

> /api/bindings/sumnumbers?numbers[]=2&numbers[]=5&numbers[]=100

? **Tip**  The [ and ] characters are escaped when the request is sent in this format and replaced with the %5B and %5D sequences.

You can omit the square brackets by setting the jQuery traditional Ajax setting to true, which will send the request in this format (both are accepted by Web API).

> /api/bindings/sumnumbers?numbers=2&numbers=5&numbers=100

Listing 16-14. Binding Request Data As an Array in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] int[] numbers) {
  return numbers.Sum().ToString();
}
```

The process of creating and populating the array is handled by the model binder and passed to the action method. You can elect to receive the same data as a strongly typed List,

Listing 16-15. Binding Request Data As a Strongly Typed Collection in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] List<int> numbers) {
  return numbers.Sum().ToString();
}
```

> **Tip**  You can also bind to a strongly typed Enumerable, such as Enumerable<T>, by changing the type of the action method parameter.

##Binding Arrays and Lists of Complex Types##

The approach I used in the previous section can be combined with the use of prefixes to bind arrays of complex types.

Listing 16-16. Changing the Request Data in the bindings.js

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "GET",
                    data: {
                        "numbers": [{
                            first: viewModel().first,
                            second: viewModel().second
                        }, {
                            first: viewModel().third,
                            second: viewModel().fourth
                        }],
                    },
                    success: function(data) {
                        gotError(false);
                        response("Total: " + data);
                    },
```

The result is a request in this format:

> /api/bindings/sumnumbers?numbers[0][first]=22&numbers[0][second]=5    &numbers[1][first]=100&numbers[1][second]=200

The built-in binders work out the relationships between the different data items and use them to create an array of objects.

Listing 16-17. Receiving an Array of Complex Objects in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] Numbers[] numbers) {
  return numbers.Select(x => x.First + x.Second).Sum().ToString();
}
```

Caution  You must ensure that there are no gaps in the index values for array items. The binder stops looking for data when it fails to get a value for a specific index.

##Binding Key-Value Pairs##

The built-in binders are able to create a strongly typed Dictionary that contains key-value pairs.

Listing 16-18. Sending Key-Value Request Data in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "GET",
                    data: {
                        numbers: [{
                            key: "one",
                            value: {
                                first: viewModel().first,
                                second: viewModel().second
                            }
                        }, {
                            key: "two",
                            value: {
                                first: viewModel().third,
                                second: viewModel().fourth
                            }
                        }]
                    },
                    success: function(data) {
```

The format of the object used for the data setting contains a number property (named so that the binder will match it to the action method parameter) that is set to an array of objects that has key and value properties.

The changes in Listing 16-18 create a request with this format URL.

> /api/bindings/sumnumbers?numbers[0][key]=one&numbers[0][value][first]=2&numbers[0][value][second]=52&numbers[1[key]=two&numbers[1][value][first]=100     &numbers[1][value][second]=200

Listing 16-19. Receiving Key-Value Pairs in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] Dictionary<string, Numbers> numbers) {
return numbers.Select(x => x.Value.First + x.Value.Second).Sum().ToString();
}
```

You can mix and match the techniques in this part of the chapter, and the binders will usually be able to figure it out. You can, for example, send a collection of key-value pairs where the value is an array of complex types that has a property that is an array of key-value pairs and so on.

##Working with Custom Model Binders##

the built-in model binders are capable of dealing with a good range of bindings.

the main limitation is that classes can be instantiated only if they have a parameterless constructor,

and data values can be set only through properties,

##Preparing the Application##

Listing 16-20. Changing the Numbers Classin the BindingModels.cs File

```cs
namespace ExampleApp.Models {
 public class Numbers {
  private int first, second;

  public Numbers(int firstVal, int secondVal) {
   first = firstVal;
   second = secondVal;
  }

  public int First { get { return first; } }
  public int Second { get { return second; } }
  public Operation Op { get; set; }
  public string Accept { get; set; }
 }

 public class Operation {
  public bool Add { get; set; }
  public bool Double { get; set; }
 }
}
```

Listing 16-21. Changing the Action Method Parameters in the BindingsController.cs

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] Numbers numbers) {
  var result = numbers.Op.Add ? numbers.First + numbers.Second : numbers.First - numbers.Second;
  return string.Format("{0}", numbers.Op.Double ? result * 2 : result);
}
```

Listing 16-22. Changing the Ajax Request Data in the bindings.js

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "GET",
                    data: {
                        "numbers.first": viewModel().first,
                        "numbers.second": viewModel().second,
                        "numbers.op.add": true,
                        "numbers.op.double": true
                    },
                    success: function(data) {
```

##Testing the Preparations##

navigating to /Home/Bindings in the browser,

The response from the web service will be reported in the browser as a 500 (Internal Server Error),

No parameterless constructor defined for this object

##Understanding Model Binders##

Model binders implement the IModelBinder interface, which is defined in the System.Web.Http.ModelBinding namespace.

Listing 16-23. The IModelBinder Interface

```cs
using System.Web.Http.Controllers; namespace System.Web.Http.ModelBinding {
  public interface IModelBinder {
    bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext);
  }
}
```

Table 16-5. Selected Members Defined by the HttpActionDescriptor Class

|Name| Description|
|--|--|
|ActionName| Returns the name of the action method |
|ReturnType| Returns the Type that the action method returns|
|SupportedHttpMethods| Returns a collection of HttpMethod objects that represent the HTTP verbs that can be used to target the action method |
|GetParameters()| Returns a collection of HttpParameterDescription objects that represent the action method parameters|

the ModelBindingContext class provides information to the model binder and provides the parameter value to Web API so that the action method can be invoked.

Table 16-6. Selected Properties Defined by the ModelBindingContext Class

|Name| Description|
|--|--|
|FallbackToEmptyPrefix| Returns true if the model binder can ignore the binding prefix. Model Set by the model binder when it is able to create an instance of the model class.|
|ModelMetadata| Returns a ModelMetadata object that describes the type of the parameter that is to be bound.|
|ModelName| Returns the name of the parameter that is to be bound.|
|ModelState| Returns a ModelStateDictionary object that is used to perform validation. See Chapter 18 for details.|
|ModelType| Returns the type of the parameter that is bound.|
|PropertyMetadata| Provides a dictionary of ModelMetadata objects that describe each property defined by the model type, indexed by name. |
|ValidationNode| Returns a ModelValidationNode object used to perform validation. See Chapter 18 for details.|
|ValueProvider| Returns an IValueProvider that can be used to obtain individual data values from the request. The IValueProvider that is returned by default consolidates access to all the individual value providers that have been registered in the services container or via dependency injection.|

> **Tip**  If suitable data isn’t available, then the ModelBinding.ModelState property is used to report errors.

##Creating a Custom Model Binder##

There are two categories of model binders.

The first is loosely coupled binders., which use the metadata in the HttpActionDescriptor and ModelBindingContext objects passed to the BindModel method to instantiate classes of which they have no prior knowledge.

The other category is tightly coupled binders, which are written to handle a specific class.

The problem with tightly coupled classes is that they break when the class they operate on changes,

Listing 16-24. The Contents of the NumbersBinder.cs File

```cs
using System.Collections.Generic;
using System.Linq;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {

 public class NumbersBinder: IModelBinder {

  public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext) {

   string modelName = bindingContext.ModelName;

   Dictionary < string, ValueProviderResult > data = new Dictionary < string, ValueProviderResult > ();
   data.Add("first", GetValue(bindingContext, modelName, "first"));
   data.Add("second", GetValue(bindingContext, modelName, "second"));
   data.Add("add", GetValue(bindingContext, modelName, "op", "add"));
   data.Add("double", GetValue(bindingContext, modelName, "op", "double"));
   data.Add("accept", GetValue(bindingContext, modelName, "accept"));

   if (data.All(x => x.Value != null)) {
    bindingContext.Model = CreateInstance(data);
    return true;
   }

   return false;
  }

  private ValueProviderResult GetValue(ModelBindingContext context, params string[] names) {

   for (int i = 0; i < names.Length - 1; i++) {

    string prefix = string.Join(".", names.Skip(i).Take(names.Length - (i + 1)));

    if (context.ValueProvider.ContainsPrefix(prefix)) {
     return context.ValueProvider.GetValue(prefix + "." + names.Last());
    }
   }

   return context.ValueProvider.GetValue(names.Last());
  }

  private Numbers CreateInstance(Dictionary < string, ValueProviderResult > data) {

   return new Numbers(Convert < int > (data["first"]), Convert < int > (data["second"])) {
    Op = new Operation {
     Add = Convert < bool > (data["add"]), Double = Convert < bool > (data["double"])
    }, Accept = Convert < string > (data["accept"])
   };
  }

  private T Convert < T > (ValueProviderResult result) {
   try {
    return (T) result.ConvertTo(typeof(T));
   } catch {
    return default (T);
   }
  }
 }
}
```

> **Caution**  Model binders can be used to service multiple requests. Don’t use instance variables when writing a model binder, but ensure that you write thread-safe code and reset the shared state after if you can’t avoid instance variables.

Chapter 15, I explained that value providers will return a ValueProviderResult object if they are able to provide a value and null if not. My first job is to try to gather the set of ValueProviderResult results that contains the values I need,

handle each property independently and try to locate a value for multiple levels of prefix.

I request the following:

> numbers.op.add op.add add

use LINQ to generate the property name permutations I look for.

I check these values with the value providers through the ModelBindingContext.ValueProvider property, which returns an IValueProvider that queries all of the value providers registered in the service collection.

call the GetValue method from the GetBinding method to create a dictionary of ValueProviderResult objects that are indexed by property name, like this:

##Checking Values##

A false result from the BindModel method tells Web API that the binder can’t create an instance of the model object.

> **Note**  Web API provides a model validation mechanism that allows errors to be usefully reported to the user. I am focused solely on the binding process in this chapter,

##Creating the Model Object##

model object is to convert the values from the ValueProviderResult objects into the types required for the constructor, methods, and properties.

The Convert method uses the ValueProviderResult.ConvertTo method to perform the type conversion.

The ConvertTo method will throw an exception if the value cannot be converted. Handling the conversion in a strongly typed method lets me use the default keyword to provide the caller with a default value for the required type.

##Applying a Custom Model Binder##

There are several ways to apply a binder, depending on how widely you want to apply the binding process.

Web API looks in three different places for a model binding instruction before using the built-in binders, in order:

The ModelBinder attribute applied to the action method parameter The ModelBinder attribute applied to the model class A parameter binding rule

###Applying a Custom Binder Directly to the Parameter###

Table 16-8. The Properties Defined by the ModelBinder Attribute

|Name| Description|
|--|--|
|BinderType| This property specifies the model binder class that will be used for the parameter.|
|Name| This property specifies the name that will be used as the top-level prefix, overriding the name of the parameter, which is used by default.|

Listing 16-25. Applying a Custom Model Binder in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder(BinderType=typeof(NumbersBinder))] Numbers numbers) {
```

###Registering the Model Binder with the Services Collection###

you can register the binder with the services collection.

Listing 16-26. Registering a Model Binder in the WebApiConfig.cs

```cs
config.Services.Insert(typeof(ModelBinderProvider), 0, new SimpleModelBinderProvider(typeof(Numbers), new NumbersBinder()));
```

Listing 16-27. Removing the Model Binder Type in the BindingsController.cs

```cs
[HttpGet]
[HttpPost]
public string SumNumbers([ModelBinder] Numbers numbers) {
  var result = numbers.Op.Add
```

##Applying a Binder to the Model Class##

The ModelBinder attribute can also be applied to the model class, which has the effect of applying the model binder to every action method parameter of that type.

Listing 16-28. Using the ModelBinder Attribute in the BindingModels.cs File

```cs
[ModelBinder(BinderType = typeof(NumbersBinder))]     
public class Numbers {
```

There is no need to apply the attribute to the action method when the ModelBinder attribute is applied to the model class.

Listing 16-29. Removing the ModelBinding Attribute in the BindingsController.cs File

```cs
[HttpGet] 
[HttpPost] 
public string SumNumbers(Numbers numbers) {
var result = numbers.Op.Add ? numbers.First + numbers.Second
```

##Creating a Parameter Binding Rule##

Applying the ModelBinder attribute to the model class affects all the action method parameters of that type,

You can get more control over when the model binder is used by defining a parameter binding rule.

the main benefit of a parameter binding rule for a model binder is to restrict the set of value providers that are used to obtain data values, which can be useful when you want to make sure that, say, routing data isn’t used in the model binding process.

Listing 16-30. Removing the ModelBinder Attribute in the BinderModels.cs File

```cs
//[ModelBinder(BinderType = typeof(NumbersBinder))]
public class Numbers {
private int first, second;
```

Listing 16-31. Defining a Parameter Model Binding in the WebApiConfig.cs File

```cs
config.ParameterBindingRules.Add(x => {
 return x.ParameterType == typeof(Numbers) ? new ModelBinderParameterBinding(x, new NumbersBinder(), new ValueProviderFactory[] {
  new QueryStringValueProviderFactory(), new HeaderValueProviderFactory()
 }) : null;
});
```

The ModelBinderParameterBinding class is derived from HttpParameterBinding and defines a constructor that receives an HttpParameterDescriptor object, an IModelBinder implementation, and an enumeration of ValueProviderFactory classes.

created a rule that specifies the NumbersBinder binder class but limits the source of values to the query string and request headers.

##Using Type Converters##

Type converters are an oddity. They allow a complex type parameter to be created from the query string, using a mechanism that has been part of .NET since version 1.1.

###Understanding Type Converters###

Type converters are responsible for creating an object from the URL, from a single query string property or routing segment.

Type converters are derived from the System.ComponentModel.TypeConverter class and associated with action method parameters with the TypeConverter attribute.

The problem with type converters is that they require all the information necessary to create an instance of a model object to be expressed in a single query string parameter or routing segment.

> api/bindings/sumnumbers?numbers=2,54,true,true

###Creating a Type Converter###

The TypeConverter class—and, in fact, the entire System.ComponentModel namespace—is a general-purpose mechanism for managing and converting types, and most of its features have no role in Web API.

Table 16-10. The Methods Required to Create a Web API Type Converter


|Name| Description|
|--|--|
|CanConvertFrom(context, type)| Called to check whether the type converter is able to create an instance of its model object from a specified type. In Web API, implementations of this method should return true for strings and return false for all other types. |
|ConvertFrom(context, culture,value)| Called to create an instance of the model object from a request value, which will be a string. This method should return null if the data cannot be converted into a model object.|

Listing 16-32. The Contents of the NumbersTypeConverter.cs File

```cs
using System;
using System.ComponentModel;
using System.Globalization;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {

 public class NumbersTypeConverter: TypeConverter {

  public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType) {
   return sourceType == typeof(string);
  }

  public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value) {

   string valueToParse = value as string;
   string[] elements = null;

   if (valueToParse != null && (elements = valueToParse.Split(',')).Length == 4) {
    int firstVal, secondVal;
    bool addVal, doubleVal;

    if (int.TryParse(elements[0], out firstVal) && int.TryParse(elements[1], out secondVal) && bool.TryParse(elements[2], out addVal) && bool.TryParse(elements[3], out doubleVal)) {
     return new Numbers(firstVal, secondVal) {
      Op = new Operation {
       Add = addVal, Double = doubleVal
      }
     };
    }
   }
   return null;
  }
 }
}
```

###Applying a Type Converter###

Type converters are applied to the model class, rather than the action method parameter.

The TypeConverter attribute, defined in the System.ComponentModel namespace, specifies the type converter class that is used to create instances of the model.

Listing 16-33. Applying a Type Converter in the BindingModels.cs File

```cs
[TypeConverter(typeof(NumbersTypeConverter))]
public class Numbers {
```

Type converters only read their data from the URL, which means I need to configure the client to send a GET request in the format I described in the previous section.

Listing 16-34. Configuring the Ajax Request in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "GET",
                    data: "numbers=" + viewModel().first + "," + viewModel().second + "," + "true" + "," + true,
                    success: function(data) {
```

Listing 16-35. Disabling the Parameter Binding Rule in the WebConfig.cs File

```cs
=> {
  //    return x.ParameterType == typeof(Numbers)
  //        ? new ModelBinderParameterBinding(x, new NumbersBinder(),
  //            new ValueProviderFactory[] {
  //            new QueryStringValueProviderFactory(),
  //            new HeaderValueProviderFactory()})
  //        : null;
  //});
```

#CHAPTER 17 Binding Complex Data Types Part II#

In this chapter, I conclude the coverage of the parameter and model binding processes by explaining how media type formatters can be used to deserialize complex types from the request body.

##Preparing the Example Project##

First I need to simplify the Numbers class so that it has a parameterless constructor and settable properties—changes

Listing 17-1. Simplifying the Class in the BindingModels.cs

```cs
namespace ExampleApp.Models {
 public class Numbers {
  public Numbers() { /* do nothing */ }
  public Numbers(int first, int second) {
   First = first;
   Second = second;
  }
  public int First { get; set; }
  public int Second { get; set; }
  public Operation Op { get; set; }
  public string Accept { get; set; }
 }
 public class Operation {
  public bool Add { get; set; }
  public bool Double { get; set; }
 }
}
```

Ineed to remove the model binding configuration from the WebApiConfig.cs file.

Listing 17-3. Changing the Request Verb and Data Format in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    data: viewModel(),
                    success: function(data) {
```

Listing 17-4. Changing the Action Method Result in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public int SumNumbers(Numbers numbers)
```

##Creating a Custom Media Type Formatter##

By default, Web API assumes that any complex type parameter will be obtained from the request body and uses a media type formatter to try to get and bind a value.

In Chapter 12, I created the ProductFormatter class, which was responsible for formatting a Product object into a string like this:

> 1,Kayak,275.0

The three comma-separated values represented the ProductId, Name, and Price properties defined by the Product model object.

Custom media types can be used to deserialize data from the request body that is in a bespoke or unusual encoding format. Custom media formatters are also useful for dealing with classes that cannot be instantiated by invoking a parameterless constructor and setting properties.

##Preparing the Client##

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    contentType: "application/x.product",
                    data: [viewModel().first, viewModel().second, viewModel().add, viewModel().double].join(),
                    success: function(data) {
```

I have used the contentType setting to specify that the content is in my custom application/x.product encoding (the MIME type I used in Chapter 12

the following URL in

> /api/bindings/sumnumbers

It has a payload of the following:

> 2,5,true,true

##Creating the Media Type Formatter##

Listing 17-6. The Contents of the XNumbersFormatter.cs File

```cs
using System;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {
 public class XNumbersFormatter: MediaTypeFormatter {
  
  long bufferSize = 256;
  
  public XNumbersFormatter() {
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/x.product"));
  }
  
  public override bool CanWriteType(Type type) {
   return false;
  }
  
  public override bool CanReadType(Type type) {
   return type == typeof(Numbers);
  }
  
  public async override Task < object > ReadFromStreamAsync(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger) {
  
   byte[] buffer = new byte[Math.Min(content.Headers.ContentLength.Value, bufferSize)];
   string[] items = Encoding.Default.GetString(buffer, 0, await readStream.ReadAsync(buffer, 0, buffer.Length)).Split(',', '=');
  
   if (items.Length == 4) {
    return new Numbers(GetValue < int > ("First", items[0], formatterLogger), GetValue < int > ("Second", items[1], formatterLogger)) {
     Op = new Operation {
      Add = GetValue < bool > ("Add", items[2], formatterLogger), Double = GetValue < bool > ("Double", items[3], formatterLogger)
     }
    };
   } else {
    formatterLogger.LogError("", "Wrong Number of Items");
    return null;
   }
  }
  
  private T GetValue < T > (string name, string value, IFormatterLogger logger) {
   T result =
    default (T);
   try {
    result = (T) System.Convert.ChangeType(value, typeof(T));
   } catch {
    logger.LogError(name, "Cannot Parse Value");
   }
   return result;
  }
 }
}
```

This formatter binds instances of the Numbers class for requests whose Content-Type header is application/x.product. In the sections that follow, I’ll break down each part of the class and explain how it works.

##Getting the Request Data##

Table 17-3. The Parameter Types of the MediaTypeFormatter.ReadFromStreamAsync Method

|Type| Description|
|--|--|
|Type| The type that the formatter is required to instantiate. This is useful if the implementation of the CanReadType method responds with true to multiple types.|
|Stream| A System.IO.Stream object from which the request body can be read. This must be used cautiously; see the warnings and examples that follow this table.|
|HttpContent |A System.Net.Http.HttpContent object that describes the request content and provides access to it. This object is used to gain access to an HttpContentHeaders object through its Headers property. See Table 17-4 for details of the headers that are available.|
|IFormatterLogger |An implementation of the System.Net.Http.Formatting.IFormatterLogger interface that can be used to report problems processing the data. See the “Creating the Model Object”|

Table 17-4. The Request Header Convenience Properties Defined by the HttpContentHeaders Class

|Name| Description|
|--|--|
|ContentEncoding| Returns the value of the Content-Encoding header, which is used to indicate when additional encodings have been applied to the content in addition to the one specified by the Content-Type header. |
|ContentLength| Returns the value of the Content-Length header, which reports the size of the request body in bytes. When using the value of the Content-Length header, be sure to apply an upper limit to how much data you read from the request body; see the following text for details. | 
|ContentMD5 |Returns the value of the Content-MD5 header, which contains a hash code to ensure the integrity of the data.|
|ContentType| Returns the value of the Content-Type header, which specifies the primary encoding of the request body. Additional encodings can be specified with the Content-Encoding header.|

> **Tip**  See www.w3.org/Protocols/rfc2616/rfc2616-sec14.html for the detailed specification and use of HTTP headers.

three important rules that you should follow when writing a custom media type formatter:

Don’t use the convenience methods to read basic types. Limit the amount of data you read. Read data asynchronously.

A simple but effective denial-of-service attack is for a client to send an HTTP server misleading information in the Content-Length header, either to cause an error or to try to get the server to exhaust its memory by reading enormous amounts of data. A custom media type formatter requires care because the content is read and processed by your code, rather than that of the ASP.NET Framework as is the case in an MVC application.

The first precaution you should take is to avoid using the convenience methods provided by the stream and reader classes in the System.IO namespace. Using a ReadLine or ReadString method would allow me to simplify my media type formatter, but these methods just keep reading data from the underlying stream until they get the data they expect.

The second precaution you should take is to limit the amount of data you read from the stream. In Listing 17-6, I defined a maximum buffer size of 256 bytes,

> **Tip**  You don’t have to guard against negative Content-Length header values, which used to be a popular attack. Basic validation is performed on the headers when the request is processed and requests with illegal headers are rejected by ASP.NET.

The final rule you should follow is to read data asynchronously from the Stream to maximize the request throughput of the web service.

##Creating the Model Object##

The important part of the GetValue method is the use of the IFormatterLogger parameter object, which is used to record any problems processing the request data to create the model object.

The default implementation of the IFormatterLogger interface adds errors to the model state,

Table 17-5. The Methods Defined by the IFormatterLogger Interface

|Method| Description|
|--|--|
|LogError(property, message) |Records an error for the specified property. The error is described by a string message.|
|LogError(property, exception)| Records an error for the specified property. The error is described by an Exception.|

In the listing, I note any problems parsing values, but I still return the default value for the required type. This will make more sense once I describe the model validation process in Chapter 18

##Registering and Testing the Media Type Formatter##

Listing 17-7. Registering a Media Type Formatter in the WebApiConfig.cs File

```cs
config.Formatters.Add(new XNumbersFormatter());
```

For variety, I am going to test the custom formatter with Postman.

Set the URL to http://localhost:29844/api/bindings/sumnumbers (replacing 29844 with your application’s port number), the request type to POST, and the Content-Type header to application/x.product. Click the Raw button to specify a request body that won’t be formatted by Postman and enter the following into the text box:

> 100,150,true,false

##Using the Built-in Media Type Formatters##

The default behavior for a complex type parameter is to act as though the FromBody attribute has been applied.

Table 17-6. The Built-in Media Type Formatters

|MIME Types| Media Type Formatter|
|--|--|
|application/json, text/json| JsonMediaTypeFormatter |
|application/xml, text/json | XmlMediaTypeFormatter |
|application/x-www-form-urlencoded |FormUrlEncodedMediaTypeFormatter |

When a request arrives, the MIME type in the Content-Type header selects the media type formatter that can handle that type.

##Handling URL-Encoded Data##

If you use jQuery to write your application client, then you will usually end up dealing with form-encoded data because it is the default format that jQuery uses when sending an Ajax request.

The other data formats are important if you need to support clients that you have not written yourself or that are not browser-based.

##Handling URL-Encoded Requests##

The FormUrlEncodedMediaTypeFormatter class can bind only to an instance of the FormDataCollection class, which is defined in the System.Net.Http.Formatting namespace and which presents form-encoded data as a collection of name-value pairs.

The real value of the FormUrlEncodedMediaTypeFormatter class is that it provides a foundation for creating formatters that handle more useful types, such as the JQueryMvcFormUrlEncodedFormatter class

Listing 17-8. Changing the Request Format in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    data: viewModel(),
                    success: function(data) {
                            gotError(false);
```

The changes to the client-side code are minor because jQuery sends URL-encoded data by default.

Listing 17-9. Receiving Request Data in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public IHttpActionResult SumNumbers(FormDataCollection numbers) {
 int first, second;
 bool add, doubleVal;
 if (int.TryParse(numbers["first"], out first) && int.TryParse(numbers["second"], out second) && bool.TryParse(numbers["add"], out add) && bool.TryParse(numbers["double"], out doubleVal)) {
  int result = add ? first + second : first - second;
  return Ok(string.Format("{0}", doubleVal ? result * 2 : result));
 } else {
  return BadRequest();
 }
}```

> **Note**  You won’t often rely on the FormUrlEncodedMediaTypeFormatter class directly because the other built-in media type formatters can bind to .NET classes,

##Creating Complex Types from URL-Encoded Requests##

The JQueryMvcFormUrlEncodedFormatter class is derived from FormUrlEncodedMediaTypeFormatter and adds support for binding values to complex types,

Behind the scenes, the JQueryMvcFormUrlEncodedFormatter class uses extension methods defined in the System.Web.Http.ModelBinding.FormDataCollectionExtensions class to create objects using the model binding feature

Unfortunately, the FormDataCollectionExtensions extension methods are written to use only the built-in media formatters and value providers, preventing the use of custom classes and limiting the range of types that can be bound from application/x-www-form-urlencoded data to classes with parameterless constructors and settable properties, arrays, lists, and key-value pairs.

> **Tip**  The name of the JQueryMvcFormUrlEncodedFormatter class reflects the fact that the property names are converted from the jQuery default to that used by the MVC framework.

Using model binders also means that the data sent by the client needs to be structured with prefixes in order to be properly processed.

Listing 17-10. Adding Prefixes to the View Model in the bindings.js File

```JavaScript
var viewModel = ko.observable({
  first: 2, second: 5,
  "op.add": true, "op.double": true
});
```

Listing 17-11. Changing the Action Method Parameter in the BindingsController.cs File

```cs
[HttpGet]
[HttpPost]
public int SumNumbers(Numbers numbers) {
  var result = numbers.Op.Add ? numbers.First + numbers.Second : numbers.First - numbers.Second; 
  return numbers.Op.Double ? result * 2 : result;
  }
```

It is this change—specifying a parameter that is a complex type but not the FormDataCollection class—that causes Web API to select the JQueryMvcFormUrlEncodedFormatter class instead of the FormUrlEncodedMediaTypeFormatter class.

> **Tip**  You might be wondering how the JQueryMvcFormUrlEncodedFormatter class is able to use the model binding system when the built-in value providers read values from the URL. The answer is that the NameValuePairsValueProvider class is used behind the scenes.

The NameValuePairsValueProvider class is the superclass of the QueryStringValueProvider and RouteDataValueProvider

The JQueryMvcFormUrlEncodedFormatter works directly with the NameValuePairsValueProvider class and gets its key-value pairs from the FormUrlEncodedMediaTypeFormatter class, which decodes the URL-encoded request body.

##Instantiating Difficult Types Using URL-Encoded Data##

Although the JQueryMvcFormUrlEncodedFormatter doesn’t allow the use of custom model binders, I can use the FormUrlEncodedMediaTypeFormatter class to create a custom media type formatter that does—and that means I can instantiate classes that require special handling, such as those with constructor parameters.

Listing 17-12. The Contents of the UrlNumbersFormatter.cs File

```cs
using System;
using System.Globalization;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Metadata;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders.Providers;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {
 public class UrlNumbersFormatter: FormUrlEncodedMediaTypeFormatter {

  public override bool CanWriteType(Type type) {
   return false;
  }

  public override bool CanReadType(Type type) {
   return type == typeof(Numbers);
  }

  public override async Task < object > ReadFromStreamAsync(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger) {

   FormDataCollection fd = (FormDataCollection) await base.ReadFromStreamAsync(typeof(FormDataCollection), readStream, content, formatterLogger);
   HttpActionContext actionContext = new HttpActionContext {};
   ModelMetadata md = GlobalConfiguration.Configuration.Services.GetModelMetadataProvider().GetMetadataForType(null, type);
   ModelBindingContext bindingContext = new ModelBindingContext {
    ModelMetadata = md, ValueProvider = new NameValuePairsValueProvider(fd, CultureInfo.InvariantCulture)
   };

   if (new NumbersBinder().BindModel(actionContext, bindingContext)) {
    return bindingContext.Model;
   }
   return null;
  }
 }
}
```

The reason that the built-in JQueryMvcFormUrlEncodedFormatter media type formatter doesn’t allow custom binders and value providers is because the problems that feeding data from the body to model binders can cause.

For my custom model binder, there are two problems that I need to resolve,

Listing 17-13. Adapting a Model Binder in the NumbersBinder.cs File

```cs
using System.Collections.Generic;
using System.Linq;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
using System.Web.Http.ValueProviders;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {

 public class NumbersBinder: IModelBinder {

  public bool BindModel(HttpActionContext actionContext, ModelBindingContext bindingContext) {

   string modelName = bindingContext.ModelName;
   Dictionary < string, ValueProviderResult > data = new Dictionary < string, ValueProviderResult > ();
   data.Add("first", GetValue(bindingContext, modelName, "first"));
   data.Add("second", GetValue(bindingContext, modelName, "second"));
   data.Add("add", GetValue(bindingContext, modelName, "op", "add"));
   data.Add("double", GetValue(bindingContext, modelName, "op", "double"));
   data.Add("accept", GetValue(bindingContext, modelName, "accept"));

   if (data.All(x => x.Key == "accept" || x.Value != null)) {
    bindingContext.Model = CreateInstance(data);
    return true;
   }
   return false;
  }

  private ValueProviderResult GetValue(ModelBindingContext context, params string[] names) {
   for (int i = 0; i < names.Length - 1; i++) {
    string prefix = string.Join(".", names.Skip(i).Take(names.Length - (i + 1)));
    if (prefix != string.Empty && context.ValueProvider.ContainsPrefix(prefix)) {
     return context.ValueProvider.GetValue(prefix + "." + names.Last());
    }
   }
   return context.ValueProvider.GetValue(names.Last());
  }

  private Numbers CreateInstance(Dictionary < string, ValueProviderResult > data) {
   // ...statements omitted for brevity...
  }

  private T Convert < T > (ValueProviderResult result) {
   // ...statements omitted for brevity...
  }
 }
}
```

need to fix two problems. The first is in the BindModel method, when I check to see whether I have been able to obtain values for all the properties and constructor parameters I need to set. The Numbers class defines the Accept property, which I have been setting using data from the request header. Media type formatters don’t have access to the request, and there is no global property that provides access to it, unlike in the MVC framework. To get the model binder working with the media type formatter, I have to relax the check that I perform to exclude the value for the Accept value.

```cs
if (data.All(x => x.Key == "accept" || x.Value != null)) {
  bindingContext.Model = CreateInstance(data);
  return true;
}
```

The second problem is that binders use the parameter name, which is available through the ModelBindingContext.ModelName property. Media type formatters don’t have access to details about which parameter they are being used to bind and can’t provide the model binder with the name. To make my custom model binder work in this situation, I have added support for working with an empty string as the model name, which is the value that the binder is presented with from the ModelBindingContext that I created in the UrlNumbersFormatter class.

```cs
if (prefix != string.Empty && context.ValueProvider.ContainsPrefix(prefix)) {
```

Listing 17-14. Registering a Media Type Formatter in the WebApiConfig.cs File

```cs
config.Formatters.Insert(0, new UrlNumbersFormatter());
```

##Simplifying the Custom Media Type Formatter##

If you don’t have a model binder that you want to use, then you can read the data values directly from the FormDataCollection object. Listing 17-15 shows how I simplified the UrlNumbersFormatter class so that it gets the data values and instantiates the Numbers class directly.

Listing 17-15. Simplifying the Media Type Formatter in the UrlNumbersFormatter.cs File

```cs
using System;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Threading.Tasks;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {
 
 public class UrlNumbersFormatter: FormUrlEncodedMediaTypeFormatter {
  
  public override bool CanWriteType(Type type) {
   return false;
  }
  
  public override bool CanReadType(Type type) {
   return type == typeof(Numbers);
  }
  
  public override async Task < object > ReadFromStreamAsync(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger) {
   FormDataCollection fd = (FormDataCollection) await base.ReadFromStreamAsync(typeof(FormDataCollection), readStream, content, formatterLogger);
   return new Numbers(GetValue < int > ("First", fd, formatterLogger), GetValue < int > ("Second", fd, formatterLogger)) {
    Op = new Operation {
     Add = GetValue < bool > ("Add", fd, formatterLogger), Double = GetValue < bool > ("Double", fd, formatterLogger)
    }
   };
  }
  
  private T GetValue < T > (string name, FormDataCollection fd, IFormatterLogger logger) {
   T result =
    default (T);
   try {
    result = (T) System.Convert.ChangeType(fd[name], typeof(T));
   } catch {
    logger.LogError(name, "Cannot Parse Value");
   }
   return result;
  }
 }
}
```

This class uses the same techniques I employed in the “Creating a Custom Media Type Formatter” section, except that I use the base class to read and parse the data from the request body.

##Handling JSON Requests##

The JsonMediaTypeFormatter class is responsible for deserializing content in requests that are encoded with application/json or text/json MIME types (which are equivalent—both MIME types are JSON).

it will decode even the sloppiest JSON data,

Listing 17-16. Changing the jQuery Request Encoding to JSON in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    data: JSON.stringify(viewModel()),
                    contentType: "application/json",
                    success: function(data) {
```

JSON.stringify method to serialize the view model object into a JSON string like this:

```JSON
{"first":2,"second":5,"op":{"add":true,"double":true}}
```

##UNDERSTANDING THE JSON.STRINGIFY METHOD##

The JSON.stringify method takes an object and serializes it into the JSON format. The JSON object that defines the stringify method—and its counterpart, JSON.parse—isn’t part of jQuery. Instead, it is provided by the browser as part of a set of global JavaScript objects that provide commonly used functionality.

All modern browsers have a built-in implementation of JSON.stringify, but if you find yourself having to support older browsers, then you can get an implementation from https://github.com/douglascrockford/JSON-js

You can see which browsers have built-in support for JSON.stringify at http://caniuse.com/json

##Creating Complex Types##

Json.Net provides many options for customizing the instantiation process based on the JSON data, including attributes that can be applied to the model class to help instantiation.

You can get full details of both approaches—and the rest of the Json.Net features—at http://james.newtonking.com

In this section, I am going to demonstrate how to use a different Json.Net feature: LINQ to JSON.

Listing 17-17. The Contents of the JsonNumbersFormatter.cs File

```cs
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using ExampleApp.Models;
using Newtonsoft.Json.Linq;

namespace ExampleApp.Infrastructure {

 public class JsonNumbersFormatter: MediaTypeFormatter {
  long bufferSize = 256;

  public JsonNumbersFormatter() {
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/json"));
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/json"));
  }

  public override bool CanWriteType(Type type) {
   return false;
  }

  public override bool CanReadType(Type type) {
   return type == typeof(Numbers);
  }

  public async override Task < object > ReadFromStreamAsync(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger) {

   byte[] buffer = new byte[Math.Min(content.Headers.ContentLength.Value, bufferSize)];
   string jsonString = Encoding.Default.GetString(buffer, 0, await readStream.ReadAsync(buffer, 0, buffer.Length));
   JObject jData = JObject.Parse(jsonString);

   return new Numbers((int) jData["first"], (int) jData["second"]) {
    Op = new Operation {
     Add = (bool) jData["op"]["add"], Double = (bool) jData["op"]["double"]
    }
   };
  }
 }
}
```

I access the LINQ to JSON feature through this statement:

```cs
JObject jData = JObject.Parse(jsonString);
```

The result is an implementation of the IEnumerable<KeyValuePair<string, JToken>>, where the JToken class describes one property from the JSON string I read from the request body.

JSON to LINQ helpfully presents the data values through array-style indexers.

Listing 17-18. Registering a Media Type Formatter in the WebApiConfig.cs File

```cs
config.Formatters.Insert(0, new JsonNumbersFormatter());
```

##Handling XML Requests##

Dealing with XML data can be tricky because there are so many ways in which the same data can be expressed.

Using the built-in XML media type serializer involves carefully formatting the data sent by the client and preparing the model class for use by the web service.

jQuery doesn’t have built-in support for generating XML data from a JavaScript object,

Listing 17-19. Using jQuery to Send XML Data in the bindings.js File

```JavaScript
var sendRequest = function(requestType) {
        $.ajax("/api/bindings/sumnumbers", {
                    type: "POST",
                    data: "<Numbers>" + "<First>" + viewModel().first + "</First>" + "<Op>" + "<Add>" + viewModel().op.add + "</Add>" + "<Double>" + viewModel().op.double + "</Double>" + "</Op>" + "<Second>" + viewModel().second + "</Second>" + "</Numbers>",
                    contentType: "application/xml",
                    success: function(data) {
```

The result of the changes in Listing 17-19 is that the body of the HTTP request will contain the following XML fragment:

```xml
<Numbers>
  <First>2</First>
  <Op>
    <Add>true</Add>
    <Double>true</Double>
  </Op>
  <Second>5</Second>
</Numbers>
```

I find using the built-in media type formatter to be awkward because there are some important constraints on the way that XML data has to be structured.

The first constraint is that the name and capitalization of each attribute name much exactly match the class or property name that it corresponds to.

The second constraint—and the one that I find the most problematic—is that the attributes must be organized in alphabetical order.

The XML serializer that the built-in media type formatter uses will instantiate only the objects that have been annotated with the DataContract attribute and will set only the properties that have been decorated with the DataMember attribute.

Listing 17-20. Applying the Data Contract Attributes in the BindingModels.cs File

```cs
using System.Runtime.Serialization;

namespace ExampleApp.Models {

 [DataContract(Namespace = "")] public class Numbers {
  public Numbers() { /* do nothing */ }
 
  public Numbers(int first, int second) {
   First = first;
   Second = second;
  }
  
  [DataMember] public int First { get; set; }
  
  [DataMember] public int Second { get; set; }
  
  [DataMember] public Operation Op { get; set; }
  public string Accept { get; set; }
 }
 
[DataContract(Namespace = "")] 
public class Operation {
  [DataMember] public bool Add { get; set; }
  [DataMember] public bool Double { get; set; }
 }
}
```

I have set the Namespace property of the DataContract attributes to the empty string ("") so that the serializer won’t expect an xmlns attribute on the top-level element of the data that is received from the client.

System.Runtime.Serialization assembly,

the media type formatter won’t deserialize the request if there is a mismatch between the data from the client and the format implied by the attributes.

Table 17-8. The Properties Defined by the DataMember Attribute

|Name| Description|
|--|--|
|IsRequired| When true, the serializer will not deserialize the data if it does not contain a value for the property to which the attribute has been applied. Missing data feeds an error into the model state, which is used for validation. I describe model state and validation in Chapter 18. The default value is false. |
|Name|  Set the name of the XML element from which the value for the property will be read. The default behavior is to use the name of the property. |
| Order|  When set, this specifies the position of the element in the XML data that will be used to read a value for the property. This overrides the alphabetic order that is the default behavior.|

Creating Complex Types from XML Data

When trying to instantiate classes using XML, I avoid treating the elements and attributes as a document with namespaces and schemas. Instead, I use LINQ to mine the XML data for key-value pairs. This approach has its limitations—not least that it incurs the overhead of XML without getting any of the benefits that structured data offers—but in most web services the use of XML is a legacy holdover, and the task at hand is to support XML clients with the minimum of effort.

Listing 17-21. The Contents of the XmlNumbersFormatter.cs File

Add a note
```cs
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using ExampleApp.Models;
namespace ExampleApp.Infrastructure {
 public class XmlNumbersFormatter: MediaTypeFormatter {
  long bufferSize = 256;
  public XmlNumbersFormatter() {
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/xml"));
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/xml"));
  }

  public override bool CanWriteType(Type type) {
   return false;
  }

  public override bool CanReadType(Type type) {
   return type == typeof(Numbers);
  }

  public async override Task < object > ReadFromStreamAsync(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger) {
   byte[] buffer = new byte[Math.Min(content.Headers.ContentLength.Value, bufferSize)];
   XElement xmlData = XElement.Parse(Encoding.Default.GetString(buffer, 0, await readStream.ReadAsync(buffer, 0, buffer.Length)));
   Dictionary < string, string > items = new Dictionary < string, string > ();
   GetKvps(xmlData, items);
   if (items.Count == 4) {
    return new Numbers(GetValue < int > (items["first"], formatterLogger), GetValue < int > (items["second"], formatterLogger)) {
     Op = new Operation {
      Add = GetValue < bool > (items["add"], formatterLogger), Double = GetValue < bool > (items["double"], formatterLogger)
     }
    };
   } else {
    formatterLogger.LogError("", "Wrong Number of Items");
    return null;
   }
  }

  private void GetKvps(XElement elem, Dictionary < string, string > dict) {
   if (elem.HasElements) {
    foreach(XElement innerElem in elem.Elements()) {
     GetKvps(innerElem, dict);
    }
   } else {
    dict.Add(elem.Name.LocalName.ToLower(), elem.Value);
   }
  }

  private T GetValue < T > (string value, IFormatterLogger logger) {
   T result =
    default (T);
   try {
    result = (T) System.Convert.ChangeType(value, typeof(T));
   } catch {
    logger.LogError("", "Cannot Parse Value");
   }
   return result;
  }
 }
}
```

I read the body of the request and use the XElement.Parse method to enter the world of XML to LINQ.

Listing 17-22. Registering the Custom Media Type Formatter in the WebApiConfig.cs File

```cs
config.Formatters.Insert(0, new XmlNumbersFormatter());         }
```

##Customizing the Model Binding Process##

Web API delegates the entire process of binding values for parameters to an implementation of the IActionValueBinder interface, which is defined in the System.Web.Http.Controllers namespace.

Listing 17-23. The IActionValueBinder Interface

```cs
namespace System.Web.Http.Controllers {
  public interface IActionValueBinder { HttpActionBinding GetBinding(HttpActionDescriptor actionDescriptor);
  }
}
```

The important thing to note about the IActionValueBinder interface is that the GetBinding method operates on action methods and is being asked to find bindings for all of the parameters defined by an action—not just a single parameter.

Table 17-9. Selected Members Defined by the HttpActionDescriptor Class

| Name| Description|
|--|--|
|ActionName| Returns the name of the action method |
|ReturnType| Returns the Type that the action method returns |
|SupportedHttpMethods |Returns a collection of HttpMethod objects that represent the HTTP verbs that can be used to target the action method |
|GetParameters() | Returns a collection of HttpParameterDescription objects that represent the action method parameters|

The HttpActionBinding class, which is returned by the GetBinding method, is a wrapper around the HttpActionDescriptor and an array of HttpParameterBinding objects that are used to get values for the parameters defined by an action method.

The HttpActionBinding class defines a constructor with the following signature:

```cs
public HttpActionBinding(HttpActionDescriptor actionDescriptor, HttpParameterBinding[] bindings) {
```

the purpose of an implementation of the IActionValueBinder interface is to be able to create an HttpActionBinding

custom action value binder allows you to change the way that Web API locates values for action method parameters.

You can override the GetParameterBinding method of the DefaultActionValueBinder class if you want to change the default behavior but still take advantage of features such as value providers, model binders, and media type formatters.

Changing the Behavior of the Default Action Value Binder

All of the functionality that I have described since Chapter 14—value providers, model binders, and media type formatters—is provided by the DefaultActionValueBinder class, which is the Web API default implementation of the IActionValueBinder interface.

There are no configuration options for changing the behavior of the DefaultActionValueBinder class, but it is possible to create a subclass and override the method that defines the default policy for how values are sought for parameters.

As a reminder, here is the default sequence that yields an HttpParameterBinding object for a single parameter:

If the parameter has been decorated with a subclass of the ParameterBindingAttribute, then call the attribute’s GetBinding method.

Try to obtain an HttpParameterBinding object from the parameter binding rules collection.

For simple types, proceed as though the FromUri attribute has been applied to the parameter.

For complex types, proceed as though the FromBody attribute has been applied to the parameter.

This sequence is implemented in the GetParameterBinding method of the DefaultActionValueBinder class.

To demonstrate how to change the sequence

Listing 17-24. The Contents of the CustomActionValueBinder.cs File

```cs
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
namespace ExampleApp.Infrastructure {

 public class CustomActionValueBinder: DefaultActionValueBinder {

  protected override HttpParameterBinding GetParameterBinding(HttpParameterDescriptor parameter) {
   if (parameter.ParameterBinderAttribute != null) {
    return parameter.ParameterBinderAttribute.GetBinding(parameter);
   }

   HttpParameterBinding binding = parameter.Configuration.ParameterBindingRules.LookupBinding(parameter);

   if (binding != null) {
    return binding;
   }

   if (parameter.ParameterType.IsPrimitive || parameter.ParameterType == typeof(string)) {
    return parameter.BindWithAttribute(new ModelBinderAttribute());
   }

   return new FromBodyAttribute().GetBinding(parameter);
  }
 }
}
```

> **Note**  Although the IActionValueBinder interface deals with an entire action method in one go, the GetParameterBinding method in the DefaultActionValueBinder class deals with one parameter at a time. The DefaultActionValueBinder implementation of the GetBinding method calls the GetParameterBinding method for each parameter defined by the action method described by the HttpActionDescriptor class.

This class follows the same sequence of the DefaultActionValueBinder class but with one important difference: for simple types, I act as though the ModelBinder attribute has been applied, rather than the FromUri attribute. The FromUri attribute excludes any value provider factory class that does not implement the IUriValueProviderFactory interface. By using the ModelBinder attribute—which I described in Chapter 15—I allow all value provider factories to participate in the binding process.

> **Tip**  There is a second difference between CustomActionValueBinder and DefaultActionValueBinder: I check only for primitive types and strings, rather than the full set of simple types. If you override the GetParameterBinding method in a real project, take care to consider how you draw the line between types you will obtain from the URL and those you will obtain from the body.

Listing 17-25. Registering an Action Value Binder in the WebApiConfig.cs File

```cs
config.Services.Replace(typeof(IActionValueBinder), new CustomActionValueBinder());
```

I used the HttpConfiguration.Services.Replace method to replace the DefaultActionValueBinder with a CustomActionValueBinder object.


##Creating a Custom Action Value Binder##

You can completely replace the process used to bind parameter values by directly implementing the IActionValueBinder interface. There is little reason to do this because there is a lot of flexibility in how the DefaultActionValueBinder can be used.

Listing 17-26. Implementing the IActionValueBinder Interface in the CustomActionValueBinder.cs File

```cs
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.ModelBinding;
using System.Linq;
namespace ExampleApp.Infrastructure {

 public class CustomActionValueBinder: IActionValueBinder {

  public HttpActionBinding GetBinding(HttpActionDescriptor actionDescriptor) {
   return new HttpActionBinding(actionDescriptor, actionDescriptor.GetParameters().Select(p => GetParameterBinding(p)).ToArray());
  }

  protected HttpParameterBinding GetParameterBinding(HttpParameterDescriptor parameter) {
   if (parameter.ParameterBinderAttribute != null) {
    return parameter.ParameterBinderAttribute.GetBinding(parameter);
   }
   
   HttpParameterBinding binding = parameter.Configuration.ParameterBindingRules.LookupBinding(parameter);
   if (binding != null) {
    return binding;
   }
   
   if (parameter.ParameterType.IsPrimitive || parameter.ParameterType == typeof(string)) {
    return parameter.BindWithAttribute(new ModelBinderAttribute());
   }
   
   return new FromBodyAttribute().GetBinding(parameter);
  }
 }
}
```

#CHAPTER 18 Model Validation#

The way that Web API binds complex types is useful and flexible, but Web API is a little too trusting and tries to carry on to the point where the action method can be executed, even if the data that has been sent to the client can’t be used to bind to the parameters that the action method requires or if the data cannot be used within the application.

Three main problems arise when processing client data: under-posting, over-posting, and unusable data.

##Understanding Common Data Problems##

You will face three main problems when dealing with data in a web service: too little data (under-posting), too much data (over-posting), and bad data (as good a term as any).

###Understanding Under-Posting###

Under-posting occurs when the request doesn’t contain values for all of the properties defined by a model object.

The underlying problem is that the model binding process has no inherent understanding of the way in which model objects are used.

No error is reported if there are properties for which the request doesn’t provide a value and if the default value for the property type will be used.

The impact of under-posting depends on the type of the properties that are affected and the way that the model object is used.

###Understanding Over-Posting###

Over-posting occurs when the request contains values for model properties that the developer expected to come from elsewhere.

The default binding process will look for request values for all the objects in a model object, even if you expected the values to be set elsewhere in the application.

> **Tip**  Although I show you how to deal with over-posting using the Web API validation features, the best solution is to avoid defining model properties that cause problems, which prevents requests from being able to cause unwanted effects. If you can’t separate out the safe and unsafe properties in your model classes, then consider using a data transfer object (DTO), which is a class used solely as an action method parameter and contains only the safe properties. The binding process will set the DTO properties, which you can then copy to an instance of the model class within the action method.


###Understanding Bad Data###

The final category of problem is bad data, where the client sends data values that cannot be used, either because the values cannot be parsed to the types required by the data model or because the values do not make sense.

##Using Web API Model Validation##

To help manage the process of validating data, Web API keeps track of the model state, which contains details of any problems that were encountered during the binding process and which can be checked and handled in the action method.

By default, the model state will contain details of only basic errors—such as problems converting a value into a property type—but Web API provides an extensible mechanism for defining different kinds of validation that can be used to detect and report more complex problems.

###Understanding Model State###

The model state for a request is described with an instance of the ModelStateDictionary class, which is defined in the System.Web.Http.ModelBinding namespace.

Table 18-3. The Properties Defined by the ModelStateDictionary Class Used to Check Validation

|Name| Description|
|--|--|
|IsValid| Returns true if there are no validation errors |
|Count| Returns the number of validation errors Keys Returns the collection of property names for which there are validation errors|
|Values| Returns an enumeration of ModelState objects for the specific property name|

Listing 18-8. Using Model State in the ProductsController.cs File


```cs
public IHttpActionResult Post(Product product) {

if (ModelState.IsValid) {
  repo.SaveProduct(product);
  return Ok();
 } else {
  foreach(string property in ModelState.Keys) {
   ModelState mState = ModelState[property];
   IEnumerable < ModelError > mErrors = mState.Errors;
   foreach(ModelError error in mErrors) {
    Debug.WriteLine("Property: {0}, Error: {1}", property, error.ErrorMessage);
   }
  }
  return BadRequest(ModelState);
 }
}
```

Each property is represented by a ModelState object.

Table 18-4. The Properties Defined by the ModelState Class

|Name| Description|
|--|--|
|Errors| Returns a collection of ModelError objects representing the validation errors for a property|
|Value| Returns the ValueProviderResult associated with the property|

Table 18-5. The Properties Defined by the ModelError  Class

|Name| Description|
|--|--|
| ErrorMessage | Returns an error message that describes the validation problem |
| Exception | Returns an exception associated with the validation problem |

Listing 18-9. Removing the Debug Code from the ProductsController.cs File

```cs
public IHttpActionResult Post(Product product) {

 if (ModelState.IsValid) {
  repo.SaveProduct(product);
  return Ok();
 } else {
  return BadRequest(ModelState);
 }
}
```

##Using the Binding Control Attributes##

The simplest way to guard against under- and over-posting is to use one of the attributes that Web API provides to control the binding process.

The attributes are defined in the System.Web.Http namespace

Table 18-6. The Binding Control Attributes

|Name| Description|
|--|--|
|HttpBindNever |This attribute tells the built-in model binder to ignore any request values for the property to which it has been applied to.|
|HttpBindRequired| This attribute reports a validation error if the request does not contain a value for the property to which it has been applied.|

Listing 18-10. Applying the Binding Control Attributes in the Product.cs File

```cs
public class Product {
    
 public int ProductID { get; set; }
 public string Name { get; set; }
 
 [HttpBindRequired]
 public decimal Price { get; set; }
 
 [HttpBindNever] 
 public bool IncludeInSale { get; set; }
}
```

##Performing Validation with Validation Attributes##

The simplest way to increase the amount of validation that is performed is to apply the attributes defined in the System.ComponentModel.DataAnnotations namespace, which work exactly as they do in the MVC framework.

##Using the Built-in Validation Attributes##

Table 18-8. The Built-in Validation Attributes

|Name| Example| Description
|--|--|--|

|Compare| [Compare("OtherProperty")] | This attribute reports a validation error if the property it is applied to does not have the same value as the property whose name is specified as the configuration string: OtherProperty in this case. This attribute is useful for e-mail addresses and passwords.|
|CreditCard| [CreditCard]| This attribute reports a validation error if the value for the property to which it has been applied is not a credit card number. This attribute just checks the format of the number and not whether the card itself is valid.|
|Email| [Email] |This attribute reports a validation error if the value for the property to which it has been applied is not a valid e-mail address. Only the format is checked and not whether the address exists and can accept e-mail.|
|Enum |[Enum(typeof(MyEnum)] |This attribute reports a validation error if the value for the property to which it has been applied cannot be parsed into a value for the specified enum.|
|MaxLength| [MaxLength(10)] |This attribute is applied to string properties and reports a validation error if the value exceeds the specific number of characters (10 in the example).|
|MinLength| [MinLength(2)] |This attribute is applied to string properties and reports a validation error if the number of characters in the value is less than the specific value (2 in the example).|
|Range |[Range(10, 20)] | This attribute is applied to numeric properties and reports a validation error if the value falls outside the specified limits.|
|RegularExpression| [RegularExpression("blue|green")] | This attribute reports a validation error if the value doesn’t match the specific regular expression.|
|Required | [Required] | This attribute reports a validation error if no value has been supplied for the property to which it has been applied. This is functionally equivalent to the HttpBindRequired attribute.|
|StringLength| [StringLength(10)] | Specifies the minimum and maximum length of characters that are allowed in a data field.|

```cs
[HttpBindRequired]
[Range(1, 20000)]
public decimal Price { get; set; }
```

attributes from Table 18-8 with the HttpBindRequired or Required attribute. The other attributes perform validation only if there is a value in the request for the property to which they are applied, which means that under-posting doesn’t cause a validation error to be added to the ModelStateDictionary unless the HttpBindRequred or Required attribute is used as well.

An alternative to using attributes is to put the validation logic into the model class and implement the IValidatableObject interface, which is defined in the System.ComponentModel.DataAnnotations namespace.

The IValidatableObject interface defines the Validate method, which receives a ValidationContext object and returns an enumeration of the validation errors, expressed as ValidationResult objects.

Listing 18-14. Applying the IValidatableObject Interface in the Product.cs File

```cs
using System.ComponentModel.DataAnnotations;
using ExampleApp.Infrastructure;
using System.Collections.Generic;
namespace ExampleApp.Models {
 public class Product: IValidatableObject {
  public int ProductID { get; set; }
  public string Name { get; set; }
  public decimal Price { get; set; }
  public bool IncludeInSale { get; set; }

  public IEnumerable < ValidationResult > Validate(ValidationContext validationContext) {

   List < ValidationResult > errors = new List < ValidationResult > ();

   if (Name == null || Name == string.Empty) {
    errors.Add(new ValidationResult("A value is required for the Name property"));
   }

   if (Price == 0) {
    errors.Add(new ValidationResult("A value is required for the Price property"));
   } else if (Price < 1 || Price > 2000) {
    errors.Add(new ValidationResult("The Price value is out of range"));
   }

   if (IncludeInSale) {
    errors.Add(new ValidationResult("Request cannot contain values for IncludeInSale"));
   }

   return errors;
  }
 }
}
```

If the validation logic is reusable, then I recommend creating custom validation attributes instead.

Performing Validation in a Media Type Formatter

MediaTypeFormatter, provides its subclasses with access to the model validation feature,

You should perform basic validation for each model property that you set in a custom media type formatter.

The binding control attributes are implemented by the default complex model formatter and are not automatically applied in custom classes.

##Creating a Validating Media Type Formatter##

Listing 18-15. The Contents of the ValidatingProductFormatter.cs File

```cs
using System;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using ExampleApp.Models;
using Newtonsoft.Json.Linq;
namespace ExampleApp.Infrastructure {

 public class ValidatingProductFormatter: MediaTypeFormatter {

  long bufferSize = 256;

  public ValidatingProductFormatter() {
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("application/json"));
   SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/json"));
  }

  public override bool CanReadType(Type type) {
   return type == typeof(Product);
  }

  public override bool CanWriteType(Type type) {
   return false;
  }

  public async override Task < object > ReadFromStreamAsync(Type type, Stream readStream, HttpContent content, IFormatterLogger formatterLogger) {
   byte[] buffer = new byte[Math.Min(content.Headers.ContentLength.Value, bufferSize)];
   string jsonString = Encoding.Default.GetString(buffer, 0, await readStream.ReadAsync(buffer, 0, buffer.Length));
   JObject jData = JObject.Parse(jsonString);
   if (jData.Properties().Any(p => string.Compare(p.Name, "includeinsale", true) == 0)) {
    formatterLogger.LogError("IncludeInSale", "Request Must Not Contain IncludeInSale Value");
   }
   return new Product {
    Name = (string) jData["name"], Price = (decimal) jData["price"]
   };
  }
 }
}
```

Table 18-10. The Methods Defined by the IFormatterLogger

|Name| Description|
|--|--|
|LogError(name, message)| Registers a validation error for the specified property name and message |
|LogError(name, exception)| Registers a validation error for the specified property name and exception|

I use the IFormatterLogger parameter to register a validation error if the request contains a value for the IncludeInSale property.

##REWARDING BAD BEHAVIOR WITH ERROR MESSAGES##

In Listing 18-15, I reject requests that contain a value for the IncludeInSale property and report a descriptive error. This is a different approach to using the HttpBindNever attribute, which quietly ignores values for the properties to which it is applied.

There is a difficult balance to be struck when it comes to validation messages. On one hand, you want to provide meaningful messages so that users and third-party developers can figure out what is going wrong. On the other hand, you don’t want to reveal anything about the internal structure of your application to deliberate over-posters.

There is no absolutely right answer, but my advice is to report errors when it comes to validating the properties that you have publically described and quietly ignore attempts to over-post by using the HttpBindNever attribute.

Registering and Using the Custom Media Type Formatter

Listing 18-16. Registering a Media Type Formatter in the WebApiConfig.cs File

```cs
config.Formatters.Insert(0, new ValidatingProductFormatter());
```
