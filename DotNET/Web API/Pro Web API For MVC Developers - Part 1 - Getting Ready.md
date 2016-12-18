#CHAPTER 1 Getting Readys#

Get the Postman client from www.getpostman.com

You will also need the Postman Interceptor extension, which increases the functionality and is available through the Google Chrome Extension Store as a zero-cost installation.

#CHAPTER 2 Your First Web API Application#

##Creating the Visual Studio Project##

Templates section to select the Visual C# Web ASP.NET Web Application template

Ensure that the Empty option is selected and check the MVC and Web API options,

Visual Studio Tools NuGet Package Manager menu and enter the following commands to update the MVC and Web API packages, as well as the package that is used to process JSON data

```
Update-Package microsoft.aspnet.mvc -version 5.1.1
Update-Package microsoft.aspnet.webapi -version 5.1.1
Update-Package Newtonsoft.json -version 6.0.1
```

To add Bootstrap, jQuery, and Knockout to the project, enter the following commands into the Package Manager Console:

```
Install-Package jquery -version 2.1.0
Install-Package bootstrap -version 3.1.1
Install-Package knockoutjs –version 3.1.0
```

##Setting the Port and Start URL##

Enable the Specific Page option and enter Home/Index in the field. On the same page, change the value in the Project Url field to http://localhost:37993/ and click the Create Virtual Directory button.

The first change prevents Visual Studio from trying to work out what URL should be shown when the application starts based on the file you edited most recently, and the second change means that requests will be received on TCP port 37993.

The structure of a Web API application shares a lot with the MVC framework, which is one of the reasons that both technologies can coexist so well.

Listing 2-1. The Contents of the GuestResponse.cs File

```csharp

using System.ComponentModel.DataAnnotations;
namespace PartyInvites.Models {
 public class GuestResponse {
  [Required]
  public string Name { get; set; }
  [Required]
  public string Email { get; set; }
  [Required]
  public bool ? WillAttend { get; set; }
 }
}```

Listing 2-2. The Contents of the Repository.cs File

```csharp
using System.Collections.Generic;

namespace PartyInvites.Models {
 public class Repository {
  private static Dictionary < string, GuestResponse > responses;
  static Repository() {
   responses = new Dictionary < string, GuestResponse > ();

   responses.Add("Bob", new GuestResponse {
    Name = "Bob", Email = "bob@example.com", WillAttend = true
 	});

   responses.Add("Alice", new GuestResponse {
    Name = "Alice", Email = "alice@example.com", WillAttend = true
   });

	responses.Add("Paul", new GuestResponse {
    Name = "Paul", Email = "paul@example.com", WillAttend = true
   });
  }

  public static void Add(GuestResponse newResponse) {
   string key = newResponse.Name.ToLowerInvariant();
   if (responses.ContainsKey(key)) {
    responses[key] = newResponse;
   } else {
    responses.Add(key, newResponse);
   }
  }

  public static IEnumerable < GuestResponse > Responses {
   get { return responses.Values; }
  }
 }
}
```

My next step is to create an MVC controller that will generate content and receive form data from my application

Web API also has controllers—as you will see in the “Creating the Web Service” section—and I will be clear about which kind of controller I am using throughout this book. I created an MVC controller by right-clicking the Controllers folder and selecting Add Controller from the pop-up menu.

Listing 2-3. The Contents of the HomeController.cs File

```csharp
using System.Web.Mvc;
using PartyInvites.Models;
using System.Linq;

namespace PartyInvites.Controllers {
 public class HomeController: Controller {
  public ActionResult Index() {
   return View();
  }

  public ActionResult Rsvp() {
   return View();
  }

  [HttpPost] public ActionResult Rsvp(GuestResponse response) {
   if (ModelState.IsValid) {
    Repository.Add(response);
    return View("Thanks", response);
   } else {
    return View();
   }
  }

  [ChildActionOnly] public ActionResult Attendees() {
   return View(Repository.Responses.Where(x => x.WillAttend == true));
  }
 }
}
```

Listing 2-4. The Contents of the _Layout.cshtml File

```aspx
<!DOCTYPE html>
 <html>
  <head>
   <meta name="viewport" content="width=device-width" />
   <script src="~/Scripts/jquery-2.1.0.min.js"></script>
   <script src="~/Scripts/knockout-3.1.0.js"></script>
   <link href="~/Content/bootstrap.css" rel="stylesheet" />
   <link href="~/Content/bootstrap-theme.css" rel="stylesheet" />
   <title>@ViewBag.Title</title>
   <style>
      body { padding-top: 10px; }
   </style>
  </head>
  <body class="container">
     @RenderBody()
  </body>
 </html>
```

Listing 2-5. The Contents of the Index.cshtml File

```aspx
@{ ViewBag.Title = "Party!";}
<div class="text-center">
 <h2>We're going to have an exciting party!</h2>
 <h3>And you are invited.</h3>
 @Html.ActionLink("RSVP Now", "Rsvp", null, new { @class="btn btn-success"})
</div>
```

Listing 2-6. The Contents of the Rsvp.cshtml File

```aspx
@model PartyInvites.Models.GuestResponse
@{ ViewBag.Title = "Rsvp"; }
<div class="panel panel-success">
  <div class="panel-heading">
    <h4>RSVP</h4>
  </div>

  <div class="panel-body">
    @using (Html.BeginForm()) {
      <div class="form-group">
        <label>Your name:</label>
        @Html.TextBoxFor(x => x.Name, new { @class = "form-control" })
      </div>

     <div class="form-group">
       <label>Your email:</label>
       @Html.TextBoxFor(x => x.Email, new { @class = "form-control" })
     </div>

     <div class="form-group">
       <label>Will you attend?</label>
       @Html.DropDownListFor(x => x.WillAttend, new[] {
        new SelectListItem() {Text = "Yes, I'll be there",
          Value = bool.TrueString},
          new SelectListItem() {Text = "No, I can't come",
          Value = bool.FalseString}
        }, "Choose an option", new { @class = "form-control" })
     </div>
     <div class="text-center">
       <input class="btn btn-success" type="submit" value="Submit RSVP" />
     </div>
    }
  </div>
</div>
```

