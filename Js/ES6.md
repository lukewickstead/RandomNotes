# Keywords

## The const and let keywords

ES6 comes with two more options to declare your variables: const and let.

Unlike var they are not hoisted to the top of their enclosing scope.

They are block scoped, referencing them before they are defined will produce a 'ReferenceError'

A variable declared with const cannot be re-assigned or re-declared. It cannot get mutated (changed, modified).

```JavaScript
let foo = 'bar';
const boo = 'moo' 
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let

# Types 

## Symbols

Symbols have existed prior to ES6, but now we have a public interface to usingthem directly. Symbols are immutable and unique and can be used as keys in any hash.

- Every symbol is unique and immutable
- You can use symbols as identifiers when adding properties to an Object

### Symbol

Calling `Symbol()` or `Symbol(description)` will create a unique symbol that cannot be looked upglobally. 

```JavaScript
const aSymbol = Symbol();
const bSymbol = Symbol('A description');
```

### Symbol For

`Symbol.for(key)` will create a Symbol that is still immutable and unique, but can be looked up globally .Two identical calls to `Symbol.for(key)` will return the same Symbol instance. NOTE: This is not true for`Symbol(description)`:

```JavaScript
Symbol('foo') === Symbol('foo') // false
Symbol.for('foo') === Symbol('foo') // false
Symbol.for('foo') === Symbol.for('foo') // true
```

## Get Own Property Symbols

The method getOwnPropertySymbols will return all symbols of an object without walking up the prototype chain.

```javascript
let article = {
title: 'Whiteface Mountain',
[Symbol.for('article')]: 'My Article'
};

console.log( Object.getOwnPropertySymbols(article) ); // [Symbol(article)]
```

# Parameters

## Default Parameters

Methods can not have default parameters


```JavaScript
function aFunction(a=0, b=1) {
}
```



## Rest Parameters

Rest parameters can handle any number of arguments which are collected up into an array

```JavaScript
function aFunction(...args) {
    for (let arg of args) {
        console.log(arg);
    }
}
```



## Destructuring

Destructing allows objects and arrays to be broken down into variables:

```javascript
const person = {   firstName: 'John',   surname: 'Smith', };

const { firstname, surname } = person;
console.log(firstname + ' ' + surname); // output: John Smith
```

A best practice for readability is to use multilines:

```javascript
const {
	firstname,
    surname
} = person;
```

Arrays can also be destructed:

```javascript
const people = ['John', 'Mark', 'Bob'];
const [
	personOne,
    personTwo,
    personThree
] = people;

console.log(personOne, personTwo, personThree); // output: John Mark Bob
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment



## Spread Operators

The spread operator, when it is used, every value from an array or object gets copied to another array or object.

```javascript
const list = ['A', 'B', 'C'];
const additional = 'D'; 
const all = [ ...list, additional ];

console.log(all);
// output: ['A', 'B', 'C', 'D']
```

Can merge two arrays

```javascript
const one = ['A', 'B'];
const two = ['C', 'D']; 
const all = [ ...one, ...two ];

console.log(all); 
// output: ['A', 'B', 'C', 'D' ]
```

It is not JavaScript ES6 but create-react-app incorporated the feature in the configuration.

```javascript
const name = { firstName: 'John', lastName: 'Smith' };
const age = 50;
const user = { ...name, age };

console.log(user);
// output: { firstName: 'John', lastName: 'Smith', age: 50 }
```

Multiple objects can be spread like in the array spread example.

```javascript
const name = { firstName: 'John', lastName: 'Smith' };
const age = { age: 50 };
const user = { ...name, age };

console.log(user);
// output: { firstName: 'John', lastName: 'Smith', age: 50 }
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax




# Strings

### Includes

```javascript
var string = 'ABCDEFG';
var substring = 'ABC';

console.log(string.indexOf(substring) > -1);
console.log(string.includes(substring)); // true
```



## Starts With 

```javascript
let name = "ABCDEFGH";
let starts = name.startsWith("ABC"); // true
```



## Ends With 

```javascript
let name = "ABCDEFGH";
let starts = name.endsWith("FGH"); // true
```



### Repeat

```JavaScript
'Foo'.repeat(3); // 'FooFooFoo'
```



### Template Literals

Easier escaping of special characters

```JavaScript
let text = `Special chars such as "double quotes" don't need to be explicitly escaped anymore.`;
```

Easier concatentation with string interpolation.

```JavaScript
const firstName = 'John';
const surname = 'Smith';

