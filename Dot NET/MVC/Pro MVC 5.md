- [CHAPTER 5 Working with Razor](#Chap5)
- [CHAPTER 12 Security](#Chap12)
- [CHAPTER 15 URL Routing](#Chap15)
- [CHAPTER 17 Controllers and Actions](#Chap17)
- [CHAPTER 18 Filters](#Chap18)
- [CHAPTER 19 Controller Extension](#Chap19)
- [CHAPTER 20 Views](#Chap20)
- [CHAPTER 21 Helper Methods](#Chap21)
- [CHAPTER 22 Templated Helper Methods](#Chap22)
- [CHAPTER 23 URL and AJAX Helper Methods](#Chap23)
- [CHAPTER 24 Model Binding](#Chap24)
- [CHAPTER 25 Model Validation](#Chap25)
- [CHAPTER 26 Bundles](#Chap26)

#CHAPTER 5 Working with Razor# {#Chap5}

##Basics##
Razor statements start with the @ character

```
//Declare a model
@model Razor.Models.Product
```

```
// Import a namespace
@using Razor.Models
```

```
// Refer to the methods, fields, and properties of the view model object through @Model
<div>
	@Model.Name
</div>
```

By default all text is encoded; to prevent encoding:
```
@Html.Raw(@Model.Message)
```

Inside of the Razor code block, you can include HTML elements and data values into the view output just by defining the HTML and Razor expressions. 

```
<b>Low Stock (@ViewBag.ProductCount)</b> 
```

if you want to insert literal text into the view when it is not contained in an HTML element, then you need to give Razor a helping hand and prefix the line like this: 

```
@: Out of Stock 
```

```
//Code blocks are evaluated when the view is rendered
@{ 
  int x = 123; 
  string y = "foo";
}
```

##Layouts##

The convention for an MVC project is to place layout files in the Views folder.

Layout files are prefixed with a _ and within the views file; they will never be downloaded to the user.

```
// Setting a layout
@{     
    Layout = "∼/Views/_BasicLayout.cshtml"; 
}
```

```
// Removing a layout
@{     
    Layout = null; 
}
```

The Initial Contents of the _BasicLayout.cshtml 

```
File 
<!DOCTYPE html> 
<html> 
<head>     
<meta name="viewport" content="width=device-width" />     
<title>@ViewBag.Title</title>
</head>
<body>
    <div>
        @RenderBody()
    </div>
</body>
</html>
```

The @RenderBody method inserts the contents of the view into the layout.

The contents of the _ViewStart.cshtml File are automatically added into each view. They can be used to set the default layout.

```
// _ViewStart.cshtml
@{     
    Layout = "∼/Views/_BasicLayout.cshtml"; 
}
```
   

##Setting Attribute Values##

```
<div data-discount="@ViewBag.ApplyDiscount" data-express="@ViewBag.ExpressShip"></div>
```

```
<input type="checkbox" checked="@ViewBag.ApplyDiscount" />
```

A null is rendered as an empty string.

Razor is aware of the way that attributes such as checked are used, 

The presence of an attribute rather than its value changes the configuration of the element (known as a Boolean attribute in the HTML specification) for some elements such as checkboxes. Razor will delete the attribute where the value is false, null or an empty string.

##Conditional Statements##

```
@switch ((int)ViewBag.ProductCount) 
{
    case 0:
        @: Out of Stock
        break;                 
    case 1:                     
        <b>Low Stock (@ViewBag.ProductCount)</b>                     
        break;                 
    default:                     
        @ViewBag.ProductCount                     
        break;             
}
```
               
> Razor switch expression cannot evaluate a dynamic property; a cast is requried to a specific type

```
@if (ViewBag.ProductCount == 0)
{
    @:Out of Stock
} else if (ViewBag.ProductCount == 1) {
    <b>Low Stock (@ViewBag.ProductCount)</b>
} else {
    @ViewBag.ProductCount
}
```

```
<tbody>             
@foreach (Razor.Models.Product p in Model) 
{                 
    <tr>                     
        <td>@p.Name</td>                     
        <td>$@p.Price</td>                 
    </tr>             
}         
</tbody>
```

#CHAPTER 12 Security# {#Chap12}

The Authorize file can be used to ensure only logged in users can call an action method. 

```
[Authorize]
public class AdminController : Controller
```

> **Note**  The filter can be applied at the action method and controller level,

##Creating the Authentication Provider##

Using the forms authentication feature requires calls to two static methods of the System.Web.Security.FormsAuthentication class: 

 1. The Authenticate method validates credentials supplied by the user. 
 2. The SetAuthCookie method adds a cookie to the response to the browser,

As static methods are hard to test we will decouple the controller via an interface.

```
﻿namespace SportsStore.WebUI.Infrastructure.Abstract {
    public interface IAuthProvider {
        bool Authenticate(string username, string password);
    }
}
```

```
﻿using System.Web.Security;
using SportsStore.WebUI.Infrastructure.Abstract;

namespace SportsStore.WebUI.Infrastructure.Concrete {

    public class FormsAuthProvider : IAuthProvider {

        public bool Authenticate(string username, string password) {

            bool result = FormsAuthentication.Authenticate(username, password);
            if (result) {
                FormsAuthentication.SetAuthCookie(username, false);
            }
            return result;
        }
    }
}
```

```
kernel.Bind<IAuthProvider>().To<FormsAuthProvider>();
```

###Creating the Account Controller###


```
﻿using System.ComponentModel.DataAnnotations;

namespace SportsStore.WebUI.Models {
    public class LoginViewModel {
        [Required]
        public string UserName { get; set; }

    [Required]
    public string Password { get; set; }
   }
}
```

```
﻿using System.Web.Mvc;
using SportsStore.WebUI.Infrastructure.Abstract;
using SportsStore.WebUI.Models;

namespace SportsStore.WebUI.Controllers {

    public class AccountController : Controller {
        IAuthProvider authProvider;

        public AccountController(IAuthProvider auth) {
            authProvider = auth;
        }

        public ViewResult Login() {
            return View();
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel model, string returnUrl) {

            if (ModelState.IsValid) {
                if (authProvider.Authenticate(model.UserName, model.Password)) {
                    return Redirect(returnUrl ?? Url.Action("Index", "Admin"));
                } else {
                    ModelState.AddModelError("", "Incorrect username or password");
                    return View();
                }
            } else {
                return View();
            }
        }
    }
}
```

```
﻿@model SportsStore.WebUI.Models.LoginViewModel

@{
    ViewBag.Title = "Admin: Log In";
    Layout = "~/Views/Shared/_AdminLayout.cshtml";
}

<div class="panel">
    <div class="panel-heading">
        <h3> Log In</h3>
    </div>
    <div class="panel-body">
        <p class="lead">Please log in to access the administration area:</p>
        @using (Html.BeginForm()) {
            @Html.ValidationSummary()
            <div class="form-group">
                <label>User Name:</label>
                @Html.TextBoxFor(m => m.UserName, new { @class = "form-control" })
            </div>
            <div class="form-group">
                <label>Password:</label>
                @Html.PasswordFor(m => m.Password, new { @class = "form-control" })
            </div>
            <input type="submit" value="Log in" class="btn btn-primary" />
        }
    </div>
</div>
```

#CHAPTER 15 URL Routing# {#Chap15}

The routing system has two functions:

- Examine an incoming URL and determine the controller and action required 
- Generate outgoing URLs

There are two ways to create routes in an MVC Framework application: 

- Convention-based routing
- Attribute routing

##Introducing URL Patterns##

Rroutes collectively comprise the URL schema or scheme for an application,

Each route contains a URL pattern, if a URL matches the pattern, then it is used by the routing system to process that URL.

{controller}/{action} will match any URL that has two segments

URL patterns are conservative, and will match only URLs that have the same number of segments as the pattern.

URL patterns are liberal. If a URL does have the correct number of segments, the pattern will extract the value for the segment variable, whatever it might be.

URL patterns will match even when there is no controller or action that corresponds to the values extracted from a URL.

##Creating and Registering a Simple Route##

Routes are defined in the RouteConfig.cs and called from called from Application_Start of Global.asax.cs.

RouteTable.Routes property is an instance of the RouteCollection class.

```
var myRoute = new Route("{controller}/{action}", new MvcRouteHandler());
routes.Add("MyRoute", myRoute);
```

> Naming your routes is optional, and there is a philosophical argument that doing so sacrifices some of the clean separation of concerns that otherwise comes from routing.

A more convenient way of registering routes:
 
```
routes.MapRoute("MyRoute", "{controller}/{action}");
```

Routes are applied in the order in which they appear in the RouteCollection object.

##UNIT TEST: TESTING INCOMING URLS##

Need to mock three classes from the MVC Framework: HttpRequestBase, HttpContextBase, and HttpResponseBase.

```
private HttpContextBase CreateHttpContext(string targetUrl = null, string httpMethod = "GET") {
    // create the mock request 
    Mock<HttpRequestBase> mockRequest = new Mock<HttpRequestBase>();
    mockRequest.Setup(m => m.AppRelativeCurrentExecutionFilePath)
        .Returns(targetUrl);
    mockRequest.Setup(m => m.HttpMethod).Returns(httpMethod);

    // create the mock response
    Mock<HttpResponseBase> mockResponse = new Mock<HttpResponseBase>();
    mockResponse.Setup(m => m.ApplyAppPathModifier(
        It.IsAny<string>())).Returns<string>(s => s);

    // create the mock context, using the request and response
    Mock<HttpContextBase> mockContext = new Mock<HttpContextBase>();
    mockContext.Setup(m => m.Request).Returns(mockRequest.Object);
    mockContext.Setup(m => m.Response).Returns(mockResponse.Object);

    // return the mocked context
    return mockContext.Object;
}
```

Testing the route:

```
private void TestRouteMatch(string url, string controller, string action,
            object routeProperties = null, string httpMethod = "GET") {

   // Arrange
    RouteCollection routes = new RouteCollection();
    RouteConfig.RegisterRoutes(routes);
    // Act - process the route
    RouteData result
        = routes.GetRouteData(CreateHttpContext(url, httpMethod));
    // Assert
    Assert.IsNotNull(result);
    Assert.IsTrue(TestIncomingRouteResult(result, controller,
        action, routeProperties));
}
```

```
private bool TestIncomingRouteResult(RouteData routeResult,
    string controller, string action, object propertySet = null) {

    Func<object, object, bool> valCompare = (v1, v2) => {
        return StringComparer.InvariantCultureIgnoreCase
            .Compare(v1, v2) == 0;
    };

    bool result = valCompare(routeResult.Values["controller"], controller)
        && valCompare(routeResult.Values["action"], action);

    if (propertySet != null) {
        PropertyInfo[] propInfo = propertySet.GetType().GetProperties();
        foreach (PropertyInfo pi in propInfo) {
            if (!(routeResult.Values.ContainsKey(pi.Name)
                    && valCompare(routeResult.Values[pi.Name],
                    pi.GetValue(propertySet, null)))) {

                result = false;
                break;
            }
        }
    }
    return result;
}
```

Testing Route Failure:

```
private void TestRouteFail(string url) {
    // Arrange
    RouteCollection routes = new RouteCollection();
    RouteConfig.RegisterRoutes(routes);
    // Act - process the route
    RouteData result = routes.GetRouteData(CreateHttpContext(url));
    // Assert
    Assert.IsTrue(result == null || result.Route == null);
}
```

When testing, we must prefix the URL with the tilde (∼) character, because this is how the ASP.NET Framework presents the URL to the routing system. 

```
TestRouteMatch("~/", "Home", "Index");
TestRouteMatch("~/Home/Index", "Home", "Index
```

##Defining Default Values##

Default values are supplied as properties in an anonymous type.

```
routes.MapRoute("MyRoute", "{controller}/{action}", new { action = "Index" });
routes.MapRoute("MyRoute", "{controller}/{action}", new { controller = "Home", action = "Index" });
```

##Using Static URL Segments##

```
http://mydomain.com/Public/Home/Index
```

```
routes.MapRoute("", "Public/{controller}/{action}", new { controller = "Home", action = "Index" });
```

Segments can contain both static and variable elements:

```
routes.MapRoute("", "X{controller}/{action}");
```

I can combine static URL segments and default values to create an alias for a specific URL.

I can create a route to preserve the old URL schema:

```
routes.MapRoute("ShopSchema", "Shop/{action}", new { controller = "Home" });
```

Create aliases for action methods that have been refactored away as well

```
routes.MapRoute("ShopSchema2", "Shop/OldAction", new { controller = "Home", action = "Index" });
```

##Defining Custom Segment Variables##

The controller and action segment variables have special meaning to the MVC Framework

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}",
    new { controller = "Home", action = "Index", id = "DefaultId" });
```

> Caution; some names are reserved and not available for custom segment variable names. These are controller, action, and area.

You can access any of the segment variables in an action method with RouteData.Values.

```
RouteData.Values["id"];
```

```
TestRouteMatch("∼/Customer/List/All", "Customer", "List", new { id = "All" });
```

##Using Custom Variables as Action Method Parameters##

Parameters in an action method with names that match the URL pattern variables will be passed in the URL values.

```
public ActionResult CustomVariable(string id)
{
}
```

The MVC Framework will try to convert the URL value to whatever parameter type is defined.

> The MVC Framework uses the model binding feature to convert the values contained in the URL to .NET types and can handle much more complex situations than shown in this example.

##Defining Optional URL Segments##

An optional URL segment is one that the user does not need to specify, but for which no default value is specified.

When no value has been supplied for an optional segment variable, the value of the corresponding parameter will be null.

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}", 
    new { controller = "Home", action = "Index", id = UrlParameter.Optional });
```

This route will match URLs whether or not the id segment has been supplied.

##Using Optional URL Segments to Enforce Separation of Concerns##

Some developers who are focused on the separation of concerns in the MVC pattern do not like putting the default values for segment variables into the routes for an application.

You can use C# optional parameters along with an optional segment variable in the route to define the default values for action method parameters.

```
public ActionResult CustomVariable(string id = "DefaultId")
{
}
```

There will always be a value for the id parameter (either one from the URL or the default),

Optional URL segments will not be added to the RouteData.Values unless a value was found in the URL.

##Defining Variable-Length Routes##

Accept a variable number of URL segments with the catchall asterix:

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/ {*catchall}",                 
new { controller = "Home", action = "Index", id = UrlParameter.Optional });
```

Segments captured by the catchall are presented in a single segment in the form segment / segment / segment. 

Notice that I will not receive the leading or trailing / character.

```
TestRouteMatch("∼/Customer/List/All/Delete/Perm", "Customer", "List",
    new { id = "All", catchall = "Delete/Perm" });
```

##Prioritizing Controllers by Namespaces##

The controller is an unqualified class name, an error will occur if more than one controller can be addressed.

You can tell the MVC Framework to give preference to certain namespaces.

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/{*catchall}", 
    new { controller = "Home", action = "Index", id = UrlParameter.Optional }, 
    new[] { "URLsAndRoutes.AdditionalControllers" });
}
```
The namespaces added to a route are given equal priority.

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/{*catchall}",
     new { controller = "Home", action = "Index", id = UrlParameter.Optional },
     new[] { "URLsAndRoutes.AdditionalControllers", "UrlsAndRoutes.Controllers" });
```

If a controller was found in both namespaces we would have the same issue.

If I want to give preference to a single controller in one namespace, but have all other controllers resolved in another namespace, I need to create multiple routes.

```
routes.MapRoute("AddContollerRoute", "Home/{action}/{id}/{*catchall}",                 
    new { controller = "Home", action = "Index",
    id = UrlParameter.Optional },
    new[] { "URLsAndRoutes.AdditionalControllers" });             
 
routes.MapRoute(
    "MyRoute", 
    "{controller}/{action}/{id}/{*catchall}",
    new { controller = "Home", action = "Index", id = UrlParameter.Optional },
    new[] { "URLsAndRoutes.Controllers" });
```

I can tell the MVC Framework to look only in the namespaces that I specify. If a matching controller cannot be found, then the framework will not search elsewhere:

```
var myRoute = routes.MapRoute("AddContollerRoute", "Home/{action /{id}/{*catchall}",
    new { controller = "Home", action = "Index",
    id = UrlParameter.Optional },
    new[] { "URLsAndRoutes.AdditionalControllers" });

myRoute.DataTokens["UseNamespaceFallback"] = false;
```

This setting will be passed along to the component responsible for finding controllers, which is known as the controller factory.

##Constraining Routes##

###Constraining a Route Using a Regular Expression###

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/{*catchall}",
    new { controller = "Home", action = "Index", id = UrlParameter.Optional }, 
    new { controller = "^H.*" }, new[] { "URLsAndRoutes.Controllers" });
```

Default values are applied before constraints are checked.

###Constraining a Route to a Set of Specific Values###

Regular expressions '|' can can constrain a route so that only specific values for a URL segment will cause a match. 

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/{*catchall}",
    new { 
        controller = "Home", 
        action = "Index", 
        id = UrlParameter.Optional 
        },
    new { 
        controller = "^H.*", 
        action = "^Index$|^About$" 
        },
    new[] { "URLsAndRoutes.Controllers" });
```

Constraints are applied together, so the restrictions imposed on the value of the action variable are combined with those imposed on the controller variable.

###Constraining a Route Using HTTP Methods###

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/{*catchall}",
    new { 
        controller = "Home", 
        action = "Index", id = 
        UrlParameter.Optional },
    new { 
        controller = "^H.*", 
        action = "Index|About", 
        httpMethod = new HttpMethodConstraint("GET")},
    new[] { "URLsAndRoutes.Controllers" });
    }
```

The format for specifying an HTTP method constraint is slightly odd. It does not matter what name is given to the property, as long as it is assigned to an instance of the HttpMethodConstraint class.

> Note : The ability to constrain routes by HTTP method is unrelated to the ability to restrict action methods using attributes such as HttpGet and HttpPost. The route constraints are processed much earlier in the request pipeline, and they determine the name of the controller and action required to process a request. The action method attributes are used to determine which specific action method will be used to service a request by the controller. I provide details of how to handle different kinds of HTTP methods (including the more unusual ones such as PUT and DELETE)

```
httpMethod = new HttpMethodConstraint("GET", "POST") },
```

###Using Type and Value Constraints###

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}/{*catchall}",
    new { 
        controller = "Home", 
        action = "Index", id = 
        UrlParameter.Optional },
    new { 
        controller = "^H.*", 
        action = "Index|About", 
        httpMethod = new HttpMethodConstraint("GET"), 
        id = new RangeRouteConstraint(10, 20)               
        },
    new[] { "URLsAndRoutes.Controllers" }
);
```

In the constraint classes, which are in the System.Web.Mvc.Routing.Constraints namespace, check to see if segment variables are values for different C# types and can perform basic checks.

|Name |Description |Attribute Constraint |
|--|--|--|
|AlphaRouteConstraint()| Matches alphabet characters, irrespective of case (A–Z, a–z)| alpha |
|BoolRouteConstraint() |Matches a value that can be parsed into a bool |bool |
|DateTimeRouteConstraint() |Matches a value that can be parsed into a DateTime |datetime |
|DecimalRouteConstraint() |Matches a value that can be parsed into a decimal| decimal |
|DoubleRouteConstraint() |Matches a value that can be parsed into a double |double |
|FloatRouteConstraint() |Matches a value that can be parsed into a float |float |
|IntRouteConstraint() |Matches a value that can be parsed into an int |int |
|LengthRouteConstraint(len), LengthRouteConstraint(min, max)| Matches a value with the specified number of characters or that is between min and max characters in length. |length(len, length(min, max) |
|LongRouteConstraint()|Matches a value that can be parsed into a long |long |
|MaxRouteConstraint(val)| Matches an int value if the value is less than val |max(val) |
|MaxLengthRouteConstraint(len)| Matches a string with no more than len characters |maxlength(len) |
|MinRouteConstraint(val) |Matches an int value if the value is more than val |min(val) |
|MinLengthRouteConstraint(len)| Matches a string with at least len characters |minlength(len) |
|RangeRouteConstraint(min, max) |Matches an int value if the value is between min and max|range(min,max)

You can combine different constraints for a single segment variable by using the CompoundRouteConstraint class, which accepts an array of constraints as its constructor argument.

```
id = new CompoundRouteConstraint(
    new IRouteConstraint[] {
        new AlphaRouteConstraint(),                         
        new MinLengthRouteConstraint(6)
    })
```

###Defining a Custom Constraint###

The Contents of the UserAgentConstraint.cs File 

```
using System.Web;
using System.Web.Routing; 
namespace UrlsAndRoutes.Infrastructure {
    public class UserAgentConstraint : IRouteConstraint {         
        private string requiredUserAgent;         
        public UserAgentConstraint(string agentParam) {      
            requiredUserAgent = agentParam;         
        }
           
        public bool Match(HttpContextBase httpContext, Route route, string parameterName, RouteValueDictionary values, RouteDirection routeDirection) {
            return httpContext.Request.UserAgent != null && httpContext.Request.UserAgent.Contains(requiredUserAgent); 
        }
    } 
}
```

```
routes.MapRoute("ChromeRoute", "{*catchall}", 
    new { controller = "Home", action = "Index" }, 
    new { customConstraint = new UserAgentConstraint("Chrome") }, 
    new[] { "UrlsAndRoutes.AdditionalControllers" });             
```

##Using Attribute Routing##

MVC 5 adds support for a new technique known as attribute routing, in which routes are defined by C# attributes that are applied directly to the controller classes.

They can be mixed freely with the standard convention-based routes.

##CONVENTION VERSUS ATTRIBUTE ROUTING##

###Enabling and Applying Attribute Routing###

Attribute routing is disabled by default; to enable call MapMvcAttributeRoutes:

```
public static void RegisterRoutes(RouteCollection routes) {             
    routes.MapMvcAttributeRoutes();             
    routes.MapRoute("Default", "{controller}/{action}/{id}", 
        new { controller = "Home", action = "Index", id = UrlParameter.Optional },
        new[] { "UrlsAndRoutes.Controllers" });
}
```

Calling the MapMvcAttributeRoutes method causes the routing system to inspect the controller classes in the application and look for attributes that configure routes.

The most important attribute is called Route.

```
[Route("Test")]

public ActionResult Index() {
   ViewBag.Controller = "Customer";
   // More code would be here.
}  
```

This is the basic use of the Route attribute, which is to define a static route for an action method. 

The Route defines two properties:

|Name |Description |
|--|--|
|Name |Assigns a name to the route, used for generating outgoing URLs from a specific route |
|Template |Defines the pattern that will be used to match URLs that target the action method|

The Route attribute was used to specify that the Index action on the Customer controller can be accessed through the URL /Test.

When an action method is decorated with the Route attribute, it can no longer be accessed through the convention-based routes defined in the RouteConfig.cs file.

> **Caution:**  The Route attribute stops convention-based routes from targeting an action method even if attribute routing is disabled.

###Creating Routes with Segment Variables###

The attribute routing feature supports all of the same features as convention-based routing, albeit expressed through attributes.

```
[Route("Users/Add/{user}/{id}")]         
public string Create(string user, int id) {
    return string.Format("User: {0}, ID: {1}", user, id);
}
```

###Applying Route Constraints###

```
[Route("Users/Add/{user}/{id:int}")]
public string Create(string user, int id) {
// Code 
}
```

The int constraint corresponds to the IntRouteConstraint constraint class.

###Combining Constraints###

```
[Route("Users/Add/{user}/{password :alpha:length(6) }")]
```

The route created by the attribute in this example will only match alphabetic strings that have exactly six characters.

###Using a Route Prefix###

You can use the RoutePrefix attribute to define a common prefix that will be applied to all of the routes defined in a controller, which can be useful when you have multiple action methods that should be targeted using the same URL root.

```
[RoutePrefix("Users")]     
public class CustomerController : Controller {         
    [Route("∼/Test")]         
    public ActionResult Index() {
        // Accessed via /Test             
    }         

    [Route("Add/{user}/{id:int}")]         
    public string Create(string user, int id) {
        // Accessed Via /User/Add/{User}{id}
    }

    [Route("Add/{user}/{password}")]         
    public string ChangePass(string user, string password) {
            // Accessed Via /User/Add/{password}
    }
}
```

I used the RoutePrefix attribute to specify that the routes for the action method should be prefixed with Users.

Prefixing the URL with ∼/ tells the MVC Framework that I don’t want the RoutePrefix attribute applied to the Index action method, which means that it will still be accessible through the URL /Test.

#CHAPTER 16 Advanced Routing Features#

##Adding the Optimization Package##

The areas feature requires a new package be installed:

```
Install-Package Microsoft.AspNet.Web.Optimization -version 1.1.0     -projectname UrlsAndRoutes
```

This package contains functionality for optimizing the JavaScript and CSS files.

##Updating the Unit Test Project##

I need to add the MVC 5 package so that I can use some helper methods to generate outgoing URLs.

```
Install-Package Microsoft.Aspnet.Mvc -version 5.0.0 -projectname UrlsAndRoutes.Tests
```

##Generating Outgoing URLs in Views##

###Using the Routing System to Generate an Outgoing URL###

```
// Text, Action method
@Html.ActionLink("This is an outgoing URL", "CustomVariable")
```

Assuming the view is rendered by the Home controller:

```
<a href="/Home/CustomVariable">This is an outgoing URL</a>
```

###UNDERSTANDING OUTBOUND URL ROUTE MATCHING###

The routing system processes the routes in the order that they were added to the RouteCollection object passed to the RegisterRoutes method.

Each route is inspected to see if it is a match, which requires three conditions to be met:

1. A value must be available for every segment variable defined in the URL pattern. To find values for each segment variable, the routing system looks first at the values provided of the anonymous type, then the variable values for the current request, and finally the default values defined in the route.
2. The values for all of the segment variables must satisfy the route constraints.
3. None of the values provided for segments may disagree with defined default-only variables. Here myVar is a default-only variable. For this route to be a match, either no value or a matching value for myVar should be provided:
 
```
routes.MapRoute("MyRoute", "{controller}/{action}", new { myVar = "true" });
```

> **To be clear:** the routing system doesn’t try to find the route that provides the best matching route. It finds only the first match

If no matching route can be found, a link that contains an empty href will be generated:

```
<a href="">About this application</a>
```

- The first Route object meeting these criteria will produce a non-null URL, and will terminate the URL-generating process. 
- The chosen parameter values will be substituted for each segment parameter, with any trailing sequence of default values omitted. 
- Any explicit parameters that do not correspond to segment parameters or default parameters, will be appended as a set of query string name/value pairs.

###Targeting Other Controllers###

```
@Html.ActionLink("This targets another controller", "Index", "Admin")
```

> **Caution:** The routing system does not validate to ensure that action methods and controllers are matched.

The routing system is pretty clever and it knows that the route defined in the application will use the Index action method by default, allowing it to omit unneeded segments. The href will appear as:

```
<a href="/Admin">This targets another controller</a>
```

###Passing Extra Values###

You can pass values for segment variables using an anonymous type, with properties representing the segments.

Segments not found within the route are added  as query string parameters.

```
@Html.ActionLink("This is an outgoing URL", "CustomVariable", new { id = "Hello" })
```

```
<a href="/App/DoCustomVariable?id=Hello">This is an outgoing URL</a>
```

Adding the segment id to prevent a query string being added:

```
routes.MapRoute("MyRoute", "{controller}/{action}/{id}", new { controller = "Home", action = "Index", id = UrlParameter.Optional });
```

```
<a href="/Home/CustomVariable/Hello">This is an outgoing URL</a>
```

##UNDERSTANDING SEGMENT VARIABLE REUSE##

When trying to find values for each of the segment variables in a route’s URL pattern, the routing system will look at the values from the current request and reuse segment variable values:

```
routes.MapRoute("MyRoute", "{controller}/{action}/{color}/{page}");
```

Currently at the URL /Catalog/List/Purple/123

```
@Html.ActionLink("Click me", "List", "Catalog", new {page=789}, null) 
```

Will generate the following HTML: 

```
<a href="/Catalog/List/Purple/789">Click me</a>
```

This is not a behavior of last resort; this technique is part of the regular assessment of routes, even if there is a subsequent route that would match without requiring values from the current request to be reused.

The routing system will reuse values only for segment variables that occur earlier in the URL pattern rather than any parameters that are supplied to the Html.ActionLink method.

```
@Html.ActionLink("Click me", "List", "Catalog", new {color="Aqua"}, null) 
```

A value for color and not for page has been specified. As color appears before page in the URL pattern, the routing system won’t reuse the values from the incoming URL, and the route will not match.


##Specifying HTML Attributes##

Provided by an anonymous type whose properties correspond to the attributes required:

```
@Html.ActionLink("This is an outgoing URL", "Index", "Home", null, 
    new { id = "myAnchorID", @class = "myCSSClass" })
```

```
<a class="myCSSClass" href="/" id="myAnchorID">This is an outgoing URL</a>
```

> **Tip**  Notice the prepended class property with a @ character. This is a C# language feature that lets reserved keywords be used as the names for class members.

##Generating Fully Qualified URLs in Links##

```
@Html.ActionLink("This is an outgoing URL", "Index", "Home", "https", 
    "myserver.mydomain.com", 
    " myFragmentName", 
    new { id = "MyId" }, 
    new { id = "myAnchorID", @class = "myCSSClass" })
```

> **Note:** Use relative URLs wherever possible; fully qualified URLs create dependencies on the way that your application infrastructure is presented to your users.
 
##Generating URLs (and Not Links)##

```
@Url.Action("Index", "Home", new { id = "MyId" })
```

The Url.Action method works in the same way as the Html.ActionLink method, except that it generates only the URL.

##Generating Outgoing URLs in Action Methods##

```
public ViewResult MyActionMethod() {
    string myActionUrl = Url.Action("Index", new { id = "MyID" });
    string myRouteUrl = Url.RouteUrl(new { controller = "Home", action = "Index"});

    //... do something with URLs...             
    return View();
}
```

RouteUrl allows you to target a controller/action directly.

A more common requirement is to redirect the client browser to another URL by returning a RedirectToRouteResult via the RedirectToAction method:

```
public RedirectToRouteResult MyActionMethod() {
    return RedirectToAction("Index");
}
```

RedirectToRoute method can be used to target a controller and action method directly.

```
public RedirectToRouteResult MyActionMethod() {
    return RedirectToRoute(
        new { controller = "Home", action = "Index", id = "MyID" });
}
```

##Generating a URL from a Specific Route##

```
routes.MapRoute("MyRoute", "{controller}/{action}");     
routes.MapRoute("MyOtherRoute", "App/{action}", new { controller = "Home" }); }
```

You can override the default route matching behavior by using the Html.RouteLink method,

```
@Html.RouteLink("Click me", "MyOtherRoute","Index", "Customer")
```

You can also give names to the routes you define with the Route attribute.

```
[Route("Add/{user}/{id:int}", Name="AddRoute")]
public string Create(string user, int id) {
    return string.Format("Create Method - User: {0}, ID: {1}", user, id);
}
```

> **Note:** The problem with relying on route names to generate outgoing URLs is that doing so breaks through the separation of concerns that is so central to the MVC design pattern.

##Customizing the Routing System##


###Creating a Custom RouteBase Implementation###

####Generating Incoming  URLs####

You can derive an alternative class from RouteBase.

This gives you control over how URLs are matched, how parameters are extracted, and how outgoing URLs are generated. To derive a class from RouteBase, you need to implement two methods:

- GetRouteData (HttpContextBase httpContext): This is the mechanism by which inbound URL matching works. The framework calls this method on each RouteTable.Routes entry in turn, until one of them returns a non-null value. 
- GetVirtualPath (RequestContext requestContext, RouteValueDictionary values): This is the mechanism by which outbound URL generation works. The framework calls this method on each RouteTable.Routes entry in turn, until one of them returns a non-null

A controller to handle legacy requests:

```
public class LegacyController : Controller {
    public ActionResult GetLegacyURL(string legacyURL) {
        return View((object)legacyURL); // Cast to ensure View(Object object) is called
    }
}
```

Routing Incoming URLs:

```
public class LegacyRoute : RouteBase {
    private string[] urls;

    public LegacyRoute(params string[] targetUrls) {
	urls = targetUrls;
    }

    public override RouteData GetRouteData(HttpContextBase httpContext) {
	RouteData result = null;

	string requestedURL =
		httpContext.Request.AppRelativeCurrentExecutionFilePath;
	if (urls.Contains(requestedURL, StringComparer.OrdinalIgnoreCase)) {
		result = new RouteData(this, new MvcRouteHandler());
		result.Values.Add("controller", "Legacy");
		result.Values.Add("action", "GetLegacyURL");
		result.Values.Add("legacyURL", requestedURL);
	}
	return result;
    }
}
```

The GetRouteData method is called by the routing system calls to see if the LegacyRoute class can match an incoming URL. For no match null is returned otherwise return an instance of RouteData which contains the controller and action variables, and anything else required to be passed to the the action method.

When I create the RouteData object, I need to pass in the handler that I want to deal with the values that generated. I use the standard MvcRouteHandler class, which is what assigns meaning to the controller and action values:

```
result = new RouteData(this, new MvcRouteHandler());
```

For the vast majority of MVC applications, this is the class that you will require, as it connects the routing system to the controller/action model of an MVC application. But you can implement a replacement for MvcRouteHandler, demonstrated later.

The last step is to register a new route that uses the custom RouteBase class:

```
routes.Add(new LegacyRoute( "∼/articles/Windows_3.1_Overview.html", "∼/old/.NET_1.0_Class_Library"));
routes.MapRoute("MyRoute", "{controller}/{action}");
routes.MapRoute("MyOtherRoute", "App/{action}", new { controller = "Home" });
```

####Generating Outgoing URLs####

To support outgoing URL generation, I implement GetVirtualPath in the LegacyRoute class to return an instance of the VirtualPathData:

```
public override VirtualPathData GetVirtualPath(RequestContext requestContext, 
RouteValueDictionary values) {

    VirtualPathData result = null;

    if (values.ContainsKey("legacyURL") &&
	urls.Contains((string)values["legacyURL"], StringComparer.OrdinalIgnoreCase)) {
	result = new VirtualPathData(this,
		new UrlHelper(requestContext)
			.Content((string)values["legacyURL"]).Substring(1));
    }
    return result;
}
```

Segment variables defined as anonymous types are converted behind the scenes to RouteValueDictionary objects so they can be processed by RouteBase implementations.

To use:

```
@Html.ActionLink("Click me", "GetLegacyURL", new { legacyURL = "∼/articles/Windows_3.1_Overview.html" }) 
```

```
<a href="/articles/Windows_3.1_Overview.html">Click me</a>
```

We used the Content method of the UrlHelper class to convert the application-relative URL to one that can be passed to browsers.

###Creating a Custom Route Handler###

```
public class CustomRouteHandler : IRouteHandler {
    public IHttpHandler GetHttpHandler(RequestContext requestContext) {
	return new CustomHttpHandler();
    }
}

public class CustomHttpHandler : IHttpHandler {
    public bool IsReusable {
	get { return false; }
    }

    public void ProcessRequest(HttpContext context) {
	context.Response.Write("Hello");
    }
}
```

The purpose of the IRouteHandler interface is to provide a means to generate implementations of the IHttpHandler interface, which is responsible for processing requests.

Register the route handler:

```
routes.Add(new Route("SayHello", new CustomRouteHandler()));     
```

##Working with Areas##

Each area represents a functional segment of the application, such as administration, billing, customer support, and so on.

Each MVC area has its own folder structure, keeping everything separate.

###Creating an Area###

Our Admin area folder contains a file called AdminAreaRegistration.cs

```
using System.Web.Mvc;

namespace UrlsAndRoutes.Areas.Admin {
    public class AdminAreaRegistration : AreaRegistration {
        public override string AreaName {
            get {
                return "Admin";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) {
            context.MapRoute(
                "Admin_default",
                "Admin/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
```

The RegisterArea method registers routes which will be unique to this area.

> Caution:  Route names should be unique between all areas and not just within an area.

Areas are registerd before routes:

```
protected void Application_Start() {
    AreaRegistration.RegisterAllAreas();
    RouteConfig.RegisterRoutes(RouteTable.Routes);
}
```

AreaRegistration.RegisterAllAreas will search for all classes derived from AreaRegistration. RegisterArea is called on each of them.

> **Caution:**  Calling RegisterRoutes before AreaRegistration.RegisterAllAreas will mean that requests for area controllers are likely to be matched incorrectly.

The AreaRegistrationContext class that is passed to each area’s RegisterArea method exposes a set of MapRoute methods that the area can use to register routes in the same way as your main application does in the RegisterRoutes method of Global.asax.Read more at location 13108

> **Note:** The MapRoute methods in the AreaRegistrationContext class automatically limit the routes you register to the namespace that contains the controllers for the area. Leave any controllers in their default namespace otherwise they won't be found.


###Resolving the Ambiguous Controller Issue###

When an area is registered, any routes that it defines are limited to the namespace associated with the area.

However, routes defined in the RegisterRoutes method of RouteConfig.cs are not similarly restricted.

To resolve prioritize the main controller namespace in all of the routes which might lead to a conflict.

```
routes.MapRoute("MyOtherRoute", "App/{action}", 
    new { controller = "Home" },
    new[] { "UrlsAndRoutes.Controllers" });
```

###Creating Areas with Attributes###

```
namespace UrlsAndRoutes.Controllers {
[RouteArea("Services")]
[RoutePrefix("Users")]
public class CustomerController : Controller 
{
```

The RouteArea attribute moves all of the routes defined by the Route attribute into the specified area.

I have to create a URL like this due to the route prefix: 

```
http://localhost:34855/Services/Users/Add/Adam/100
```

The RouteArea attribute doesn’t affect routes that are defined by the Route attribute but that start with ∼/.

The RouteArea attribute has no effect on action methods to which the Route attribute has not been defined.

###Generating Links to Actions in Areas###

Not special steps to create links that refer to actions in the same MVC area that the current request relates to.

The MVC Framework detects that a request relates to a particular area and ensures that outbound URL generation will find a match only among routes defined for that area.

```
@Html.ActionLink("Click me", "About")
```
Will generate the following HTML: 

```
<a href="/Admin/Home/About">Click me</a>
```

To create a link to an action in a different area, or no area at all:

```
@Html.ActionLink("Click me to go to another area", "Index", new { area = "Support" })
@Html.ActionLink("Click me to go to another area", "Index", new { area = "" })
```

##Routing Requests for Disk Files##

By default, the routing system checks to see if a URL matches a disk file before evaluating the application’s routes.

This behavior can be reversed by setting RouteExistingFiles property of the RouteCollection to true.

```
public static void RegisterRoutes(RouteCollection routes) {
    routes.RouteExistingFiles = true;
```

The convention is to place this statement close to the top of the RegisterRoutes method, although it will take effect even if you set it after you have defined your routes.

##Configuring the Application Server##

I also have to tell IIS Express not to intercept requests for disk files before they are passed to the MVC routing system.

Go to IIS exspress confi icon and go to the modules configuration file:

```
<add name="UrlRoutingModule-4.0" type="System.Web.Routing.UrlRoutingModule"     preCondition="" />
```

##Defining Routes for Disk Files##

We can now define routes matching disk files:

```
routes.MapRoute("DiskFile", "Content/StaticContent.html",
    new { controller = "Customer", action = "List", });
```

##Bypassing the Routing System##

By using the IgnoreRoute method of the RouteCollection class.

```
routes.IgnoreRoute("Content/{filename}.html");
routes.Add(new Route("SayHello", new CustomRouteHandler()));
```

The IgnoreRoute method creates an entry in the RouteCollection where the route handler is an instance of the StopRoutingHandler class, rather than MvcRouteHandler.

##URL Schema Best Practices##

###Make Your URLs Clean and Human-Friendly###

```
http://www.amazon.com/Pro-ASP-NET-MVC-Professional-Apress/dp/1430242361/ref=la_B001IU0SNK_1_5?ie=UTF8&qid=1349978167&sr=1-5
```

```
http://www.amazon.com/books/pro-aspnet-mvc5-framework
```

Design URLs to describe their content, not the implementation details of your application;  /Articles/AnnualReport rather than /Website_v2/CachedContentServer/FromCache/AnnualReport.

Prefer content titles over ID numbers;  /Articles/AnnualReport rather than /Articles/2392. If you require id provide both; /Articles/2392/AnnualReport.

Only use file name extensions for specialized file types (such as .jpg, .pdf, and .zip). Web browsers use MIME type and not file extension though humans prefer them.

Create a sense of hierarchy; /Products/Menswear/Shirts/Red).

Be case-insensitive; the ASP.NET routing system is case-insensitive by default.

Avoid symbols, codes, and character sequences. If you want a word separator, use a dash (as in /my-great-article). Underscores are unfriendly, and URL-encoded spaces are bizarre (/my+great+article) or disgusting (/my%20great%20article).

Do not change URLs. Broken links equal lost business. When you do change URLs, continue to support the old URL schema for as long as possible via permanent (301) redirections.

Be consistent. Adopt one URL format across your entire application.

Jakob Nielsen, usability guru, expands on this topic at http://www.useit.com/alertbox/990321.html

Tim Berners-Lee, inventor of the Web, offers similar advice; http://www.w3.org/Provider/Style/URI

##GET and POST: Pick the Right One##

The rule of thumb is that GET requests should be used for all read-only information retrieval, while POST requests should be used for any operation that changes the application state.

These conventions are set by the World Wide Web Consortium (W3C); http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html.

GET requests are addressable: all the information is contained in the URL, so it’s possible to bookmark and link to these addresses.

Authentication might protect you from this, but it wouldn’t protect you from Web accelerators.


#CHAPTER 17 Adding Security# {#Chap12}

##Securing the Administration Controller##

###DIGGING INTO THE ASP.NET SECURITY FEATURES###

####Applying Authorization with Filters####

The filter that interests me at the moment is the default authorization filter, Authorize.

```
[Authorize]     
public class AdminController : Controller
```

>**Note**  You can apply filters to an individual action method or to a controller. Applying to a controller is the same as applying to every action method in the controller.

###Creating the Authentication Provider ###

Forms authentication feature requires calls to two static methods of the System.Web.Security.FormsAuthentication class: 

 1. The Authenticate method validates credentials supplied by the user. 
 2. The SetAuthCookie method adds a cookie to the response to the browser, so that users do not need to authenticate every time they make a request.

Static methods are hard to unit test, even with mocking frameworks. Best to decouple with an interface.

```
namespace SportsStore.WebUI.Infrastructure.Abstract 
{
     public interface IAuthProvider {
         bool Authenticate(string username, string password);
     }
}
```

```
using System.Web.Security;
using SportsStore.WebUI.Infrastructure.Abstract; 
namespace SportsStore.WebUI.Infrastructure.Concrete
{
    public class FormsAuthProvider : IAuthProvider
    {
        public bool Authenticate(string username, string password) 
        {
            bool result = FormsAuthentication.Authenticate(username, password);
            if (result) {                 
                FormsAuthentication.SetAuthCookie(username, false);
            }
            return result;
        }
    }
}
```

The final step is to register the FormsAuthProvider in the AddBindings method of the NinjectDependencyResolver class,

```
kernel.Bind<IAuthProvider>().To<FormsAuthProvider>();
```

###Creating the Account Controller###

```
using System.ComponentModel.DataAnnotations;
namespace SportsStore.WebUI.Models {
    public class LoginViewModel {
        [Required]
        public string UserName { get; set; }
        [Required]
        public string Password { get; set; }
    }
}
```

Listing 12-8.  The the Contents of the AccountController.cs File 
````
using System.Web.Mvc; 
using SportsStore.WebUI.Infrastructure.Abstract; 
using SportsStore.WebUI.Models; 
namespace SportsStore.WebUI.Controllers
{
    public class AccountController : Controller
    {
        IAuthProvider authProvider;
        public AccountController(IAuthProvider auth) 
        {
            authProvider = auth;
        }
        public ViewResult Login() {
            return View();
        }
        
    [HttpPost]
    public ActionResult Login(LoginViewModel model, string returnUrl) 
    {
        if (ModelState.IsValid)
        {
            if (authProvider.Authenticate(model.UserName, model.Password)) 
            {
                return Redirect(returnUrl ?? Url.Action("Index", "Admin"));
            } else {
                ModelState.AddModelError("", "Incorrect details");
                return View();
            }
        } else {
	        return View();
	}
    }
   }
}
````

###Creating the View###

Listing 12-9.  The Contents of the Login.cshtml File 
```
@model SportsStore.WebUI.Models.LoginViewModel 

@{
     ViewBag.Title = "Admin: Log In";
     Layout = "∼/Views/Shared/_AdminLayout.cshtml"; 
} 

<div class="panel">
     <div class="panel-heading">
         <h3> Log In</h3>
     </div>
     <div class="panel-body">
         <p class="lead">Please log in to access the administration area:</p>
         @using (Html.BeginForm()) {
             @Html.ValidationSummary()
             <div class="form-group">
                 <label>User Name:</label>
                 @Html.TextBoxFor(m => m.UserName, new { @class = "form-control" })
             </div>
             <div class="form-group">
                 <label>Password:</label>
                 @Html.PasswordFor(m => m.Password, new { @class = "form-control" })
             </div>
             <input type="submit" value="Log in" class="btn btn-primary"/>
         }     
      </div> 
</div>
```


#CHAPTER 17 Controllers and Actions# {#Chap17}

The role of the controller is to encapsulate your application logic.

Controllers are responsible for processing incoming requests, performing operations on the domain model, and selecting views to render to the user.

Install the MVC package so tests have access to the base controller classes:

```
Install-Package Microsoft.Aspnet.Mvc -version 5.0.0 -projectname      ControllersAndActions.Tests
```

##Introducing the Controller##

###Creating a Controller with IController###

Controller classes must implement System.Web.Mvc.IController

```
public interface IController {
    void Execute(RequestContext requestContext);
}
```

The MVC Framework knows which controller class has been targeted in a request by reading the value of the controller property generated by the routing data,

```
using System.Web.Routing; 
namespace ControllersAndActions.Controllers {
    public class BasicController : IController {    
        public void Execute(RequestContext requestContext) 
        {           
            string controller = (string)requestContext.RouteData.Values["controller"];         
            string action = (string)requestContext.RouteData.Values["action"];
            requestContext.HttpContext.Response.Write(string.Format("Controller: {0}, Action: {1}", controller, action));
        }
    }
}
```

Properties of RequestContext:

|Name |Description |
|--|--|
|**HttpContext**| Returns an HttpContextBase object that describes the current request|
|**RouteData**| Returns a RouteData object that describes the route that matched the request|

The HttpContextBase object provides access to a set of objects that describe the current request, known as the context objects.

Properties of RouteData:

| Name |Description |
|--|--|
|**Route** |Returns the RouteBase implementation that matched the route|
| **RouteHandler** |Returns the IRouteHandler that handled the route |
|**Values** |Returns a collection of segment values, indexed by name|

To introduce testability with existing ASP.NET Web Forms applications the introduction of abstract Base classes and wrapper classes for creating instances of them.

The wrapper classes are derived from the Base classes and have constructors that accept an instance of the original class:

```
HttpContext myContext = getOriginalObjectFromSomewhere(); 
HttpContextBase myBase = new HttpContextWrapper(myContext);
```

The HttpContextBase.Response property returns an HttpResponseBase object that allows you to configure and add to the response that will be sent to the client. This is another touch-point between the ASP.NET platform and the MVC Framework.

##Creating a Controller by Deriving from the Controller Class##

Derive controllers from System.Web.Mvc.Controller.

The Controller class provides three key features:

- Action methods: A controller’s behavior is partitioned into multiple methods each exposed on a different URL and is invoked with parameters extracted from the incoming request. 
- Action results: return an object describing the result of an action which is then carried out on your behalf. 
- Filters: You can encapsulate reusable behaviors as filters which are applied as attributes.

```
using System.Collections.Generic;
using System.Linq; 
using System.Web; 
using System.Web.Mvc; 
namespace ControllersAndActions.Controllers {
    public class DerivedController : Controller {
        public ActionResult Index() {
            ViewBag.Message = "Hello";
            return View("MyView");
        }
    }
}
```

MyView.cshtml:

```
@{
    ViewBag.Title = "MyView";
} 

<h2>MyView</h2>
Message: @ViewBag.Message
```

##Receiving Request Data##

Incoming request data:
- Query string values
- Form values
- URL segments

Accessed via 
- Extract from the context objects
- Passed as parameters to an action method. 
- Explicitly invoke the framework’s model binding feature.

###Getting Data from Context Objects###

Controllers deriving from Controller provides access to a set of convenience properties to access information about the request;  Request, Response, RouteData, HttpContext, and Server.

Commonly Used Context Objects and Properties:

|Property |Type |Description |
|--|--|--|
|Request.QueryString |NameValueCollection GET variables sent with this request |
|Request.Form |NameValueCollection |POST variables sent with this request |
|Request.Cookies |HttpCookieCollection |Cookies sent by the browser with this request|
| Request.HttpMethod |string |The HTTP method (verb, such as GET or POST) used for this request |
|Request.Headers |NameValueCollection |The full set of HTTP headers sent with this request |
|Request.Url| Uri |The URL requested |
|Request.UserHostAddress |string |The IP address of the user making this request |
|RouteData.Route |RouteBase |The chosen RouteTable.Routes entry for this request |
|RouteData.Values |RouteValueDictionary |Active route parameters (either extracted from the URL or default values) |
|HttpContext.Application |HttpApplicationStateBase |Application state store |
|HttpContext.Cache |Cache |Application cache store|
| HttpContext.Items |IDictionary |State store for the current request |
|HttpContext.Session |HttpSessionStateBase |State store for the visitor’s session |
|User |IPrincipal |Authentication information about the logged-in user TempData TempDataDictionary Temporary data items stored for the current user|

```
public ActionResult RenameProduct() {
     // Access various properties from context objects
     string userName = User.Identity.Name;
     string serverName = Server.MachineName;
     string clientIP = Request.UserHostAddress;
     DateTime dateStamp = HttpContext.Timestamp;
     
     AuditRequest(userName, serverName, clientIP, dateStamp, "Renaming product");
     
     // Retrieve posted data from Request.Form
     string oldProductName = Request.Form["OldName"];
     string newProductName = Request.Form["NewName"];
     bool result = AttemptProductRename(oldProductName, newProductName);
     
     ViewData["RenameResult"] = result;
     
     return View("ProductRenamed"); }
```

###Using Action Method Parameters###

```
var city = (string)RouteData.Values["city"];
var forDate  = DateTime.Parse(Request.Form["forDate"]);
```

Can be changed to:

```
public ActionResult ShowWeatherForcast(string city, DateTime forDate)
{
    //...
}
```

> **Note:** action methods aren’t allowed to have out or ref parameters; MVC Framework throws an exception.

The MVC Framework will provide values for action method parameters by checking the context objects and properties automatically, including Request.QueryString, Request.Form, and RouteData.Values. 

The names of the parameters are treated case-insensitively, so an action method parameter called city can be populated by a value from Request.Form["City"].

####Understanding How Parameters Objects Are Instantiated####

There are built-in value providers that fetch items from Request.Form, Request.QueryString, Request.Files, and RouteData.Values. The values are then passed to model binders that try to map them to the types that your action methods require as parameters.

The default model binders can create and populate objects of any .NET type, including collections and project-specific custom types.

Chapter 11 showed form data posted to single Product object, even though the individual values were dispersed among a few elements.

####Understanding Optional and Compulsory Parameters####

If the MVC Framework cannot find a value for a reference type parameter (such as a string or object), the action method will still be called, but using a null value for that parameter.

If a value cannot be found for a value type parameter (such as int or double), then an exception will be thrown, and the action method will not be called.

Value-type parameters are compulsory. To make them optional, either specify a default value (see the next section) or change the parameter type to a nullable type (such as int? or DateTime?), so the MVC Framework can pass null if no value is available.

Reference-type parameters are optional. To make them compulsory (to ensure that a non-null value is passed), add some code to the top of the action method to reject null values.

####Specifying Default Parameter Values####

```
public ActionResult Search(string query = "all" , int page = 1) {
     // ...process request...     
     return View();
} 
```

You mark parameters as optional by making them optional in the method signature.

The MVC Framework will try to obtain values from the request for these parameters, but if there are no values available, the defaults specified will be used instead.

> **Caution:** If a request contains a value but cannot be converted then the default value will be used and will register the attempted value as a validation error in a special context object called ModelState.Read 

##Producing Output##

```
﻿using System.Web.Mvc;
using System.Web.Routing;

namespace ControllersAndActions.Controllers {

    public class BasicController : IController {

        public void Execute(RequestContext requestContext) {

            string controller = (string)requestContext.RouteData.Values["controller"];
            string action = (string)requestContext.RouteData.Values["action"];

            if (action.ToLower() == "redirect") {
                requestContext.HttpContext.Response.Redirect("/Derived/Index");
            } else {
                requestContext.HttpContext.Response.Write(
                    string.Format("Controller: {0}, Action: {1}",
                    controller, action));
            }
        }
    }
}
```

The HttpResponseBase class that is returned when you read the requestContext.HttpContext.Response property in your Execute method is available through the Controller.Response property.

```
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ControllersAndActions.Infrastructure;

namespace ControllersAndActions.Controllers {
    public class DerivedController : Controller {

        public ActionResult Index() {
            ViewBag.Message = "Hello from the DerivedController Index method";
            return View("MyView");
        }

        public ActionResult ProduceOutput() {
            return Redirect("/Basic/Index");
        } 
    }
}
```

The controller classes must contain details of HTML or URL structure, which makes the classes harder to read and maintain. It is hard to unit test a controller that generates its response directly to the output. You need to create mock implementations of the Response object, and then be able to process the output you receive from the controller in order to determine what the output represents. This can mean parsing HTML for keywords, for example, which is a drawn-out and painful process. Handling the fine detail of every response this way is tedious and error-prone. Some programmers will like the absolute control that building a raw controller gives, but normal people get frustrated pretty quickly.

Fortunately, the MVC Framework has a nice feature that addresses all of these issues, called action results.

###Understanding Action Results###

The MVC Framework uses action results to separate stating intentions from executing intentions.

Instead of working directly with the Response object, action methods return an object derived from the ActionResult class that describes what the response from controller will be, such as rendering a view or redirecting to another URL or action method.

Indirection comes in—you don’t generate the response directly. Instead, you create an ActionResult object that the MVC Framework processes to produce the result for you, after the action method has been invoked.

>**Note**  The system of action results is an example of the command pattern. This pattern describes scenarios where you store and pass around objects that describe operations to be performed. See http://en.wikipedia.org/wiki/Command_pattern for more details.

When the MVC Framework receives an ActionResult object from an action method, it calls the ExecuteResult method defined by that object.

The action result implementation then deals with the Response object for you, generating the output that corresponds to your intention.

```
﻿using System.Web.Mvc;

namespace ControllersAndActions.Infrastructure {
    public class CustomRedirectResult : ActionResult {

        public string Url { get; set; }

        public override void ExecuteResult(ControllerContext context) {
            string fullUrl = UrlHelper.GenerateContentUrl(Url, context.HttpContext);
            context.HttpContext.Response.Redirect(fullUrl);
        }
    }
}
```

```
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ControllersAndActions.Infrastructure;

namespace ControllersAndActions.Controllers {
    public class DerivedController : Controller {

        public ActionResult Index() {
            ViewBag.Message = "Hello from the DerivedController Index method";
            return View("MyView");
        }

        public ActionResult ProduceOutput() {
            return new CustomRedirectResult("/Basic/Index");
        } 
    }
}
```

###UNIT TESTING CONTROLLERS AND ACTIONS###

There are a few reasons for this support:

- You can test actions and controllers outside a web server. The context objects are accessed through their base classes (such as HttpRequestBase), which are easy to mock.
- You do not need to parse any HTML to test the result of an action method. You can inspect the ActionResult object that is returned to ensure that you received the expected result.
- You do not need to simulate client requests. The MVC Framework model binding system allows you to write action methods that receive input as method parameters.

Using the Built-in RedirectResult Object in the DerivedController.cs 

```
public ActionResult ProduceOutput()
{
    return new RedirectResult("/Basic/Index");
}
```


To make action method code simpler, the Controller class includes convenience methods for generating different kinds of ActionResult objects.

```
public ActionResult ProduceOutput()
{
    return  Redirect("/Basic/Index");
}
```

Built-in ActionResult Types:

|Type |Description| Helper Methods|
|---------|----------------|-------------------------|
|ViewResult| Renders the specified or default view template| View|
|PartialViewResult| Renders the specified or default partial view template| PartialView|
| RedirectToRouteResult |Issues an HTTP 301 or 302 redirection to an action method or specific route entry, generating a URL according to your routing configuration RedirectToAction |RedirectToActionPermanent |
|RedirectToRoute| RedirectToRoutePermanent RedirectResult Issues an HTTP 301 or 302 redirection to a specific URL Redirect |RedirectPermanent |
|ContentResult| Returns raw textual data to the browser, optionally setting a content-type header  |Content|
|FileResult| Transmits binary data (such as a file from disk or a byte array in memory) directly to the browser  |File |
|JsonResult |Serializes a .NET object in JSON format and sends it as the response. This kind of response is more typically generated using the Web API feature, which I describe in Chapter 27, but you can see this action type used in Chapter 23.| Json |
|JavaScriptResult| Sends a snippet of JavaScript source code that should be executed by the browser |JavaScript| 
|HttpUnauthorizedResult| Sets the response HTTP status code to 401 (meaning “not authorized”), which causes the active authentication mechanism (forms authentication or Windows authentication) to ask the visitor to log in  |None |
|HttpNotFoundResult| Returns a HTTP 404—Not found error |HttpNotFound | 
|HttpStatusCodeResult| Returns a specified HTTP code None EmptyResult Does nothing |None |


###Returning HTML by Rendering a View###

```
﻿using System;
using System.Web.Mvc;

namespace ControllersAndActions.Controllers {

    public class ExampleController : Controller {

        public ViewResult Index() {

            ViewBag.Message = "Hello";
            ViewBag.Date = DateTime.Now;

            return View();
        }

        public RedirectToRouteResult Redirect() {
            return RedirectToAction("Index", "Basic");
        }

        public HttpStatusCodeResult StatusCode() {
            return new HttpUnauthorizedResult();
        }
    }
}

```

When the MVC Framework calls the ExecuteResult method of the ViewResult object, a search will begin for the view that you have specified. If you are using areas in your project, then the framework will look in the following locations: 

- /Areas/ <AreaName> /Views /<ControllerName> / <ViewName> .aspx 
- /Areas/ <AreaName> /Views/ <ControllerName> / <ViewName> .ascx
- /Areas/ <AreaName> /Views/Shared/ <ViewName> .aspx 
- /Areas/ <AreaName> /Views/Shared/ <ViewName> .ascx
- /Areas/ <AreaName> /Views/ <ControllerName> / <ViewName> .cshtml 
- /Areas/ <AreaName> /Views/ <ControllerName> / <ViewName> .vbhtml 
- /Areas/ <AreaName> /Views/Shared/<ViewName>.cshtml 
- /Areas/ <AreaName> /Views/Shared/ <ViewName> .vbhtml

If you are not using areas, or you are using areas but none of the files in the preceding list have been found, then the framework continues its search, using the following locations: 

- /Views/ <ControllerName> / <ViewName> .aspx 
- /Views/<ControllerName>/<ViewName>.ascx 
- /Views/Shared/ <ViewName> .aspx /Views/Shared/ <ViewName> .ascx 
- /Views/ <ControllerName> / <ViewName> .cshtml 
- /Views/ <ControllerName> / <ViewName> .vbhtml 
- /Views/Shared/ <ViewName> .cshtml 
- /Views/Shared/ <ViewName> .vbhtml

Notice that the Controller part of the class name is omitted, so that creating a ViewResult in ExampleController leads to a search for a directory called Example

###UNIT TEST: RENDERING A VIEW###

To test the view that an action method renders, you can inspect the ViewResult object that it returns.

```
[TestMethod]
        public void ControllerTest() {

            // Arrange - create the controller
            ExampleController target = new ExampleController();

            // Act - call the action method
            HttpStatusCodeResult result = target.StatusCode();

            // Assert - check the result
            Assert.AreEqual(401, result.StatusCode);
        }
```

A slight variation arises when you are testing an action method that selects the default view, like this:

```
Assert.AreEqual("", result.ViewName);
```


The sequence of directories that the MVC Framework searches for a view is another example of convention over configuration.


```
return View();    
```

The MVC Framework assumes that I want to render a view that has the same name as the action method. This means that the call to the View method in Listing 17-14 starts a search for a view called Index.

>**Note**  The MVC Framework actually gets the name of the action method from the RouteData.Values["action"] value,

The action method name and the routing value will be the same if you are using the built-in routing classes, but this may not be the case if you have implemented custom routing classes which do not follow the MVC Framework conventions.

You can override the layout used by a view by explicitly naming an alternative,

```
return View("Index", "_AlternateLayoutPage");
```


###SPECIFYING A VIEW BY ITS PATH###

If you want to render a specific view, you can do so by providing an explicit path and bypass the search phase.

```
return View("∼/Views/Other/Index.cshtml");
```

When you specify a view like this, the path must begin with / or ∼/ and include the file name extension (such as .cshtml for Razor views containing C# code).

You might be better off redirecting the user to an action method in that controller (see the “Redirecting to an Action Method”)

If you are trying to work around the naming scheme because it doesn’t suit the way you have organized your project, then see Chapter 20, which explains how to implement a custom search sequence.

###Passing Data from an Action Method to a View###

####Providing a View Model ObjectRead more at location 14188


```
DateTime date = DateTime.Now;             
return View(date);
```

I can access the object in the view using the Razor Model keyword.

```
The day is: @(((DateTime)Model).DayOfWeek)
```

This is an untyped or weakly typed view. The view does not know anything about the view model object, and treats it as an instance of object.

I can tidy this up by creating strongly typed views.

```
@model DateTime 

@{
    ViewBag.Title = "Index";
} 

<h2>Index</h2> The day is: @Model.DayOfWeek
```

##UNIT TEST: VIEW MODEL OBJECTS##

You can access the view model object passed from the action method to the view through the ViewResult.ViewData.Model property.

```
[TestMethod]
public void ViewSelectionTest() {

// Arrange - create the controller
ExampleController target = new ExampleController();

// Act - call the action method
ViewResult result = target.Index();

// Assert - check the result
Assert.AreEqual("", result.ViewName);
Assert.IsInstanceOfType(result.ViewData.Model, typeof(System.DateTime));
}
```


###Passing Data with the View Bag###

```
ViewBag.Message = "Foo";
ViewBag,Moo = "Boo";

```

The ViewBag has an advantage over using a view model object in that it is easy to send multiple objects to the view.

Visual Studio cannot provide IntelliSense support for any dynamic objects, including the ViewBag, and errors such as this won’t be revealed until the view is rendered.

###UNIT TEST: VIEWBAG###

You can read values from the ViewBag through the ViewResult.ViewBag property.

```
ViewResult result = target.Index();
Assert.AreEqual("Hello", result.ViewBag.Message);
```

###Performing Redirections###

####THE POST/REDIRECT/GET PATTERN####

You just return HTML following the processing of a request, you run the risk that the user will click the browser’s reload button and resubmit the form a second time, causing unexpected and undesirable results.

To avoid this problem, you can follow the pattern called Post/Redirect/Get. In this pattern,

When you perform a redirect, you send one of two HTTP codes to the browser: Send the HTTP code 302, which is a temporary redirection. This is the most frequently used type of redirection and when using the Post/Redirect/Get pattern, this is the code that you want to send. Send the HTTP code 301, which indicates a permanent redirection. This should be used with caution, because it instructs the recipient of the HTTP code not to request the original URL ever again and to use the new URL that is included alongside the redirection code.

###Redirecting to a Literal URL###

```
public RedirectResult Redirect()
{             
    return Redirect("/Example/Index");
}
```

The Redirect method sends a temporary redirection. You can send a permanent redirection using the RedirectPermanent method,

```
return RedirectPermanent("/Example/Index");
```

> Tip  If you prefer, you can use the overloaded version of the Redirect method, which takes a bool parameter that specifies whether or not a redirection is permanent.

###UNIT TEST: LITERAL REDIRECTIONS###


```
RedirectResult result = target.Redirect();     
Assert.IsTrue(result.Permanent);     
Assert.AreEqual("/Example/Index", result.Url); }
```

##Redirecting to a Routing System URL###

The problem with using literal URLs for redirection is that any change in your routing schema means that you need to go through your code and update the URLs.

Fortunately, you can use the routing system to generate valid URLs with the RedirectToRoute method, which creates an instance of the RedirectToRouteResult,

```
public RedirectToRouteResult Redirect() {
    return RedirectToRoute(new { controller = "Example", action = "Index", ID = "MyID" });
}
```

The RedirectToRoute method issues a temporary redirection. Use the RedirectToRoutePermanent method for permanent redirections.

Both methods take an anonymous type whose properties are then passed to the routing system to generate a URL.

###UNIT TESTING: ROUTED REDIRECTIONS###

```
// Arrange - create the controller     
ExampleController target = new ExampleController();     

// Act - call the action method     
RedirectToRouteResult result = target.Redirect();     

// Assert - check the result     
Assert.IsFalse(result.Permanent);     
Assert.AreEqual("Example", result.RouteValues["controller"]);     
Assert.AreEqual("Index", result.RouteValues["action"]);     
Assert.AreEqual("MyID", result.RouteValues["ID"]); }
```

###Redirecting to an Action Method###

You can redirect to an action method more elegantly by using the RedirectToAction method (for temporary redirections) or the RedirectToActionPermanent (for permanent redirections). These are just wrappers around the RedirectToRoute method that lets you specify values for the action method and the controller without needing to create an anonymous type,

```
public RedirectToRouteResult Redirect() 
{     
    return RedirectToAction("Index"); 
} 
```

If you just specify an action method, then it is assumed that you are referring to an action method in the current controller.

```
public RedirectToRouteResult Redirect() {     
    return RedirectToAction("Index", "Basic"); 
}
```

There are other overloaded versions that you can use to provide additional values for the URL generation.

> **Note**  The values that you provide for the action method and controller are not verified before they are passed to the routing system.


###PRESERVING DATA ACROSS A REDIRECTION###

A redirection causes the browser to submit an entirely new HTTP request, which means that you do not have access to the details of the original request. If you want to pass data from one request to the next, you can use the Temp Data feature.

TempData is similar to Session data, except that TempData values are marked for deletion when they are read, and they are removed when the request has been processed.

```
public RedirectToRouteResult RedirectToRoute() {     
    TempData["Message"] = "Hello";     
    TempData["Date"] = DateTime.Now;
    RedirectToAction("Index"); } 
```

```
public ViewResult Index() {     
    ViewBag.Message = TempData["Message"];     
    ViewBag.Date = TempData["Date"];     
    return View(); }
```

A more direct approach would be to read these values in the view, like this: 

```
@{     
    ViewBag.Title = "Index"; 
} 

<h2>Index</h2> 

The day is: @(((DateTime) TempData["Date"]).DayOfWeek) <p /> 

The message is: @TempData["Message"]
```

You must cast the TempData results to an appropriate type.

You can get a value from TempData without marking it for removal by using the Peek method, like this:

```
DateTime time = (DateTime)TempData.Peek("Date");
```

You can preserve a value that would otherwise be deleted by using the Keep method, like this:

```
TempData.Keep("Date");
```

The Keep method doesn’t protect a value forever. If the value is read again, it will be marked for removal once more. If you want to store items so that they won’t be removed when the request is processed then use session data instead.

###Returning Errors and HTTP Codes###

####Sending a Specific HTTP Result Code####

You can send a specific HTTP status code to the browser using the HttpStatusCodeResult class.

```
public HttpStatusCodeResult StatusCode() {             
    return new HttpStatusCodeResult(404, "URL cannot be serviced");
}
```

####Sending a 404 Result####


HttpNotFoundResult class, which is derived from HttpStatusCodeResult

and can be created using the controller HttpNotFound convenience method

```
public HttpStatusCodeResult StatusCode() 
{     
    return HttpNotFound(); 
} 
```

####Sending a 401 Result####

Another wrapper class for a specific HTTP status code is the HttpUnauthorizedResult, which returns the 401 code,


```
public HttpStatusCodeResult StatusCode()
{     
    return new HttpUnauthorizedResult(); 
}
```

####UNIT TEST: HTTP STATUS CODES###

The StatusCode property returns the numeric HTTP status code, and the StatusDescription property returns the associated descriptive string.

```
[TestMethod] public void ControllerTest() 
{
     // Arrange - create the controller
     ExampleController target = new ExampleController();

     // Act - call the action method
     HttpStatusCodeResult result = target.StatusCode();

     // Assert - check the result
     Assert.AreEqual(401, result.StatusCode);
} 
```

#CHAPTER 18 Filters# {#Chap18}

Filters inject extra logic into MVC Framework request processing. They provide a simple and elegant way to implement cross-cutting concerns.

Classic examples of cross-cutting concerns are logging, authorization, and caching.

```
<system.web>
    <compilation debug="true" targetFramework="4.5.1" />
    <httpRuntime targetFramework="4.5.1" />
    <authentication mode="Forms">
      <forms loginUrl="~/Account/Login" timeout="2880">
        <credentials passwordFormat="Clear">
          <user name="user"  password="secret"/>
          <user name="admin" password="secret" />
        </credentials>
      </forms>
    </authentication>
    <customErrors mode="On" defaultRedirect="/Content/RangeErrorPage.html"/>
  </system.web>
```

I have used the loginUrl attribute to specify that unauthenticated requests should be redirected to the /Account/Login URL.

```
﻿using System.Web.Mvc;
using System.Web.Security;

namespace Filters.Controllers {
    public class AccountController : Controller {

        public ActionResult Login() {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string password, string returnUrl) {
            bool result = FormsAuthentication.Authenticate(username, password);
            if (result) {
                FormsAuthentication.SetAuthCookie(username, false);
                return Redirect(returnUrl ?? Url.Action("Index", "Admin"));
            } else {
                ModelState.AddModelError("", "Incorrect username or password");
                return View();
            }
        }
    }
}
```

```
File @{     
    Layout = null;
    } 

<!DOCTYPE html>
<html>
    <head>     
	<meta name="viewport" content="width=device-width" />     
        <title></title> 
    </head> 
<body>     

@using (Html.BeginForm()) {
    @Html.ValidationSummary()
    <p><label>Username:</label><input name="username" /></p>
    <p><label>Password:</label><input name="password" type="password"/></p>
    <input type="submit" value="Log in" />
}
</body>
</html>
```


##Using Filters##

I could have checked the authorization status of the request in each and every action method,


```
public ViewResult Index() {
             if (!Request.IsAuthenticated) {
                 FormsAuthentication.RedirectToLoginPage();
             }
             // ...rest of action method
         }
```

There is a lot of repetition which can be removed by using a filter:


```
namespace SportsStore.WebUI.Controllers
{
     [Authorize]
     public class AdminController : Controller {
         // ... instance variables and constructor
```

Filters are .NET attributes that add extra steps to the request processing pipeline.

##Introducing the Filter Types##

|Filter Types | Interface | Default Implementation | Description |
|---------------|--------------|---------------------------------|----------------|
|Authentication | IAuthenticationFilter | N/A | Runs first before other filters or action method, but can be run again after the authorisation filters |
|Authorizarion| IAuthorizationFilter | AuthorizeAttribute | Runs after authentication but before other filters or the action method |
|Action | IActionFilter | ActionFilterAttributes | Runs before and after the action method |
|Result | IResultFiter | ActionFilterAttribute | Runs before and after the action result is executed |
|Exception | IExceptionFilter | HandleErrorAttribute | Runs only if another filter, the action method or the action result throws an exception |


Before the MVC Framework invokes an action, it inspects the method definition to see if it has attributes that implement the interfaces listed above; methods defined by these interfaces are invoked.

> **Tip**  MVC 5 introduces a new interface, IoverrideFilter,

The ActionFilterAttribute class implements both the IActionFilter and IResultFilter interfaces. This class is abstract, which forces you to provide an implementation. The AuthorizeAttribute and HandleErrorAttribute classes contain useful features and can be used without creating a derived class.

##Applying Filters to Controllers and Action Methods##

Filters can be applied to individual action methods or to an entire controller.

The Authorize filter was added  to the AdminController class, which has the same effect as applying it to each action method in the controller,

> **Note**  If you have defined a custom base class for your controllers, any filters applied to the base class will affect the derived classes.

##Using Authorization Filters##

Authorization filters are run after the authentication filters, before action filters and before the action method is invoked; ensuring that action methods can be invoked only by approved users.

```
IAuthorizationFilter Interface namespace System.Web.Mvc {
     public interface IAuthorizationFilter {
         void OnAuthorization(AuthorizationContext filterContext);
     }
}
```

```
﻿using System.Web;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class CustomAuthAttribute : AuthorizeAttribute {
        private bool localAllowed;

        public CustomAuthAttribute(bool allowedParam) {
            localAllowed = allowedParam;
        }

        protected override bool AuthorizeCore(HttpContextBase httpContext) {
            if (httpContext.Request.IsLocal) {
                return localAllowed;
            } else {
                return true;
            }
        }
    }
}

```

##KEEPING AUTHORIZATION ATTRIBUTES SIMPLE##

HttpContextBase object, which provides access to information about the request, but not about the controller or action method that the authorization attribute has been applied to. The main reason that developers implement the IAuthorizationFilter interface directly is to get access to the AuthorizationContext passed to the OnAuthorization method, through which a much wider range of information can be obtained, including routing details and the current controller and action method.

I do not recommend this approach, and not just because I think writing your own security code is dangerous. Although authorization is a cross-cutting concern, building logic into your authorization attributes which is tightly coupled to the structure of your controllers undermines the separation of concerns and causes testing and maintenance problems. Keep your authorization attributes simple and focused on authorization based on the request. Let the context of what is being authorized come from where the attribute is applied.

##Applying the Custom Authorization Filter##

To use the custom authorization filter, I simply apply an attribute to the action methods or controllers that I want to protect,

```
[CustomAuth(false)]
public string Index() {
return "This is the Index action on the Home controller";
}
```

The filter has denied authorization for the request and the MVC Framework has responded in the only way it knows how: by prompting the user for credentials.

##Using the Built-in Authorization Filter##

When using the AuthorizeAttribute directly, I can specify an authorization policy using two public properties of this class,

|Name| Type| Description|
|--------|-------|---------------| 
|Users| string| A comma-separated list of usernames that are allowed to access the action method.| 
|Roles |string |A comma-separated list of role names. To access the action method, users must be in at least one of these roles.|

```
[Authorize(Users = "admin")]
public string Index() { 
    return "This is the Index action on the Home controller";
}
```

There is an implicit condition as well: the request is authenticated.

If I do not specify any users or roles, then any authenticated user can use the action method.

##Using Authentication Filters##

Authentication filters are new in MVC version 5 and provide the means to provide fine-grain control over how users are authenticated for controllers and actions in an application.

Authentication filters have a relatively complex lifecycle. They are run before any other filter, which lets you define an authentication policy that will be applied before any other type of filter is used.

Authentication filters can also be combined with authorization filters to provide authentication challenges for requests that don’t comply to the authorization policy.

Authentication filters are also run after an action method has been executed but before the ActionResult is processed.

##Understanding the IAuthenticationFilter Interface##


```
namespace System.Web.Mvc.Filters {
     public interface IAuthenticationFilter {
         void OnAuthentication(AuthenticationContext context);
         void OnAuthenticationChallenge(AuthenticationChallengeContext context);
     }
 }
```

The OnAuthenticationChallenge method is called by the MVC Framework whenever a request has failed the authentication or authorization policies for an action method.

The OnAuthenticationChallenge method is passed an AuthenticationChallengeContext object, which is derived from the ControllerContext class

|Name |Description |
|--------|----------------|
|ActionDescriptor| Returns an ActionDescriptor that describes the action method to which the filter has been applied|
|Result| Sets an ActionResult that expresses the result of the authentication challenge|

The most important property is Result, because it allows the authentication filter to pass an ActionResult to the MVC Framework, a process known as short-circuiting. 

The best way of explaining how an authentication filter works is through an example. To my mind, the most interesting aspect of authentication filters is that they allow a single controller to define action methods that are authenticated in different ways, so my first step is to add a new controller that simulates Google logins. In

```
﻿using System.Web.Mvc;
using System.Web.Security;

namespace Filters.Controllers {
    public class GoogleAccountController : Controller {

        public ActionResult Login() {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string password, string returnUrl) {
            if (username.EndsWith("@google.com") && password == "secret") {
                FormsAuthentication.SetAuthCookie(username, false);
                return Redirect(returnUrl ?? Url.Action("Index", "Home"));
            } else {
                ModelState.AddModelError("", "Incorrect username or password");
                return View();
            }
        }
    }
}
```


I have created a terrible hack that will authenticate any user name that ends with @google.com as long as it is provided with the password secret.

I created a new class file called GoogleAuthAttribute.cs,

The FilterAttribute class, from which my GoogleAuth filter is derived, is the base for all filter classes.


```
﻿using System;
using System.Security.Principal;
using System.Web.Mvc;
using System.Web.Mvc.Filters;
using System.Web.Routing;
using System.Web.Security;

namespace Filters.Infrastructure {

    public class GoogleAuthAttribute : FilterAttribute, IAuthenticationFilter {

        public void OnAuthentication(AuthenticationContext context) {
            IIdentity ident = context.Principal.Identity;
            if (!ident.IsAuthenticated || !ident.Name.EndsWith("@google.com")) {
                context.Result = new HttpUnauthorizedResult();
            }
        }

        public void OnAuthenticationChallenge(AuthenticationChallengeContext context) {
            if (context.Result == null || context.Result is HttpUnauthorizedResult) {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary {
                    {"controller", "GoogleAccount"}, 
                    {"action",  "Login"}, 
                    {"returnUrl", context.HttpContext.Request.RawUrl}
                });
            } else {
                FormsAuthentication.SignOut();
            }
        }
    }
}
```


OnAuthenticationChallenge method checks to see if the Result property of the AuthenticationChallengeContext argument has been set. This allows me to avoid challenging the user when the filter is run after the action method has executed.

What’s important for this section is that I use the OnAuthenticationChallenge method to challenge the user for credentials by redirecting their browser to my GoogleAccount controller with a RedirectToRouteResult. Authentication filters can use all of the ActionResult types that I described in Chapter 17, but the Controller convenience methods for creating them are not available, which is why I had to use a RouteValueDictionary object to specify the segment values so that a route to the challenge action method can be generated.

##Implementing the Authentication Check##



|Name| Description|
|--------|----------------| 
|ActionDescriptor |Returns an ActionDescriptor that describes the action method to which the filter has been applied|
|Principal| Returns an IPrincipal implementation that identifies the current user, if they have already been authenticated.|
|Result| Sets an ActionResult that expresses the result of the authentication check|

If the OnAuthentication sets a value for the Result property of the context object, then the MVC Framework will call the OnAuthenticationChallenge method. If the OnAuthenticationChallenge method doesn’t set a value for the Result property on its context object, then the one from the OnAuthentication method will be executed.

I use the OnAuthentication method to create a result that reports an authentication error to the user, which can then be overridden by the OnAuthenticationChallenge method to challenge the user for credentials instead. This allows me to be sure that they see a meaningful response, even if no challenge can be issued (although I must admit that I have yet to encounter a situation where this has happened).

See above; code was augmented between examples.


```
[Authorize(Users = "admin")]
public string Index() {
    return "This is the Index action on the Home controller";
}

[GoogleAuth]
public string List() {
    return "This is the List action on the Home controller";
}
```


##Combining Authentication and Authorization Filters##

The MVC Framework will call the OnAuthentication method of the authentication filter, just as in the previous example, and move on to run the authorization filter if the request passes the authentication check.


If the request doesn’t pass the authorization filter, then the OnAuthenticationChallenge method of the authentication filter will be called so that you can challenge the user for the required credentials.

```
[GoogleAuth]
[Authorize(Users = "bob@google.com")]
public string List() {
    return "This is the List action on the Home controller";
}
```

The Authorize filter restricts access to the bob@google.com account. If the action method is targeted by another Google account, then the authentication filter OnAuthenticationChallenge method will be passed an AuthenticationChallengeContext object whose Result property is set to an instance of the HttpUnauthorizedResult class (which is why I used the same class in the OnAuthentication method).

The filters in the Home controller restrict access to the Index method to the user admin, who is authenticated using the AccountController, and restrict access to the List method to the bob@google.com user, who is authenticated through the GoogleAccount controller.

##Handling the Final Challenge Request##

The MVC Framework calls the OnAuthenticationChallenge method one final time after the action method has been executed, but before the ActionResult is returned and executed. This provides authentication filters an opportunity to respond to the fact that the action has completed or even alter the result (something that is also possible with result filters, which I describe later in the chapter). It is for this reason that I check the Result property of the AuthenticationChallengeContext object in the OnAuthenticationChallenge method. If I did not, I end up challenging the user for credentials once again, which makes little sense given that the action method has already been executed by this point. The only reason I have found for responding to this last method call is to clear the authentication for the request, which can be useful when important action methods require temporarily elevated credentials that you want entered each and every time the action is to be executed. 

```
﻿using System;
using System.Security.Principal;
using System.Web.Mvc;
using System.Web.Mvc.Filters;
using System.Web.Routing;
using System.Web.Security;

namespace Filters.Infrastructure {

    public class GoogleAuthAttribute : FilterAttribute, IAuthenticationFilter {

        public void OnAuthentication(AuthenticationContext context) {
            IIdentity ident = context.Principal.Identity;
            if (!ident.IsAuthenticated || !ident.Name.EndsWith("@google.com")) {
                context.Result = new HttpUnauthorizedResult();
            }
        }

        public void OnAuthenticationChallenge(AuthenticationChallengeContext context) {
            if (context.Result == null || context.Result is HttpUnauthorizedResult) {
                context.Result = new RedirectToRouteResult(new RouteValueDictionary {
                    {"controller", "GoogleAccount"}, 
                    {"action",  "Login"}, 
                    {"returnUrl", context.HttpContext.Request.RawUrl}
                });
            } else {
                FormsAuthentication.SignOut();
            }
        }
    }
}
```


##Using Exception Filters##

Exception filters are run only if an unhandled exception has been thrown when invoking an action method.

The exception can come from the following locations: Another kind of filter (authorization, action, or result filter) The action method itself When the action result is executed (see Chapter 17 for details on action results)

###Creating an Exception Filter###


Exception filters implement the IExceptionFilter interface.

```
namespace System.Web.Mvc {
     public interface IExceptionFilter {
         void OnException(ExceptionContext filterContext);
     }
 }
```

The OnException method is called when an unhandled exception arises. The parameter for this method is an ExceptionContext object, which is derived from ControllerContext


|Name| Type| Description|
|--|--|--|
| Controller |ControllerBase| Returns the controller object for this request|
| HttpContext| HttpContextBase| Provides access to details of the request and access to the response|
| IsChildAction| bool| Returns true if this is a child action (see Chapter 20) |
|RequestContext| RequestContext| Provides access to the HttpContext and the routing data, both of which are available through other properties |
|RouteData| RouteData| Returns the routing data for this request |

In addition to the properties inherited from the ControllerContext class, the ExceptionContext class defines some additional properties which are useful with dealing with exceptions,

|Name| Type| Description|
|--|--|--|
| ActionDescriptor| ActionDescriptor |Provides details of the action method |
|Result| ActionResult| The result for the action method; a filter can cancel the request by setting this property to a non-null value|
| Exception| Exception| The unhandled exception |
|ExceptionHandled| bool| Returns true if another filter has marked the exception as handled |

An exception filter can report that it has handled the exception by setting the ExceptionHandled property to true.

All of the exception filters applied to an action are invoked even if this property is set to true, so it is good practice to check whether another filter has already dealt with the problem, to avoid attempting to recover from a problem that another filter has resolved.

> **Note**  If none of the exception filters for an action method set the ExceptionHandled property to true, the MVC Framework uses the default ASP.NET exception handling procedure which will display the dreaded “yellow screen of death.”

The Result property is used by the exception filter to tell the MVC Framework what to do. The two main uses for exception filters are to log the exception and to display a message to the user.

```
﻿using System;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class RangeExceptionAttribute : FilterAttribute, IExceptionFilter {

        public void OnException(ExceptionContext filterContext) {

            if (!filterContext.ExceptionHandled &&
                    filterContext.Exception is ArgumentOutOfRangeException) {
                        filterContext.Result = new RedirectResult("~/Content/RangeErrorPage.html");		
                        filterContext.ExceptionHandled = true;
            }
        }
    }
}

```

In order for a .NET attribute class to be treated as an MVC filter, the class has to implement the IMvcFilter interface. You can do this directly, but the easiest way to create a filter is to derive your class from FilterAttribute, which implements the required interface and provides some useful basic features, such as handling the default order in which filters are processed

###Applying the Exception Filter###

```
[RangeException]
public string RangeTest(int id) {
```

###Using a View to Respond to an Exception###

Depending on the exception you are dealing with, displaying a page of static content can be the simplest and safest thing to do.

An alternative approach is to use a view to display details of the problem and present the user with some contextual information and options they can follow to sort things out.

```
﻿using System;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class RangeExceptionAttribute : FilterAttribute, IExceptionFilter {

        public void OnException(ExceptionContext filterContext) {

            if (!filterContext.ExceptionHandled &&
                    filterContext.Exception is ArgumentOutOfRangeException) {

                int val = (int)(((ArgumentOutOfRangeException)
                    filterContext.Exception).ActualValue);
                filterContext.Result = new ViewResult {
                    ViewName = "RangeError",
                    ViewData = new ViewDataDictionary<int>(val)
                };
                filterContext.ExceptionHandled = true;
            }
        }
    }
}
```


Create a ViewResult object and set the values of the ViewName and ViewData properties to specify the name of the view and the model object that will be passed to it.
I cover views in depth in Chapter 20 and the built-in exception filter, which I describe in the next section, can be used to achieve the same effect more elegantly. I just want you to see how things work behind the scenes.

The ViewResult object specifies a view called RangeError and passes the int value of the argument that caused the exception as the view model object.

```
﻿@model HandleErrorInfo

@{
    ViewBag.Title = "Sorry, there was a problem!";
}

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Range Error</title>
</head>
<body>
    <h2>Sorry</h2>
    <span>
        The value @Model was out of the expected range.
    </span>
    <div>
        @Html.ActionLink("Change value and try again", "Index")
    </div>
</body>
</html>
```

##Avoiding the Wrong Exception Trap##

The benefits of using a view to display an error are that you can use layouts to make the error message consistent with the rest of your application and generate dynamic content that will help the user understand what is going wrong and what they can do about it.

###Using the Built-in Exception Filter####

You do not often need to create your own filters in real projects because Microsoft has included the HandleErrorAttribute in the MVC Framework, which is a built-in implementation of the IExceptionFilter interface.

|Name| Type| Description|
|--|--|--|
|ExceptionType |Type| The exception type handled by this filter. It will also handle exception types that inherit from the specified value, but will ignore all others. The default value is System.Exception, which means that, by default, it will handle all standard exceptions. |
|View| string| The name of the view template that this filter renders. If you do not specify a value, it takes a default value of Error, so by default, it renders /Views/<currentControllerName>/Error.cshtml or /Views/Shared/Error.cshtml. |
|Master| string| The name of the layout used when rendering this filter’s view. If you do not specify a value, the view uses its default layout page.|

When an unhandled exception of the type specified by ExceptionType is encountered, this filter will render the view specified by the View property (using the default layout or the one specified by the Master property).

###Preparing to Use the Built-in Exception Filter###

The HandleErrorAttribute filter works only when custom errors are enabled in the Web.config file, which is done by adding a customErrors attribute inside the <system.web> node.


```
<customErrors mode="On" defaultRedirect="/Content/RangeErrorPage.html"/>
```

The default value for the mode attribute is RemoteOnly, which means that connections made from the local machine will always receive the standard yellow page of death errors,

The defaultRedirect attribute specifies a default content page that will be displayed if all else fails.

###Applying the Built-in Exception Filter###

```
[HandleError(ExceptionType = typeof(ArgumentOutOfRangeException), View = "RangeError")]
public string RangeTest(int id) {
```

When rendering a view, the HandleErrorAttribute filter passes a HandleErrorInfo view model object, which is a wrapper around the exception that provides additional information that you use in your view.

|Name| Type| Description|
|--|--|--|
|ActionName| string| Returns the name of the action method that generated the exception|
| ControllerName| string| Returns the name of the controller that generated the exception|
| Exception| Exception| Returns the exception|


```
﻿@model HandleErrorInfo

@{
    ViewBag.Title = "Sorry, there was a problem!";
}

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Range Error</title>
</head>
<body>
    <h2>Sorry</h2>
    <span>
        The value @(((ArgumentOutOfRangeException)Model.Exception).ActualValue)
        was out of the expected range.
    </span>
    <div>
        @Html.ActionLink("Change value and try again", "Index")
    </div>
</body>
</html>
```

##Using Action Filters##

Action filters are filters that can be used for any purpose.


```
namespace System.Web.Mvc {
     public interface IActionFilter {
         void OnActionExecuting(ActionExecutingContext filterContext);
         void OnActionExecuted(ActionExecutedContext filterContext);
     }
}
```

This interface defines two methods. The MVC Framework calls the OnActionExecuting method before the action method is invoked. It calls the OnActionExecuted method after the action method has been invoked.

###Implementing the OnActionExecuting Method###

You can use this opportunity to inspect the request and elect to cancel the request, modify the request, or start some activity that will span the invocation of the action.

The parameter to this method is an ActionExecutingContext object, which subclasses the ControllerContext class

Table 18-10. ActionExecutingContext Properties 

|Name| Type| Description|
|--|--|--|
| ActionDescriptor| ActionDescriptor| Provides details of the action method|
| Result| ActionResult| The result for the action method; a filter can cancel the request by setting this property to a non-null value |

You can use a filter to cancel the request by setting the Result property of the parameter to an action result.

```
﻿using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class CustomActionAttribute : FilterAttribute, IActionFilter {

        public void OnActionExecuting(ActionExecutingContext filterContext) {
            if (filterContext.HttpContext.Request.IsLocal) {
                filterContext.Result = new HttpNotFoundResult();
            }
        }

        public void OnActionExecuted(ActionExecutedContext filterContext) {
            // not yet implemented
        }
    }
}
```



```
[CustomAction]         
public string FilterTest() {
    return "This is the FilterTest action";
}
```

###Implementing the OnActionExecuted Method###


```
﻿using System.Diagnostics;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class ProfileResultAttribute : FilterAttribute, IResultFilter {
        private Stopwatch timer;

        public void OnResultExecuting(ResultExecutingContext filterContext) {
            timer = Stopwatch.StartNew();
        }

        public void OnResultExecuted(ResultExecutedContext filterContext) {
            timer.Stop();
            filterContext.HttpContext.Response.Write(
                    string.Format("<div>Result elapsed time: {0:F6}</div>",
                        timer.Elapsed.TotalSeconds));
        }
    }
}
```

```
[ProfileAction] public string FilterTest() {
     return "This is the ActionFilterTest action"; }
```


Tip  Notice that the profile information is shown in the browser before the result of the action method. This is because the action filter is executed after the action method has completed but before the result is processed.

The parameter that is passed to the OnActionExecuted method is an ActionExecutedContext object.

Table 18-11. ActionExecutedContext Properties 

|Name| Type| Description|
|--|--|--|
|ActionDescriptor| ActionDescriptor| Provides details of the action method|
| Canceled| bool| Returns true if the action has been canceled by another filter|
| Exception| Exception| Returns an exception thrown by another filter or by the action method|
| ExceptionHandled| bool| Returns true if the exception has been handled| 
|Result| ActionResult| The result for the action method; a filter can cancel the request by setting this property to a non-null value|

The Canceled property will return true if another filter has canceled the request (by setting a value for the Result property) since the time that the filter’s OnActionExecuting method was invoked.

The OnActionExecuted method will still be called, but only so that it can tidy up and release any resources the filter was using.

##Using Result Filters##

Result filters are general-purpose filters which operate on the results produced by action methods. Result filters implement the IResultFilter interface, which is shown in Listing 18-36.

```
namespace System.Web.Mvc {
     public interface IResultFilter {
         void OnResultExecuting(ResultExecutingContext filterContext);
         void OnResultExecuted(ResultExecutedContext filterContext);
     }
}
```

When I apply a result filter to an action method, the OnResultExecuting method is invoked after the action method has returned an action result but before the action result is executed.

The OnResultExecuted method is invoked after the action result is executed.

The parameters to these methods are ResultExecutingContext and ResultExecutedContext objects, respectively, and they are similar to their action filter counterparts.

They define the same properties, which have the same effects. (See Table 18-11

```
﻿using System.Diagnostics;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class ProfileResultAttribute : FilterAttribute, IResultFilter {
        private Stopwatch timer;

        public void OnResultExecuting(ResultExecutingContext filterContext) {
            timer = Stopwatch.StartNew();
        }

        public void OnResultExecuted(ResultExecutedContext filterContext) {
            timer.Stop();
            filterContext.HttpContext.Response.Write(
                    string.Format("<div>Result elapsed time: {0:F6}</div>",
                        timer.Elapsed.TotalSeconds));
        }
    }
}
```

This result filter is the complement to the action filter I created in the previous section and measures the amount of time taken to execute the result.

```
[ProfileAction]
[ProfileResult]
public string FilterTest() {
     return "This is the ActionFilterTest action";
}
```

###Using the Built-in Action and Result Filter Class###

The MVC Framework includes a built-in class that can be derived to create a class that is both an action and result filter. The class, called ActionFilterAttribute, is shown in Listing 18-39.

```
﻿using System.Diagnostics;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class ProfileAllAttribute : ActionFilterAttribute {
        private Stopwatch timer;

        public override void OnActionExecuting(ActionExecutingContext filterContext) {
            timer = Stopwatch.StartNew();
        }

        public override void OnResultExecuted(ResultExecutedContext filterContext) {
            timer.Stop();
            filterContext.HttpContext.Response.Write(
                    string.Format("<div>Total elapsed time: {0:F6}</div>",
                        timer.Elapsed.TotalSeconds));
        }
    }
}
```


```
﻿using System.Diagnostics;
using System.Web.Mvc;

namespace Filters.Infrastructure {
    public class ProfileAllAttribute : ActionFilterAttribute {
        private Stopwatch timer;

        public override void OnActionExecuting(ActionExecutingContext filterContext) {
            timer = Stopwatch.StartNew();
        }

        public override void OnResultExecuted(ResultExecutedContext filterContext) {
            timer.Stop();
            filterContext.HttpContext.Response.Write(
                    string.Format("<div>Total elapsed time: {0:F6}</div>",
                        timer.Elapsed.TotalSeconds));
        }
    }
}
```


The ActionFilterAttribute class implements the IActionFilter and IResultFilter interfaces, which means that the MVC Framework will treat derived classes as both types of filters, even if not all of the methods are overridden.

This allows me to continue the profiling theme and measure the time it takes for the action method to execute and the result to be processed as a single unit. Listing 18-41 shows how I applied the filter to the Home

```
[ProfileAction]
[ProfileResult]
[ProfileAll]
public string FilterTest() {
     return "This is the FilterTest action";
}
```

##Using Other Filter Features##

###Filtering Without Attributes###

However, there is an alternative. The Controller class implements the IAuthenticationFilter, IAuthorizationFilter, IActionFilter, IResultFilter, and IExceptionFilter interfaces.

It also provides empty virtual implementations of each of the On XXX methods you have already seen, such as OnAuthorization and OnException.

```
﻿using System;
using System.Diagnostics;
using System.Web.Mvc;
using Filters.Infrastructure;

namespace Filters.Controllers {
    public class HomeController : Controller {
        private Stopwatch timer;

        [Authorize(Users = "admin")]
        public string Index() {
            return "This is the Index action on the Home controller";
        }

        [GoogleAuth]
        [Authorize(Users = "bob@google.com")]
        public string List() {
            return "This is the List action on the Home controller";
        }

        [HandleError(ExceptionType = typeof(ArgumentOutOfRangeException),
            View = "RangeError")]
        public string RangeTest(int id) {
            if (id > 100) {
                return String.Format("The id value is: {0}", id);
            } else {
                throw new ArgumentOutOfRangeException("id", id, "");
            }
        }

        public string FilterTest() {
            return "This is the FilterTest action";
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext) {
            timer = Stopwatch.StartNew();
        }

        protected override void OnResultExecuted(ResultExecutedContext filterContext) {
            timer.Stop();
            filterContext.HttpContext.Response.Write(
                    string.Format("<div>Total elapsed time: {0}</div>",
                        timer.Elapsed.TotalSeconds));
        }
    }
}

```

###Using Global Filters###

Global filters are applied to all of the action methods in all of the controllers in your application.

Application-wide configuration is done in classes added to the App_Start folder,

To create the equivalent for filters, I added a new class file called FilterConfig.cs to the App_Start folder.

```
﻿using System.Web;
using System.Web.Mvc;
using Filters.Infrastructure;

namespace Filters {
    public class FilterConfig {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters) {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new ProfileAllAttribute());
        }
    }
}
```

There are two conventions to note in this file. The first is that the FilterConfig class is defined in the Filters namespace and not Filters.App_Start, which is what Visual Studio will use when it creates the file.

The second is that the HandleError filter, which I described earlier in the chapter, is always defined as a global filter by calling the Add method on the GlobalFilterCollection object.

> **Note**  You don’t have to set up the HandleError filter globally, but it defines the default MVC exception handling policy. This will render the /Views/Shared/Error.cshtml view when an unhandled exception arises. This exception handling policy is disabled by default for development.

I appliws my ProfileAll filter globally:

```
filters.Add(new ProfileAllAttribute());
```

The next step is to ensure that the FilterConfig.RegisterGlobalFilters method is called from the Global.asax file when the application starts.

```
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Filters {
    public class MvcApplication : System.Web.HttpApplication {
        protected void Application_Start() {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
        }
    }
}
```

###Ordering Filter Execution###

I have already explained that filters are executed by type. The sequence is authentication filters, authorization filters, action filters, and then result filters.

Add a note
The framework executes exception filters at any stage if there is an unhandled exception.

Add a note
However, within each type category, you can take control of the order in which individual filters are used.

```
﻿using System;
using System.Web.Mvc;

namespace Filters.Infrastructure {

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method,
        AllowMultiple = true)]
    public class SimpleMessageAttribute : FilterAttribute, IActionFilter {

        public string Message { get; set; }

        public void OnActionExecuting(ActionExecutingContext filterContext) {
            filterContext.HttpContext.Response.Write(
                string.Format("<div>[Before Action: {0}]<div>", Message));
        }

        public void OnActionExecuted(ActionExecutedContext filterContext) {
            filterContext.HttpContext.Response.Write(
                string.Format("<div>[After Action: {0}]<div>", Message));
        }
    }
}
```

```
﻿using System.Web.Mvc;
using Filters.Infrastructure;

namespace Filters.Controllers {
    [SimpleMessage(Message = "A")]
    public class CustomerController : Controller {

        [SimpleMessage(Message = "A")]
        [SimpleMessage(Message = "B")]
        public string Index() {
            return "This is the Customer controller";
        }
    }
}
```

The MVC Framework does not guarantee any particular order or execution. Most of the time, the order does not matter. When it does, you can use the Order property,

```
﻿using System.Web.Mvc;
using Filters.Infrastructure;

namespace Filters.Controllers {
    [SimpleMessage(Message = "A")]
    public class CustomerController : Controller {

        [SimpleMessage(Message = "A", Order = 1)]
        [SimpleMessage(Message = "B", Order = 2)]
        public string Index() {
            return "This is the Customer controller";
        }
    }
}
```


The Order parameter takes an int value, and the MVC Framework executes the filters in ascending order.

>**Note**  Notice that the OnActionExecuting methods are executed in the order I specified, but the OnActionExecuted methods are executed in the reverse order. The MVC Framework builds up a stack of filters as it executes them before the action method, and then unwinds the stack afterward. This unwinding behavior cannot be changed.

If I do not specify a value for the Order property, it is assigned a default value of -1. This means that if you mix filters so that some have Order values and others do not, the ones without these values will be executed first, since they have the lowest Order value.

If multiple filters of the same type (say, action filters) have the same Order value (say 1), then the MVC Framework determines the execution order based on where the filter has been applied. Global filters are executed first, then filters applied to the controller class, and then filters applied to the action method.

> **Note**  The order of execution is reversed for exception filters. If exception filters are applied with the same Order value to the controller and to the action method, the filter on the action method will be executed first. Global exception filters with the same Order value are executed last.

###Overriding Filters###

There will be occasions when you want to apply a filter globally or at the controller level, but use a different filter for a specific action method.

```
﻿using System;
using System.Web.Mvc;

namespace Filters.Infrastructure {

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method,
        AllowMultiple = true)]
    public class SimpleMessageAttribute : FilterAttribute, IActionFilter {

        public string Message { get; set; }

        public void OnActionExecuting(ActionExecutingContext filterContext) {
            filterContext.HttpContext.Response.Write(
                string.Format("<div>[Before Action: {0}]<div>", Message));
        }

        public void OnActionExecuted(ActionExecutedContext filterContext) {
            filterContext.HttpContext.Response.Write(
                string.Format("<div>[After Action: {0}]<div>", Message));
        }
    }
}
```

```
﻿using System.Web.Mvc;
using Filters.Infrastructure;

namespace Filters.Controllers {
    [SimpleMessage(Message = "A")]
    public class CustomerController : Controller {

        public string Index() {
            return "This is the Customer controller";
        }

        [SimpleMessage(Message = "B")]
        public string OtherAction() {
            return "This is the Other Action in the Customer controller";
        }
    }
}
```

If you want an action method to just be affected by the filters that have been directly applied to it, then you can use a filter override. This tells the MVC Framework to ignore any filters that have been defined at a higher-level, such as the controller or globally.

Filter overrides are attributes that implement the IOverrideFilter interface, which is shown in Listing 18-52.

```
namespace System.Web.Http.Filters {
     public interface IOverrideFilter : IFilter {
         Type FiltersToOverride { get; }
     }
}
```

The FiltersToOverride method returns the type of filter that will be overridden. I am interested in action filters for this example and to that end I created the CustomOverrideActionFiltersAttribute.cs file in the Infrastructure. As Listing 18-53 shows, I implemented the FiltersToOverride method so that my new attribute overrides the IActionFilter type.

>**Caution**  The MVC Framework comes with some built-in filter overrides in the System.Web.Mvc.Filters namespace: OverrideAuthenticationAttribute, OverrideActionFiltersAttribute, and so on. As I write this, these filters do not work. This is because they are derived from Attribute and not FilterAttribute. I assume that this will be resolved in a later release, but in the meantime you should create custom filter override attributes like the one I demonstrate below.

```
﻿using System;
using System.Web.Mvc;
using System.Web.Mvc.Filters;

namespace Filters.Infrastructure {

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method,
        Inherited = true, AllowMultiple = false)]
    public class CustomOverrideActionFiltersAttribute : FilterAttribute,
            IOverrideFilter {
        public Type FiltersToOverride {
            get { return typeof(IActionFilter); }
        }
    }
}
```

I can apply this filter to my controller to prevent the global and controller level action filters from taking effect, as shown in Listing 18-54.

```
﻿using System.Web.Mvc;
using Filters.Infrastructure;