Listing 2-7. The Contents of the Thanks.cshtml File

```aspx
@model PartyInvites.Models.GuestResponse @{ ViewBag.Title = "Thanks";}
<h1>Thank you, @Model.Name!</h1>
<div class="lead">
  @if (Model.WillAttend == true) {
    @:It's great that you're coming. The drinks are already in the fridge!
    @Html.Action("Attendees", "Home")
  } else {
    @:Sorry to hear that you can't make it, but thanks for letting us know.
  }
</div>
```


Listing 2-8. The Contents of the Attendees.cshtml File

```aspx
@model IEnumerable<PartyInvites.Models.GuestResponse> @if (Model.Count() == 1) {
  <p>You are the first to accept! Hurrah!</p> } else {
  <p>Here is the list of cool people coming: @string.Join(", ", Model.Select(x => x.Name))</p>
}
```

##Creating the Web Service##

I created a Web API controller by right-clicking the Controllers folder, selecting Add Controller from the pop-up menu, and selecting Web API 2 Controller – Empty

Listing 2-9. The Contents of the RsvpController.cs File

```csharp
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using PartyInvites.Models;

namespace PartyInvites.Controllers {
 public class RsvpController: ApiController {
  public IEnumerable < GuestResponse > GetAttendees() {
   return Repository.Responses.Where(x => x.WillAttend == true);
  }

  public void PostResponse(GuestResponse response) {
   if (ModelState.IsValid) {
    Repository.Add(response);
   }
  }
 }
}
```

The base class is ApiController, which is defined in the System.Web.Http namespace.

Web API doesn’t use the standard System.Web and System.Web.Mvc namespaces. Instead,

Web API uses separate classes, even for functionality that is shared with MVC, such as filter attributes.

Tip  Web API uses the ASP.NET routing system to match requests to controllers and action methods, which means that URLs can be customized.

The default convention is that all URLs for Web API web services are prefixed with /api, followed by the controller name.

The selection of the action method is made using the HTTP verb from the request, matched to an action method whose name begins with the verb—so the GET request sent by Postman to /api/rsvp is mapped to the GetAttendees action method in the RsvpController class.

> **Tip**  Notice that Web API automatically converted the result from the GetAttendees action method from IEnumerable<GuestResponse> to a JSON array.

Postman can also be used to test HTTP POST requests, which allows me to test my PostResponse action method as well, although care must be taken to configure the request correctly. To target the PostResponse action method, change the HTTP verb for the request to POST by clicking the button marked GET to the right of the URL and selecting POST from the drop-down list. Now click the x-www-form-urlencoded button to select the format in which Web API expects to receive form data and enter key/value pairs to define the properties in Table 2-2

##Implementing the Single-Page Client##

###Setting Up JavaScript IntelliSense###

To enable JavaScript IntelliSense, add a new JavaScript file called _references.js (don’t forget the leading underscore character) in the Scripts folder.

Listing 2-10. Adding IntelliSense References to the _references.js File

```JavaScript
/// <reference path="jquery-2.1.0.js" />
/// <reference path="knockout-3.1.0.debug.js" />

###Defining the Client-Side Data Model and Controller###

Listing 2-11. The Contents of the rsvp.js File

```JavaScript
var model = {
    view: ko.observable("welcome"),
    rsvp: {
        name: ko.observable(""),
        email: "",
        willattend: ko.observable("true")
    },
    attendees: ko.observableArray([])
}
var showForm = function() {
    model.view("form");
}
var sendRsvp = function() {
    $.ajax("/api/rsvp", {
        type: "POST",
        data: {
            name: model.rsvp.name(),
            email: model.rsvp.email,
            willattend: model.rsvp.willattend()
        },
        success: function() {
            getAttendees();
        }
    });
}
var getAttendees = function() {
    $.ajax("/api/rsvp", {
        type: "GET",
        success: function(data) {
            model.attendees.removeAll();
            model.attendees.push.apply(model.attendees, data.map(function(rsvp) {
                return rsvp.Name;
            }));
            model.view("thanks");
        }
    });
}
$(document).ready(function() {
    ko.applyBindings();
})
```

The first is the use of the ko.observable method, which is used to create a data value that can be used to automatically update HTML elements when it changes.

##Defining the Controller

The showForm, sendRsvp, and getAttendees functions collectively form the client-side controller.

###Initializing Knockout###

Knockout requires initialization to associate the observables and observable arrays in the data model with the bindings attached to the HTML elements

```JavaScript
$(document).ready(function () {
   ko.applyBindings();
   });
```

The ko.applyBindings method is called to initialize Knockout but should not be called until the browser has loaded and processed all of the HTML and JavaScript files.

###Appling Data Bindings###

Now that I have a model and controller in place, I can update the HTML so that it responds dynamically to data changes.

Knockout uses a system of bindings, which are applied to elements through the data-bind attribute.

> **Tip**  A single-page application doesn’t have to be defined in a single HTML page—the principle of updating the content with data obtained via Ajax requests. For large applications, it often makes sense to have several HTML hub pages that represent each major area of the application,

Listing 2-13. Creating a Dynamic Client in the Index.cshtml File

```aspx
@{ ViewBag.Title = "Party!";}
<div class="text-center" data-bind="visible: model.view() == 'welcome'">
  <h2>We're going to have an exciting party!</h2>
  <h3>And you are invited.</h3>
  <button class="btn btn-success" data-bind="click: showForm">RSVP Now</button>