console.log(`Hello there ${firstName} ${surname}.`);
```

New lines chars are preserved.

```JavaScript
let text = ( `cat
dog
nickelodeon`
);
```

They can also take expressions:

```JavaScript
let today = new Date();
let text = `The time and date is ${today.toLocaleString()}`;
```



# Objects

## Object Initializer

```JavaScript
const name = 'John';
const user = {
    name: name,
};
```

When the property name in your object is the same as your variable name, you can do the following:

```JavaScript
const name = 'John';
const user = {
	name,
};
```

```JavaScript
// ES5
this.state = {
	list: list,
};

// ES6
this.state = {
	list,
};
```

Another neat helper are shorthand method names.

```JavaScript
// ES5
var userService = {
	getUserName: function (user) {
    	return user.firstname + ' ' + user.lastname;
    },
};

// ES6
const userService = {
	getUserName(user) {
    	return user.firstname + ' ' + user.lastname;
    },
};
```

Computed property names

```JavaScript
// ES5
var user = {
name: 'John',
};

// ES6
const key = 'name';
const user = {
	[key]: 'Smith',
};
```

- - https://developer.mozilla.org/enUS/docs/Web/JavaScript/Reference/Operators/Object_initializer



## Assign

It takes as first argument a target object. All following arguments are source objects. These objects are merged into the target object.

```JavaScript
const updatedHits = { hits: updatedHits }; const updatedResult = Object.assign({}, this.state.result, updatedHits);
```

Latter objects will override former merged objects when they share the same property names.

## Getter & Setter Functions

ES6 has started supporting getter and setter functions within classes. Using the following example:

```JavaScript
class Employee {
    constructor(name) {
        this._name = name;
    }

    get name() {
        return this._name.toUpperCase();  
    }

    set name(newName) {
        this._name = newName;
    }
}

var emp = new Employee("James Bond");

// uses the get method in the background
if (emp.name) {
  console.log(emp.name);  // JAMES BOND
}