namespace Filters.Controllers {
    [SimpleMessage(Message = "A")]
    public class CustomerController : Controller {

        public string Index() {
            return "This is the Customer controller";
        }

        [CustomOverrideActionFilters]
        [SimpleMessage(Message = "B")]
        public string OtherAction() {
            return "This is the Other Action in the Customer controller";
        }
    }
}
```


#CHAPTER 19 Controller Extensibility# {#Chap19}

Request --> Routing --> Controller Factory --> Controller --> Action Invoker --> Action

The controller factory is responsible for creating instances of controllers to service a request.

The action invoker is responsible for finding and invoking the action method in the controller class.

##Creating a Custom Controller Factory##

Controller factories are defined by the IControllerFactory interface:


```
using System.Web.Routing; 
using System.Web.SessionState; 

namespace System.Web.Mvc {
     public interface IControllerFactory {
         IController CreateController(RequestContext requestContext, string controllerName);
         SessionStateBehavior GetControllerSessionBehavior(RequestContext requestContext, string controllerName);
         void ReleaseController(IController controller);
     }
}
```

```
﻿using System;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.SessionState;
using ControllerExtensibility.Controllers;

namespace ControllerExtensibility.Infrastructure {

    public class CustomControllerFactory : IControllerFactory {

        public IController CreateController(RequestContext requestContext,
            string controllerName) {

            Type targetType = null;
            switch (controllerName) {
                case "Product":
                    targetType = typeof(ProductController);
                    break;
                case "Customer":
                    targetType = typeof(CustomerController);
                    break;
                default:
                    requestContext.RouteData.Values["controller"] = "Product";
                    targetType = typeof(ProductController);
                    break;
            }

            return targetType == null ? null :
                (IController)DependencyResolver.Current.GetService(targetType);
        }