</div>
<div data-bind="visible: model.view() == 'form'">
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4>RSVP</h4>
    </div>
    <div class="panel-body">
      <div class="form-group">
        <label>Your name:</label>
        <input class="form-control" data-bind="value: model.rsvp.name" />
      </div>
      <div class="form-group">
        <label>Your email:</label>
        <input class="form-control" data-bind="value: model.rsvp.email" />
      </div>
      <div class="form-group">
        <label>Will you attend?</label>
        <select class="form-control" data-bind="value: model.rsvp.willattend">
          <option value="true">Yes, I'll be there</option>
          <option value="false">No, I can't come</option>
        </select>
      </div>
      <div class="text-center">
        <button class="btn btn-success" data-bind="click: sendRsvp">Submit RSVP</button>
      </div>
    </div>
  </div>
</div>

<div data-bind="visible: model.view() == 'thanks'">
  <h1>Thank you, <span data-bind="text: model.rsvp.name()"></span>!</h1>
  <div class="lead">
    <span data-bind="visible: model.rsvp.willattend() == 'true'">
      It's great that you're coming. The drinks are already in the fridge!
      <br />
      Here is the list of cool people coming:
      <span data-bind="text: model.attendees().join(',')"></span>
    </span>
    <span data-bind="visible: model.rsvp.willattend() == 'false'">
      Sorry to hear that you can't make it, but thanks for letting us know.
    </span>
  </div>
</div>
```

I control which view is shown to the user through a Knockout binding, like this one:

```aspx
<div class="text-center" data-bind="visible: model.view() == 'welcome'"> ...
```

>**Tip** Observable values are functions, which means you have to invoke them to read their value—like model.view()—and pass values as arguments to set them, such as model.view(newView).

#CHAPTER 3 Essential Techniques#

The default behavior for the Web API controller is to use the HTTP verb to select the action method, and the GET request will target GetPageSize.

##Understanding Asynchronous Methods##

Web API adopts asynchronous methods throughout its API.

###Understanding the Problem Asynchronous Methods Solve###

Listing 3-4. Creating an Asynchronous Action Method in the PageSizeController.cs File

```csharp
using System.Net;
using System.Web.Http;
using System.Diagnostics;
using System.Threading.Tasks;

namespace Primer.Controllers {
  public class PageSizeController: ApiController {
    private static string TargetUrl = "http://apress.com";

    public async Task < long > GetPageSize() {
      WebClient wc = new WebClient();
      Stopwatch sw = Stopwatch.StartNew();
      byte[] apressData = await wc.DownloadDataTaskAsync(TargetUrl);
      Debug.WriteLine("Elapsed ms: {0}", sw.ElapsedMilliseconds);
      return apressData.LongLength;
    }
  }
}
```

Using asynchronous methods increases the overall throughput of the web application, but it can degrade the performance for each individual request.

##Implementing an Asynchronous Interface##

Once you start using some of the advanced features, you will need to implement interfaces that are written explicitly for asynchronous execution.

If the method you are going to write calls another asynchronous method, then you can use the async and await keywords, just as I did in Listing 3-4 and receive the CancellationToken parameter, as shown in Listing 3-6

##Dealing with Cancellation##

###Creating a Self-Contained Asynchronous Method Body###

A common scenario in Web API development is where you have a series of synchronous statements that you want to execute asynchronously.

Listing 3-8. Creating a Task in the PageSizeController.cs File

```csharp
using System.Net;
using System.Web.Http;
using System.Diagnostics;
using System.Threading.Tasks;
using Primer.Infrastructure;
using System.Threading;
using System.Collections.Generic;
using System.Linq;

namespace Primer.Controllers {

  public class PageSizeController: ApiController, ICustomController {

    private static string TargetUrl = "http://apress.com";