// uses the setter in the background
emp.name = "Bond 007";
console.log(emp.name);  // BOND 007  
```

## Is

```JavaScript
let amount = NaN;
console.log(amount === amount); // false
console.log(Object.Is(amount, amount); // true
```


# Collections 

## Maps

Maps  allow us to set,  get and search for values (and much more).

```JavaScript
let map = new Map();
> map.set('name', 'John');
> map.get('name'); // John
> map.has('name'); // true
```

The most amazing part of Maps is that we are no longer limited to just usingstrings. We can now use any type as a key, and it will not be type-cast to a string.

```JavaScript
let map = new Map([
    ['name', 'John'],
    [true, 'false'],
    [1, 'one'],
    [{}, 'object'],
    [function () {}, 'function']
]);

for (let key of map.keys()) {
    console.log(typeof key);
    // > string, boolean, number, object, function
}
```

> **Note**: Using non-primitive values such as functions or objects won't workwhen testing equality using methods such as `map.get()`. As such, stick toprimitive values such as Strings, Booleans and Numbers.

We can also iterate over maps using `.entries()`:

```JavaScript
for (let [key, value] of map.entries()) {
    console.log(key, value);
}
```

## Sets

Contains a distinct set of elements

```JavaScript
let numbers = [1,1,2,2,3,3];
let numberSet = new Set(numbers.values()); // contains 1,2,3
```

```javascript
let numbers = new Set();
numberSet.add(1);
numberSet.add(1); // contains 1
```

## Arrays

Arrays now contains the methods values, keys and entries which return an iterator of the 

```javascript
let numbers = [a,b,c];
let values = values.values()
let keys = numbers.keys();
let entries = entries.values();
```

Arrays can now been generated with the of and from methods.

```JavaScript
let numbers = Array.of(1,2,3);
let squared = Array.from(numbers, n => n* n);
```

The methods find and findIndex are convenient methods for locating items in an array/

```JavaScript
let numbers = Array.of(1,2,3);
let one = numbers.find(n => n === 1);
let oneIndex = numbers.findIndex(n => n === 1);
```



## Generators

A simple example of using generators is shown below:

```JavaScript
function* sillyGenerator() {
    yield 1;
    yield 2;
}

var generator = sillyGenerator();
> console.log(generator.next()); // { value: 1, done: false }
> console.log(generator.next()); // { value: 2, done: false }
```

Next pushes the  generator forward and evaluate a new expression.



## For In Loop

Similar to for in loop but works returns the values returned by the generator. For in loops over the object properties and returns the index.



```JavaScript
let numbers = [1,2,3,4,5];

for(let n of numbers) {
    console.log(n);
}

// output: 1 2 3 4 5
```



# Functions

## Function Name

```JavaScript
let fn = function calc() {
return 0;
};

console.log(fn.name); // output: calc
```

## Arrow Functions

```JavaScript
// function expression
function () { ... }

// arrow function expression
() => { ... }
```

A function expression always defines its own this object. Arrow function expressions still have the this object of the enclosing context.

You can remove the parentheses when the function gets only one argument,

```JavaScript
// allowed
item => { ... }

// allowed
(item) => { ... }

// not allowed
item, key => { ... }

// allowed
(item, key) => { ... }
```

Additionally, you can remove the block body, meaning the curly braces, of the ES6 arrow function.

```JavaScript
{list.map(item =>
	return (
        <div>{item}</div>
    );
)}
```

In a concise body an implicit return is attached. Thus you can remove the return statement.

```JavaScript
{list.map(item =>
	return <div>{item}</div>
)}
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions

# Object Orientation


## Classes

JavaScript ES6 introduced classes.

```JavaScript
class Person {
	constructor(firstname, lastname) {
    	this.firstname = firstname;
        this.lastname = lastname;
    }

    getName() {
    	return this.firstname + ' ' + this.lastname;
    }
}
```

```JavaScript
const robin = new Person('John', 'Smith');
console.log(robin.getName()); // output: John Smith
```

Classes can inherit from one another.

```JavaScript
class Developer extends Person {
    constructor(firstname, lastname, programmingLanguage) {
        super(firstname, lastname);
        this.programmingLanguage = programmingLanguage;
    }

    getName() {
        console.log(`Developer: ${super.getName()}`);
    }
}
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes



## Static 

We can not define static variables and methods on classes; we get one copy of the method for all class instances. They can not reference instance methods or variables and must be called on the class itself.

```JavaScript
class Foo {   
    static Bar(bar) {
        return `Foo ${bar}`
    } 
}

Foo.Bar('bar'); // returns Foo bar
```



## Modules

```JavaScript
// file1.js
const firstName = 'John';
const surname = 'Smith';

export { firstname, lastname };
```

And import them in another file with a relative path to the first file.

```JavaScript
import { firstName, surname } from './file1.js';

console.log(firstname);
// output: John
```

You can also import all exported variables from another file as one object.

```JavaScript
file2.js import * as person from './file1.js';

console.log(person.firstname);
// output: John
```

Imports can have an alias.

```JavaScript
import { firstname as foo } from './file1.js';
console.log(foo);
// output: John
```

Last but not least there exists the default statement. It can be used for a few use cases:

- to export and import a single functionality
- to highlight the main functionality of the exported API of a module
- to have a fallback import functionality

```JavaScript
// file1.js
const person = {
	firstName: 'John',
    lastName: 'Smith',
};

export default person;
```

You can leave out the curly braces for the import to import the default export.

```JavaScript
import foo from './file1.js';
console.log(foo);
// output: { firstname: 'John', lastname: 'Smith' }
```

Export the variables directly

```JavaScript
export const firstName = 'John'; export const lastName = 'SMith';
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export
- https://read.amazon.com/ref=kcr_app_surl_cloudreader

# Promises

Promises allow us to get out of callback hell, allowing callback to be chained upon completion of a promise or a previous then step.

```JavaScript
doSomething(aValue)
    .then(doSomething2)
    .then(doSomethin3)
    .then(doSomething4)
    .then(doSomething5, aValue5 => {
    });
```

A promise is returned which takes two handlers; resolve and reject.

```JavaScript
new Promise((resolve, reject) =>
    reject(new Error('Failed to fulfill Promise')))
        .catch(reason => console.log(reason));
```

Using Promises, we have a clear path to bubbling errors upand handling them appropriately. Moreover, the value of a Promise after it hasbeen resolved/rejected is immutable - it will never change.

Here is a practical example of using Promises:

```JavaScript
var request = require('request');

return new Promise((resolve, reject) => {
  request.get(url, (error, response, body) => {
    if (body) {
        resolve(JSON.parse(body));
      } else {
        resolve({});
      }
  });
});
```

## Promise API

You can explicitly resolve and reject a promise:

```JavaScript
Promise.resolve(result);
Promise.reject("Error");
```

We can also parallelize Promises to handle an array of asynchronousoperations by using `Promise.all()`. The combined promise will call then when all contained promises complete.

```JavaScript
let urls = [
  '/api/one',
  '/api/two',
];

let promises = urls.map((url) => {
  return new Promise((resolve, reject) => {
    $.ajax({ url: url })
      .done((data) => {
        resolve(data);
      });
  });
});

Promise.all(promises)
  .then((results) => {
 });
```

The race works like all but calls then once any single promise has complete.

```JavaScript
let promiseOne = dosomething();
let promiseTwo = dosomethingAgain();

let combinedPromise = Promise.race([promiseOne, promiseTwo])
combinedPromise.then(result => console.log(result));
```

## Promise Errors

When an error is thrown all steps are missed, execution jumps to the next error handler and then carries on after the error handler as if nothing has gone wrong.

```JavaScript
doSomething(aValue)
    .then(doSomething2, errorHandler2)
    .then(doSomethin3)
    .then(doSomething4)
    .catch(errorHandler)
    .then(doSomething5, aValue5 => {
    });
```

# Async Await

While this is actually an upcoming ES2016 feature, `async await` allows us to perform the same thing we accomplished using Promises::

```JavaScript
var request = require('request');

function getJSON(url) {
  return new Promise(function(resolve, reject) {
    request(url, function(error, response, body) {
      resolve(body);
    });
  });
}

async function main() {
  var data = await getJSON();
  console.log(data); // NOT undefined!
}

main();
```

# Reflect & Proxy

## Reflect

The Reflect API provides a common interface for  reflection.

> https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Reflect

### Object Construction

```JavaScript
class Foo {
    
}

let f = Reflect.Construct(Foo);
console.log(f instanceof Foo);
```

### Method Calls

We can call a method on any object

```JavaScript
class Foo {
    constructor() {
        this.id = 1;
    }
    show() {
        console.log(this.id);
    }
}

Reflect.apply(Foo.prototype.show, {id: 2}); // output: 2
```

## Get & Set ProtoType

The static Reflect.getPrototypeOf() method is the same method as Object.getPrototypeOf().
The static Reflect.setPrototypeOf() method is the same method as Object.setPrototypeOf()

```JavaScript
let moo {    
}
class Foo {
    constructor() {
        this.id = 1;
    }
    show() {
        console.log(this.id);
    }
}

let f = new Foo();

console.log(Reflect.getPrototypeOf(f)); // output: Foo
Reflect.setPrototypeOf(moo, Foo));
console.log(Reflect.getPrototypeOf(moo)); // output: Foo
```

## Properties

- Reflect.get()
- Reflect.set()
- Reflect.has()
- Reflect.ownKeys()
- Reflect.defineProperty()
- Reflect.deleteProperty()
- Reflect.getOwnPropertyDescriptor()

## Property Extensoins

- Reflect.preventExtensions()
- Reflect.isExtensible()

## Proxy

Proxy provides an interface similar to Reflect but allows interception or trap of any method or property call.

### Available Traps

- handler.apply() handler.defineProperty()
- handler.deleteProperty()
- handler.getOwnPropertyDescriptor()
- handler.getPrototypeOf()
- handler.setPrototypeOf() handler.preventExtensions()
- handler.isExtensible()
- handler.construct()
- handler.get()
- handler.set()
- handler.has()
- handler.ownKeys()

### Get Example

```JavaScript
function Employee () {
	this.name = 'Milton Waddams';
	this.salary = 0;
}

var e = new Employee();
var p = new Proxy(e, {
	get: function (target, prop, receiver) {
		return "Attempted access: " + prop;
	}
});

console.log(p.salary); // output: Attempted access: salary
```

### Calling Functions by Proxy

```JavaScript
function getId() {
	return 55;
}

var p = new Proxy(getId, {
	apply: function (target, thisArg, argumentsList) {
		return Reflect.apply(target, thisArg, argumentsList);
	}
});

console.log( p() ); // output: 55
```

### Revocable Proxy

```JavaScript
var t = {
tableId: 99
}

let { proxy, revoke } = Proxy.revocable(t, {
	get: function (target, prop, receiver) {
		return Reflect.get(target, prop, receiver) + 100;
	}
});

console.log(proxy.tableId); // output: 199
revoke();
console.log(proxy.tableId); // output: Property does not exist
```