        public SessionStateBehavior GetControllerSessionBehavior(RequestContext
            requestContext, string controllerName) {

            return SessionStateBehavior.Default;
        }

        public void ReleaseController(IController controller) {
            IDisposable disposable = controller as IDisposable;
            if (disposable != null) {
                disposable.Dispose();
            }
        }
    }
}
```

The most important method is CreateController, which the MVC Framework calls when it needs a controller to service a request.

The RequestContext object parameter, which allows the factory to inspect details of the request, and a string, which contains the controller value from the routed URL.

Table 19-2. RequestContext Properties 

|Name| Type| Description|
|--|--|--|
| HttpContext| HttpContextBase| Provides information about the HTTP request| 
|RouteData| RouteData| Provides information about the route that matches the request|


##Dealing with the Fallback Controller##

By default, the MVC Framework selects a view based on the controller value in the routing data, not the name of the controller class.

So, in my example, if I want the fallback position to work with views that follow the convention of being organized by controller name, I need to change the value of the controller routing property, like this: ... requestContext.RouteData.Values["controller"] = "Product";

The controller factory have sole responsibility for matching requests to controllers, but it can change the request to alter the behavior of subsequent steps in the request processing pipeline.

###Instantiating Controller Classes###

You can see how I used the DependencyResolver class to create controllers instances:

```
return targetType == null ? null : (IController)DependencyResolver.Current.GetService(targetType) ;
```

###Implementing the Other Interface Methods###

The GetControllerSessionBehavior method is used by the MVC Framework to determine if session data should be maintained for a controller.

The ReleaseController method is called when a controller object created by the CreateController method is no longer needed.

###Registering a Custom Controller Factory###

```
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using ControllerExtensibility.Infrastructure;