    public Task < long > GetPageSize(CancellationToken cToken) {

      return Task < long > .Factory.StartNew(() => {
        WebClient wc = new WebClient();Stopwatch sw = Stopwatch.StartNew();List < long > results = new List < long > ();

        for (int i = 0; i < 10; i++) {
          if (!cToken.IsCancellationRequested) {
            Debug.WriteLine("Making Request: {0}", i);
            results.Add(wc.DownloadData(TargetUrl).LongLength);
          } else {
            Debug.WriteLine("Cancelled");
            return 0;
          }
        }

        Debug.WriteLine("Elapsed ms: {0}", sw.ElapsedMilliseconds);
        return (long) results.Average();
      });
    }
  }
}```

>**Tip**  Notice that the method definition does not include the async keyword. This is required only when using the await keyword.

##Making Ajax Requests with jQuery##

There are some higher-level alternatives available, but the $.ajax method lets me make a complete range of HTTP request types and take control over the way that the request is formatted, sent, and processed.

###Understanding the $.ajax Method###

The $.ajax method accepts two arguments: the URL that the request will be sent to and a JavaScript object that contains the settings for the request.

The URL is expressed relative to the URL of the document that has loaded the JavaScript code,

A lot of configuration properties are available for jQuery, all of which are detailed at http://api.jquery.com/jQuery.ajax

#CHAPTER 4 Understanding HTTP Web Services#

The choice between simple and RESTful web services echoes themes that run through MVC framework development: an initial investment of design and development time that is paid back through a loosely coupled system that is easier to change over time.

##Understanding ASP.NET Web API##

ASP.NET Web API solves a simple problem: it creates services that deliver data from ASP.NET applications to clients over HTTP requests, known as HTTP web services.

There are four different types of Web API client, each of which benefits from a data-only service in a different way: single-page applications, native applications, shared-model applications, and service applications.

##Understanding Single-Page Applications##

Single-page applications, starts with an HTML document and uses JavaScript to make Ajax requests to the server for additional data or fragments of HTML in order to response to user interaction.

##Understanding Native Applications##

The rise of smartphones and tablets means that many applications are delivered as native clients, rather than as HTML content in a browser window.

##Understanding Shared-Model Applications##

An alternative approach is to use a web service to mediate access to the data store from multiple applications, providing an abstraction from the storage implementation and isolating the applications from changes in the way that data is stored.

##Understanding Service Applications##

Service applications don’t interact directly with users. Instead, they obtain data from a web service and package or process it for a different kind of client.

##Understanding Simple Web Services##

A tightly coupled web service. The tight coupling refers to the fact that the client has to have prior knowledge of how the web service has been designed in order to consume the web service.

As an example of prior knowledge, the client in the PartyInvites application needs to know that new RSVP responses are submitted as POST requests to the /api/rsvp/add URL.

The alternative is to create a web service that doesn’t require the client to have any prior knowledge of the web service, which is the essence of what REST is all about.

Simple web services are perfectly acceptable for situations where you are confident that the only client will be delivered by the MVC framework and you know that the rate of change will be low and not driven by third parties (in other words, you are not trying to create an API that can be consumed by a wider audience outside the scope of the MVC framework application).

##Understanding RESTful Web Services##

The most commonly used pattern to create loosely coupled web services is Representational State Transfer (REST).

REST is a general-purpose pattern that, when applied to a web service, creates what is known as a RESTful web service.

##THE DANGER OF DESIGN PATTERNS##

The goal behind RESTful web services is to ensure that the client and ASP.NET Web API controller are loosely coupled, and only you know which aspects of the REST pattern will help you achieve that goal.

You should use RESTful web services when clients are being developed by third parties or when you expect a high rate of change in the API delivered by the web service.

##Embracing HTTP##

The core foundation of RESTful web services is to define operations on the model using a combination of HTTP verbs and unique URLs to refer to individual data objects and collections of those objects.

>**Tip**  The terms verbs and methods are equivalent when referring to HTTP and can be used interchangeably. I tend to refer to methods when I am writing MVC framework views (because the form element defines a method attribute) and verbs when writing web services.

Here is an example of a URL that uniquely represents the RSVP response from a user called Bob

> /api/rsvp/bob

##GET and POST##

The HTTP specification contains additional verbs

In a RESTful web service, these are used to indicate what kind of operation is being requested on the data object identities by the URL in the request.

Table 4-3. Combining HTTP Verbs with URLs to Specify a Web Service API

|Verb|URL|Description|Client Sends|Server Sends|
|--|--|--|--|--|
|GET| /api/rsvp/bob|Gets the data object that represents Bob's RSVP|Nothing| The GuestResponse for Bob|
|POST| /api/rsvp/bob|Creates a new RSVP object for Bob|The GuestResponse to be saved|The savedGuestResponse object|
|PUT| /api/rsvp/bob|Updates the existing RSVP for Bob|The modified GuestResponse to be saved|The savedGuestResponse object|
|DELETE| /api/rsvp/bob|Deletes the RSVP for Bob|Nothing|Nothing|

This kind of API embraces HTTP by combining URLs and HTTP verbs, which feels exciting and dynamic and like a definite improvement over URLs derived from arbitrary methods names in a controller class, but the truth is somewhat different because the client and server are still too tightly coupled for comfort.

##USING SAFE AND IDEMPOTENT HTTP VERBS##

There is no standard mapping of HTTP verbs to web service operations,

You can use any HTTP verb that you like for your web services, as long as you understand the importance of the safe and idempotent HTTP verbs.

Safe verbs have no side effects. The most commonly used safe verb is GET, and when you receive a GET request, you may not perform any action that alters the state of the data model.

Optionally, perform cross-cutting activities such as logging and caching.

Idempotent verbs, such as PUT and DELETE, are allowed to modify the data model, but multiple requests with the same verb to the same URL should have the same effect as a single request.

The practical effect of this is that you should use URLs to uniquely identify resources, rather than relying on the relationship between data items.

For example, if you support a URL such as /api/rsvp/first that refers to the first data object in the repository, accepting a DELETE request for that URL should not cause the data items to shuffle so that there is a new “first” object. You must also write your web service so that it doesn’t generate an error when receiving multiple requests such as a DELETE request for a data object that has already been removed from the repository.

Be careful with the POST verb; it is not necessarily safe or idempotent, and you have some flexibility about how you respond to multiple requests that target the same URL. Most web services will treat a POST request as a PUT request if there is already a matching data item, but you can choose to create a new object or report an error depending on the needs of your data model.

###Adding Data Discovery###

Uniquely identifying each data object—more properly known as a resource in REST—with a URL is an excellent idea, but it presents a problem: how does the client discover the set of data objects and the URLs that refer to them?

The solution is to create a collection URL, which returns all of the data objects in the model. The convention is that the collection of data objects is retrieved using the root URL that identifies individual objects.

In my API, this means that the URL /api/rsvp would return all of the data objects in the model.

Table 4-4. Adding a Collections URL to the Web Service API

|Verb|URL|Description|Client Sends|Server Sends|
|--|--|--|--|--|
|GET| /api/rsvp/bob|Gets the data object that represents Bob's RSVP|Nothing| The GuestResponse for Bob|
|POST| /api/rsvp/bob|Creates a new RSVP object for Bob|The GuestResponse to be saved|The savedGuestResponse object|
|PUT| /api/rsvp/bob|Updates the existing RSVP for Bob|The modified GuestResponse to be saved|The savedGuestResponse object|
|DELETE| /api/rsvp/bob|Deletes the RSVP for Bob|Nothing|Nothing|
|GET| /api/rsvp|Gets the collection of data objects|Nothing| The collection of all GuestResponse objects in the repository|

###Filtering the Collection###

Most clients don’t need to retrieve all of the data in the model, so the convention is to allow clients to narrow the data returned by the collection URL by using query string parameters.

> /api/rsvp?WillAttend=true

The web service can ignore the query string and return all of the data objects in the model, but it is generally a good idea to support this convention so that you are not transferring endless amounts of data that clients don’t require and that will be discarded.

> **Tip**  A common variation on this pattern is to build the filter into the URL, rather than relying on the query string.

The object that has the unique identifier 100, for example, would be accessed via the URL /api/products/100. Web API makes it easy to support both URL formats.

This is an example of what I mean about pragmatism in design patterns—even as I am trying to minimize the amount of prior knowledge that the client requires, I am extending my web service API using a convention that both the client and the server need to understand.

There is a balance to be found between client-server coupling and applying sensible optimizations, which differs for each project.

#CHAPTER 5 SportsStore: Preparation#

Entity Framework:

> http://msdn.microsoft.com/data/ef.aspx

#CHAPTER 6 SportsStore: A RESTful Application#

##Creating a RESTful Web Service##

> **Tip**  The convention for naming Web API controllers is to prefix the word Controller with the plural form of the model class that the web service will expose.

##ProductsController##

Listing 6-1. The Contents of the ProductsController.cs File 

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
namespace SportsStore.Controllers {
 public class ProductsController: ApiController {}
}
```

