
## Interpolation ##

```angular
<img src={{product.imageUr}}>
```

```angular
<tr *ngFor='let product of products'>
```


## Property Binding ##

```angular
<img *ngIf='showImage'
	[src]='product.imageUrl'>
	[style.width.px]='imageWidth'>
    {{showImage ? 'Hide' : 'Show'}} Image
</img>
```

## Event Binding ##


```angular
<button (click) ='toggleImage()'>
```


## Two Way Binding ##
```angular
<input [(ngModel)] ='listFiler'>
```

## Pipes ##

```angular
{{ product.productCode | lowerCase}}
{{ product.productCode | upperCase}}
{{ product.price | currency |lowerCase}}
```


## Nested Components ##

You can bind to a nested component by use of the @Input() attribute on the component property. You can then bind in the markup of the outer html using property binding.

You can use @Output() decorator to bind outwards using an event emiter the outer element can respond to the notify event and bind it to a method to call....



## Dependency Injection ##

@Injectable() defined on the service. Only required if the service class has an injectable dependency but good practice says always mark it.

The service can be registered in a compoennt or a module and affects the scope of accessibility.

In a compoenent allows injection into any child componenents

It seems injection is of a singleton

Injection is done in the constructor. Adding in an acceissble of the variable means a shortcut to do the backing fields

Don't do any expensive things in the construcotr; favor the ngOnInit life cycle hook



## Retrieving Data Using HTTP ##


Observables help us manages back end data. They are an array of elements determined asynchronously. Proposed EMCA 2016 but we use RxJS library in the mean time.

Obseravable operators map observable arrays in someway and don't wait until all the data is available to start.

They are lazy, can be cancellable.

HttpClient can be injected in and used to do a http get etc import from @angular/common/http. This needs to be registered in the imports declration of the module. The get method can take a generic parameter to allow hydrating into a type from json

Our service will call an Observable<IFoo[]> from our http request.

On http get we cal call do as a call back to log to the console etc and the catch to handle errors. Both need to be importws from the rxjs library


We can subscribe to the returned observable array which takes parameters for call back, errors and completion (optional). the returned object can be used to cancel the request if requierd.


## Navigation and Routing ##

One page, multiple views. The displayed views is determined by the routing.

<a routerLink="/products">Products</a> can be used to activate a route and display the associated display. It is bound and is surrounded by []

The routerOutlet element type defines where it is displayed.

Register the RouterModule before you can use routing. calling forRoute() with the determined routes.

Routes can be html5 with no # for page sections though this requires config on the web server for url rewriting. Alternatively you can pass in an option useHash: true option.

Each route contains a path, and a componenents.

'' is  a default route. ** cn be used for wild anything and therefore good for error pages.

More specific routes first.


Parameters can be defined out the route  foo/:id, the parameter is then passed in on the router link

<a [routerLink]="['/products', product.productId]"

To get the parameter within the compoenent use the ActivatedRoute module.


// do this within the ngOnInit method and not the constructor.
+this._route.snapshot.paramMap.get('id');

The + is a js shortcut to convert the id from string into an int.

Howver is the paramer will change without leaving the 'page' use an observable.

You can activate a route in code with the Router module.

this._router.navigate(['/products'])

the method containing this would then be bound to the click event

(click)='onBack()'



You can protect routes via guards for authoisation/ensuring saving before changing.

There are various types

- CanActivate
	- Guard to a route
- CanDeactivate
	- Guar from a route
- Resolve
	- PreLoad before activating route 
- CanLoad  
	- Prevent asynch routing


To create a guard class implement CanActivate (for example), mark as Injectable()

ProductGuardService class uses canActivate() which returns a booleann promoise or observable

Register as a provider list section in the module, in the @NgModule sections

Added into the route section for example { path: 'products/:id',  canActivate: [ProductGuardService] ....}


In our guard inject in  ActivatedRouteSnapshot which we cna grab the segment fronm 

let id = +route.url[1].path;

check with isName and also < 1



## Angular Modules ##

We can have multiple modules (instead of one app module), each having their componenents. All ways of segmenting our code.