namespace ControllerExtensibility {
    public class MvcApplication : System.Web.HttpApplication {
        protected void Application_Start() {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            ControllerBuilder.Current.SetControllerFactory(new
                DefaultControllerFactory(new CustomControllerActivator()));
        }
    }
}
```

##Working with the Built-in Controller Factory##

For most applications, however, the built-in controller factory class, called DefaultControllerFactory, is perfectly adequate.

When it receives a request from the routing system, this factory looks at the routing data to find the value of the controller property and tries to find a class in the Web application that meets the following criteria: 

- The class must be public. 
- The class must be concrete (not abstract). 
- The class must not take generic parameters. 
- The name of the class must end with Controller. 
- The class must implement the IController interface.

The DefaultControllerFactory class maintains a list of such classes in the application so that it does not need to perform a search every time a request arrives.

You do not need to register your controllers in a configuration file, because the factory will find them for you. All you need to do is create classes that meet the criteria that the factory is seeking.

If you want to create custom controller factory behavior, you can configure the settings of the default factory or override some of the methods.

###Prioritizing Namespaces###

See Chapter 16 for details on specifying namespaces for individual routes.

If you have an application that has a lot of routes, it can be more convenient to specify priority namespaces globally, so that they are applied to all of your routes.

Add a note
Listing 19-8 shows how to do this in the Application_Start method of the Global.asax file. (This is where I put these statements, but you can also use the RouteConfig.cs file in the App_Start folder if you prefer.)

```
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using ControllerExtensibility.Infrastructure;

namespace ControllerExtensibility {
    public class MvcApplication : System.Web.HttpApplication {
        protected void Application_Start() {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            ControllerBuilder.Current.Defaukt.Namespaces.Add("MyControllerNamespace");
            ControllerBuilder.Current.Defaukt.Namespaces.Add("MyProject.*");
        }
    }
}
```


I use the static ControllerBuilder.Current.DefaultNamespaces.Add method to add namespaces that should be given priority. The order in which I add the namespaces does not imply any kind of search order or relative priority.

All of the namespaces defined by the Add method are treated equally and the priority is relative to those namespaces which have not been specified by the Add method.

> **Tip**  Notice that I used an asterisk character (*) in the second statement shown in bold in Listing 19-8. This allows me to specify that the controller factory should look in the MyProject namespace and any child namespaces that MyProject contains.

##Customizing DefaultControllerFactory Controller Instantiation##

By far, the most common reason for customizing the controller factory is to add support for DI.

###Using the Dependency Resolver###

The DefaultControllerFactory class will use a dependency resolver to create controllers if one is available. I covered dependency resolvers in Chapter 6 and showed you the NinjectDependencyResolver class, which implements the IDependencyResolver interface to provide Ninject DI support. I also demonstrated how to use the DependencyResolver class earlier in this chapter when I created my own custom controller factory. The DefaultControllerFactory will call the IDependencyResolver.GetService method to request a controller instance, which gives you the opportunity to resolve and inject any dependencies.

```
﻿using System;
using System.Collections.Generic;
using System.Web.Mvc;
using EssentialTools.Models;
using Ninject;
using Ninject.Web.Common;

namespace EssentialTools.Infrastructure {
    public class NinjectDependencyResolver : IDependencyResolver {
        private IKernel kernel;

        public NinjectDependencyResolver(IKernel kernelParam) {
            kernel = kernelParam;
            AddBindings();
        }

        public object GetService(Type serviceType) {
            return kernel.TryGet(serviceType);
        }

        public IEnumerable<object> GetServices(Type serviceType) {
            return kernel.GetAll(serviceType);
        }

        private void AddBindings() {
            kernel.Bind<IValueCalculator>().To<LinqValueCalculator>().InRequestScope();
            kernel.Bind<IDiscountHelper>()
              .To<DefaultDiscountHelper>().WithConstructorArgument("discountParam", 50M);
            kernel.Bind<IDiscountHelper>().To<FlexibleDiscountHelper>()
              .WhenInjectedInto<LinqValueCalculator>();
        }
    }
}
```

```
[assembly: WebActivator.PreApplicationStartMethod(typeof(EssentialTools.App_Start.NinjectWebCommon), "Start")]
[assembly: WebActivator.ApplicationShutdownMethodAttribute(typeof(EssentialTools.App_Start.NinjectWebCommon), "Stop")]

namespace EssentialTools.App_Start {
    using System;
    using System.Web;

    using Microsoft.Web.Infrastructure.DynamicModuleHelper;

    using Ninject;
    using Ninject.Web.Common;

    public static class NinjectWebCommon {
        private static readonly Bootstrapper bootstrapper = new Bootstrapper();

        /// <summary>
        /// Starts the application
        /// </summary>
        public static void Start() {
            DynamicModuleUtility.RegisterModule(typeof(OnePerRequestHttpModule));
            DynamicModuleUtility.RegisterModule(typeof(NinjectHttpModule));
            bootstrapper.Initialize(CreateKernel);
        }

        /// <summary>
        /// Stops the application.
        /// </summary>
        public static void Stop() {
            bootstrapper.ShutDown();
        }

        /// <summary>
        /// Creates the kernel that will manage your application.
        /// </summary>
        /// <returns>The created kernel.</returns>
        private static IKernel CreateKernel() {
            var kernel = new StandardKernel();
            kernel.Bind<Func<IKernel>>().ToMethod(ctx => () => new Bootstrapper().Kernel);
            kernel.Bind<IHttpModule>().To<HttpApplicationInitializationHttpModule>();

            RegisterServices(kernel);
            return kernel;
        }