There are two important namespaces in Web API development: System.Net.Http and System.Web.Http.

Web API relies on an abstract model of HTTP requests and responses that is defined in System.Net.Http.

The classes from this namespace that you will work with most often are HttpRequestMessage and HttpResponseMessage, which are used to represent an HTTP request from the client and the response that will be sent in return.

The most important namespace, however, is System.Web.Http, which is where the Web API classes are defined.

ApiController, which is the standard base class for creating Web API controllers

ApiController feature: the RESTful action method naming convention.

Listing 6-2. Adding RESTful Action Methods in the ProductsController.cs File 

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SportsStore.Models;
using System.Threading.Tasks;

namespace SportsStore.Controllers {
  public class ProductsController: ApiController {

    public ProductsController() {
     Repository = new ProductRepository();
    }

    public IEnumerable < Product > GetProducts() {
     return Repository.Products;
    }

    public Product GetProduct(int id) {
     return Repository.Products.Where(p => p.Id == id).FirstOrDefault();
    }

    public async Task PostProduct(Product product) {
      await Repository.SaveProductAsync(product);
    }

    public async Task DeleteProduct(int id) {
      await Repository.DeleteProductAsync(id);
    }

    private IRepository Repository { get; set; }
  }
}
```


With just a few lines of code, I am able to define a working RESTful web service that exposes the product repository and its contents over HTTP requests.

###Testing the Products Web Service###

> http://localhost:6100/api/products/2

The response is an XML document

XML isn’t widely used in modern web applications, and I’ll show you how to change the format Chapter 13

Table 6-1. The Web Service API Presented by the Products Controller

|Verb|URL|Action Method|Description|
|--|--|--|--|
|GET|/api/products|GetProducts|Returns all the Product objects in the repository|
|GET|/api/products/1 or /api/products?id=1 |GetProduct|Returns a specific Product object|
|POST|/api/products|PostProducts|Updates or creates a Product object|
|DELETE|/api/products/1 or /api/products?id=1|DeleteProduct|Removes a Product from the repository|

##Working with Regular C# Objects##

Web API uses a data binding and URL routing processes similar to the MVC framework to extract data values from the request to present as action method parameters.

Web API takes care of creating an HTTP response that contains a serialized representation of the result object.

>**Tip**  Serialization is handled by a feature called media type formatters, which I describe in Chapters 12 and 13

##Using the RESTful Action Method Convention##

Web API makes it easy to create RESTful web services by applying a helpful convention when selecting action methods to handle requests: it looks for action methods whose name starts with the request HTTP verb.

Web API selects the action method by looking at the action methods defined by the controllers and filtering out any whose name doesn’t begin with the request HTTP verb.

Web API then looks at the data that has been extracted from the request by the URL routing system and selects the method whose parameters match the data.

##Configuring Serialization##

Clients can specify the data formats they are willing to work with in the Accept request header, and Web API will use the formats that are specified to select a serialization format.

The serialization of data objects so they can be sent to the client is handled by media type formatter classes.

To disable XML output, I am going to remove the XML media type formatter so that it is no longer used to serialize objects, leaving only the JSON formatter to handle requests.

>**Tip** The WebApiConfig.cs file is used to configure Web API rather than the Global.asax.cs file,

```csharp
public static class WebApiConfig {
public static void Register(HttpConfiguration config) {
   ...
}
```

```csharp
config.Formatters.Remove(config.Formatters.XmlFormatter);
```

> **Tip**  Although the WebApiConfig.cs file is used to configure Web API, it is the Global.asax.cs file that initiates that process when the application is hosted by IIS, which is required when MVC 5 and Web API 2 are used in the same application. If you look at the Global.asax.cs file, you will see a call to the GlobalConfiguration.Configure method,

Web API usually selects the right format for each client, but the process by which this is done, known as content negotiation, has some wrinkles that can trap the unwary,

##Adding Basic Data Validation##

Listing 6-4. Handling an Error in the ProductsController.cs File 

```csharp
public Product GetProduct(int id) {
 Product result = Repository.Products.Where(p => p.Id == id).FirstOrDefault();
 if (result == null) {
  throw new HttpResponseException(HttpStatusCode.BadRequest);
 } else {
  return result;
 }
}
```

In Web API, HTTP status codes are represented using values from the System.Net.HttpStatusCode enumeration.

##Using Action Results##

An alternative approach to using regular C# objects and the HttpResponseException is to use action results, which perform the same function as in the MVC framework and give you greater flexibility in how you structure your action method code.


Listing 6-5. Using Action Results in the ProductsController.cs File

```csharp
public IHttpActionResult GetProduct(int id) {
 Product result = Repository.Products.Where(p => p.Id == id).FirstOrDefault();
 return result == null ? (IHttpActionResult) BadRequest("No Product Found") : Ok(result);
}
```


The BadRequest method generates a response with the 400 (Bad Request) status code, and the Ok method generates a 200 (OK) result and serializes its argument.

The response contains a JSON-formatted object that has a Message property set to the string I passed to the ApiController.BadRequest method.

##CHOOSING BETWEEN OBJECTS/EXCEPTIONS AND ACTION RESULTS##

There is no practical difference in the results generated from action methods that use action methods instead of regular C# objects and the HttpResponseException, and the decision between them is a matter of personal style.

##Securing the Product Web Service##

By default, there are no restrictions on who can the access action methods defined by a Web API controller,

##HTTP DELETE request to the URL##

Response status code, which is 204 (No Content) for this request.

(Another common approach is to return the data object that has been deleted, in which case a 200 [OK] status code would be used.)

##Restricting Access to Action Method##

Restrict access so that only authenticated users who have been assigned to the Administrators role

The first step is to apply the Authorize filter to the action method

Listing 6-6. Applying Authorization in the ProductsController.cs File

```csharp
[Authorize(Roles = "Administrators")]
public async Task DeleteProduct(int id) {
  await Repository.DeleteProductAsync(id); }
```


Web API filters have the same effect as their counterparts in the MVC framework, which is to add logic into the request handling process that doesn’t belong elsewhere in the components of the MVC pattern, such as logging or security, known as cross-cutting concerns.

The Authorize filter prevents action methods from being invoked unless the request has been authenticated and the user associated with the request belongs to one or more specified roles.

Rather than the 204 (No Content) success method that was returned in the previous section, the web service now returns a 401 (Unauthorized) response,

##Authenticating Requests##

Web API lets you choose your own approach to authenticating requests, and in Chapters 23 and 24, I show you how to create a custom implementation of HTTP basic authentication.

Basic authentication is a rudimentary system that is safe only over SSL connections and that requires the client to provide the name and password of the user for every request,

The most common approach to authentication requests in Web API is to use ASP.NET Identity,

Authenticating users with ASP.NET Identity requires a specifically formatted request, but once the initial authentication has been performed, subsequent requests are identified as being authenticated by setting the standard HTTP Authorization header or an authentication cookie, using a value that is provided in the initial request.

##Configuring Authentication##

Using ASP.NET Identity in a web service requires some configuration statements in the IdentityConfig.cs file,

```csharp
app.UseOAuthBearerTokens(
  new OAuthAuthorizationServerOptions {
    Provider = new StoreAuthProvider(),
    AllowInsecureHttp = true,
    TokenEndpointPath = new PathString("/Authenticate")
  }
);
```

> **Tip**  There are many configuration options for authentication—too many for me to describe in this book. See http://msdn.microsoft.com/en-us/library/microsoft.owin.security.oauth.oauthauthorizationserveroptions(v=vs.113).aspx

Setting the AllowInsecureHttp property to true allows authentication to be performed for any HTTP request rather than the default behavior, which is to support only SSL requests.

The final property—TokenEndpointPath—specifies a URL that will be used to receive and process authentication requests. I have specified /Authenticate, which means that clients will send their authentication requests to http://localhost:6100/authenticate, as I demonstrate in the next section.

##Testing Authentication##

Allow the encoding style for the data in the request to be selected; click the x-www-form-urlencoded

Beneath the buttons are spaces for Key and Value.

Table 6-2. The Key Value Data Required for an Authentication Request

|Key|Value|
|--|--|
|grant_type|password|
|username|Bob|
|password|secret|

> **Tip**  A common cause of confusion is the response code for a failed authentication code. Many developers expect to receive a 401 (Unauthorized), but that is sent only when accessing a restricted URL without being authenticated or authorized.

Click the Headers button (which is to the right of the verb list). Enter Authorization into the header area.

Set the value to bearer followed by a space and then the value of the access_token from the authentication request. (The value bearer is taken from the token_type property in the response.)

##Adding Model Validation##

###Applying Validation Attributes###

Listing 6-9. Applying Validation to the Product.cs File

```csharp
using System.ComponentModel.DataAnnotations;

namespace SportsStore.Models {
  public class Product {