A module is a class with a @NgModule decorator

A module declares compoenent, directive and pipe. They can be exported and inported as required.



##Binding ##

NO binding; however this field will be used by angular to build up it's internal object
```
<input  name="firstName" ngModel >

```



One way binding. data mapped from model into html but not reflected back when the user changes the data
```
<input  name="firstName" [ngModel]="firstName" >

```


Two way binding. data mapped from model into html and reflected back when the user changes the data

```
<input  name="firstName" [ngModel]="firstName" (ngModelChange)="firstName=$event" >

```

Calling to a function 
```
<input  name="firstName" [ngModel]="firstName" (ngModelChange)="firstNameToUpper($event)" >

```



Two way binding can be simplified by the banan in a box syntax. Calling functions cannot be used with this short hand syntax.

```
<input  name="firstName" [(ngModel)]="firstName" >

```



If our compoenent has a model assigned to model proprty we can bind to it formatting as json via

```
Model {{ model | json }}
```

We can get the form data as json via the form value attribure.

```
Angular  {{ form.value | json }}
```

Elements wil be bound via the property model

```
<input  name="firstName" [(ngModel)]="model.firstName" >

```





## CSS Classes ##

ng-untouched initially then to ng-touched. This only changes when the field loses focus
ng-pristine unchganged and not touched moved to ng-dirty.  dirty will be set when changes but focus has not been lost.
ng-valid and ng-invalid; changes without losing focus

We can access the class via a template reference variable and the className

```
<input #firstName .... >

{{ firstName.className }}

```

We can access the values via the model

- touched/untouched
- pristine/dirty
- valid/invalid

but we need to bind the model

```
<input #firstName="ngModel" .... >

{{ firstName.invalid }}

```

We can display/hide out validation div

```
<div *ngIf="firstName.invalid && firstName.dirty/touched"
```

We can conditionally add a class onto  a div/form-group

```
<div [class.has-error]="firstName.invalid && firstName.dirty/touched"

```
For more exomplex we can bind to a compoennt function

```
<div [class.has-error]="hasFieldSetCorrectly"

```

We can trigger setting this via a blue trigger envent when changing

```
<select.....
(blur)="validateFieldSetCorrecrly()"
```


```
validateFieldSetCorrecrly(event) [
]

```

Better to pass in value using a template reference and binding with the vlaue; example said about update of the model might not have happend before calling the fucjtion. example had in the compoenent function this.model.primaryanguage.

```
(blur)="validateFieldSetCorrecrly(primaryLanguage.value)"
(change)="validateFieldSetCorrecrly(primaryLanguage.value)"
```


## Validatiobs##

Supports html5 validation attributes but use caniuse to ensure all browsers support them,
```
<input required
minlength="2" // not fully supported 
maxlength="12"
pattern="^Q.*"
pattern="...+"
```


## Options ##

<option default> Please fooo </option>



## Form Validaiton##

```
<form #form="ngForm" novalidate> 

<button [disabled]="form.invalid"


{{ form.pristine }}
{{ form.valid }}

```


## HTTP Form Post ##

See FormPosterService (second course)

ON form bind to the submit event

```
<form #form="ngForm" (submit)="submitForm()" novalidate ...
```


```
submitFor(form: NgForm) {

}

```

## Third Party ##

ng2-bootstrap

make sure you use [] arround attributr to bind. also when passing a string pass in "'year'" as otherwise it will look for a year property on the componenent.




## Reactive Forms ##

### Template Driven vs. Reactive ###



Value Chnaged pristine/dirty
Validaity; valid/invalid
Visited; touched/untouched


Use different form directives

ngForm, ngModel and ngModelGroup are replaced with

formGroup, formControl, formControlName, formGroupName, formArrayName


#Best Practices#

Names contain their type.
foo.componenent.ts
foo.componenent.css
foo.componenent.html

The actual component class will be upper camal case FooComponent

Directry should be by features

app/Foo/foo*.*

One item per file.

For imutability you can use object.assign to create a new object from another with changes.



- Thursday; Basic working two step form with validation and 'posting'
- Friday; E2E Testing, best practices & CLI 