        /// <summary>
        /// Load your modules or register your services here!
        /// </summary>
        /// <param name="kernel">The kernel.</param>
        private static void RegisterServices(IKernel kernel) {
            System.Web.Mvc.DependencyResolver.SetResolver(new
                EssentialTools.Infrastructure.NinjectDependencyResolver(kernel));
        }
    }
}
```


###Using a Controller Activator###

You can also introduce DI into controllers by creating a controller activator; by implementing the IControllerActivator

```
namespace System.Web.Mvc {
     using System.Web.Routing;
     public interface IControllerActivator {
         IController Create(RequestContext requestContext, Type controllerType);
     }
}
```

The interface contains one method, called Create, which is passed a RequestContext object describing the request and a Type that specifies which controller class should be instantiated.

```
﻿using System;
using System.Web.Mvc;
using System.Web.Routing;
using ControllerExtensibility.Controllers;

namespace ControllerExtensibility.Infrastructure {
    public class CustomControllerActivator : IControllerActivator {

        public IController Create(RequestContext requestContext,
            Type controllerType) {

            if (controllerType == typeof(ProductController)) {
                controllerType = typeof(CustomerController);
            }
            return (IController)DependencyResolver.Current.GetService(controllerType);
        }
    }
}
```

To use a custom activator, I need to pass an instance of the implementation class to the DefaultControllerFactory constructor and register the result in the Application_Start method of the Global.asax file,

```
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using ControllerExtensibility.Infrastructure;

namespace ControllerExtensibility {
    public class MvcApplication : System.Web.HttpApplication {
        protected void Application_Start() {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            ControllerBuilder.Current.SetControllerFactory(new
                DefaultControllerFactory(new CustomControllerActivator()));
        }
    }
}
```

###Overriding DefaultControllerFactory Methods###

Table 19-3. Overridable DefaultContollerFactory Methods

| Method| Result| Description|
|--|--|--|
|CreateController IController| The implementation of the CreateController method from the IControllerFactory interface. By default, this method calls GetControllerType to determine which type should be instantiated, and then gets a controller object by passing the result to the GetControllerInstance method. 
|GetControllerType| Type| Maps requests to controller types. This is where most of the conventions listed earlier in the chapter are enforced. |
|GetControllerInstance| IController| Creates an instance of a specified type.|

##Creating a Custom Action Invoker##

Once the controller factory has created an instance of a class, the framework needs a way of invoking an action on that instance. If you derived your controller from the Controller class, then this is the responsibility of an action invoker, which is the subject of this section.

>**Tip**  If you create a controller directly from the IController interface, then you are responsible for executing the action yourself.

Action invokers are part of the functionality included in the Controller class.

An action invoker implements the IActionInvoker interface.


```
namespace System.Web.Mvc {
     public interface IActionInvoker {
         bool InvokeAction(ControllerContext controllerContext, string actionName);
     }
}
```

```
﻿using System.Web.Mvc;

namespace ControllerExtensibility.Infrastructure {

    public class CustomActionInvoker : IActionInvoker {

        public bool InvokeAction(ControllerContext controllerContext,
                string actionName) {

            if (actionName == "Index") {
                controllerContext.HttpContext.
                    Response.Write("This is output from the Index action");
                return true;
            } else {
                return false;
            }
        }
    }
}
```

If the request is for any other action, then it returns false, which causes a 404—Not found error to be displayed to the user.

The action invoker associated with a controller is obtained through the Controller.ActionInvoker property. This means that different controllers in the same application can use different action invokers.

```
﻿using ControllerExtensibility.Infrastructure;
using System.Web.Mvc;

namespace ControllerExtensibility.Controllers {

    public class ActionInvokerController : Controller {
        public ActionInvokerController() {
            this.ActionInvoker = new CustomActionInvoker();
        }
    }
}
```

##Using the Built-in Action Invoker##

The built-in action invoker, which is the ControllerActionInvoker class, has some sophisticated techniques for matching requests to actions.

To qualify as an action, a method must meet the following criteria: 

- The method must be public. 
- The method must not be static. 
- The method must not be present in System.Web.Mvc.Controller or any of its base classes. 
- The method must not have a special name.

The last criterion means that constructors, property and event accessors are excluded. In fact, no class member that has the IsSpecialName flag from System.Reflection.MethodBase will be used to process an action.

> **Note**  Methods that have generic parameters (such as MyMethod<T>()) meet all of the criteria, but the MVC Framework will throw an exception if you try to invoke such a method to process a request.

By default, the ControllerActionInvoker finds a method that has the same name as the requested action.


###Using a Custom Action Name###

You can override this behavior using the ActionName attribute,

[ActionName("Enumerate")]         
public ViewResult List() {
             return View("Result", new Result {
		ControllerName = "Customer", ActionName = "List"
});

This means that URLs which directly target the List method will no longer work,

There are two main reasons why you might want to override a methods name in this way:

- You can then accept an action name that wouldn’t be legal as a C# method name (for example, [ActionName("User-Registration")]). 
- If you want to have two different C# methods that accept the same set of parameters and should handle the same action name, but in response to different HTTP request types (for example, one with [HttpGet] and the other with [HttpPost]), you can give the methods different C# names to satisfy the compiler, but then use [ActionName] to map them both to the same action name.

###Using Action Method Selection###

It is often the case that a controller will contain several actions with the same name. This can be because there are multiple methods, each with different parameters, or because you used the ActionName attribute so that multiple methods represent the same action.

The MVC Framework needs some help selecting the appropriate action

The mechanism for doing this is called action method selection.

You have already seen an example of action method selection when I restricted an action using the HttpPost attribute

```
[HttpPost]
public ViewResult Checkout(Cart cart, ShippingDetails shippingDetails)
{
// More
}
```

The action invoker uses action method selectors to resolve ambiguity when selecting an action.

The invoker gives preference to the actions that have selectors. In this case, the HttpPost selector is evaluated to see if the request can be processed.

There are built-in attributes that work as selectors for the different kinds of HTTP requests: HttpPost for POST requests, HttpGet for GET requests, HttpPut for PUT requests, and so on.

Another built-in attribute is NonAction, which indicates to the action invoker that a method that would otherwise be considered a valid action method should not be used.

```
[NonAction]         
public ActionResult MyAction() {
             return View();
}
```

The reason you must mark such a method as public. Requests for URLs that target NonAction methods will generate 404—Not Found errors,

###Creating a Custom Action Method Selector###

Action method selectors are derived from the ActionMethodSelectorAttribute

```
using System.Reflection; 
namespace System.Web.Mvc {
     [AttributeUsage(AttributeTargets.Method, AllowMultiple = false, Inherited = true)]
     public abstract class ActionMethodSelectorAttribute : Attribute {
         public abstract bool IsValidForRequest(ControllerContext controllerContext, MethodInfo methodInfo);
     }
}
```

```
﻿using System.Reflection;
using System.Web.Mvc;

namespace ControllerExtensibility.Infrastructure {
    public class LocalAttribute : ActionMethodSelectorAttribute {

        public override bool IsValidForRequest(ControllerContext controllerContext,
                MethodInfo methodInfo) {
            return controllerContext.HttpContext.Request.IsLocal;
        }
    }
}
```

He applies the ActionName attribute to cause two Index methods on the same controller causing an ambigusou exception to be raised and then applied the LocalAttribute:

```
[Local]
[ActionName("Index")] 
public ActionResult LocalIndex() {
}
```

###THE ACTION METHOD DISAMBIGUATION PROCESS###

The invoker starts the process with a list of possible candidates, which are the controller methods that meet the action method criteria. Then it goes through the following process:

- The invoker discards any method based on name. Only methods that have the same name as the target action or have a suitable ActionName attribute are kept on the list. 
- The invoker discards any method that has an action method selector attribute that returns false for the current request. 
- If there is exactly one action method with a selector left, then this is the method that is used. If there is more than one method with a selector, then an exception is thrown, because the action invoker cannot disambiguate between the available methods. 
- If there are no action methods with selectors, then the invoker looks at those without selectors. If there is exactly one such method, then this is the one that is invoked. If there is more than one method without a selector, an exception is thrown, because the invoker can’t choose between them.

###Handling Unknown Actions###

If the action invoker is unable to find an action method to invoke, it returns false from its InvokeAction method. When this happens, the Controller class calls its HandleUnknownAction method. By default, this method returns a 404—Not Found response to the client.

```
﻿using System.Web.Mvc;
using ControllerExtensibility.Infrastructure;
using ControllerExtensibility.Models;

namespace ControllerExtensibility.Controllers {
    public class HomeController : Controller {

	// ...

        protected override void HandleUnknownAction(string actionName) {
            Response.Write(string.Format("You requested the {0} action", actionName));
        }
    }
}
```

##Improving Performance with Specialized Controllers##

###Using Sessionless Controllers###

By default, controllers support session state,

In order to simplify session state, ASP.NET will process only one query for a given session at a time. If the client makes multiple overlapping requests, they will be queued up and processed sequentially by the server. The benefit is that you do not need to worry about multiple requests modifying the same data. The downside is that you do not get the request throughput you might like.

###Managing Session State in a Custom IControllerFactory###

The IControllerFactory interface contained a method called GetControllerSessionBehavior, which returns a value from the SessionStateBehavior enumeration.

Table 19-4. The Values of the SessionStateBehavior Enumeration 

|Value| Description| 
|--|--|
|Default| Use the default ASP.NET behavior, which is to determine the session state configuration from HttpContext. |
|Required Full read-write session state is enabled. |
|ReadOnly| Read-only session state is enabled. |
|Disabled| Session state is disabled entirely.|


Listing 19-23.  Defining Session State Behavior for a Controller in the CustomControllerFactory.cs File

```
public SessionStateBehavior GetControllerSessionBehavior(RequestContext requestContext, string controllerName) {
     switch (controllerName) {
         case "Home":
             return SessionStateBehavior.ReadOnly;
         case "Product":
             return SessionStateBehavior.Required;
         default:
             return SessionStateBehavior.Default;
     }
}
```

###Managing Session State Using DefaultControllerFactory###

When you are using the built-in controller factory, you can control the session state by applying the SessionState attribute to individual controller classes,

```
[SessionState(SessionStateBehavior.Disabled)]     
public class FastController : Controller
```
			

I disabled session state entirely, which means that if I try to set a session value in the controller, like this:

```
Session["Message"] = "Hello";
```
or try to read back from the session state in a view, like this: 

```
Message: @Session["Message"]
```

The MVC Framework will throw an exception when the action is invoked or the view is rendered.

>**Tip**  When session state is Disabled, the HttpContext.Session property returns null.


> **Tip**  If you are simply trying to pass data from the controller to the view, consider using the View Bag feature instead, which is not affected by the SessionState attribute.

###Using Asynchronous Controllers###

The underlying ASP.NET platform maintains a pool of .NET threads that are used to process client requests. This pool is called the worker thread pool, and the threads are called worker threads.

There are two key benefits of using thread pools for ASP.NET applications:

- By reusing worker threads, you avoid the overhead of creating a new one each time you process a request. 
- By having a fixed number of worker threads available, you avoid the situation where you are processing more simultaneous requests than your server can handle.

The worker thread pool works best when requests can be processed in a short period of time.

> **Note**  In this section, I assume that you are familiar with the Task Parallel Library (TPL). If you want to learn about the TPL, see my book on the topic, called Pro .NET Parallel Programming in C#, which is published by Apress.

The solution to this problem is to use an asynchronous controller.

> **Note**  Asynchronous controllers are useful only for actions that are I/O- or network-bound and not CPU-intensive.

See my Pro ASP.NET MVC 5 Client book, published by Apress in 2014, for details.

###Creating an Asynchronous Controller###

One is to implement the System.Web.Mvc.Async.IAsyncController interface, which is the asynchronous equivalent of IController. I am not going to demonstrate that approach, because it requires so much explanation of the .NET concurrent programming facilities.

One artifact of the old approach is that you can’t use action method names that end with Async (e.g., IndexAsync) or Completed (e.g., IndexCompleted).

```
﻿using System.Web.Mvc;
using ControllerExtensibility.Models;
using System.Threading.Tasks;

namespace ControllerExtensibility.Controllers {
    public class RemoteDataController : Controller {

        public async Task<ActionResult> Data() {
            string data = await Task<string>.Factory.StartNew(() => {
                return new RemoteService().GetRemoteData();
            });

            return View((object)data);
        }
    }
}
```

 I have refactored the action method so that it returns a Task<ActionResult>, applied the async and await keywords, and created a Task<string>, which is responsible for calling the GetRemoteData method.

###Consuming Asynchronous Methods in a Controller###

```
﻿using System.Threading;
using System.Threading.Tasks;

namespace ControllerExtensibility.Models {
    public class RemoteService {

        public string GetRemoteData() {
            Thread.Sleep(2000);
            return "Hello from the other side of the world";
        }

        public async Task<string> GetRemoteDataAsync() {
            return await Task<string>.Factory.StartNew(() => {
                Thread.Sleep(2000);
                return "Hello from the other side of the world";
            });
        }
    }
}
```

```
﻿using System.Web.Mvc;
using ControllerExtensibility.Models;
using System.Threading.Tasks;

namespace ControllerExtensibility.Controllers {
    public class RemoteDataController : Controller {

        public async Task<ActionResult> Data() {
            string data = await Task<string>.Factory.StartNew(() => {
                return new RemoteService().GetRemoteData();
            });

            return View((object)data);
        }

        public async Task<ActionResult> ConsumeAsyncMethod() {
            string data = await new RemoteService().GetRemoteDataAsync();
            return View("Data", (object)data);
        }
    }
}
```



#CHAPTER 20 Views# {#Chap20}

##Creating a Custom View Engine##

View engines implement the IViewEngine interface, which is shown in Listing 20-1.

```
namespace System.Web.Mvc {
     public interface IViewEngine {
         ViewEngineResult FindPartialView(ControllerContext controllerContext, string partialViewName, bool useCache);
         ViewEngineResult FindView(ControllerContext controllerContext, string viewName, string masterName, bool useCache);
         void ReleaseView(ControllerContext controllerContext, IView view);
     }
}
```

The role of a view engine is to translate requests for views into ViewEngineResult objects. The first two methods in the interface, FindView and FindPartialView, are passed parameters that describe the request and the controller that processed it (a ControllerContext object), the name of the view and its layout, and whether the view engine is allowed to reuse a previous result from its cache. These methods are called when a ViewResult is being processed. The final method, ReleaseView, is called when a view is no longer needed.

>**Note**  The MVC Framework support for view engines is implemented by the ControllerActionInvoker class, which is the built-in implementation of the IActionInvoker interface, as described in Chapter 17. You will not have automatic access to the view engines feature if you have implemented your own action invoker or controller factory directly from the IActionInvoker or IControllerFactory interfaces.

The ViewEngineResult class allows a view engine to respond to the MVC Framework when a view is requested. Listing 20-2 shows the ViewEngineResult class.

Listing 20-2.  The ViewEngineResult Class from the MVC Framework 

```
using System.Collections.Generic; namespace System.Web.Mvc {
     public class ViewEngineResult {
         public ViewEngineResult(IEnumerable<string> searchedLocations) {
             if (searchedLocations == null) {
                 throw new ArgumentNullException("searchedLocations");
             }
             SearchedLocations = searchedLocations;
         }
         public ViewEngineResult(IView view, IViewEngine viewEngine) {
             if (view == null) { throw new ArgumentNullException("view");}
             if (viewEngine == null) { throw new ArgumentNullException("viewEngine");}
             View = view;
             ViewEngine = viewEngine;
         }
         public IEnumerable<string> SearchedLocations { get; private set; }
         public IView View { get; private set; }
         public IViewEngine ViewEngine { get; private set; }
     }
} 
```

You express a result by choosing one of the two constructors. If your view engine is able to provide a view for a request, then you create a ViewEngineResult using this constructor: ... public ViewEngineResult(IView view, IViewEngine viewEngine) ... The parameters to this constructor are an implementation of the IView interface and a view engine (so that the ReleaseView method can be called later). If your view engine cannot provide a view for a request, then you use this constructor: 

```
public ViewEngineResult(IEnumerable<string> searchedLocations)
```

The parameter for this version is an enumeration of the places you searched to find a view. This information is displayed to the user if no view can be found, as I will demonstrate later.  

>**Note**  You are not alone if you think that the ViewEngineResult class is a little awkward. Expressing outcomes using different versions of a class constructor is an odd approach and does not really fit with the rest of the MVC Framework design. 

The last building block of the view engine system is the IView interface, which is shown in 

Listing 20-3. Listing 20-3.  The IView Interface from the MVC Framework 

```
using System.IO; namespace System.Web.Mvc {
     public interface IView {
         void Render(ViewContext viewContext, TextWriter writer);
     } 
} 
```

An IView implementation is passed to the constructor of a ViewEngineResult object, which is then returned from the view engine methods. The MVC Framework then calls the Render method. The ViewContext parameter provides information about the request from the client and the output from the action method. The TextWriter parameter is for writing output to the client. The ViewContext object defines properties that give you access to information about the request and details of how the MVC Framework has processed it so far. I have described the most useful of these properties in Table 20-2. 

Table 20-2. Useful ViewContext Properties 

|Name| Description| 
|--|--|
|Controller| Returns the IController implementation that processed the current request |
|RequestContext| Returns details of the current request |
|RouteData |Returns the routing data for the current request |
|TempData |Returns the temp data associated with the request| 
|View |Returns the implementation of the IView interface that will process the request. Obviously, this will be the current class if you are creating a custom view implementation. |
|ViewBag| Returns an object that represents the view bag |
|ViewData| Returns a dictionary of the view model data, which also contains the view bag and meta data for the model. See Table 20-3 for details. |

The most interesting of these properties is ViewData, which returns a ViewDataDictionary object. The ViewDataDictionary class defines a number of useful properties that give access to the view model, the view bag and the view model metadata. I have described the most useful of these properties in Table 20-3. 

Table 20-3. Useful ViewDataDictionary Properties 

|Name| Description|
|--|--|
|Keys| Returns a collection of key values for the data in the dictionary, which can be used to access view bag properties| 
|Model| Returns the view model object for the request|
| ModelMetadata| Returns a ModelMetadata object that can be used to reflect on the model type|
| ModelState| Returns information about the state of the model, which I describe in detail in Chapter 25|

As I said earlier, the simplest way to see how this works—how IViewEngine, IView, and ViewEngineResult fit together—is to create a view engine. I am going to create a simple view engine that returns one kind of view. This view will render a result that contains information about the request and the view data produced by the action method. This approach lets me demonstrate the way that view engines operate without getting bogged down in parsing view templates.

##Creating a custom IView##

```
﻿using System.IO;
using System.Web.Mvc;

namespace Views.Infrastructure {
    public class DebugDataView : IView {

        public void Render(ViewContext viewContext, TextWriter writer) {

            Write(writer, "---Routing Data---");
            foreach (string key in viewContext.RouteData.Values.Keys) {
                Write(writer, "Key: {0}, Value: {1}",
                    key, viewContext.RouteData.Values[key]);
            }

            Write(writer, "---View Data---");
            foreach (string key in viewContext.ViewData.Keys) {
                Write(writer, "Key: {0}, Value: {1}", key,
                    viewContext.ViewData[key]);
            }
        }

        private void Write(TextWriter writer, string template, params object[] values) {
            writer.Write(string.Format(template, values) + "<p/>");
        }
    }
}
```

##Creating an IView Implementation##

```
﻿using System.Web.Mvc;

namespace Views.Infrastructure {
    public class DebugDataViewEngine : IViewEngine {

        public ViewEngineResult FindView(ControllerContext controllerContext,
                string viewName, string masterName, bool useCache) {

            if (viewName == "DebugData") {
                return new ViewEngineResult(new DebugDataView(), this);
            } else {
                return new ViewEngineResult(new string[] { "No view (Debug Data View Engine)" });
            }
        }

        public ViewEngineResult FindPartialView(ControllerContext controllerContext,
                string partialViewName, bool useCache) {

            return new ViewEngineResult(new string[] { "No view (Debug Data View Engine)" });
        }

        public void ReleaseView(ControllerContext controllerContext, IView view) {
            // do nothing
        }
    }
}
```

##Registering a Custom View Engine##


Register view engines in the Application_Start method of Global.asax,

```
ViewEngines.Engines.Add(new DebugDataViewEngine());
```

 The MVC Framework supports the idea of there being several engines installed in a single application.

When a ViewResult is being processed, the action invoker obtains the set of installed view engines and calls their FindView methods in turn. The action invoker stops calling FindView methods as soon as it receives a ViewEngineResult object that contains an IView. This means that the order in which engines are added to the ViewEngines.Engines collection is significant if two or more engines are able to service a request for the same view name.

```
ViewEngines.Engines.Insert(0, new DebugDataViewEngine());
```

```
ViewEngines.Engines.Clear();             
ViewEngines.Engines.Add(new DebugDataViewEngine());
```

##Working with the Razor Engine##

###Understanding Razor View Rendering###

The Razor View Engine compiles the views in your applications to improve performance. The views are translated into C# classes, and then compiled, which is why you are able to include C# code fragments so easily.

The views in an MVC application are not compiled until the application is started,

The initial request to MVC application triggers the compilation process for all views.

You can find the generated files in c:\Users\< yourLoginName> \AppData\Local\Temp\Temporary ASP.NET Files on Windows 7 and Windows 8.

Listing 20-11.  The Generated C# Class for a Razor View 

```
namespace ASP {
     
using System;     
using System.Collections.Generic;     
using System.IO;     
using System.Linq;     
using System.Net;     
using System.Web;     
using System.Web.Helpers;     
using System.Web.Security;     
using System.Web.UI;     
using System.Web.WebPages;     
using System.Web.Mvc;     
using System.Web.Mvc.Ajax;     
using System.Web.Mvc.Html;     
using System.Web.Optimization;     
using System.Web.Routing;     

public class _Page_Views_Home_Index_cshtml : System.Web.Mvc.WebViewPage<string[]> {

         public _Page_Views_Home_Index_cshtml() { }

         public override void Execute() {
             ViewBag.Title = "Index";
             WriteLiteral("\r\n\r\nThis is a list of fruit names:\r\n\r\n");
             foreach (string name in Model) {
                 WriteLiteral("    <span><b>");
                 Write(name);
                 WriteLiteral("</b></span>\r\n");
             }
         }
     } 
}
```

The class that has been generated: _Page_Views_Home_Index_cshtml. You can see how the path of the view file has been encoded in the class name. This is how Razor maps requests for views into instances of compiled classes.

The HTML elements are handled with the WriteLiteral method, which writes the contents of the parameter to the result as they are given. This is opposed to the Write method, which is used for C# variables and encodes the string values to make them safe for use in an HTML page.

##Configuring the View Search Locations##


Razor looks through this list of views: 

- ∼/Views/Home/Index.cshtml 
- ∼/Views/Home/Index.vbhtml 
- ∼/Views/Shared/Index.cshtml 
- ∼/Views/Shared/Index.vbhtml

You can change the view files that Razor searches for by creating a subclass of RazorViewEngine. This class is the Razor IViewEngine implementation. It builds on a series of base classes that define a set of properties that determine which view files are searched for. These properties are described in Table 20-4.

Table 20-4. Razor View Engine Search Properties 

|Property| Description| Default Value |
|--|--|--|
|ViewLocationFormats, MasterLocationFormats, PartialViewLocationFormats |The locations to look for views, partial views, and layouts| ∼/Views/\{1}/\{0}.cshtml, ∼/Views/\{1}/\{0}.vbhtml, ∼/Views/Shared/\{0}.cshtml, ∼/Views/Shared/\{0}.vbhtml |
|AreaViewLocationFormats, AreaMasterLocationFormats,  AreaPartialViewLocationFormats| The locations to look for views, partial views, and layouts for an area |∼/Areas/\{2}/Views/\{1}/\{0}.cshtml, ∼/Areas/\{2}/Views/\{1}/\{0}.vbhtml, ∼/Areas/\{2}/Views/Shared/\{0}.cshtml, ∼/Areas/\{2}/Views/Shared/\{0}.vbhtml|

These properties predate the introduction of Razor, which why each set of three properties has the same values.

The following are the parameter values that correspond to the placeholders: 

- {0} represents the name of the view. 
- {1} represents the name of the controller. 
- {2} represents the name of the area.

To change the search locations, you create a new class that is derived from RazorViewEngine and change the values for one or more of the properties described in Table 20-4.


```
﻿using System.Web.Mvc;

namespace WorkingWithRazor.Infrastructure {
    public class CustomLocationViewEngine : RazorViewEngine {

        public CustomLocationViewEngine() {
            ViewLocationFormats = new string[] { "~/Views/{1}/{0}.cshtml", "~/Views/Common/{0}.cshtml" };
        }
    }
}
```

Register the derived view engine using the ViewEngines.Engines collection in the Application_Start method of Global.asax,

```
ViewEngines.Engines.Clear();             
ViewEngines.Engines.Add(new CustomLocationViewEngine());
```

##Adding Dynamic Content to a Razor View##

Table 20-5. Adding Dynamic Content to a View 

|Technique| When to Use|
|--|--|
| Inline code| Use for small, self-contained pieces of view logic, such as if and foreach statements. This is the fundamental tool for creating dynamic content in views, and some of the other approaches are built on it. I introduced this technique in Chapter 5 and you have seen countless examples in the chapters since. |
|HTML helper methods| Use to generate single HTML elements or small collections of them, typically based on view model or view data values. The MVC Framework includes a number of useful HTML helper methods, and it is easy to create your own. HTML helper methods are the topic of Chapter 21. |
|Sections| Use for creating sections of content that will be inserted into layout at specific locations. |
|Partial views| Use for sharing subsections of view markup between views. Partial views can contain inline code, HTML helper methods, and references to other partial views.  Partial views do not invoke an action method, so they cannot be used to perform business logic. |
|Child actions| Use for creating reusable UI controls or widgets that need to contain business logic. When you use a child action, it invokes an action method, renders a view, and injects the result into the response stream.|

###Using Layout Sections###

Listing 20-16.  Defining a Section in the Index.cshtml File 


```
@model string[] @{
     ViewBag.Title = "Index";
     Layout = "∼/Views/Shared/_Layout.cshtml"; 
} 

@section Header {
     <div class="view">
         @foreach (string str in new [] {"Home", "List", "Edit"}) {
             @Html.ActionLink(str, str, null, new { style = "margin: 5px" })
         }
     </div> } 

<div class="view">
     This is a list of fruit names:
     @foreach (string name in Model) {
         <span><b>@name</b></span>
     } 
</div> 

@section Footer {
     <div class="view">
         This is the footer     </div> 
}
```

Sections are defined in the view, but applied in a layout with the @RenderSection helper method.

```
﻿<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <style type="text/css">
        div.layout { background-color: lightgray; }
        div.view { border: thin solid black; margin: 10px 0; }
    </style>
    <title>@ViewBag.Title</title>
</head>
<body>
    @RenderSection("Header")

    <div class="layout">
        This is part of the layout
    </div>

    @RenderBody()

    <div class="layout">
        This is part of the layout
    </div>

    @RenderSection("Footer")
    <div class="layout">
        This is part of the layout
    </div>
</body>
</html>
```


The parts of the view that are not contained with a section are inserted into the layout using the RenderBody helper.

>**Note**  A view can define only the sections that are referred to in the layout. The MVC Framework will throw an exception if you attempt to define sections in the view for which there is no corresponding @RenderSection helper call in the layout.

Mixing the sections in with the rest of the view is unusual. The convention is to define the sections at either the start or the end of the view, to make it easier to see which regions of content will be treated as sections and which will be captured by the RenderBody helper.

Another approach, which I tend to use, is to define the view solely in terms of sections, including one for the body, as shown in Listing 20-18.

```
﻿@model string[]

@{
    ViewBag.Title = "Index";
    Layout = "~/Views/Shared/_Layout.cshtml";
}

@section Header {
    <div class="view">
        @foreach (string str in new[] { "Home", "List", "Edit" }) {
            @Html.ActionLink(str, str, null, new { style = "margin: 5px" })
        }
    </div>
}

@section Body {
    <div class="view">
        This is a list of fruit names:

        @foreach (string name in Model) {
            <span><b>@name</b></span>
        }
    </div>
}

@section Footer {
    <div class="view">
        This is the footer
    </div>
}
```

To use this approach, I have to replace the call to the RenderBody helper with RenderSection("Body"), as shown in Listing 20-19.


```
﻿<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <style type="text/css">
        div.layout { background-color: lightgray; }
        div.view { border: thin solid black; margin: 10px 0; }
    </style>
    <title>@ViewBag.Title</title>