    public int Id { get; set; }

    [Required]
    public string Name { get; set; }

    [Required]
    public string Description { get; set; }

    [Required][Range(1, 100000)]
    public decimal Price { get; set; }

    [Required]
    public string Category { get; set; }
  }
}
```

###Validating the Model###

The final step is to check that the model object passed to the action method is valid, which is done through the ModelState property defined by the ApiController class.

Listing 6-10. Validating a Model in the ProductsController.cs File

```csharp
public async Task<IHttpActionResult> PostProduct(Product product) {
  if (ModelState.IsValid) {
    await Repository.SaveProductAsync(product);
    return Ok();
  } else {
    return BadRequest(ModelState);
    }
 }

```

Pass the value returned by the ModelState property to the BadRequest method, which has the effect of sending the client details of which properties are problematic and why.


##Creating a Non-RESTful Web Service##

###Preparing the Routing Configuration###

The URL routing system is responsible for matching requests in order to extract data and select the controller that will generate the response for the client.

The default Web API configuration doesn’t deal with action method names because the assumption is that you will follow the RESTful naming convention, so the first task is to add a new route that will match requests for my non-RESTful controller and extract both the controller and action method names from the URL,

Listing 6-14. Defining a New Route in the WebApiConfig.cs File

```csharp
config.Routes.MapHttpRoute(
  name: "OrdersRoute",
  routeTemplate: "nonrest/{controller}/{action}/{id}",
  defaults: new { id = RouteParameter.Optional }
);

config.Routes.MapHttpRoute(
  name: "DefaultApi",
  routeTemplate: "api/{controller}/{id}",
  defaults: new { id = RouteParameter.Optional }
);
```


###Preparing the Model Objects###

Listing 6-15. Applying Attributes in the Order.cs File

```csharp
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Http;

namespace SportsStore.Models {

