My personal notes for [Knockout](http://knockoutjs.com).

# An overview of Knockout #

Knockout is a Model-View-ViewModel (MVVM) JavaScript framework.

MVVM A design pattern which promotes seperation of concerns:

- Model
	- The domain model or in some cases the DAL.
- View
	- The UI responsible for displaying the the ViewModel.
- ViewModel
	- Above and beyond MVC, MVVM introduces the concept of a ViewModel. It is an abstraction of the View into a model.
	- In Knockout the ViewModel is represented by an observable; which provides a notification mechanism for when changes to the ViewModel occur.
- Binder
	- The binder is responsible for setting up the View based upon the initial state of the ViewModel. It is then responsible for maintaining the ViewModel and View when changes are made to each other.

# Observables #

Knockout uses a publish/subscribe pattern to keep the View and ViewModel in sync between called observables.

Observables are JavaScript functions that record subscribers and then publish to these when the property value is changed. This is done using Knockout's dependency tracking mechanism

All properties requiring this mechanism on a ViewModel are defined as observables:

```JavaScript
// Creating an obserable
this.SynchedProperty = ko.observable();
```

The value of the property defaults to undefined but can be set upon calling the observable fucntion:

```JavaScript
// Creating an obserable with an initial value
this.SynchedProperty = ko.observable('InitialValue');
```

> **Note** Knockout observables are functions and not properties to allow backwards support for older browsers which did not support getters and setters.

Observables are functions which allow reading and writing to get and set the ViewModels state.

```JavaScript
// Reading an obserable
var total = vm.total();

// Writing to an obserable
vm.total(50);
```

Observables can contain any JavaScript value; primitives, arrays, objects and functions

## Observable Arrays ##

If an obserable contains a array, changes to elements within the array won't fire the change mechanism; observable arrays are however do.

```JavaScript
this.entries = ko.observableArray(currentEntries);
```

Changes to the underlying array should be made via Knockout API, otherwise the change notification won't fire.

The following is bad as it uses the underlying data array and not the ko modification mechanism to modify the data.

```JavaScript
this.entries().push(1);
```

To following using ko objects to set data and therefore raise change notifications:

```JavaScript
this.entries.push(1);
```

Knockout provides the standard array methods on the observable: push, pop, shift, unshift, sort, reverse, and splice.

## Computed observables ##

Computed observables are obserable properties that automatically update their value when any of their dependant obserables change.

```JavaScript
var value = ko.observable(1);
var factor = ko.observable(2);
var total  = ko.computed(
	function() {
		return parseFloat(value()) * parseFloat(factor());
    });
```

Dependant obserables are determined upon the first call to the computed obserable.

The parseFloat calls ensure values used are number and not strings which are returned by default.

Strings are returned by default as Knockout binds data against HTML attributes.

##Writable computed observables##

Computed observables can be writable as well as readable. Here we update the value when passed in a new total value from the existing factor.

```JavaScript
var value = ko.observable(1);
var factor = ko.observable(2);
var total  = ko.computed(
{
	write: function(newTotal) {
       	value(newTotal / parseFloat(self.factor()));
    },
    read: function() {
    	parseFloat(value()) *  parseFloat(factor());
    }
});
```

## Pure computed observables ##

Non pure computed obseravables always recalculate themselves regardless if there are any listeners.

Pure computed observables only revaluate themselves when there are active subscribers.

A pure computed observables has two states; listening and sleeping. It will always revaluate itself before it wakes up when a new subscribers is registered.

Pure computed can be created by either calling ko.pureComputed or by passing { pure: true } into  ko.computed.

```JavaScript
var value = ko.observable(1);
var factor = ko.observable(2);


var totalOne  = ko.pureComputed(
	function() {
		return parseFloat(value()) * parseFloat(factor());
    });

var totalTwo  = ko.computed(
	function() {
		return parseFloat(value()) * parseFloat(factor());
    }, this, { pure: true });

```

## Manual subscriptions ##

Observables allow registering a function which will be called and an obserable is updated.

```JavaScript
var value = ko.observable();
value.subscribe(
	function (newValue) {
    	// Do something here with the new value
    });
```

The subscribe function has parameters for the target and the event:
- The target is the value of this for the subscription handler you provide.
- The event cab be change (default) or beforeChange defaults.

```JavaScript
value.subscribe(
	function (oldValue) {
    	console.log("Value " + oldValue + " is changing...");
    }, self, 'beforeChange');});
```

Dispose is used to stop the subscription.

```JavaScript
var value = ko.observable();
value.subscribe(
	function (newValue) {
    	// Do something here with the new value

        // stopping the description
        value.dispose();
    });
```

Once disposed a subscription cannot be restarted; recreation is the only way to mimick this.

# ViewModels #

ViewModels are the objects of observable properties which the UI binds to.

## The this and self keywords ##

The binding context can be defined two ways with ko; passing in as the second argument:

```JavaScript
function Squared() {
	this.value = ko.observable();
    this.squaredValue = ko.computed(
    	function() {
        	return this.value() * this.value();
        }, this);
}
```

Alternatively a closeure can be created; the variable self, _this or that are often used:

```JavaScript
function Squared() {

	var self = this;
	this.value = ko.observable();
    this.squaredValue = ko.computed(
    	function() {
        	return self.value() * self.value();
        }, this);
}
```

## Serializing ViewModels ##

- **ko.toJS** provides a deep copy of an object removing obserables to be normal values.
- **ko.toJSON** Serialises an object using ko.toJS and JSON.stringify to JSON.

```JavaScript

var plainJs = ko.toJS(viewModel);
var jsonData = ko.toJSON(viewModel);
```

# Data Binding #

The HTML5 data-* attributes are used to define knockout data-bind attributes.

Knockout can bind to any data type; it simply parses the value to a strings of key value pairs.

```XML
<button data-bind="enable: isEnabled">Button Name</button>
<input type="text" data-bind="value: modelValue, visible: isVisible" />
```

The following bindings are available:

- Text & Appearance
	- visible
	- text
	- html
	- css
	- style
	- attr
- Control Flow
	- foreach
	- if
	- ifnot
	- with
	- component
- Form Fields
	- click
	- event
	- submit
	- enable
	- disable
	- value
	- textInput
	- hasFocus
	- checked
	- options
	- selectedOptions
	- uniqueName

Bindings are mostly two way in that changing either the UI or the model sychronises the other. However some bindings are only one way for example enable and visible.

## Binding with nested properties ##

Observables can be nested as many times as required.

```JavaScript
var viewmodel = {
	item1: {
    	one: ko.observable('one'),
        two: ko.observable(2)
    }
};
```

```xml
<input data-bind="value: item1().one" />
```

## Binding against functions ##

Some bindings such as click or even be only bound to a function.

The function receives two elements;
- The current model (the binding context)
- The JavaScript event as the second parameter

The foreach binding creates a nested binding context for each element within.

The $parent allows referncing the parent of the bound model.

```xml
<ul data-bind="foreach: elements">
	<li>
		<span data-bind="text: elementName"></span>
        <button data-bind="click: $parent.removeElement">Remove</button>
    </li>
</ul>
```

```JavaScript
var ViewModel = function() {
	var self = this;
    self.elements = ko.observableArray([{ name: 'One' }, { name: 'Two' }]);
    self.removeElement = function (element) {
    	self.elements.remove(element);
    };
};
```

## Binding to expressions ##

Bindings which expect booleans can be bound to expressions.

```xml
<button data-bind="enable: count > 0">Remove</button>
```

Ternary expressions can also be bound to:

```xml
<span data-bind="text: count > 1 ? 'Yes' : 'No'"></span>
```

#Binding to function expressions#

```xml
<button data-bind="enable: isOk(model)">Yes!!!</button>
```

Also it is possible (bug ugly) to bind to anonymous functions:

```xml
<button data-bind="text: function(model) { console.log(model.name)  }">Write Model To Console</button>
```

##Using parentheses in bindings##

For simple expressions no parentheses are required:

```xml
<input data-bind="value: name" />
```

Parentheses are rquired for both nested properties and also function expressions:

```xml
<input data-bind="value: Do().name" />
<button data-bind="enable: Do().number > 1">Do</button>
<button data-bind="enable: Do().Get() > 1">Get</button>
````

## Debugging with ko.toJSO N##

You can bind to ko.toJSON to provide debug information:

```xml
<pre data-bind="text: ko.toJSON($root, null, 2)"></pre>
```

## Control flow bindings ##

Control flow bindings allow modifying the DOM by adding or remving elements.

They include:
- foreach
- if
- with
- template

They work by creating an in-memory template of what should have been placed in the DOM; thisn is used to modify the DOM as required when the binding requires.

They create a binding context hierarchy (except if); bindings by default are then scoped to the child element:

```xml
<div data-bind="with: spouse">
    <span data-bind="text: spouseName"></span>
    <span data-bind="text: $parent.name"></span>
</div>
```

The hierahcy context can be navigated by the following variables:

- $parent; the imediate parent
- $parents[n]: parent contexts.
- $root: root viewmodel
- $data: current viewmodel (useful in foreach loops)
- $index: current index of viewmodel (useful in foreach loops)
- $element: the DOM object

### The if binding ###

Conditionally modify the DOM upon a truth value. When the binding value changes the section will be conditionally added or removed from the DOM using the in-memmory template.

```xml
<div data-bind="if: hasSpouse">
	<span data-bind="text: spouse.spouseName"></span>
    <button data-bind="click: deleteSpouse">Delete</button>
</div>
```

The ifnot binding inverts the expression

```xml
<div data-bind="ifnot: hasSpouse" >
No spouse
</div>
```

### The with binding ###

The with binding creates a child bound context upon a value provided.

```xml
<span data-bind="text: spouse().souseName"></span>
<span data-bind="text: name"></span>
```

The benefit of the with binding is that it only binds if the value is not null; the section is rendered out to the DOM if the value is null or undefined.

### The foreach binding ###

```JavaScript
var viewmodel = {
	numbers: [{value: '1'}, {value: '2'}, {value: '3'}]
}
```

```xml
<ul data-bind="foreach: numbers">
	<li data-bind="text: value"></li>
</ul>
```

Aliases can be used

```xml
<ul data-bind="foreach: { data: numbers, as: 'number' }">
	<li data-bind="text: number.value"></li>
</ul>
```

$data can be used to reference the child bound context; useful if there is only primitives in the list;

```JavaScript
var viewmodel = {
	numbers: [1,2,3]
}
```

```xml
<ul data-bind="foreach: numbers">
	<li data-bind="text: $data"></li>
</ul>
```

### Template binding ###

By default knockout only looks for templates defined by a script tag with a matching id:

```xml
<div data-bind="template: { name: 'number-template', data: numbers }"></div>

<script type="text/html" id="number-template">
<h3 data-bind="text: value"></h3>
</script>
```

Knockout will not apply bindings to script elements and will only use them for templates.

Templates can be refernced from external files:

```xml
<div>
	<div data-bind="template: { name: 'number', data: numbers} "></div>
	<div data-bind="template: { name: 'number', data: otherNumbers} "></div>
</div>
```

```
<script type="text/html" id="number">
<h3 data-bind="text: value"></h3>
</script>
```

### Containerless control flow ###

Bindings can be used outside of an element container; here they are defined as special comments which ko picks up.

```xml
<ul>
	<li>One</li>
    <li>Two</li>
    <!-- ko if: isThreeAndFour -->
    <li>Three</li>
    <li>Four</li>
    <!-- /ko -->
</ul>
```

```
<ul>
    <!-- ko foreach: numbers -->
    <li>
    	<span data-bind="text: $data"></span>
    </li>
    <!-- /ko -->
</ul>
```

# Extenders #

Extenders can be used for:
- Adding properties or functions to observable
- Wrapping an obserable to modify any data which is writen or read

## Simple extenders ##

An extender is added via the ko.extenders object passing in:

- The observable being extended (target)
- Any configuration to be passed to the extender

> **Note** subscribe is used to add manually add a change notification onto an observable. The obseravable will hold the current value when the subscriber is called.

```JavaScript
ko.extenders.auditLog = function(target, options) {
	target.previousValues = ko.observableArray();
	target.subscribe(
    	function(oldValue) {
        	target.previousValues.push(oldValue);
		}, null, 'beforeChange');
return target; };
```

The extender must return the target as the result of the extender is a new ko observable.

```JavaScript
var foo = ko.observable(0).extend({ auditLog: true});
```

You can also add multiple extenders to an observable in the same call.

```JavaScript
var foo = ko.observable(0).extend({ auditLog: true,formatNumber: { decimalPlaces: 2});
```

## Extenders with options ##

```JavaScript
ko.extenders.auditLog = function(target, options) {
	target.previousValues = ko.observableArray();
	target.subscribe(function(oldValue) {
		if (!(options.ignore && options.ignoreValues.indexOf(oldValue) !== -1))
			target.previousValues.push(oldValue)
        }, null, 'beforeChange');
return target; };
```

```JavaScript
var foo = ko.observable(0).extend({   auditLog: { ignoreValues: [0, null] } });
```

##Extenders that replace the target##

Rather than returning the original observable you can return a new computed one; this wrapps the original extender to allow modifying the reading and writing to the original observable.

```JavaScript
ko.extenders.recordChanges = function(target, options) {
    var ignore = options.ignore instanceof Array ? options.ignore : [];

    //Make sure this value is available
    var result = ko.computed({
        read: target,
        write: function(newValue) {
            if (ignore.indexOf(newValue) === -1) {
                result.previousValues.push(target());
                target(newValue);
            } else {
                target.notifySubscribers(target());
            }
        }
    }).extend({
        notify: 'always'
    });

    result.previousValues = ko.observableArray();

    //Return the computed observable
    return result;
};
```

Calling notifySubscribers with target() notifies observers that the old value is being put back; the UI is then reverted back for free.

Extending with notify: 'always' ensures that the observable always reports changes regardless if the value is the same.

This tiem we return the new computed observable instead of the target

Finally, the extender returns the new computed observable instead of the target; all read and write operations to the target are therefore done through our wrapper.