</head>
<body>
    @RenderSection("Header")

    <div class="layout">
        This is part of the layout
    </div>

    @RenderSection("Body")

    <div class="layout">
        This is part of the layout
    </div>

    @RenderSection("Footer")
    <div class="layout">
        This is part of the layout
    </div>
</body>
</html>
```


###Testing For Sections###

Listing 20-20.  Checking Whether a Section Is Defined in the _Layout.cshtml File 

```
@if (IsSectionDefined("Footer")) {
     @RenderSection("Footer") 
} else {
     <h4>This is the default footer</h4> 
}
```

###Rendering Optional Sections###

By default a view has to contain all of the sections for which there are RenderSection calls in the layout. If sections are missing, then the MVC Framework will report an exception to the user.

A more elegant approach to IsSectionDefined is to use optional sections,

```
@RenderSection("scripts", false)
```

###Using Partial Views###

Partial views, which are separate view files that contain fragments of tags and markup that can be included in other views.

####Creating a Partial View####

> **Tip**  The scaffolding feature only sets the initial content for a file. What makes a view a partial is its content (it only contains a fragment of HTML, rather than a complete HTML document, and doesn't reference layouts) and the way that it is used (which I describe shortly). Once you are familiar with the different kinds of view, you can just use Add MVC 5 View Page (Razor) and set the contents you require directly.

You can mix HTML markup and Razor tags in a partial view,

A partial view is consumed by calling the Html.Partial helper method from within another view.

```
@Html.Partial("MyPartial")
```

The view engine will look for the partial view that I have specified in the usual locations, which means the /Views/Home and /Views/Shared folders for this example:

>**Tip**  The Razor View Engine looks for partial views in the same way that it looks for regular views (in the ∼/Views/<controller> and ∼/Views/Shared folders). This means that you can create specialized versions of partial views that are controller-specific and override partial views of the same name in the Shared folder.

>**Tip**  The call I made to the ActionLink helper method in the partial view takes its controller information from the request that is being processed.

###Using Strongly Typed Partial Views###

```
﻿@model IEnumerable<string>

<div>
    This is the message from the partial view.
    <ul>
        @foreach (string str in Model) {
            <li>@str</li>
        }
    </ul>
</div>
```


```
@Html.Partial("MyStronglyTypedPartial", new [] {"Apple", "Orange", "Pear"})
```

###Using Child Actions###

Child actions are action methods invoked from within a view. This lets you avoid repeating controller logic that you want to use in several places in the application. Child actions are to actions as partial views are to views.

You can use a child action whenever you want to display some data-driven widget that appears on multiple pages and contains data unrelated to the main action that is running.

####Creating a Child Action####

```
[ChildActionOnly]         
public ActionResult Time() {
     return PartialView(DateTime.Now);
}
```

An action method doesn’t need to have this attribute to be used as a child action, but I tend to use it to prevent the action methods from being invoked as a result of a user request.

Child actions are typically associated with partial views, although this is not compulsory.

```
﻿@model DateTime

<p>The time is: @Model.ToShortTimeString()</p>
```

####Rendering a Child Action####

Child actions are invoked using the Html.Action helper.

With this helper, the action method is executed, the ViewResult is processed, and the output is injected into the response to the client.

```
@Html.Action("Time")
```

This looks for the action method on the controller which is handling the request, to call action methods on other controllers we can specify the controller name:

```
@Html.Action("Time", "MyController")
```

You can pass parameters to action methods by providing an anonymously typed object whose properties correspond to the names of the child action method parameters.

```
[ChildActionOnly] 
public ActionResult Time(DateTime time) {
     return PartialView(time);
 }
```

```
@Html.Action("Time", new { time = DateTime.Now })
```


#CHAPTER 21 Helper Methods# {#Chap21}

##Creating Custom Helper Methods##

###Creating an Inline Helper Method###

```
<div>
         Here are the fruits: @ListArrayItems(ViewBag.Fruits)
</div>
```

Although an inline helper looks like a method, there is no return value. The contents of the helper body are processed and put into the response to the client.

> **Tip**  Notice that I did not have to cast the dynamic properties from the ViewBag to string arrays when using the inline helper. One of the nice features of this kind of helper method is that it is happy to evaluate types at runtime.


```
@helper ListArrayItems(string[] items) {
     <ul>
         @foreach(string str in items) {
             <li>@str</li>
         }
     </ul> 
}
```

> **Tip**  Notice that I had to prefix the foreach keyword with @ in this example but not in Listing 21-4. This is because the first element in the helper body changed to become an HTML element, which means I have to use @ to tell Razor that I am using a C# statement.

###Creating an External Helper Method###


```
﻿using System.Web.Mvc;
using System;

namespace HelperMethods.Infrastructure {
    public static class CustomHelpers {

        public static MvcHtmlString ListArrayItems(this HtmlHelper html, string[] list) {

            TagBuilder tag = new TagBuilder("ul");

            foreach (string str in list) {
                TagBuilder itemTag = new TagBuilder("li");
                itemTag.SetInnerText(str);
                tag.InnerHtml += itemTag.ToString();
            }

            return new MvcHtmlString(tag.ToString());
        }
    }
}
```

Table 21-2. Useful Properties Defined by the HtmlHelper Class 

|Property| Description|
|--|--|
| RouteCollection| Returns the set of routes defined by the application 
|ViewBag| Returns the view bag data passed from the action method to the view that has called the helper method |
|ViewContext| Returns a ViewContext object, which provides access to details of the request and how it has been handled (and which I describe below)|

The ViewContext property is the most useful when you want to create content which adapts to the request being processed.

Table 21-3. Useful Properties Defined by the ViewContext Class 

|Property| Description|
|--|--|
| Controller| Returns the controller processing the current request|
| HttpContext| Returns the HttpContext object that describes the current request|
| IsChildAction| Returns true if the view that has called the helper is being rendered by a child action (see Chapter 20 for details of child actions) |
|RouteData| Returns the routing data for the request|
| View| Returns the instance of the IView implementation that has called the helper method|

But for the most part helper methods are simple and used to keep formatting consistent.

The TagBuilder class, which allows you to build up HTML strings without needing to deal with all of the escaping and special characters.

The TagBuilder class is part of the System.Web.WebPages.Mvc assembly but uses a feature called type forwarding to appear as though it is part of the System.Web.Mvc assembly.

It does not appear in the Microsoft Developer Network (MSDN) API documentation.

Table 21-4. Some Members of the TagBuilder Class 

|Member| Description|
|--|--|
| InnerHtml| A property that lets you set the contents of the element as an HTML string. The value assigned to this property will not be encoded, which means that is can be used to nest HTML elements. 
|SetInnerText(string) |Sets the text contents of the HTML element. The string parameter is encoded to make it safe to display. |
|AddCssClass(string)| Adds a CSS class to the HTML element| 
|MergeAttribute(string, string, bool) |Adds an attribute to the HTML element. The first parameter is the name of the attribute, and the second is the value. The bool parameter specifies if an existing attribute of the same name should be replaced.|

The result of an HTML helper method is an MvcHtmlString object, the contents of which are written directly into the response to the client.

##Using a Custom External Helper Method##

```
@using HelperMethods.Infrastructure

// ...
<div>         
Here are the fruits: @Html.ListArrayItems((string[])ViewBag.Fruits)     
</div>
```

I need to ensure that the namespace that contains the helper extension method is in scope. I have done this using an @using tag, but if you are developing a lot of custom helpers then you will want to add the namespaces that contain them to the /Views/Web.config file so that they are always available in your views.

The Html part of this expression refers to a property defined by the view base class, which returns an HtmlHelper object, which is the type to which I applied the extension method in Listing 21-5

###KNOWING WHEN TO USE HELPER METHODS###

Only use helper methods to reduce the amount of duplication in views, just as I did in this example, and only for the simplest of content. For more complex markup and content I use partial views and I use a child action when I need to perform any manipulation of model data.

##Managing String Encoding in a Helper Method##

The MVC Framework makes an effort to protect you from malicious data by automatically encoding it so that it can be added to an HTML page safely.

Razor encodes data values automatically when they are used in a view, but helper methods need to be able to generate HTML.

As a consequence, they are given a higher level of trust by the view engine, and this can require some careful attention.

##Encoding Helper Method Content##

The simplest solution is to change the return type of the helper method to string, as shown in Listing 21-10. This alerts the view engine that your content is not safe and should be encoded before it is added to the view.

This technique causes Razor to encode all of the content that is returned by the helper, which is a problem when you are generating HTML elements (as I am in the example helper), but which is convenient otherwise.

Listing 21-11.  Selectively Encoding Data Values in the CustomHelpers.cs 

```
﻿using System.Web.Mvc;
using System;

namespace HelperMethods.Infrastructure {
    public static class CustomHelpers {   
        public static MvcHtmlString DisplayMessage(this HtmlHelper html, string msg) {
            string encodedMessage = html.Encode(msg);
            string result = String.Format("This is the message: <p>{0}</p>", encodedMessage);
            return new MvcHtmlString(result);
        }

    }
}
```

##Using the Built-In Form Helper Methods##

###Creating Form Elements###

```
﻿@model HelperMethods.Models.Person

@{
    ViewBag.Title = "CreatePerson";
    Layout = "/Views/Shared/_Layout.cshtml";
}
<h2>CreatePerson</h2>