  public class Order {

    [HttpBindNever]
    public int Id { get; set; }

    [Required]
    public string Customer { get; set; }

    [Required]
    [HttpBindNever]
    public decimal TotalCost { get; set; }

    public ICollection < OrderLine > Lines { get; set; }
  }

 public class OrderLine {
   [HttpBindNever]
   public int Id { get; set; }

   [Required]
   [Range(0, 100)]
   public int Count { get; set; }

   [Required] public int ProductId { get; set; }

   [HttpBindNever]
   public int OrderId { get; set; }

   [HttpBindNever]
   public Product Product { get; set; }

   [HttpBindNever] public Order Order { get; set; }
 }
}
```

I have also used the HttpBindNever attribute, which prevents Web API from assigning a value to a property from the request.

###Preventing Formatting Loops###

There is a circular reference in the relationship between the Order and OrderLine classes: an Order has a collection of OrderLine objects, each of which contains a reference back to the Order.

To prevent this from being a problem, I need to change the behavior of the class responsible for serializing objects into JSON so that it simply ignores circular references, rather than throws an error.

Listing 6-16. Disabling Errors for Circular References in the WebApiConfig.cs File

```csharp
GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
```

##Defining the Web API Controller##

Listing 6-17. The Contents of the OrdersController.cs File

```csharp
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using SportsStore.Models;

namespace SportsStore.Controllers {
  public class OrdersController: ApiController {

  public OrdersController() {
    Repository = (IRepository) GlobalConfiguration.Configuration.DependencyResolver.GetService(typeof(IRepository));
  }

  [HttpGet]
  [Authorize(Roles = "Administrators")]
  public IEnumerable < Order > List() {
   return Repository.Orders;
  }

  [HttpPost]
  public async Task < IHttpActionResult > CreateOrder(Order order) {
    if (ModelState.IsValid) {
      IDictionary<int,Product> products = Repository.Products.Where(
        p => order.Lines.Select(ol => ol.ProductId).Any(id => id == p.Id)).ToDictionary(p => p.Id);

      order.TotalCost = order.Lines.Sum(ol => ol.Count * products[ol.ProductId].Price);
      await Repository.SaveOrderAsync(order);
      return Ok();
    } else {
      return BadRequest(ModelState);
    }
  }

  [HttpDelete]
  [Authorize(Roles = "Administrators")]
  public async Task DeleteOrder(int id) {
    await Repository.DeleteOrderAsync(id);
  }

  private IRepository Repository { get; set; }
 }
}
```

These names don’t provide Web API with information about which HTTP verbs each will accept, so I have to apply attributes to specify them.

In the listing, I have used the HttpGet, HttpPost, and HttpDelete attributes, but Web API provides a wider range of verb attributes, as I describe in Chapter 22

##Completing the Product Controller##

Before moving on, I need to make a final change to the Product controller, which is to apply the Authorize attribute to the PostProduct action method.

```csharp
[Authorize(Roles = "Administrators")]
public async Task<IHttpActionResult> PostProduct(Product product) {
```

#CHAPTER 7 SportsStore: Creating the Clients#

###Setting Up JavaScript IntelliSense###

Creation of a filed called _references.js in the Scripts folder.

I dragged the JavaScript files I will be depending on from the Solution Explorer and dropped them on the editor window for the _references.js

Listing 7-3. The Contents of the _references.js File

```JavaScript
/// <reference path="jquery-2.1.0.js" />
/// <reference path="bootstrap.js" />
/// <reference path="knockout-3.1.0.js" />
```

##Updating the Layout#

I also need to update the Views/Shared/_Layout.cshtml file so that it contains script elements that reference the JavaScript

Listing 7-4. Adding script Elements to the _Layout.cshtml File

```aspx
<script src="~/Scripts/storeCommonController.js"></script>
```

##Implementing the Common Code##

###Defining the Ajax Layer###

I like to start by creating a JavaScript file that contains the code that will make Ajax calls on behalf of other parts of the application

I created a JavaScript file called storeAjax.js

Listing 7-5. The Contents of the storeAjax.js File

```JavaScript
var sendRequest = function(url, verb, data, successCallback, errorCallback, options) {
    var requestOptions = options || {};
    requestOptions.type = verb;
    requestOptions.success = successCallback;
    requestOptions.error = errorCallback;
    if (!url || !verb) {
        errorCallback(401, "URL and HTTP verb required");
    }
    if (data) {
        requestOptions.data = data;
    }
    $.ajax(url, requestOptions);
}
var setDefaultCallbacks = function(successCallback, errorCallback) {
    $.ajaxSetup({
        complete: function(jqXHR, status) {
            if (jqXHR.status >= 200 && jqXHR.status < 300) {
                successCallback(jqXHR.responseJSON);
            } else {
                errorCallback(jqXHR.status, jqXHR.statusText);
            }
        }
    });
}
var setAjaxHeaders = function(requestHeaders) {
    $.ajaxSetup({
        headers: requestHeaders
    });
}
```

##Defining the Model##

I define the client-side model, which I will use to store the product and order data and keep track of the client application state.

I created a file called storeModel.js

Listing 7-6. The Contents of the storeModel.js File

```JavaScript
var model = {
    products: ko.observableArray([]),
    orders: ko.observableArray([]),
    authenticated: ko.observable(false),
    username: ko.observable(null),
    password: ko.observable(null),
    error: ko.observable(""),
    gotError: ko.observable(false)
};
$(document).ready(function() {
    ko.applyBindings();
    setDefaultCallbacks(function(data) {
        if (data) {
            console.log("---Begin Success---");
            console.log(JSON.stringify(data));
            console.log("---End Success---");
        } else {
            console.log("Success (no data)");
        }
        model.gotError(false);
    }, function(statusCode, statusText) {
        console.log("Error: " + statusCode + " (" + statusText + ")");
        model.error(statusCode + " (" + statusText + ")");
        model.gotError(true);
    });
});
```

##Defining the Authentication Controller##

The first client-side controller that I am going to create will handle authentication.

I added a file called storeCommonController.js

Listing 7-7. The Contents of the storeCommonController.js File

```JavaScript
var authenticateUrl = "/authenticate"
var authenticate = function(successCallback) {
    sendRequest(authenticateUrl, "POST", {
        "grant_type": "password",
        username: model.username(),
        password: model.password()
    }, function(data) {
        model.authenticated(true);
        setAjaxHeaders({
            Authorization: "bearer " + data.access_token
        });
        if (successCallback) {
            successCallback();
        }
    });
};
```

> **Tip**  This isn’t really a controller in the Web API or MVC framework sense of that word, but it helps to add structure to the client-side part of the application and ensure that functionality is concentrated in a single place, rather than repeated in different files.

##Testing Authentication##

To test the client-side authentication, I added some JavaScript code and HTML markup to the Index view to display the current authentication status and to send an authentication request,

```
<script>
var testAuth = function () {
  model.username('Admin');
  model.password('secret');
  authenticate();
}
</script>
```

```aspx
<div class="panel panel-primary">
  <div class="panel-heading">Authentication</div>
  <table class="table table-striped">
    <tr><td>Authenticated:</td><td data-bind="text: model.authenticated()"></td></tr>
    <tr><td>User:</td><td data-bind="text: model.username()"></td></tr>
    <tr><td colspan="2"><button data-bind="click: testAuth">Authenticate</button></td></tr>
  </table>
</div>
```

> **Note**  Reloading the web page in the browser means that the client loses the authentication token required to authorize requests. This is a side effect of using the Authorization header, which makes it easier to build and test client-side code but requires authentication each time the page is loaded.

##Defining the Products Controller##

The next step is to create the client-side code that will send Ajax requests to get and manipulate products.

Listing 7-9. The Contents of the storeProductsController.js File

```JavaScript
var productUrl = "/api/products/";
var getProducts = function() {
    sendRequest(productUrl, "GET", null, function(data) {
        model.products.removeAll();
        model.products.push.apply(model.products, data);
    })
};
var deleteProduct = function(id) {
    sendRequest(productUrl + id, "DELETE", null, function() {
        model.products.remove(function(item) {
            return item.Id == id;
        })
    });
}
var saveProduct = function(product, successCallback) {
    sendRequest(productUrl, "POST", product, function() {
        getProducts();
        if (successCallback) {
            successCallback();
        }
    });
}
```

##Defining the Orders Controller##

The final controller is to provide access to the orders.


Listing 7-11. The Contents of the storeOrdersController.js File

```JavaScript
var ordersUrl = "/nonrest/orders";
var ordersListUrl = ordersUrl + "/list";
var ordersCreateUrl = ordersUrl + "/createorder/";
var ordersDeleteUrl = ordersUrl + "/deleteorder/";
var getOrders = function() {
    sendRequest(ordersListUrl, "GET", null, function(data) {
        model.orders.removeAll();
        model.orders.push.apply(model.orders, data);
    });
}
var saveOrder = function(order, successCallback) {
    sendRequest(ordersCreateUrl, "POST", order, function() {
        if (successCallback) {
            successCallback();
        }
    });
}
var deleteOrder = function(id) {
    sendRequest(ordersDeleteUrl + id, "DELETE", null, function() {
        model.orders.remove(function(item) {
            return item.Id == id;
        })
    });
}
```

The server-side Web API controller for Orders objects is non-RESTful, which is why I have had to define URLs for each of the different operations.

##Testing the Orders Controller##

Listing 7-12. Adding Support for Testing Orders in the Index.cshtml File

```JavaScript
var testDeleteOrder = function () {
  deleteOrder(1);
}
```

```JavaScript
var testSaveOrder = function () {
  var order = model.orders()[0];
  order.TotalPrice = order.TotalPrice + 10;
  saveOrder(order);
}
```

```aspx
<div class="panel panel-primary">
  <div class="panel-heading">Order Controller Functions</div>
    <table class="table table-striped">
      <tr>
      <td><button data-bind="click: getOrders">Get Orders</button></td>
      <td><button data-bind="click: testDeleteOrder">Delete Order</button></td>
      <td><button data-bind="click: testSaveOrder">Save Order</button></td>
    </tr>
  </table>
</div>
```

##Creating the Customer Client##

###Creating the Customer Model###

Listing 7-13. The Contents of the storeCustomerModel.js File

```JavaScript
var customerModel = {
    productCategories: ko.observableArray([]),
    filteredProducts: ko.observableArray([]),
    selectedCategory: ko.observable(null),
    cart: ko.observableArray([]),
    cartTotal: ko.observable(0),
    cartCount: ko.observable(0),
    currentView: ko.observable("list")
}
```


###Creating the Customer Controller###

I added a file called storeCustomerController.js to the Scripts

Listing 7-14. The Contents of the storeCustomerController.js File

I have also used the Knockout subscribe function to define functions that are called automatically when there are changes to observable data items, like this:

##Creating the Views##

###Creating the Placeholders###

I will use a set of MVC framework partial views to break the content into more manageable chunks.

> **Tip**  There is a client-side validation library for Knockout available at https://github.com/Knockout-Contrib/Knockout-Validation