<form action="/Home/CreatePerson" method="post">
@using (Html.BeginRouteForm("FormRoute", new { }, FormMethod.Post,
    new { @class = "personClass", data_formType = "person" })) {

    <div class="dataElem">
        <label>PersonId</label>
        @Html.TextBoxFor(m => m.PersonId)
    </div>
    <div class="dataElem">
        <label>First Name</label>
        @Html.TextBoxFor(m => m.FirstName)
    </div>
    <div class="dataElem">
        <label>Last Name</label>
        @Html.TextBoxFor(m => m.LastName)
    </div>
    <div class="dataElem">
        <label>Role</label>
        @Html.DropDownListFor(m => m.Role,
            new SelectList(Enum.GetNames(typeof(HelperMethods.Models.Role))))
    </div>
    <input type="submit" value="Submit" />
</form>
```

>**Tip**  Notice that I have set the name attribute on all of the input elements so that it corresponds to the model property that the input element displays. The name attribute is used by the MVC Framework default model binder to work out which input elements contain values for the model type properties when processing a post request.

###Creating Form Elements###

Two of the most useful (and most commonly used) helpers are Html.BeginForm and Html.EndForm. These helpers create HTML form tags and generate a valid action attribute

There are 13 different versions of the BeginForm method, allowing you to be increasingly specific about how the resulting form element will be generated.

The EndForm helper has only one definition and it just closes the form element by adding </form> to the view.


```
@{Html.BeginForm();} 
// foo
{Html.EndForm();}

```

Creating a Self-Closing Form

```
@using(Html.BeginForm()) {
// foo
}
```

Table 21-5. The Overloads of the BeginForm Helper Method 

|Overload| Description|
|--|--|
| BeginForm() |Creates a form which posts back to the action method it originated from|
| BeginForm(action , controller) |Creates a form which posts back to the action method and controller, specified as strings |
|BeginForm(action, controller, method) |As for the previous overload, but allows you to specify the value for the method attribute using a value from the System.Web.Mvc.FormMethod enumeration |
|BeginForm(action, controller, method, attributes) |As for the previous overload, but allows you to specify attributes for the form element an object whose properties are used as the attribute names|
| BeginForm(action, controller, routeValues , method, attributes) |As for the previous overload, but allows you to specify values for the variable route segments in your application routing configuration as an object whose properties correspond to the routing variables|

Using the Most Complex Overload of the BeginForm Method

```
@using (Html.BeginForm("CreatePerson", "Home",
     new { id = "MyIdValue" }, FormMethod.Post,
     new { @class = "personClass", data_formType="person"})) {
}
```

In this example, I have explicitly specified some details that would have been inferred automatically by the MVC Framework, such as the action name and the controller. I also specified that the form should be submitted using the HTTP POST method, which would have been used anyway.

Notice that I specified an attribute called data_formType in the call to BeginForm but ended up with a data-formType attribute in the output. You cannot specify property names in a dynamic object that contain hyphens, so I use an underscore that is then automatically mapped to a hyphen in the output, neatly side-stepping a mismatch between the C# and HTML syntaxes. (And, of course, I had to prefix the property name class with a @ so that I can use a C#-reserved keyword as a property name for the class attribute.)

##Specifying the Route Used by a Form##

The BeginForm method, the MVC Framework finds the first route in the routing configuration that can be used to generate a URL that will target the required action and controller.

If you want to ensure that a particular route is used, then you can use the BeginRouteForm helper method instead.

```
@using(Html.BeginRouteForm("FormRoute", new {}, FormMethod.Post,
     new { @class = "personClass", data_formType="person"})) {
// foo
}
```

##Using Input Helpers##

able 21-6. Basic Input HTML Helpers 

|HTML Element |Example|
|--|--|
| Check box |Html.CheckBox("myCheckbox", false) Output: < input id="myCheckbox" name="myCheckbox" type="checkbox" value="true" /> < input name="myCheckbox" type="hidden" value="false" /> |
|Hidden field| Html.Hidden("myHidden", "val") Output: < input id="myHidden" name="myHidden" type="hidden" value="val" /> |
|Radio button| Html.RadioButton("myRadiobutton", "val", true) Output: < input checked="checked" id="myRadiobutton" name="myRadiobutton"type="radio" value="val" /> |
|Password| Html.Password("myPassword", "val") Output: < input id="myPassword" name="myPassword" type="password" value="val" /> |
|Text area| Html.TextArea("myTextarea", "val", 5, 20, null) Output: < textarea cols="20" id="myTextarea" name="myTextarea" rows="5"> val< / textarea> |
|Text box| Html.TextBox("myTextbox", "val") Output: < input id="myTextbox" name="myTextbox" type="text" value="val" />|

>**Note**  Notice that the checkbox helper (Html.CheckBox) renders two input elements. It renders a checkbox and then a hidden input element of the same name. This is because browsers do not submit a value for checkboxes when they are not selected. Having the hidden control ensures that the MVC Framework will get a value from the hidden field when this happens.

Listing 21-22.  Using the Basic Input Element Helper Methods in the CreatePerson.cshtml File:


```
﻿@model HelperMethods.Models.Person

@{
    ViewBag.Title = "CreatePerson";
    Layout = "/Views/Shared/_Layout.cshtml";
}
<h2>CreatePerson</h2>

@using (Html.BeginRouteForm("FormRoute", new { }, FormMethod.Post,
    new { @class = "personClass", data_formType = "person" })) {

    <div class="dataElem">
        <label>PersonId</label>
        @Html.TextBox("PersonId", @model.PersonId)
    </div>
    <div class="dataElem">
        <label>First Name</label>
        @Html.TextBox("FirstName", @model.FirstName)
    </div>
    <div class="dataElem">
        <label>Last Name</label>
        @Html.TextBox("LastName", @model.LastName)
    </div>
    <input type="submit" value="Submit" />
}
```

###Generating the Input Element from a Model Property###


```
﻿@model HelperMethods.Models.Person

@{
    ViewBag.Title = "CreatePerson";
    Layout = "/Views/Shared/_Layout.cshtml";
}
<h2>CreatePerson</h2>

@using (Html.BeginRouteForm("FormRoute", new { }, FormMethod.Post,
    new { @class = "personClass", data_formType = "person" })) {

    <div class="dataElem">
        <label>PersonId</label>
        @Html.TextBox(m => m.PersonId)
    </div>
    <div class="dataElem">
        <label>First Name</label>
        @Html.TextBox(m => m.FirstName)
    </div>
    <div class="dataElem">
        <label>Last Name</label>
        @Html.TextBox(m => m.LastName)
    </div>
    <input type="submit" value="Submit" />
}
```

The string argument is used to search the view data, ViewBag, and view model to find a corresponding data item that can be used as the basis for the input element.

The following locations are checked: 

- ViewBag.DataValue 
- @Model.DataValue

If I specify a string like DataValue.First.Name, the search becomes more complicated. The MVC Framework will try different arrangements of the dot-separated elements, such as the following: 

- ViewBag.DataValue.First.Name 
- ViewBag.DataValue["First"].Name 
- ViewBag.DataValue["First.Name"] 
- ViewBag.DataValue["First"]["Name"]

##Using Strongly Typed Input Helpers##

Add a note
For each of the basic input helpers that I described in Table 21-6, there are corresponding strongly typed helpers.

Table 21-7. Strongly Typed Input HTML Helpers 

|HTML Element| Example|
|--|--|
| Check box| Html.CheckBoxFor(x => x.IsApproved) Output: < input id="IsApproved" name="IsApproved" type="checkbox" value="true" /> < input name="IsApproved" type="hidden" value="false" /> |
|Hidden field| Html.HiddenFor(x => x.FirstName) Output: < input id="FirstName" name="FirstName" type="hidden" value="" /> |
|Radio button| Html.RadioButtonFor(x => x.IsApproved, "val") Output: < input id="IsApproved" name="IsApproved" type="radio" value="val" /> |
|Password Html|.PasswordFor(x => x.Password) Output: < input id="Password" name="Password" type="password" /> |
|Text area| Html.TextAreaFor(x => x.Bio, 5, 20, new\{}) Output: < textarea cols="20" id="Bio" name="Bio" rows="5">Bio value < / textarea> |
|Text box| Html.TextBoxFor(x => x.FirstName) Output: < input id="FirstName" name="FirstName" type="text" value="" /> |

Listing 21-25.  Using the Strongly Typed Input Helper Methods in the CreatePerson.cshtml 

```
﻿@model HelperMethods.Models.Person

@{
    ViewBag.Title = "CreatePerson";
    Layout = "/Views/Shared/_Layout.cshtml";
}
<h2>CreatePerson</h2>

@using (Html.BeginRouteForm("FormRoute", new { }, FormMethod.Post,
    new { @class = "personClass", data_formType = "person" })) {

    <div class="dataElem">
        <label>PersonId</label>
        @Html.TextBoxFor(m => m.PersonId)
    </div>
    <div class="dataElem">
        <label>First Name</label>
        @Html.TextBoxFor(m => m.FirstName)
    </div>
    <div class="dataElem">
        <label>Last Name</label>
        @Html.TextBoxFor(m => m.LastName)
    </div>
    <input type="submit" value="Submit" />
}
```

##Creating Select Elements##

Table 21-8. HTML Helpers That Render Select Elements 

|HTML| Element Example| 
|--|--|
|Drop-down list| Html.DropDownList("myList", new SelectList(new [] \{"A", "B"}), "Choose") Output: < select id="myList" name="myList">           < option value="">Choose< / option>           < option>A< / option>           < option>B< /option> </select> |
|Drop-down list| Html.DropDownListFor(x => x.Gender, new SelectList(new [] \{"M", "F"})) Output: < select id="Gender" name="Gender">           < option>M< / option>           < option>F< / option> < / select> |
|Multiple-select| Html.ListBox("myList", new MultiSelectList(new [] \{"A", "B"})) Output: <\select id="myList" multiple="multiple" name="myList">           < option>A< / option>           < option>B< / option> < / select> 
|Multiple-select| Html.ListBoxFor(x => x.Vals, new MultiSelectList(new [] \{"A", "B"\})) Output: < select id="Vals" multiple="multiple" name="Vals">           < option>A< /option>           < option>B< /option> < / select>

The select helpers take SelectList or MultiSelectList parameters.

A nice feature of SelectList and MultiSelectList is that they will extract values from objects, including the model object, for the list items.

```
@Html.DropDownListFor(m => m.Role,
             new SelectList(Enum.GetNames(typeof(HelperMethods.Models.Role))))
```

#CHAPTER 22 Templated Helper Methods# {#Chap22}

##Using Templated Helper Methods##

Html.Editor and Html.EditorFor; the Editor method takes a string argument that specifies the property for which editor element is required. The helper follows the search process that I described in Chapter 20 to locate a corresponding property in the view bag and model object.

The EditorFor method is the strongly typed equivalent,

```
@Html.Editor("PersonId")
@Html.EditorFor(m => m.LastName)
```

The HTML elements that are created by the Editor and EditorFor methods are the same. The only difference is the way that you specify the property that the editor elements are created for.

The HTML5 specification defines different types of input element that can be used to edit common data types, such as numbers and dates. The Helper and HelperFor methods use the type of the property I want to edit to select one of those new input element types.

> **Tip**  Most web UI toolkits include date pickers that you can use instead of relying on the HTML5 input element types. If you have not already selected such a toolkit for a project, then I suggest you start with jQuery UI (http://jqueryui.com), which is an open-source toolkit, built on jQuery.

Table 22-2. The MVC Templated HTML Helpers 

|Helper| Example| Description |
|--|--|--|
|Display| Html.Display("FirstName") |Renders a read-only view of the specified model property, choosing an HTML element according to the property’s type and metadata 
|DisplayFor| Html.DisplayFor(x => x.FirstName) |Strongly typed version of the previous helper |
|Editor| Html.Editor("FirstName") |Renders an editor for the specified model property, choosing an HTML element according to the property’s type and metadata |
|EditorFor |Html.EditorFor(x => x.FirstName) |Strongly typed version of the previous helper |
|Label| Html.Label("FirstName") |Renders an HTML <label> element referring to the specified model property | 
|LabelFor| Html.LabelFor(x => x.FirstName) |Strongly typed version of the previous helper|

##Generating Label and Display Elements##

```

<div class="dataElem">
     @Html.LabelFor(m => m.Role)
     @Html.DisplayFor(m => m.Role) 
</div>
```

The Label and LabelFor helpers have just used the property names as the content.

##Using Whole-Model Templated Helpers##

The MVC Framework also defines helpers that operate on the entire objects, a process known as scaffolding.

Table 22-3. The MVC Scaffolding Templated Helper methods 

|Helper| Example| Description|
|--|--|--|
|DisplayForModel| Html.DisplayForModel() |Renders a read-only view of the entire model object|
| EditorForModel| Html.EditorForModel() |Renders editor elements for the entire model object |
|LabelForModel| Html.LabelForModel() |Renders an HTML <label> element referring to the entire model object|

Listing 22-9.  Using the Scaffolding Helper Methods in the CreatePerson.cshtml File 

```
@model HelperMethods.Models.Person 

@{
     ViewBag.Title = "CreatePerson";
     Layout = "/Views/Shared/_Layout.cshtml";
     Html.EnableClientValidation(false); 
} 
<h2>CreatePerson: @Html.LabelForModel()</h2> 

@using(Html.BeginRouteForm("FormRoute", new {}, FormMethod.Post,
     new { @class = "personClass", data_formType="person"})) {
            @Html.EditorForModel()
          <input type="submit" value="Submit" /> 
}
```

##Using Model Metadata##

Fortunately, the templated helpers can be improved by using model metadata to provide guidance about how to handle model types.

###Using Metadata to Control Editing and Visibility###

I can use the HiddenInput attribute, which causes the helper to render a hidden input field.

```
public class Person {
         [HiddenInput]
         public int PersonId { get; set; }
         public string FirstName { get; set; }
	// Foo
```

The above will render a readonly field for model field; the following will not.

```
[HiddenInput(DisplayValue=false)]     
public int PersonId { get; set; }
```


###EXCLUDING A PROPERTY FROM SCAFFOLDING###

To completely exclude a property from the generated HTML, I can use the ScaffoldColumn attribute. Whereas the HiddenInput attribute includes a value for the property in a hidden input element, the ScaffoldColumn attribute can mark a property as being entirely off limits for the scaffolding process. Here is an example of the attribute in use:

```
[ScaffoldColumn(false)] 
public int PersonId { get; set; }
```

When the scaffolding helpers see the ScaffoldColumn attribute applied in this way, they skip over the property entirely; no hidden input elements will be created, and no details of this property will be included in the generated HTML.

###Using Metadata for Labels###

By default, the Label, LabelFor, LabelForModel, and EditorForModel helpers use the names of properties

The DisplayName attribute from the System.ComponentModel.DataAnnotations

```
[Display(Name = "Birth Date")]         
public DateTime BirthDate { get; set; }
```

The helpers also recognize the DisplayName attribute, which can be found in the System.ComponentModel namespace.

This attribute has the advantage of being able to be applied to classes, which allows me to use the Html.LabelForModel helper.

###Using Metadata for Data Values###

I control the way that data values are displaying using the DataType attribute,

```
[DataType(DataType.Date)]     
public DateTime BirthDate { get; set; }
```

Table 22-4. The Values of the DataType Enumeration 

|Value| Description|
|--|--
|DateTime| Displays a date and time (this is the default behavior for System.DateTime values) |
|Date| Displays the date portion of a DateTime |
|Time| Displays the time portion of a DateTime |
|Text| Displays a single line of text |
|PhoneNumber| Displays a phone number |
|MultilineText| Renders the value in a textarea element |
|Password| Displays the data so that individual characters are masked from view |
|Url| Displays the data as a URL (using an HTML a element) |
|EmailAddress| Displays the data as an e-mail address (using an a element with a mailto href)|

The effect of these values depends on the type of the property they are associated with and the helper being used.

###Using Metadata to Select a Display Template###

Templated helpers use display templates to generate HTML.

The template that is used is based on the type of the property being processed and the kind of helper being used.

The UIHint attribute to specify the template used to render HTML for a property,

```
[UIHint("MultilineText")]     
public string FirstName { get; set; }
```

Table 22-5. The Built-In MVC Framework View Templates 

|Value| Effect (Editor) |Effect (Display) |
|--|--|--|
|Boolean| Renders a checkbox for bool values. For nullable bool? values, a select element is created with options for True, False, and Not Set. |As for the editor helpers, but with the addition of the disabled attribute, which renders read-only HTML controls| 
|Collection| Renders the appropriate template for each of the elements in an IEnumerable sequence. The items in the sequence do not have to be of the same type. |As for the editor helper |
|Decimal| Renders a single-line textbox input element and formats the data value to display two decimal places |Renders the data value formatted to two decimal places |
|DateTime| Renders an input element whose type attribute is datetime and which contains the complete date and time |Renders the complete value of a DateTime variable |
|Date| Renders an input element whose type attribute is date and that contains the date component (but not the time) |Renders the date component of a DateTime variable |
|EmailAddress |Renders the value in a single-line textbox input element |Renders a link using an HTML a element and an href attribute that is formatted as a mailto URL |
|HiddenInput| Creates a hidden input element Renders the data value and creates a hidden input element |
|Html| Renders the value in a single-line textbox input element |Renders a link using an HTML a element |
|MultilineText |Renders an HTML textarea element that contains the data value |Renders the data value |
|Number| Renders an input element whose type attribute is set to number |Renders the data value| 
|Object| See explanation after this table| See explanation after this table |
|Password| Renders the value in a single-line textbox input element so that the characters are not displayed but can be edited |Renders the data value—the characters are not obscured |
|String| Renders the value in a single-line textbox input element |Renders the data value| 
|Text| Identical to the String template| Identical to the String template |
|Tel| Renders an input element whose type attribute is set to tel |Renders the data value |
|Time| Renders an input element whose type attribute is time and which contains the time component (but not the date) |Renders the time component of a DateTime variable |
|Url| Renders the value in a single-line textbox input element |Renders a link using an HTML a element. The inner HTML and the href attribute are both set to the data value.|

>**Caution**  Care must be taken when using the UIHint attribute. I will receive an exception if I select a template that cannot operate on the type of the property I have applied it

The Object template is a special case. It is the template used by the scaffolding helpers to generate HTML for a view model object. This template examines each of the properties of an object and selects the most suitable template for the property type. The Object template takes metadata such as the UIHint and DataType attributes into account.

###Applying Metadata to a Buddy Class###

It is not always possible to apply metadata to an entity model class.

Ensure that the model class is defined as partial and to create a second partial class that contains the metadata.

```
[MetadataType(typeof(PersonMetaData))]     
public partial class Person {
         public int PersonId { get; set;
	//foo
}
```

```
﻿using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace HelperMethods.Models {

    [DisplayName("New Person")]
    public partial class PersonMetaData {
        [HiddenInput(DisplayValue = false)]
        public int PersonId { get; set; }

        [Display(Name = "First")]
        public string FirstName { get; set; }

        [Display(Name = "Last")]
        public string LastName { get; set; }

        [Display(Name = "Birth Date")]
        [DataType(DataType.Date)]
        public DateTime BirthDate { get; set; }

        [Display(Name = "Approved")]
        public bool IsApproved { get; set; }
    }
}
```

The buddy class only needs to contain properties to which metadata applies. I do not have to replicate all of the properties of the Person class, for example.

The buddy class must be in the same namespace as the model class,

###Working with Complex Type Properties###

The HomeAddress was not rendered when I used the EditorForModel helper. This happens because the Object template operates only on simple types, which means those types that can be parsed from a string value using the GetConverter method of the System.ComponentModel.TypeDescriptor class.

```
﻿@model HelperMethods.Models.Person

@{
    ViewBag.Title = "CreatePerson";
    Layout = "/Views/Shared/_Layout.cshtml";
    Html.EnableClientValidation(false);
}
<h2>CreatePerson: @Html.LabelForModel()</h2>

@using (Html.BeginRouteForm("FormRoute", new { }, FormMethod.Post,
    new { @class = "personClass", data_formType = "person" })) {

    <div class="column">
        @Html.EditorForModel()
    </div>
    <div class="column">
        @Html.EditorFor(m => m.HomeAddress)
    </div>
    <input type="submit" value="Submit" />
}
```

##Customizing the Templated View Helper System##

###Creating a Custom Editor Template###

Creating a custom editor template helps render exactly the HTML I want for a model property.

The MVC Framework looks for custom editor templates in the /Views/Shared/EditorTemplates folder,

```
﻿@model HelperMethods.Models.Role

@Html.DropDownListFor(m => m,
    new SelectList(Enum.GetNames(Model.GetType()), Model.ToString()))
```

When I use any of the templated helper methods to generate an editor for the Role type, my /Views/Shared/EditorTemplates/Role.cshtml file will be used, ensuring that I present the user with a consistent and usable representation of the data type.

###UNDERSTANDING THE TEMPLATE SEARCH ORDER###

The Role.cshtml template works because the MVC Framework looks for custom templates for a given C# type before it uses one of the built-in templates. In fact, there is a specific sequence that the MVC Framework follows to find a suitable template:

- The template passed to the helper. For example, Html.EditorFor(m => m.SomeProperty, "MyTemplate") would lead to MyTemplate being used. 
- Any template that is specified by metadata attributes, such as UIHint 
- The template associated with any data type specified by metadata, such as the DataType attribute 
- Any template that corresponds to the.NET class name of the data type being processed 
- The built-in String template if the data type being processed is a simple type 
- Any template that corresponds to the base classes of the data type 
- If the data type implements IEnumerable, then the built-in Collection template will be used.  
- If all else fails, the Object template will be used, subject to the rule that scaffolding is not recursive.

At each stage in the template search process, the MVC Framework looks for a template called EditorTemplates/ <name> for editor helper methods or DisplayTemplates/ <name> for display helper methods.

Custom templates are found using the same search pattern as regular views, which means I can create a controller-specific custom template and place it in the ∼/Views/ <controller> /EditorTemplates folder to override the templates found in the ∼/Views/Shared/EditorTemplates folder.

##Creating a Generic Template##

```
﻿@model Enum

@Html.DropDownListFor(m => m, Enum.GetValues(Model.GetType())
    .Cast<Enum>()
    .Select(m => {
        string enumVal = Enum.GetName(Model.GetType(), m);
        return new SelectListItem() {
            Selected = (Model.ToString() == enumVal),
            Text = enumVal,
            Value = enumVal
        };
    }))
```

```
[UIHint("Enum")]         
public Role Role { get; set; }
```


##Replacing the Built-in Templates##

If I create a custom template that has the same name as one of the built-in templates, the MVC Framework will use the custom version in preference to the built-in one.

Listing 22-22 shows the contents of the Boolean.cshtml file that I added to the /Views/Shared/EditorTemplates folder. This view replaces the built-in Boolean template which is used to render bool and bool? values.

```
﻿@model bool?

@if (ViewData.ModelMetadata.IsNullableValueType && Model == null) {
    @:(True) (False) <b>(Not Set)</b>
} else if (Model.Value) {
    @:<b>(True)</b> (False) (Not Set)
} else {
    @:(True) <b>(False)</b> (Not Set)
}
```


##CHAPTER 23 URL and Ajax Helper Methods## {#Chap23}

##Installing the NuGet Packages##

The MVC Framework relies on the Microsoft Unobtrusive Ajax

```
Install-Package jQuery –version 1.10.2 Install-Package Microsoft.jQuery.Unobtrusive.Ajax –version 3.0.0
```

##Creating Basic Links and URLs##

Table 23-2. HTML Helpers That Render URLs

| Description| Example|
|--|--|
|Application-relative URL| Url.Content("∼/Content/Site.css") Output: /Content/Site.css |
|Link to named action/controller| Html.ActionLink("My Link", "Index", "Home") Output: <a href="/">My Link</a> 
|URL for action| Url.Action("GetPeople", "People") Output: /People/GetPeople |
|URL using route data |Url.RouteUrl(new {controller = "People", action="GetPeople"}) Output: /People/GetPeople |
|Link using route data| Html.RouteLink("My Link", new {controller = "People", action="GetPeople"}) Output: <a href="/People/GetPeople">My Link</a> |
|Link to named route |Html.RouteLink("My Link", "FormRoute", new {controller = "People", action="GetPeople"}) Output: <a href="/app/forms/People/GetPeople">My Link</a>|

I have included this example because it makes it easy to experiment with routing changes and immediately see the effect.

##Using MVC Unobtrusive Ajax##

> **Tip**  The MVC Framework unobtrusive Ajax feature is based on jQuery. If you are familiar with the way that jQuery handles Ajax, then you will understand the MVC Ajax features.

###Preparing the Project for Unobtrusive Ajax###

Web.config file (the one in the root folder of the project) the configuration/appSettings element contains an entry for the UnobtrusiveJavaScriptEnabled property, which must be set to true,

(This property is set to true by default when Visual Studio creates the project.)

```
<add key="UnobtrusiveJavaScriptEnabled" value="true" />
```

Listing 23-6.  Adding References for the Unobtrusive Ajax JavaScript Libraries to the _Layout.cshtml File

```
<script src="∼/Scripts/jquery-1.10.2.js"></script>     
<script src="∼/Scripts/jquery.unobtrusive-ajax.js"></script>
```

##Creating an Unobtrusive Ajax Form##

###Preparing the Controller###

Get just the data I want through a child action, of the PeopleController:

```
public PartialViewResult GetPeopleData(string selectedRole = "All") {
             IEnumerable<Person> data = personData;
             if (selectedRole != "All") {
                 Role selected = (Role)Enum.Parse(typeof(Role), selectedRole);
                 data = personData.Where(p => p.Role == selected);
             }
             return PartialView(data);
         }
         public ActionResult GetPeople(string selectedRole = "All") {
             return View((object)selectedRole);
         }     
}
```

Because the selection of the data is handled in the GetPeopleData action method, I have been able to simplify the GetPeople action method and remove the HttpPost version entirely.

I created a new partial view file, /Views/People/GetPeopleData.cshtml,

```
﻿@using HelperMethods.Models
@model IEnumerable<Person>

@foreach (Person p in Model) {
    <tr>
        <td>@p.FirstName</td>
        <td>@p.LastName</td>
        <td>@p.Role</td>
    </tr>
}
```

Listing 23-9.  Updating the GetPeople.cshtml File to use the helper method:


```
    <tbody id="tableBody">
        @Html.Action("GetPeopleData", new { selectedRole = Model })
    </tbody>
```

###Creating the Ajax Form###

Updating to allow the form posting to be handle by AJAX:

```
@using HelperMethods.Models
@model string
@{
    ViewBag.Title = "GetPeople";
    Layout = "/Views/Shared/_Layout.cshtml";
    AjaxOptions ajaxOpts = new AjaxOptions {
        Url = Url.Action("GetPeopleData"),
        LoadingElementId = "loading",
        LoadingElementDuration = 1000,
        OnSuccess = "processData"
    };
}

```

AND 

```
@using (Ajax.BeginForm(ajaxOpts)) {
    <div>
        @Html.DropDownList("selectedRole", new SelectList(
            new[] { "All" }.Concat(Enum.GetNames(typeof(Role)))))
        <button type="submit">Submit</button>
    </div>
}

```


Table 23-3. AjaxOptions Properties 

|Property| Description|
|--|--|
| Confirm| Sets a message to be displayed to the user in a confirmation window before making the Ajax request 
|HttpMethod| Sets the HTTP method that will be used to make the request—must be either Get or Post |
|InsertionMode| Specifies the way in which the content retrieved from the server is inserted into the HTML. The three choices are expressed as values from the InsertionMode enum: InsertAfter, InsertBefore and Replace (which is the default). |
|LoadingElementId| Specifies the ID of an HTML element that will be displayed while the Ajax request is being performed |
|LoadingElementDuration| Specifies the duration of the animation used to reveal the element specified by LoadingElementId| 
|UpdateTargetId| Sets the ID of the HTML element into which the content retrieved from the server will be inserted |
|Url| Sets the URL that will be requested from the server|

##Understanding How Unobtrusive Ajax Works##

AjaxOptions object are transformed into attributes applied to the form element.

```
<form action="/People/GetPeopleData"data-ajax="true" data-ajax-mode="replace"
     data-ajax-update="#tableBody" id="form0" method="post">
```

The JavaScript in the jquery.unobtrusive-ajax.js library scans the HTML elements and identifies the Ajax form by looking for elements that have a data-ajax attribute with a value of true.

##Setting Ajax Options##

###Ensuring Graceful Degradation###

One problem with this approach is that it doesn’t work well if the user has disabled JavaScript

The simplest way to address this problem is to use the AjaxOptions.Url property to specify the target URL for the asynchronous request rather than specifying the action name as an argument to the Ajax.BeginForm method,

```
AjaxOptions ajaxOpts = new AjaxOptions {
         UpdateTargetId = "tableBody",
         Url = Url.Action("GetPeopleData")     };
```

```
@using (Ajax.BeginForm(ajaxOpts)) {
```


This has the effect of creating a form element that posts back to the originating action method if JavaScript isn’t enabled, like this:

If JavaScript is enabled, then the unobtrusive Ajax library will take the target URL from the data-ajax-url attribute, which refers to the child action. If JavaScript is disabled, then the browser will use the regular form posting technique, which takes the target URL from the action attribute, which points back at the action method that will generate a complete HTML page.

###Providing the User with Feedback While Making an Ajax Request###

```
AjaxOptions ajaxOpts = new AjaxOptions {
         UpdateTargetId = "tableBody",
         Url = Url.Action("GetPeopleData"),
         LoadingElementId = "loading",
         LoadingElementDuration = 1000     };
```

```
<div id="loading" class="load" style="display:none">     
<p>Loading Data...</p> </div>
```

A value of 1000, which denotes one second.

###Prompting the User Before Making a Request###

```
AjaxOptions ajaxOpts = new AjaxOptions {
         UpdateTargetId = "tableBody",
         Url = Url.Action("GetPeopleData"),
         LoadingElementId = "loading",
         LoadingElementDuration = 1000,
         Confirm = "Do you wish to request new data?"     };
```

##Creating Ajax Links##

```
@foreach (string role in Enum.GetNames(typeof(Role))) {
         <div class="ajaxLink">
             @Ajax.ActionLink(role, "GetPeopleData",
                 new {selectedRole = role},
                 new AjaxOptions {UpdateTargetId = "tableBody"})
         </div>
```

The a elements that are produced have the same kind of data attributes you saw when working with forms, like this:

```
<a data-ajax="true" data-ajax-mode="replace" data-ajax-update="#tableBody"
     href="/People/GetPeopleData?selectedRole=Guest">Guest</a>
```

##Ensuring Graceful Degradation for Links##

###When there is no JavaScript###

Listing 23-15.  Creating Graceful Ajax-Enabled Links in the GetPeople.cshtml File

```
<div>
     @foreach (string role in Enum.GetNames(typeof(Role))) {
         <div class="ajaxLink">
             @Ajax.ActionLink(role, "GetPeople",
                 new {selectedRole = role},
                 new AjaxOptions {
                     UpdateTargetId = "tableBody",
                     Url = Url.Action("GetPeopleData", new {selectedRole = role})
                 })
         </div>
     } 
</div>
```

###Working with Ajax Callbacks###

Table 23-4. AjaxOptions Callback Properties

| Property |jQuery Event| Description|
|--|--|--|
|OnBegin| beforeSend| Called immediately prior to the request being sent |
|OnComplete| complete |Called if the request is successful |
|OnFailure| error| Called if the request fails|
|OnSuccess| success| Called when the request has completed, irrespective of whether the request succeeded or failed|

You can get details on each of these events and the parameters that will be passed to your functions at http://api.jquery.com/jQuery.ajax or in my book, Pro jQuery 2.0, also published by Apress.

```
<script type="text/javascript">
     function OnBegin() {
         alert("This is the OnBegin Callback");
     }
     function OnSuccess(data) {
         alert("This is the OnSuccessCallback: " + data);
     }
     function OnFailure(request, error) {
         alert("This is the OnFailure Callback:" + error);
     }
     function OnComplete(request, status) {
         alert("This is the OnComplete Callback: " + status);
     }
</script>
```

```
new AjaxOptions {
                     UpdateTargetId = "tableBody",
                     Url = Url.Action("GetPeopleData", new {selectedRole = role}),
                     OnBegin = "OnBegin",
                     OnFailure = "OnFailure",
                     OnSuccess = "OnSuccess",
                     OnComplete = "OnComplete"
                 })
```

##Working with JSON##

###Adding JSON Support to the Controller###


```
public JsonResult GetPeopleDataJson(string selectedRole = "All") {
             IEnumerable<Person> data = GetData(selectedRole);
             return Json(data, JsonRequestBehavior.AllowGet);
         }
```

Retuns a JsonResult object. This is a special kind of ActionResult that tells the view engine that I want to return JSON data to the client, rather than HTML.

In this case, I have also passed in the AllowGet value from the JsonRequestBehavior enumeration. By default, JSON data will only be sent in response to POST requests, but by passing this value as a parameter to the Json method, I tell the MVC Framework to respond to GET requests as well.

> **Caution**  You should only use JsonRequestBehavior.AllowGet if the data you are returning is not private. Due to a security issue in many Web browsers, it’s possible for third-party sites to intercept JSON data that you return in response to a GET request, which is why JsonResult will not respond to GET requests by default. In most cases, you will be able to use POST requests to retrieve the JSON data instead, avoiding the problem. For more information, see http://haacked.com/archive/2009/06/25/json-hijacking.aspx.

##Processing JSON in the Browser##

```
<script type="text/javascript">
    function processData(data) {
        var target = $("#tableBody");
        target.empty();
        for (var i = 0; i < data.length; i++) {
            var person = data[i];
            target.append("<tr><td>" + person.FirstName + "</td><td>"
                + person.LastName + "</td><td>" + person.Role
                + "</td></tr>");
        }
    }
</script>

```

```
<div class="ajaxLink">
            @Ajax.ActionLink(role, "GetPeople",
                new { selectedRole = role },
                new AjaxOptions {
                    Url = Url.Action("GetPeopleData", new { selectedRole = role }),
                    OnSuccess = "processData"
                })
        </div>
```


>**Tip**  I don’t go into jQuery in this book because it is a topic in and of itself. I love jQuery, though, and if you want to learn more about it, then I have written Pro jQuery 2.0 (Apress, 2013).

##Preparing Data for Encoding##

###VIEWING JSON DATA###

Enter a URL that targets the action in the browser, like this: http://localhost:13949/People/GetPeopleDataJson?selectedRole=Guest

Also recommend Fiddler (www.fiddler2.com), which is an excellent Web debugging proxy that allows you to dig right into the details of the data sent between the browser and the server.

```
﻿﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HelperMethods.Models;

namespace HelperMethods.Controllers {
    public class PeopleController : Controller {
        private Person[] personData = {
            new Person {FirstName = "Adam", LastName = "Freeman", Role = Role.Admin},
            new Person {FirstName = "Jacqui", LastName = "Griffyth", Role = Role.User},
            new Person {FirstName = "John", LastName = "Smith", Role = Role.User},
            new Person {FirstName = "Anne", LastName = "Jones", Role = Role.Guest}
        };

        public ActionResult Index() {
            return View();
        }

        public ActionResult GetPeopleData(string selectedRole = "All") {
            IEnumerable<Person> data = personData;
            if (selectedRole != "All") {
                Role selected = (Role)Enum.Parse(typeof(Role), selectedRole);
                data = personData.Where(p => p.Role == selected);
            }
            if (Request.IsAjaxRequest()) {
                var formattedData = data.Select(p => new {
                    FirstName = p.FirstName,
                    LastName = p.LastName,
                    Role = Enum.GetName(typeof(Role), p.Role)
                });
                return Json(formattedData, JsonRequestBehavior.AllowGet);
            } else {
                return PartialView(data);
            }
        }

        public ActionResult GetPeople(string selectedRole = "All") {
            return View((object)selectedRole);
        }
    }
}
```

##Detecting Ajax Requests in the Action Method##

The MVC Framework provides a simple way of detecting Ajax requests, which means that you can create a single action method that handles multiple data formats.


See Request.IsAjaxRequest() above.

There are a couple of limitations:

- First, the IsAjaxRequest methods returns true if the browser has included the X-Requested-With header in its request and set the value to XMLHttpRequest. This is a widely used convention, but it isn’t universal and so you should consider whether your users are likely to make requests that require JSON data without setting this header.
- The second limitation is that it assumes that all Ajax requests require JSON data.




#CHAPTER 24 Model Binding# {#Chap24}

Model binding is the process of creating .NET objects using the data sent by the browser in an HTTP request.

##Understanding Model Binding##

The process that leads to model binding begins when the request is received and processed by the routing engine.


```
routes.MapRoute(
                 name: "Default",
                 url: "{controller}/{action}/{id}",
                 defaults: new { controller = "Home", action = "Index",
                     id = UrlParameter.Optional }
             );
```

When I navigated to the /Home/Index/1 URL, the last segment of the URL, which specifies the Person object I am interested in, is assigned to the id routing variable.

The action invoker, which I introduced in Chapter 17, used the routing information to figure out that the Index action method was required to service the request, but it couldn’t call the Index method until it had some useful values for the method argument.

The default action invoker, ControllerActionInvoker, (introduced in Chapter 17), relies on model binders to generate the data objects that are required to invoke the action.

Model binders are defined by the IModelBinder interface,


```
namespace System.Web.Mvc {
     public interface IModelBinder {
         object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext);
     } 
}
```

There can be multiple model binders in an MVC application, and each binder can be responsible for binding one or more model types.

When the action invoker needs to call an action method, it looks at the parameters that the method defines and finds the responsible model binder for the type of each one.

It would then locate the binder responsible for int values and call its BindModel method.

The model binder is responsible for providing an int value that can be used to call the Index method. This usually means transforming some element of the request data (such as form or query string values), but the MVC Framework doesn’t put any limits on how the data is obtained.

##Using the Default Model Binder##

Most just rely on the built-in binder class, DefaultModelBinder.

By default, this model binder searches four locations, shown

Table 24-2. The Order in Which the DefaultModelBinder Class Looks for Parameter Data 

|Source| Description| 
|--|--|
|Request.Form |Values provided by the user in HTML form elements |
|RouteData.Values| The values obtained using the application routes|
| Request.QueryString |Data included in the query string portion of the request URL|
| Request.Files| Files that have been uploaded as part of the request (see Chapter 12 for a demonstration of uploading files)|

The search is stopped as soon as a value is found.

##Binding to Simple Types##

DefaultModelBinder tries to convert the string value, which has been obtained from the request data into the parameter type using the System.ComponentModel.TypeDescriptor class.

Can make things easier for the model binder by using a nullable type, which provides a fallback position.

##CULTURE-SENSITIVE PARSING##

The values that are obtained from URLs (the routing and query string data) are converted using culture-insensitive parsing, but values obtained from form data are converted taking culture into account.

The most common problem that this causes relates to DateTime values. Culture-insensitive dates are expected to be in the universal format yyyy-mm-dd. Form date values are expected to be in the format specified by the server.

A date value won’t be converted if it isn’t in the right format. This means that you must make sure that all dates included in the URL are expressed in the universal format.

You must also be careful when processing date values that users provide. The default binder assumes that the user will express dates in the format of the server culture, something that is unlikely to always happen in an MVC application that has international users.

##Binding to Complex Types##

The DefaultModelBinder class uses reflection to obtain the set of public properties and then binds to each of them in turn.

```
[HttpPost]         
public ActionResult CreatePerson(Person model) {
             return View("Index", model);
}
```

For each simple type property, the binder tries to locate a request value,

If a property requires another complex type, then the process is repeated for the new type.

When looking for a value for the Line1 property, the model binder looks for a value for HomeAddress.Line1, as in the name of the property in the model object combined with the name of the property in the property type.

##Creating Easily-Bound HTML##

```
<div>
         @Html.LabelFor(m => m.HomeAddress.City)
         @Html.EditorFor(m=> m.HomeAddress.City)     
</div>     
<div>         
@Html.LabelFor(m => m.HomeAddress.Country)         
@Html.EditorFor(m=> m.HomeAddress.Country)    
</div>
```

The helper automatically sets the name attributes of the input elements to match the format that the default model binder uses, as follows:

```
<input class="text-box single-line" id="HomeAddress_Country" name="HomeAddress.Country"     type="text" value="" />
```

##Specifying Custom Prefixes##

There are occasions when the HTML you generate relates to one type of object, but you want to bind it to another.

Applying the Bind attribute to the action method parameter, which tells the binder which prefix to look for,

```
public ActionResult DisplaySummary([Bind(Prefix="HomeAddress")] AddressSummary summary) {     
   return View(summary); 
}
```

The syntax is a bit nasty, but the effect is useful. When populating the properties of the AddressSummary object, the model binder will look for HomeAddress.City and HomeAddress.Country

##Selectively Binding Properties##

Listing 24-19.  Excluding a Property from Model Binding in the HomeController.cs File

```
public ActionResult DisplaySummary(     
[Bind(Prefix="HomeAddress", Exclude="Country")]AddressSummary summary) 
{
     return View(summary); 
}
```

(As an alternative, you can use the Include property to specify only those properties that should be bound in the model;

Then you can apply the Bind attribute to the model class itself,

Listing 24-20.  Applying the Bind Attribute in the AddressSummary.cs File 

```
using System.Web.Mvc; namespace MvcModels.Models 
{
     [Bind(Include="City")]
     public class AddressSummary {
         public string City { get; set; }
         public string Country { get; set; }
     } 
}
```

> **Tip**  When the Bind attribute is applied to the model class and to an action method parameter, a property will be included in the bind process only if neither application of the attribute excludes it. This means that the policy applied to the model class cannot be overridden by applying a less restrictive policy to the action method parameter.

##Binding to Arrays and Collections##

###Binding to Arrays###

```
public ActionResult Names(string[] names) {
             names = names ?? new string[0];
             return View(names);         
}
```

```
<h2>Names</h2> 
@if (Model.Length == 0) {
     using(Html.BeginForm()) {
         for (int i = 0; i < 3; i++) {
             <div><label>@(i + 1):</label>@Html.TextBox("names")</div>
         }
         <button type="submit">Submit</button>
     }
 } else {
     foreach (string str in Model) {
         <p>@str</p>
     }
     @Html.ActionLink("Back", "Names"); 
}
```

The default model binder sees that the action method requires a string array and looks for data items that have the same name as the parameter.

###Binding to Collections###

It isn’t just arrays that I can bind to. I can also use the .NET collection classes.


```
public ActionResult Names(IList<string> names) {
    names = names ?? new List<string>();
    return View(names);
}
```

###Binding to Collections of Custom Model Types##


```
public ActionResult Address(IList<AddressSummary> addresses) {
             addresses = addresses ?? new List<AddressSummary>();
             return View(addresses);         
}
```


```
using (Html.BeginForm()) {
         for (int i = 0; i < 3; i++) {
             <fieldset>
                 <legend>Address @(i + 1)</legend>
                 <div><label>City:</label>@Html.Editor("[" + i + "].City")</div>
                 <div><label>Country:</label>@Html.Editor("[" + i + "].Country")</div>
             </fieldset>
         }

<button type="submit" \>Submit< /button >
```

The elements are rendered like:
```
<input class="text-box single-line" name="[0].City" type="text" value="" />
```

The properties prefixed with [0] are used for the first AddressSummary object, those prefixed with [1] are used for the second object, and so on.

##Manually Invoking Model Binding##

Gives more explicit control over how model objects are instantiated, where data values are obtained from, and how data parsing errors are handled.

```
public ActionResult Address() {
             IList<AddressSummary> addresses = new List<AddressSummary>();
             UpdateModel(addresses);
             return View(addresses);
}
```

The UpdateModel method takes a model object that I was previously defining as a parameter and tries to obtain values for its public properties using the standard binding process.

##Restricting the Binder to the Form Data##

```

UpdateModel(addresses, new FormValueProvider(ControllerContext));
```

This version of the UpdateModel method takes an implementation of the IValueProvider interface, which becomes the sole source of data values for the binding process.

Table 24-3. The Built-in IValueProvider Implementations

|Source| IValueProvider Implementation|
| Request.Form| FormValueProvider |
|RouteData.Values| RouteDataValueProvider 
|Request.QueryString |QueryStringValueProvider|
| Request.Files| HttpFileCollectionValueProvider|

There is a neat binding trick that I can use so that I don’t have to create an instance of FormValueProvider,


```
public ActionResult Address(FormCollection formData) {
     IList<AddressSummary> addresses = new List<AddressSummary>();
     UpdateModel(addresses, formData);
     return View(addresses); 
}
```

>**Tip**  There are other overloaded versions of the UpdateModel method that specify a prefix to search for and which model properties should be included in the binding process.

##Dealing with Binding Errors##

When I invoke model binding explicitly, I am responsible for dealing with any errors.

The model binder expresses binding errors by throwing an InvalidOperationException.

But when using the UpdateModel method, I must be prepared to catch the exception and use the ModelState to express an error message to the user,


```
try {
         UpdateModel(addresses, formData);
     } catch (InvalidOperationException ex) {
         // provide feedback to user
     }
```

Alternativly we can use the TryUpdateModel function.

```
if (TryUpdateModel(addresses, formData)) {
         // proceed as normal
     } else {
         // provide feedback to user
     }
```

>**Tip**  When model binding is invoked automatically, binding errors are not signaled with exceptions. Instead, you must check the result through the ModelState.IsValid property.

##Customizing the Model Binding System##

###Creating a Custom Value Provider###

Value providers implement the IValueProvider


```
namespace System.Web.Mvc {
     public interface IValueProvider {
         bool ContainsPrefix(string prefix);
         ValueProviderResult GetValue(string key);
     } 
}
```

The ContainsPrefix method is called by the model binder to determine if the value provider can resolve the data for a given prefix. The GetValue method returns a value for a given data key, or null if the provider doesn’t have any suitable data.

Listing 24-34.  The Contents of the CountryValueProvider.cs File 

```
using System.Globalization; 
using System.Web.Mvc; 

namespace MvcModels.Infrastructure {
     public class CountryValueProvider : IValueProvider {
         public bool ContainsPrefix(string prefix) {
             return prefix.ToLower().IndexOf("country") > -1;
         }
         public ValueProviderResult GetValue(string key) {
             if (ContainsPrefix(key)) {
                 return new ValueProviderResult("USA", "USA", CultureInfo.InvariantCulture);
             } else {
                 return null;
             }
         }
}
```

I have to return the data value as a ValueProviderResult class. This class has three constructor parameters. The first is the data item that I want to associate with the requested key. The second parameter is a version of the data value that is safe to display as part of an HTML page. The final parameter is the culture information that relates to the value; I have specified the InvariantCulture.

To register the value provider with the application, I need to create a factory class that will create instances of the provider when they are required by the MVC Framework. The factory class must be derived from the abstract ValueProviderFactory class.

Listing 24-35.  The Contents of the CustomValueProviderFactory.cs File 

```
using System.Web.Mvc; 

namespace MvcModels.Infrastructure {
     public class CustomValueProviderFactory : ValueProviderFactory {
         public override IValueProvider GetValueProvider(ControllerContext controllerContext) {
             return new CountryValueProvider();
         }
     } 
}
```

I need to register the factory class with the application, which I do in the Application_Start method of Global.asax, as shown in Listing 24-36.


```
ValueProviderFactories.Factories.Insert(0, new CustomValueProviderFactory());
```

The model binder looks at the value providers in sequence, which means I have to use the Insert method to put the custom factory at the first position in the collection if I want to take precedence over the built-in providers.

If I want the custom provider to be a fallback that is used when the other providers cannot supply a data value, then I can use the Add method to append the factory class to the end of the collection, like this:

```
ValueProviderFactories.Factories.Add(new CustomValueProviderFactory());
```

###Creating a Custom Model Binder###

I can override the default binder’s behavior by creating a custom model binder for a specific type.

Implement the IModelBinder interface,

isting 24-38.  The Contents of the AddressSummaryBinder.cs File 

```
using MvcModels.Models; 
using System.Web.Mvc; 

namespace MvcModels.Infrastructure {
     public class AddressSummaryBinder : IModelBinder {
         public object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext) {
             AddressSummary model = (AddressSummary)bindingContext.Model ?? new AddressSummary();

             model.City = GetValue(bindingContext, "City");
             model.Country = GetValue(bindingContext, "Country");

             return model;
         }

         private string GetValue(ModelBindingContext context, string name) {
             name = (context.ModelName == "" ? "" : context.ModelName + ".") + name;
             ValueProviderResult result = context.ValueProvider.GetValue(name);

             if (result == null || result.AttemptedValue == "") {
                 return "<Not Specified>";
             } else {
                 return (string)result.AttemptedValue;
             }
         }
     } 
}
```

The MVC Framework will call the BindModel method when it wants an instance of the model type that the binder supports.

(You can create custom binders that support multiple types, but I prefer one binder for each type.)

The parameters to the BindModel method are a ControllerContext object that you can use to get details of the current request and a ModelBindingContext object, which provides details of the model object that is sought, as well as access to the rest of the model binding facilities in the MVC application.

Table 24-4. The Most Useful Properties Defined by the ModelBindingContext Class 

|Property| Description|
|--|--|
| Model| Returns the model object passed to the UpdateModel method if binding has been invoked manually|
| ModelName| Returns the name of the model that is being bound |
|ModelType| Returns the type of the model that is being created |
|ValueProvider| Returns an IValueProvider implementation that can be used to get data values from the request|

The custom model binder is simple. When the BindModel method is called, I check to see if the Model property of the ModelBindingContext object has been set. If it has, this is the object that I will generate data value for, and if not, then I create a new instance of the AddressSummary class. I get the values for the City and Country properties by calling the GetValue method and return the populated AddressSummary object. In the GetValue method, I use the IValueProvider implementation obtained from the ModelBindingContext.ValueProvider property to get values for the model object properties. The ModelName property tells me if there is a prefix I need to append to the property name I am looking for. You will recall that the action method is trying to create a collection of AddressSummary objects, which means that the individual input elements will have name attribute values that are prefixed [0] and [1]. The values I am looking for in the request will be [0].City, [0].Country, and so on. As a final step, I supply a default value of <Not Specified> if I can’t find a value for a property or the property is the empty string (which is what is sent to the server when the user doesn’t enter a value in the input elements in the form).

##Registering the Custom Model Binder##

I have to register the custom model binder so that the MVC application knows which types it can support. I do this in the Application_Start method of Global.asax, as demonstrated by Listing 24-39.


```
ModelBinders.Binders.Add(typeof(AddressSummary), new AddressSummaryBinder());
```

##Registering a Model Binder with an Attribute##


```
[ModelBinder(typeof(AddressSummaryBinder))]     
public class AddressSummary {
```


##CHAPTER 25 Model Validation## {#Chap25}

##Explicitly Validating a Model##

```
[HttpPost]         
public ViewResult MakeBooking(Appointment appt) {
             if (string.IsNullOrEmpty(appt.ClientName)) {
                 ModelState.AddModelError("ClientName", "Please enter your name");
             }
             if (ModelState.IsValidField("Date") && DateTime.Now > appt.Date) {
                 ModelState.AddModelError("Date", "Please enter a date in the future");
             }

             if (!appt.TermsAccepted) {
                 ModelState.AddModelError("TermsAccepted", "You must accept the terms");
             }
             if (ModelState.IsValid) {
                 // statements to store new Appointment in a
                 // repository would go here in a real project
                 return View("Completed", appt);
             } else {
                 return View();
             }
}
```


ModelState.AddModelError method to specify the name of the property for which there is a problem

To see whether the model binder was able to assign a value to a property by using the ModelState.IsValidField

ModelState.IsValid property to see whether there were errors. This method returns true if I called the Model.State.AddModelError method during the checks or if the model binder had any problems creating the Appointment object:

##Displaying Validation Errors to the User##

Templated view helpers that I used to generate input elements in the MakeBooking.cshtml view check the view model for validation errors.

The helpers add a CSS class called input-validation-error to the input elements

##STYLING CHECK BOXES##

Styling checkboxes can be difficult, especially with older browsers. An alternative to the CSS styles I defined in the _Layout.cshtml is to replace the Boolean editor template with a custom template (as the ∼/Views/Shared/EditorTemplates/Boolean.cshtml file) and to wrap the check box in another element that can be more easily styled. Here is the sort of template that I use, which you can tailor to your own application: 

```
@model bool? 

@if (ViewData.ModelMetadata.IsNullableValueType) {
     @Html.DropDownListFor(m => m, new SelectList(new[] { "Not Set", "True", "False" }, Model)) 
} else {
     ModelState state = ViewData.ModelState[ViewData.ModelMetadata.PropertyName];
     bool value = Model ?? false;
     if (state != null && state.Errors.Count > 0) {
         <span class="input-validation-error" style="padding: 0; margin: 1px">
             @Html.CheckBox("", value)
         </span>
     } else {
         @Html.CheckBox("", value)
     } 
} 
```

This template will wrap a check box in a span element to which the input-validation-error style has been applied if there are any model errors associated with the property that the template has been applied to. You can learn more about replacing editor templates in Chapter 22.

##Displaying Validation Messages##

```
@using (Html.BeginForm()) {
     @Html.ValidationSummary()
     <p>Your name: @Html.EditorFor(m => m.ClientName) </p>
```

The Html.ValidationSummary helper adds a summary of the validation errors to the user. If there are no errors, then the helper doesn’t generate any HTML.

```
<div class="validation-summary-errors" data-valmsg-summary="true">
     <ul>
         <li>Please enter your name</li>
         <li>Please enter a date in the future</li>
         <li>You must accept the terms</li>
     </ul> 
</div>
```

```
validation-summary-errors { color: #f00; font-weight: bold;}
```

Table 25-2. Useful Overloads of the ValidationSummary Helper Method 

|Overloaded Method| Description|
|--|--|
|Html.ValidationSummary()| Generates a summary for all validation errors |
|Html.ValidationSummary(bool) |If the bool parameter is true, then only model-level errors are displayed (see the explanation after the table). If the parameter is false, then all errors are shown. |
|Html.ValidationSummary(string) |Displays a message (contained in the string parameter) before a summary of all the validation errors |
|Html.ValidationSummary(bool, string)| Displays a message before the validation errors. If the bool parameter is true, only model-level errors will be shown.|

By contrast, model-level errors can be used when there is some problem arising from an interaction between two or more property values.

```
if (ModelState.IsValidField("ClientName") && ModelState.IsValidField("Date")
         && appt.ClientName == "Joe" && appt.Date.DayOfWeek == DayOfWeek.Monday) {
         ModelState.AddModelError("", "Joe cannot book appointments on Mondays");
}
```

I register a model-level error by passing the empty string ("") as the first parameter to the ModelState.AddModelError method,

##Displaying Property-Level Validation Messages##

Display property-level errors alongside the fields

```
<p>@Html.ValidationMessageFor(m => m.Date)</p>     
<p>Appointment Date: @Html.EditorFor(m => m.Date)</p>
```

```
<p>
     <span class="field-validation-error" data-valmsg-for="ClientName"
             data-valmsg-replace="true">
         Please enter your name
     </span> 
</p>
```

```
.field-validation-error { color: #f00;}
```

##Using Alternative Validation Techniques##

The default model binder performs validation as part of the binding process.

The model binder performs basic validation for each of the properties in the model object.

The built-in default model binder class, DefaultModelBinder, provides some useful methods that can be overridden to add validation to a binder.


Table 25-3. DefaultModelBinder Methods for Adding Validation to the Model Binding Process 

|Method| Description| Default Implementation|
|--|--|--| 
|OmModelUpdated| Called when the binder has tried to assign values to all of the properties in the model object |Applies the validation rules defined by the model metadata and registers any errors with ModelState. I describe the use of metadata for validation later in this chapter.|
| SetProperty| Called when the binder wants to apply a value to a specific property |If the property cannot hold a null value and there was no value to apply, then the The <name> field is required error is registered with ModelState. If there is a value but it cannot be parsed, then the The value <value> is not valid for <name> error is registered.|


###Specifying Validation Rules Using Metadata###

The advantage of using metadata is that the validation rules are enforced anywhere that the binding process is applied throughout the application, not just in a single action method.

The validation attributes are detected and enforced by the built-in default model binder class, DefaultModelBinder,

```
public class Appointment {
         [Required]
         public string ClientName { get; set; }

         [DataType(DataType.Date)]
         [Required(ErrorMessage="Please enter a date")]
         public DateTime Date { get; set; }

         [Range(typeof(bool), "true", "true", ErrorMessage = "You must accept the terms")]
         public bool TermsAccepted { get; set; }
```

Table 25-4. The Built-in Validation Attributes 

|Attribute| Example| Description|
|--|--|--|
|Compare| [Compare("MyOtherProperty")] |Two properties must have the same value. This is useful when you ask the user to provide the same information twice, such as an e-mail address or a password. |
|Range| [Range(10, 20)] |A numeric value (or any property type that implement IComparable) must not lie beyond the specified minimum and maximum values. To specify a boundary on only one side, use a MinValue or MaxValue constant—for example, [Range(int.MinValue, 50)]. |
|RegularExpression| [RegularExpression("pattern")] |A string value must match the specified regular expression pattern. Note that the pattern has to match the entire user-supplied value, not just a substring within it. By default, it matches case sensitively, but you can make it case insensitive by applying the (?i) modifier—that is, [RegularExpression("(?i)mypattern")]. |
|Required| [Required] |The value must not be empty or be a string consisting only of spaces. If you want to treat whitespace as valid, use [Required(AllowEmptyStrings = true)]. |
|StringLength| [StringLength(10)] |A string value must not be longer than the specified maximum length. You can also specify a minimum length: [StringLength(10, MinimumLength=2)].|

All of the validation attributes support specifying a custom error message by setting a value for the ErrorMessage property, like this: 

```
[Required(ErrorMessage="Please enter a date")]
```

If there is no custom error message, then the default messages will be used,

>**Tip**  The DataType attribute cannot be used to validate user input, only to provide hints for rendering values using the templated helpers (described in Chapter 22). So, for example, do not expect the DataType(DataType.EmailAddress) attribute to enforce a specific format.

##Creating a Custom Property Validation Attribute##

Deriving from the ValidationAttribute

Listing 25-13.  A Custom Property Validation Attribute in the MustBeTrueAttribute.cs File 

```
using System.ComponentModel.DataAnnotations; 

namespace ModelValidation.Infrastructure {
     public class MustBeTrueAttribute : ValidationAttribute {
         public override bool IsValid(object value) {
             return value is bool && (bool)value;
         }
     } 
}
```


```
[MustBeTrue(ErrorMessage="You must accept the terms")]         
public bool TermsAccepted { get; set; }
```

##Deriving from the Built-In Validation Attributes##

Listing 25-15.  The Contents of the FutureDateAttribute.cs Class File using System; 

```
using System.ComponentModel.DataAnnotations; 

namespace ModelValidation.Infrastructure {
     public class FutureDateAttribute : RequiredAttribute {
         public override bool IsValid(object value) {
             return base.IsValid(value) && ((DateTime)value) > DateTime.Now;
         }
     } 
}
```


```
[FutureDate(ErrorMessage="Please enter a date in the future")]         public DateTime Date { get; set; }
```

##Creating a Model Validation Attribute##

I can use attributes to validate the entire model as well, which allows me to raise model-level errors.

Listing 25-17.  The Contents of the NoJoeOnMondaysAttribute.cs File 

```
using System; using System.ComponentModel.DataAnnotations; 
using ModelValidation.Models; 

namespace ModelValidation.Infrastructure {
     public class NoJoeOnMondaysAttribute : ValidationAttribute {
         public NoJoeOnMondaysAttribute() {
             ErrorMessage = "Joe cannot book appointments on Mondays";
         }

         public override bool IsValid(object value) {
             Appointment app = value as Appointment;

             if (app == null || string.IsNullOrEmpty(app.ClientName) ||
                     app.Date == null) {

                 // I don't have a model of the right type to validate, or I don't have
                 // the values for the ClientName and Date properties I require
                 return true;
             } else {
                 return !(app.ClientName == "Joe" &&
                     app.Date.DayOfWeek == DayOfWeek.Monday);
             }
         }
     } 
}
```

```
[NoJoeOnMondays]     
public class Appointment {
```

An important point to note is that model-level validation attributes will not be used when a property-level problem is detected.

###Defining Self-Validating Models###

Another validation technique is to create self-validating models, where the validation logic is part of the model class. A self-validating model implements the IValidatableObject interface,

Listing 25-20.  Adding Self-Validation to the Appointment.cs File 

```
using System; 
using System.Collections.Generic; 
using System.ComponentModel.DataAnnotations; 
using ModelValidation.Infrastructure; 

namespace ModelValidation.Models {
     public class Appointment : IValidatableObject {
         public string ClientName { get; set; }
         [DataType(DataType.Date)]

         public DateTime Date { get; set; }

         public bool TermsAccepted { get; set; }

         public IEnumerable<ValidationResult> Validate(ValidationContext                 validationContext) {

             List<ValidationResult> errors = new List<ValidationResult>();

             if (string.IsNullOrEmpty(ClientName)) {
                 errors.Add(new ValidationResult("Please enter your name"));
             }

             if (DateTime.Now > Date) {
                 errors.Add(new ValidationResult("Please enter a date in the future"));
             }

             if (errors.Count == 0 && ClientName == "Joe"
                 && Date.DayOfWeek == DayOfWeek.Monday) {
                 errors.Add(
                     new ValidationResult("Joe cannot book appointments on Mondays"));
             }

             if (!TermsAccepted) {
                 errors.Add(new ValidationResult("You must accept the terms"));
             }

             return errors;
         }
     } 
}
```

If the model class implements the IValidatableObject interface, then the Validate method will be called after the model binder has assigned values to each of the model properties.

This approach has the benefit of combining the flexibility of putting the validation logic in the action method, but with the consistency of being applied any time the model binding process creates an instance of the model type.

##Performing Client-Side Validation##

In Web applications, users typically expect immediate validation feedback—without having to submit anything to the server. This is known as client-side validation and is implemented using JavaScript.

The MVC Framework supports unobtrusive client-side validation. The term unobtrusive means that validation rules are expressed using attributes added to the HTML elements that views generate. These attributes are interpreted by a JavaScript library that is included as part of the MVC Framework that, in turn, configures the jQuery Validation library, which does the actual validation work.

> **Tip**  Client-side validation is focused on validating individual properties. In fact, it is hard to set up model-level client-side validation using the built-in support that comes with the MVC Framework. To that end, most MVC applications use client-side validation for property-level issues and rely on server-side validation for the overall model.

###Enabling Client-Side Validation###

Listing 25-21.  Controlling Client-Side Validation in the Web.config File

```
<appSettings>
   <add key="webpages:Version" value="3.0.0.0" />
   <add key="webpages:Enabled" value="false" />
   <add key="ClientValidationEnabled" value="true" />
   <add key="UnobtrusiveJavaScriptEnabled" value="true" /> 
</appSettings>
```

> **Tip**  You can also configure client-side validation on a per-view basis by setting the HtmlHelper. ClientValidationEnabled and HtmlHelper.UnobtrusiveJavaScriptEnabled in a Razor code block.

###Adding the NuGet Packages###

```
Install-Package jQuery –version 1.10.2 
Install-Package jQuery.Validation –version 1.11.1 
Install-Package Microsoft.jQuery.Unobtrusive.Validation –version 3.0.0
```

Listing 25-22.  Adding Script Elements for the Validation Libraries to the _Layout.cshtml File

```
<script src="∼/Scripts/jquery-1.10.2.js"></script>     
<script src="∼/Scripts/jquery.validate.js"></script>     
<script src="∼/Scripts/jquery.validate.unobtrusive.js"></script>
```

The order in which the script elements are added to the layout is important. You must add the jQuery library first, followed by the jQuery Validation library and only then can you add the Microsoft unobtrusive validation library.

###Using Client-Side Validation###

The simplest way of doing this is to apply the metadata attributes that I previously used for server-side validation,


```
public class Appointment {
         [Required]
         [StringLength(10, MinimumLength = 3)]

         public string ClientName { get; set; }

         [DataType(DataType.Date)]
         public DateTime Date { get; set; }

         public bool TermsAccepted { get; set; }     
}
```

I have applied a slightly different mix of the built-in validation attributes

But once you have the JavaScript libraries included in the HTML that is sent to the client, everything just starts to work.

The JavaScript code that is performing the validation will prevent the form from being submitted until there are no outstanding validation errors.

###Understanding How Client-Side Validation Works###

Here is the HTML that is rendered by the Html.EditorFor helper for the ClientName property when client-side validation is disabled:

```
<input class="text-box single-line" id="ClientName" name="ClientName" type="text"     value="" />
```

And here is the HTML rendered for the same property when client-side validation is switched on:

```
<input class="text-box single-line" data-val="true"
     data-val-length="The field ClientName must be a string with a minimum length of 3 and
         a maximum length of 10." data-val-length-max="10" data-val-length-min="3"
     data-val-required="The ClientName field is required." id="ClientName"
     name="ClientName" type="text" value="" />
```


The jQuery Validation library identifies those fields that require validation by looking for this attribute.

Individual validation rules are specified using an attribute in the form data-val- <name>, where name is the rule to be applied.

Some rules require additional attributes. You can see this with the length rule, which has data-val-length-min and data-val-length-max attributes to let me specify the minimum and maximum string lengths that are allowed.

###AVOIDING CONFLICTS WITH BROWSER VALIDATION###

Some of the current generation of HTML5 browsers support simple client side validation based on the attributes applied to input elements. The general idea is that, say, an input element to which the required attribute has been applied, for example, will cause the browser to display a validation error when the user tries to submit the form without providing a value. 

If you are generating form elements from models, as I have been doing in this chapter, then you won’t have any problems with browser validation because the MVC Framework generates and uses data attributes to denote validation rules (so that, for example, an input element that must have a value is denoted with the data-val-required attribute, which browsers do not recognize). 

However, you may run into problems if you are unable to completely control the markup in your application, something that often happens when you are passing on content generated elsewhere. The result is that the jQuery validation and the browser validation can both operate on the form, which is just confusing to the user. To avoid this problem, you can add the novalidate attribute to the form element.

One of the nice features about the MVC client-side validation is that the same attributes used to specify validation rules are applied at the client and at the server. This means that data from browsers that do not support JavaScript are subject to the same validation as those that do, without requiring any additional effort.

##MVC CLIENT VALIDATION VERSUS JQUERY VALIDATION##

The MVC client-validation features are built on top of the jQuery Validation library. If you prefer, you can use the Validation library directly and ignore the MVC features. The Validation library is flexible and feature-rich. It is well worth exploring, if only to understand how to customize the MVC features to take best advantage of the available validation options. I cover the jQuery Validation library in depth in my Pro jQuery 2.0 book, also published by Apress.

##Performing Remote Validation##

The last validation feature I will look at in this chapter is remote validation. This is a client-side validation technique that invokes an action method on the server to perform validation.

As part of this process, an Ajax request is made to the server to validate

The first step toward using remote validation is to create an action method that can validate one of the model properties.


```
public JsonResult ValidateDate(string Date) {
             DateTime parsedDate;
             if (!DateTime.TryParse(Date, out parsedDate)) {
                 return Json("Please enter a valid date (mm/dd/yyyy)",
                     JsonRequestBehavior.AllowGet);
             } else if (DateTime.Now > parsedDate) {
                 return Json("Please enter a date in the future",
                     JsonRequestBehavior.AllowGet);
             } else {
                 return Json(true, JsonRequestBehavior.AllowGet);
             }
}
```

Actions methods that support remote validation must return the JsonResult type, which tells the MVC Framework that I am working with JSON data,

Validation action methods must define a parameter that has the same name as the data field being validated:

>**Tip**  I could have taken advantage of model binding so that the parameter to my action method would be a DateTime object, but doing so would mean that the validation method wouldn’t be called if the user entered a nonsense value like apple, for example.

This is because the model binder wouldn’t have been able to create a DateTime object from apple and throws an exception when it tries. The remote validation feature doesn’t have a way to express that exception and so it is quietly discarded.

In both cases, I must also pass the JsonRequestBehavior.AllowGet value as a parameter. This is because the MVC Framework disallows GET requests that produce JSON by default, and I have to override this behavior to handle the validation request. Without this additional parameter, the validation request will quietly fail, and no validation errors will be displayed to the client.

To use the remote validation method, I apply the Remote attribute to the property I want to validate in the model class.

```
[DataType(DataType.Date)]         
[Remote("ValidateDate", "Home")]         
public DateTime Date { get; set; }
```

Caution  The validation action method will be called when the user first submits the form and then again each time he or she edits the data. In essence, every keystroke will lead to a call to the server.


#CHAPTER 26 Bundles# {#Chap26}

In this chapter, I am going to look at the bundles feature, which the MVC Framework provides to organize and optimize the CSS and JavaScript files that views and layouts cause the browser to request from the server.

```
Install-Package jQuery –version 1.10.2 
Install-Package jQuery.Validation –version 1.11.1
Install-Package Microsoft.jQuery.Unobtrusive.Validation –version 3.0.0 
Install-Package Bootstrap -version 3.0.0 
Install-Package Microsoft.jQuery.Unobtrusive.Ajax –version 3.0.0
```

I created the Views/Shared folder and added a view file called _Layout.cshtml to it, the content of which you can see in Listing 26-3. The main purpose of this the layout is to import the JavaScript and CSS files that I added via NuGet so that they can be used in views.

```
<link href="∼/Content/bootstrap.css" rel="stylesheet" />     
<link href="∼/Content/bootstrap-theme.css" rel="stylesheet" />     
<script src="∼/Scripts/jquery-1.10.2.js"></script>     
<script src="∼/Scripts/jquery.validate.js"></script>     
<script src="∼/Scripts/jquery.validate.unobtrusive.js"></script>     
<script src="∼/Scripts/jquery.unobtrusive-ajax.js"></script>
```

##Profiling Script and Style Sheet Loading##

The F12 tools allow you to profile the network requests that your application makes. (All of the mainstream browsers offer similar developer tools and there are other alternatives. My favorite is Fiddler, which you can get from www.fiddler2.com).

##Using Script and Style Bundles##

My goal is to turn the JavaScript and CSS files into bundles, which allows me to treat several related files as a single unit.


```
Install-Package Microsoft.AspNet.Web.Optimization -version 1.1.1
```

##Defining the Bundles##

The convention is to define bundles in a file called BundleConfig.cs, which is placed in the App_Start folder.

Listing 26-5.  The Contents of the BundleConfig.cs File 

```
using System.Web.Optimization; namespace ClientFeatures {
     public class BundleConfig {
         public static void RegisterBundles(BundleCollection bundles) {
             bundles.Add(new StyleBundle("∼/Content/css").Include(
                 "∼/Content/*.css"));

             bundles.Add(new ScriptBundle("∼/bundles/clientfeaturesscripts")
                 .Include("∼/Scripts/jquery-{version}.js",
                     "∼/Scripts/jquery.validate.js",
                     "∼/Scripts/jquery.validate.unobtrusive.js",
                     "∼/Scripts/jquery.unobtrusive-ajax.js"));
         }
     } 
}
```

> **Tip**  Notice that I have changed the namespace in which the class is defined in this file. The convention is that the classes defined in the files in the App_Start folder are defined in the top-level namespace for the application, which is ClientFeatures for this project.

The static RegisterBundles method is called from the Application_Start method in Global.asax

>**Tip**  The classes that are used for creating bundles are contained in the System.Web.Optimization namespace and, as I write this, the MSDN API documentation for this namespace isn’t easy to find. You can navigate directly to http://msdn.microsoft.com/en-us/library/system.web.optimization.aspx if you want to learn more about the classes in this namespace.

When you create a new bundle, you create an instance of either StyleBundle or ScriptBundle, both of which take a single constructor argument that is the path that the bundle will be referenced by. The path is used as a URL for the browser to request the contents of the bundle, so it is important to use a scheme for your paths that won’t conflict with the routes your application supports.

The safest way to do this is to start your paths with ∼/bundles or ∼/Content.

>**Tip**  The order in which the browser loads the Bootstrap CSS files isn’t important, so using a wildcard is just fine. But if you are relying on the CSS style precedence rules, then you need to list the files individually to ensure a specific order, which is what I did for the JavaScript files.

Notice how I specified the jQuery library file:

```
∼/Scripts/jquery- {version} .js
```
The {version} part of the file name is pretty handy because it matches any version of the file specified and it uses the configuration of the application to select either the regular or minified version of the file (which I’ll explain shortly). The version I installed of the jQuery library is 1.10.2,

>**Note**  The jQuery team has done something unusual with their version numbering and is maintaining two different development branches. As of jQuery 1.9, the jQuery 1.x and 2.x branches have the same API, but the jQuery 2.x release doesn’t support older Microsoft browsers. You should use the 1.x release in your projects unless you are sure that none of your users are stuck with Internet Explorer versions 6, 7 or 8. For more details see my Pro jQuery 2.0 book, published by Apress.

To add a statement to the Global.asax file to call the RegisterBundles method in the BundleConfig

```
BundleConfig.RegisterBundles(BundleTable.Bundles);
```


###Applying Bundles###

Is make sure that the namespace that contains the bundle-related classes is available for use within my view.

To do this add  an entry into the pages/namespaces element of the Views/web.config


```
<add namespace="System.Web.Optimization"/>
```

Applying Bundles to the _Layout.cshtml File


```
@Styles.Render("∼/Content/css")     
@Scripts.Render("∼/bundles/clientfeaturesscripts")
```

Here is the output produced by the Styles.Render method for the ∼/Content/css bundle:

```
<link href="/Content/bootstrap-theme.css" rel="stylesheet"/> 
<link href="/Content/bootstrap.css" rel="stylesheet"/>
```

And here is the output produced by the Scripts.Render method:

```
<script src="/Scripts/jquery-1.10.2.js"></script> 
<script src="/Scripts/jquery.unobtrusive-ajax.js"></script> 
<script src="/Scripts/jquery.validate.js"></script> 
<script src="/Scripts/jquery.validate.unobtrusive.js"></script>
```

###Optimizing the JavaScript and CSS Files###

Debug attribute of the compilation element. Open the Web.config file and set the attribute value to false,

```
<system.web>
     <compilation debug="false" targetFramework="4.5.1" />
     <httpRuntime targetFramework="4.5.1" /> 
</system.web>
```

When the attribute is false, the minified versions of the files are selected and concatenated together so that they can be delivered to the client as a blob.

> **Note**  Minification processes a JavaScript or CSS file to remove whitespace and, in the case of JavaScript files, shortens the variable and function names so that the files require less bandwidth to transfer.

Select Start Without Debugging from the Visual Studio Debug menu. (You can’t run the debugger when the debug attribute is set to false.)

Here is the HTML that the Styles.Render method has produced:

```
<link href="/Content/css?v=PrAOvG9OQ_V435deTDX5p8RzKE4Gs8_LEeYxl29skhc1"
     rel="stylesheet"/>
```

And here is the HTML produced by the Scripts.Render method:

```
<script
     src="/bundles/clientfeaturesscripts?v=Buhg68FkCPk3xjXtPsE87M94MTb7DCZx3zKAYD0xRIA1"> 
</script>
```

The MVC Framework minifies CSS data differently from JavaScript files, which is why I have to keep style sheets and scripts in different bundles.

The impact of the optimizations is significant. I have far fewer requests from the browser (which reduces the amount of data sent to the client) and I have less data sent in return—all of which helps keep down the cost of running the web application.
