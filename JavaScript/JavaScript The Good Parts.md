
- [Chapter 1. Good Parts](#Chap1)
- [Chapter 2. Grammar](#Chap2)
- [Chapter 3. Objects](#Chap3)
- [Chapter 4. Functions](#Chap4)
- [Chapter 5. Inheritance](#Chap5)
- [Chapter 6. Arrays](#Chap6)
- [Chapter 8. Arrays](#Chap8)

Supplemental files and examples for this book can be found at http://examples.oreilly.com/9780596517748

#Chapter 1. Good Parts# {#Chap1}

JavaScript’s popularity is almost completely independent of its qualities as a programming language.

In JavaScript, there is a beautiful, elegant, highly expressive language that is buried under a steaming pile of good intentions and blunders.

The very good ideas include functions, loose typing, dynamic objects, and an expressive object literal notation. The bad ideas include a programming model based on global variables.

#Chapter 2. Grammar# {#Chap2}

##Numbers##

 JavaScript has a single number type. Internally, it is represented as 64-bit floating point, the same as Java’s double.

Unlike most other programming languages, there is no separate integer type, so 1 and 1.0 are the same value.

This is a significant convenience because problems of overflow in short integers are completely avoided, and all you need to know about a number is that it is a number.

A large class of numeric type errors is avoided.

If a number literal has an exponent part, then the value of the literal is computed by multiplying the part before the e by 10 raised to the power of the part after the e. So 100 and 1e2 are the same number.

The value NaN is a number value that is the result of an operation that cannot produce a normal result.

NaN is not equal to any value, including itself.

You can detect NaN with the isNaN( number ) function.

The value Infinity represents all values greater than 1.79769313486231570e+308.

##Strings##

 A string literal can be wrapped in single quotes or double quotes. It can contain zero or more characters.

The \ (backslash) is the escape character.

JavaScript was built at a time when Unicode was a 16-bit character set, so all characters in JavaScript are 16 bits wide.

JavaScript does not have a character type.

The \u convention allows for specifying character code points numerically. "A" === "\u0041"

Strings are immutable.

##Statements##

A compilation unit contains a set of executable statements.

In web browsers, each <script> tag delivers a compilation unit that is compiled and immediately executed.

The switch, while, for, and do statements are allowed to have an optional label prefix that interacts with the break statement.

Unlike many other languages, blocks in JavaScript do not create a new scope, so variables should be defined at the top of the function, not in blocks.

###If Statement###
The then block is executed if the expression is truthy; otherwise, the optional else branch is taken. 

Here are the falsy values: 

- false 
- null 
- undefined 
- The empty string '' 
- The number 0 
- The number NaN 

All other values are truthy, including true, the string 'false', and all objects.

###For statement###

Looping through an object with the in clause causes prototype properties to be yielded as well as local properties. It is usually necessary to test object.hasOwnProperty(variable) to determine whether the property name is truly a member of the object or was found instead on the prototype chain.

```
for (myvar in obj) {
    if (obj.hasOwnProperty(myvar)) {
        ...
    } 
}
```

##Throw Statement###

The throw statement raises an exception. If the throw statement is in a try block, then control goes to the catch clause.

The expression is usually an object literal containing a name property and a message property.

the === equality operator. The += operator can add or

##Expressions##

The simplest expressions are a literal value (such as a string or number), a variable, a built-in value (true, false, null, undefined, NaN, or Infinity), an invocation expression preceded by new, a refinement expression preceded by delete, an expression wrapped in parentheses, an expression preceded by a prefix operator, or an expression followed by:

- An infix operator
- The ? ternary operator followed by another expression, then by :, and then by yet another expression
- An invocation
- A refinement

The ? ternary operator takes three operands. If the first operand is truthy, it produces the value of the second operand.

Table 2-1. Operator precedence

|Operators| Description|
|--|--|
|. [] ( ) | Refinement and invocation |
|delete new typeof + - ! |Unary operators|
| \* / % |Multiplication, division, remainder|
| \+ - |Addition/concatenation, subtraction|
| \>= <= > < |Inequality|
| === !== |Equality|
|&& |Logical and |
| \|\| |Logical or|
| ?: | Ternary|

The values produced by typeof are 'number', 'string', 'boolean', 'undefined', 'function', and 'object'. If the operand is an array or null, then the result is 'object', which is wrong.

#Chapter 3. Objects#{#Chap3}

The simple types of JavaScript are numbers, strings, booleans (true and false), null, and undefined. All other values are objects. Numbers, strings, and booleans are object-like in that they have methods, but they are immutable. Objects in JavaScript are mutable keyed collections.

JavaScript includes a prototype linkage feature that allows one object to inherit the properties of another. When used well, this can reduce object initialization time and memory consumption.

##Object Literals##

An object literal is a pair of curly braces surrounding zero or more name/value pairs.

```
var empty_object = {}; 
var stooge = {
    "first-name": "Jerome",
    "last-name": "Howard" 
};
```

The quotes around a property’s name in an object literal are optional if the name would be a legal JavaScript name and not a reserved word.

So quotes are required around "first-name", but are optional around first_name.

##Retrieval##

 Values can be retrieved from an object by wrapping a string expression in a [ ] suffix. If the string expression is a string literal, and if it is a legal JavaScript name and not a reserved word, then the . notation can be used instead.

```
stooge["middle-name"] 
flight.departure.IATA
```

The . notation is preferred because it is more compact and it reads better:

The undefined value is produced if an attempt is made to retrieve a nonexistent member:

The || operator can be used to fill in default values: var middle = stooge["middle-name"] || "(none)";

Attempting to retrieve values from undefined will throw a TypeError exception. This can be guarded against with the && operator:

```
flight.equipment && flight.equipment.model    // undefined
```

##Update##

A value in an object can be updated by assignment.

```
stooge['first-name'] = 'Jerome';
flight.departure.IATA = "SYD";
```

##Reference##

Objects are passed around by reference. They are never copied:

##Prototype##

Every object is linked to a prototype object from which it can inherit properties.

All objects created from object literals are linked to Object.prototype, an object that comes standard with JavaScript. When you make a new object, you can select the object that should be its prototype. The mechanism that JavaScript provides to do this is messy and complex, but it can be significantly simplified. We will add a create method to the Object function. The beget method creates a new object that uses an old object as its prototype. There will be much more about functions in the next chapter. 

```
if (typeof Object.create !== 'function') {      
    Object.create = function (o) {          
        var F = function () {};          
        F.prototype = o;          
        return new F();      
    }; 
} 
var another_stooge = Object.create(stooge);
```

The prototype link has no effect on updating. When we make changes to an object, the object’s prototype is not touched:

The prototype link is used only in retrieval. If we try to retrieve a property value from an object, and if the object lacks the property name, then JavaScript attempts to retrieve the property value from the prototype object. And if that object is lacking the property, then it goes to its prototype, and so on until the process finally bottoms out with Object.prototype.

If the desired property exists nowhere in the prototype chain, then the result is the undefined value. This is called delegation.

The prototype relationship is a dynamic relationship. If we add a new property to a prototype, that property will immediately be visible in all of the objects that are based on that prototype: 

```
stooge.profession = 'actor'; 
another_stooge.profession    // 'actor'
```

##Reflection##

It is easy to inspect an object to determine what properties it has by attempting to retrieve the properties and examining the values obtained.

```
typeof flight.number      // 'number'
```

Some care must be taken because any property on the prototype chain can produce a value:

```
typeof flight.toString    // 'function' 
typeof flight.constructor // 'function'
```

The other approach is to use the hasOwnProperty method, which returns true if the object has a particular property. The hasOwnProperty method does not look at the prototype chain: 

```
flight.hasOwnProperty('number')         // true 
flight.hasOwnProperty('constructor')    // false
```

##Enumeration##

The for in statement can loop over all of the property names in an object. The enumeration will include all of the properties — including functions and prototype properties that you might not be interested in — so it is necessary to filter out the values you don’t want. The most common filters are the hasOwnProperty method and using typeof to exclude functions:

```
var name; 
for (name in another_stooge) {     
    if (typeof another_stooge[name] !== 'function') {
        document.writeln(name + ': ' + another_stooge[name]);
    } 
}
```

There is no guarantee on the order of the names, so be prepared for the names to appear in any order.

##Delete##

The delete operator can be used to remove a property from an object. It will remove a property from the object if it has one. It will not touch any of the objects in the prototype linkage.

```
delete another_stooge.nickname;
```

##Global Abatement##

JavaScript makes it easy to define global variables that can hold all of the assets of your application.

One way to minimize the use of global variables is to create a single global variable for your application. This variable then becomes the container for your application: 

```
var MYAPP = {};

MYAPP.stooge = {
    "first-name": "Joe",
    "last-name": "Howard"
};

MYAPP.flight = {
     airline: "Oceanic",
     number: 815,
     departure: {
              IATA: "SYD",
              time: "2004-09-22 14:55",
              city: "Sydney"
     },
     arrival: {   
         IATA: "LAX",
         time: "2004-09-23 10:42",
         city: "Los Angeles"
     }
};
```

#Chapter 4. Functions# {#Chap4}

##Function Objects##

Functions in JavaScript are objects. Objects are collections of name/value pairs having a hidden link to a prototype object. Objects produced from object literals are linked to Object.prototype. Function objects are linked to Function.prototype (which is itself linked to Object.prototype).

Every function is also created with two additional hidden properties: the function’s context and the code that implements the function’s behavior.

##Function Literal##

Function objects are created with function literals:

```
// Create a variable called add and store a function 
// in it that adds two numbers. 

var add = function (a, b) {
    return a + b; 
};
```

If a function is not given a name, as shown in the previous example, it is said to be anonymous.

A function literal can appear anywhere that an expression can appear. Functions can be defined inside of other functions. An inner function of course has access to its parameters and variables.

An inner function also enjoys access to the parameters and variables of the functions it is nested within. The function object created by a function literal contains a link to that outer context. This is called closure. This is the source of enormous expressive power.

##Invocation##

Invoking a function suspends the execution of the current function, passing control and parameters to the new function.

In addition to the declared parameters, every function receives two additional parameters: this and arguments.

The this parameter is very important in object oriented programming, and its value is determined by the invocation pattern. There are four patterns of invocation in JavaScript: the method invocation pattern, the function invocation pattern, the constructor invocation pattern, and the apply invocation pattern. The patterns differ in how the bonus parameter this is initialized.

There is no runtime error when the number of arguments and the number of parameters do not match. If there are too many argument values, the extra argument values will be ignored. If there are too few argument values, the undefined value will be substituted for the missing values.

There is no type checking on the argument values: any type of value can be passed to any parameter.

##The Method Invocation Pattern##

When a function is stored as a property of an object, we call it a method. When a method is invoked, this is bound to that object.

If an invocation expression contains a refinement (that is, a . dot expression or [subscript] expression), it is invoked as a method:

```
var myObject = {
    value: 0,
    increment: function (inc) {
        this.value += typeof inc === 'number' ? inc : 1;
    }
};
```

A method can use this to access the object so that it can retrieve values from the object or modify the object. The binding of this to the object happens at invocation time. This very late binding makes functions that use this highly reusable. Methods that get their object context from this are called public methods.

##The Function Invocation Pattern##

```
var sum = add(3, 4);    // sum is 7
```

When a function is invoked with this pattern, this is bound to the global object.

This was a mistake in the design of the language. Had the language been designed correctly, when the inner function is invoked, this would still be bound to the this variable of the outer function.

A consequence of this error is that a method cannot employ an inner function to help it do its work because the inner function does not share the method’s access to the object as its this is bound to the wrong value.

Fortunately, there is an easy workaround.

If the method defines a variable and assigns it the value of this, the inner function will have access to this through that variable. By convention, the name of that variable is that:

```
// Augment myObject with a double method. 
myObject.double = function (  ) {
    var that = this;    // Workaround.
    
    var helper = function (  ) {
        that.value = add(that.value, that.value);
    };
    
    helper(  );    // Invoke helper as a function.
};
```

##The Constructor Invocation Pattern##

JavaScript is a prototypal inheritance language. That means that objects can inherit properties directly from other objects. The language is class-free.

This is a radical departure from the current fashion. Most languages today are classical. Prototypal inheritance is powerfully expressive, but is not widely understood.

JavaScript itself is not confident in its prototypal nature, so it offers an object-making syntax that is reminiscent of the classical languages.

If a function is invoked with the new prefix, then a new object will be created with a hidden link to the value of the function’s prototype member, and this will be bound to that new object.

The new prefix also changes the behavior of the return statement. We will see more about that next. 

```
// Create a constructor function called Quo.
// It makes an object with a status property.

var Quo = function (string) {
    this.status = string;
};

// Give all instances of Quo a public method
// called get_status.

Quo.prototype.get_status = function (  ) {
    return this.status;
};

// Make an instance of Quo.
var myQuo = new Quo("confused");

document.writeln(myQuo.get_status(  ));  // confused
```

Functions that are intended to be used with the new prefix are called constructors. By convention, they are kept in variables with a capitalized name. If a constructor is called without the new prefix, very bad things can happen without a compile-time or runtime warning, so the capitalization convention is really important.

Use of this style of constructor functions is not recommended. We will see better alternatives in the next chapter.

##The Apply Invocation Pattern##

Because JavaScript is a functional object-oriented language, functions can have methods.

The apply method lets us construct an array of arguments to use to invoke a function. It also lets us choose the value of this.

The apply method takes two parameters. The first is the value that should be bound to this. The second is an array of parameters.

```
// Make an array of 2 numbers and add them. 

var array = [3, 4]; 
var sum = add.apply(null, array);    // sum is 7 

// Make an object with a status member. 
var statusObject = {     
    status: 'A-OK' 
}; 

// statusObject does not inherit from Quo.prototype, 
// but we can invoke the get_status method on 
// statusObject even though statusObject does not have // a get_status method. 

var status = Quo.prototype.get_status.apply(statusObject);     
// status is 'A-OK'
```

##Arguments##

A bonus parameter that is available to functions when they are invoked is the arguments array.

It gives the function access to all of the arguments that were supplied with the invocation, including excess arguments that were not assigned to parameters.

```
// Make a function that adds a lot of stuff.
// Note that defining the variable sum inside of
// the function does not interfere with the sum
// defined outside of the function. The function
// only sees the inner one.

var sum = function (  ) {
    var i, sum = 0;
    for (i = 0; i < arguments.length; i += 1) {
        sum += arguments[i];
    }
    return sum;
}; 

document.writeln(sum(4, 8, 15, 16, 23, 42)); // 108
```

Because of a design error, arguments is not really an array. It is an array-like object. arguments has a length property, but it lacks all of the array methods.

##Return##

When a function is invoked,

A function always returns a value. If the return value is not specified, then undefined is returned.

Add a note
If the function was invoked with the new prefix and the return value is not an object, then this (the new object) is returned instead.

##Exceptions##

JavaScript provides an exception handling mechanism.

```
var add = function (a, b) {
    if (typeof a !== 'number' || typeof b !== 'number') {
        throw {  
            name: 'TypeError',   
            message: 'add needs numbers'
        };
    }
return a + b;
}
```

The throw statement interrupts execution of the function. It should be given an exception object containing a name property that identifies the type of the exception, and a descriptive message property. You can also add other properties.

```
// Make a try_it function that calls the new add
// function incorrectly.

var try_it = function (  ) {
    try {
        add("seven");
    } catch (e) {
        document.writeln(e.name + ': ' + e.message);
    }
} 

try_it(  );
```

A try statement has a single catch block that will catch all exceptions.

##Augmenting Types##

JavaScript allows the basic types of the language to be augmented.

We saw that adding a method to Object.prototype makes that method available to all objects.

For example, by augmenting Function.prototype, we can make a method available to all functions: 

```
Function.prototype.method = function (name, func) {
    this.prototype[name] = func;     return this; 
};
```

By augmenting Function.prototype with a method method, we no longer have to type the name of the prototype property. That bit of ugliness can now be hidden.

JavaScript does not have a separate integer type, so it is sometimes necessary to extract just the integer part of a number. The method JavaScript provides to do that is ugly.

We can fix it by adding an integer method to Number.prototype.

```
Number.method('integer', function (  ) {     
    return Math[this < 0 ? 'ceil' : 'floor'](this); 
}); 

document.writeln((-10 / 3).integer(  ));  // −3
```

JavaScript lacks a method that removes spaces from the ends of a string. That is an easy oversight to fix: 

```
String.method('trim', function (  ) {
    return this.replace(/^\s+|\s+$/g, ''); 
}); 

document.writeln('"' + "   neat   ".trim(  ) + '"');
```

Because of the dynamic nature of JavaScript’s prototypal inheritance, all values are immediately endowed with the new methods, even values that were created before the methods were created.

The prototypes of the basic types are public structures, so care must be taken when mixing libraries. One defensive technique is to add a method only if the method is known to be missing: 

// Add a method conditionally.
Function.prototype.method = function (name, func) {
    if (!this.prototype[name]) {
        this.prototype[name] = func;
        return this; 
    }   
};

##Recursion##

A recursive function is a function that calls itself, either directly or indirectly.

Recursive functions can be very effective in manipulating tree structures such as the browser’s Document Object Model (DOM).

##Scope##

Scope in a programming language controls the visibility and lifetimes of variables and parameters.

Unfortunately, JavaScript does not have block scope even though its block syntax suggests that it does. This confusion can be a source of errors.

JavaScript does have function scope. That means that the parameters and variables defined in a function are not visible outside of the function, and that a variable defined anywhere within a function is visible everywhere within the function.

So instead, it is best to declare all of the variables used in a function at the top of the function body.

##Closure##

The good news about scope is that inner functions get access to the parameters and variables of the functions they are defined within (with the exception of this and arguments). This is a very good thing.

A more interesting case is when the inner function has a longer lifetime than its outer function.

Earlier, we made a myObject that had a value and an increment method. Suppose we wanted to protect the value from unauthorized changes.

Instead of initializing myObject with an object literal, we will initialize myObject by calling a function that returns an object literal. That function defines a value variable. That variable is always available to the increment and getValue methods, but the function’s scope keeps it hidden from the rest of the program:

```
var myObject = (function () {     
    var value = 0;
    return {
        increment: function (inc) {
            value += typeof inc === 'number' ? inc : 1;
        },
        getValue: function (  ) {
            return value;
        }
    };
}());
```

We are not assigning a function to myObject. We are assigning the result of invoking that function. Notice the ( ) on the last line. The function returns an object containing two methods, and those methods continue to enjoy the privilege of access to the value variable.

Why would you call a getter method on a property you could access directly? It would be more useful if the status property were private.

```

// Create a maker function called quo. It makes an 
// object with a get_status method and a private 
// status property.

var quo = function (status) {
    return {
        get_status: function (  ) {
            return status;
        }
    };
};

// Make an instance of quo.
var myQuo = quo("amazed");
document.writeln(myQuo.get_status(  ));
```

This quo function is designed to be used without the new prefix, so the name is not capitalized.

When we call quo, it returns a new object containing a get_status method.

The get_status method still has privileged access to quo’s status property even though quo has already returned. get_status does not have access to a copy of the parameter; it has access to the parameter itself. This is possible because the function has access to the context in which it was created. This is called closure.

Let’s look at a more useful example: 

```
// Define a function that sets a DOM node's color
// to yellow and then fades it to white.

var fade = function (node) {
    var level = 1;
    var step = function (  ) {      
        var hex = level.toString(16);
        node.style.backgroundColor = '#FFFF' + hex + hex;
        if (level < 15) {
            level += 1;  
            setTimeout(step, 100);
        }
    };
    setTimeout(step, 100); 
};
fade(document.body);
```

Suddenly, the step function gets invoked again. But this time, fade ’s level is 2. fade returned a while ago, but its variables continue to live as long as they are needed by one or more of fade’s inner functions.

It is important to understand that the inner function has access to the actual variables of the outer functions and not copies in order to avoid the following problem.

```
// BAD EXAMPLE 

// Make a function that assigns event handler functions to an array  of nodes the wrong way. 
// When you click on a node, an alert box is supposed to display the ordinal of the node. 
// But it always displays the number of nodes instead. 

var add_the_handlers = function (nodes) {
    var i;
    for (i = 0; i < nodes.length; i += 1) {
        nodes[i].onclick = function (e) {
            alert(i);
        };
    }
};
// END BAD EXAMPLE
```

The add_the_handlers function was intended to give each handler a unique number i. It fails because the handler functions are bound to the variable i, not the value of the variable i at the time the function was made.

```
// BETTER EXAMPLE 

// Make a function that assigns event handler functions to an array of nodes. 
// When you click on a node, an alert box will display the ordinal of the node.

var add_the_handlers = function (nodes) {
    var helper = function (i) {
        return function (e) {
            alert(i);
        };
    }; 
    var i;
    for (i = 0; i < nodes.length; i += 1) {
        modes[i].onclick = helper(i);
    }
};
```

We avoid the confusion by creating a helper function outside of the loop that will deliver a function that binds to the current value of i.

##Callbacks##

Functions can make it easier to deal with discontinuous events.

A better approach is to make an asynchronous request, providing a callback function that will be invoked when the server’s response is received.

```
request = prepare_the_request(  ); 
send_request_asynchronously(request, function (response) {     
    display(response);
});
```

##Module##

We can use functions and closure to make modules. A module is a function or object that presents an interface but that hides its state and implementation. By using functions to produce modules, we can almost completely eliminate our use of global variables, thereby mitigating one of JavaScript’s worst features.

We could define it in the function itself, but that has a runtime cost because the literal must be evaluated every time the function is invoked. The ideal approach is to put it in a closure, and perhaps provide an extra method that can add additional entities:

```
String.method('deentityify', function (  ) {

// The entity table. It maps entity names to
// characters.

    var entity = {
        quot: '"',         
        lt:   '<',
        gt:   '>'
    };

// Return the deentityify method.     
    return function (  ) { 

// This is the deentityify method. It calls the string 
// replace method, looking for substrings that start 
// with '&' and end with ';'. If the characters in 
// between are in the entity table, then replace the 
// entity with the character from the table. It uses 
// a regular expression (Chapter 7).         
        return this.replace(/&([^&;]+);/g,
            function (a, b) {
                var r = entity[b];
                return typeof r === 'string' ? r : a;
            }
        );
    }; 
}());
```

```
document.writeln(     '<">'.deentityify(  ));  // <">
```

The module pattern takes advantage of function scope and closure to create relationships that are binding and private. In this example, only the deentityify method has access to the entity data structure.

##Cascade##

Some methods do not have a return value.

If we have those methods return this instead of undefined, we can enable cascades.

```
getElement('myBoxDiv')
    .move(350, 150)
    .width(100)
```

##Curry## 

Functions are values, and we can manipulate function values in interesting ways. Currying allows us to produce a new function by combining a function and an argument: 

```
var add1 = add.curry(1); 
document.writeln(add1(6));    // 7
```

```
Function.method('curry', function (  ) {
    var slice = Array.prototype.slice,
        args = slice.apply(arguments),
        that = this;
    return function (  ) {
        return that.apply(null, args.concat(slice.apply(arguments)));
    };
});
```

##Memoization##

Functions can use objects to remember the results of previous operations, making it possible to avoid unnecessary work.

```
var fibonacci = (function (  ) {
    var memo = [0, 1];
    var fib = function (n) {
        var result = memo[n];
        if (typeof result !== 'number') {
            result = fib(n − 1) + fib(n − 2);
            memo[n] = result;
        }
        return result;
    };
    return fib;
}( ));
```

#Chapter 5. Inheritance# {#Chap5}

JavaScript, being a loosely typed language, never casts. The lineage of an object is irrelevant. What matters about an object is what it can do, not what it is descended from.

##Pseudoclassical##

JavaScript is conflicted about its prototypal nature. Its prototype mechanism is obscured by some complicated syntactic business that looks vaguely classical. Instead of having objects inherit directly from other objects, an unnecessary level of indirection is inserted such that objects are produced by constructor functions.

Instead of having objects inherit directly from other objects, an unnecessary level of indirection is inserted such that objects are produced by constructor functions.

When a function object is created, the Function constructor that produces the function object runs some code like this:

```
this.prototype = {constructor: this};
```

The new function object is given a prototype property whose value is an object containing a constructor property whose value is the new function object.

The prototype object is the place where inherited traits are to be deposited. Every function gets a prototype object because the language does not provide a way of determining which functions are intended to be used as constructors.

Every function gets a prototype object because the language does not provide a way of determining which functions are intended to be used as constructors.

When a function is invoked with the constructor invocation pattern using the new prefix, this modifies the way in which the function is executed. If the new operator were a method instead of an operator, it could have been implemented like this:


```
Function.method('new', function (  ) { 

// Create a new object that inherits from the 
// constructor's prototype.     
var that = Object.create(this.prototype); 

// Invoke the constructor, binding -this- to 
// the new object.     
var other = this.apply(that, arguments); 

// If its return value isn't an object, 
// substitute the new object.     
return (typeof other === 'object' && other) || that; });
```

We can define a constructor and augment its prototype:

```
var Mammal = function (name) {     
    this.name = name;
};

Mammal.prototype.get_name = function (  ) {
    return this.name;
};

Mammal.prototype.says = function (  ) {
    return this.saying || '';
};
```

Now, we can make an instance:

```
var myMammal = new Mammal('Herb the Mammal'); 
var name = myMammal.get_name(  ); // 'Herb the Mammal'
```

We can make another pseudoclass that inherits from Mammal by defining its constructor function and replacing its prototype with an instance of Mammal:

```
var Cat = function (name) {
this.name = name;
this.saying = 'meow';
};

// Replace Cat.prototype with a new instance of Mammal Cat.prototype = new Mammal(  );

// Augment the new prototype with 
// purr and get_name methods. 
Cat.prototype.purr = function (n) {
    var i, s = '';
    for (i = 0; i < n; i += 1) {
        if (s) {
            s += '-';
        }
        s += 'r';
    }
    return s;
}; 

Cat.prototype.get_name = function (  ) {
    return this.says(  ) + ' ' + this.name + ' ' + this.says(  ); 
}; 

var myCat = new Cat('Henrietta'); 
var says = myCat.says(  ); // 'meow' 
var purr = myCat.purr(5); // 'r-r-r-r-r' 
var name = myCat.get_name(  ); 
//            'meow Henrietta meow'
```

The pseudoclassical pattern was intended to look sort of object-oriented, but it is looking quite alien. We can hide some of the ugliness by using the method method and defining an inherits method:

We can hide some of the ugliness by using the method method and defining an inherits method:

```
Function.method('inherits', function (Parent) {
    this.prototype = new Parent(  );
    return this;
});
```

Our inherits and method methods return this, allowing us to program in a cascade style. We can now make our Cat with one statement.

```
var Cat = function (name) {
    this.name = name;
    this.saying = 'meow'; 

    inherits(Mammal).
    method('purr', function (n) {
        var i, s = '';
        for (i = 0; i < n; i += 1) {
            if (s) {
                s += '-';
            }
            s += 'r';
         }
         return s;
     }).
     method('get_name', function (  ) {
         return this.says(  ) + ' ' + this.name + ' ' + this.says(  );
     });
```

We now have constructor functions that act like classes, but at the edges, there may be surprising behavior. There is no privacy; all properties are public. There is no access to super methods.

Even worse, there is a serious hazard with the use of constructor functions. If you forget to include the new prefix when calling a constructor function, then this will not be bound to a new object. Sadly, this will be bound to the global object, so instead of augmenting your new object, you will be clobbering global variables.

This is a serious design error in the language. To mitigate this problem, there is a convention that all constructor functions are named with an initial capital, and that nothing else is spelled with an initial capital.

To mitigate this problem, there is a convention that all constructor functions are named with an initial capital, and that nothing else is spelled with an initial capital.

A much better alternative is to not use new at all.

The pseudoclassical form can provide comfort to programmers who are unfamiliar with JavaScript, but it also hides the true nature of the language.

JavaScript has more and better options.

##Object Specifiers##

It sometimes happens that a constructor is given a very large number of parameters.

In such cases, it can be much friendlier if we write the constructor to accept a single object specifier instead.

It can be much friendlier if we write the constructor to accept a single object specifier instead.

So, instead of:

```
var myObject = maker(f, l, m, c, s);
```

We can write:

```
var myObject = maker({
    first: f,
    last: l,
    middle: m
    state: s,
    city: c 
});
```

##Prototypal##

In a purely prototypal pattern, we dispense with classes. We focus instead on the objects. We focus instead on the objects. Prototypal inheritance is conceptually simpler than classical inheritance: a new object can inherit the properties of an old object.

You start by making a useful object. You can then make many more objects that are like that one. The classification process of breaking an application down into a set of nested abstract classes can be completely avoided.

```
var myMammal = {
    name : 'Herb the Mammal',
    get_name : function (  ) {
        return this.name;
    },
    says : function (  ) {
        return this.saying || '';
    }
};
```

Once we have an object that we like, we can make more instances with the Object.create method from Chapter 3. We can then customize the new instances:

```
var myCat = Object.create(myMammal);
myCat.name = 'Henrietta';
myCat.saying = 'meow';
myCat.purr = function (n) {
    var i, s = '';
    for (i = 0; i < n; i += 1) {
        if (s) {
            s += '-';
        }
        s += 'r';
        }
        return s; 
    }; 
myCat.get_name = function (  ) {
    return this.says() + ' ' + this.name + ' ' + this.says(); 
};
```

This is differential inheritance. By customizing a new object, we specify the differences from the object on which it is based.

##Functional##

One weakness of the inheritance patterns we have seen so far is that we get no privacy. All properties of an object are visible.

Fortunately, we have a much better alternative in an application of the module pattern.

We start by making a function that will produce objects. We will give it a name that starts with a lowercase letter because it will not require the use of the new prefix. The function contains four steps:

- It creates a new object. There are lots of ways to make an object. It can make an object literal, or it can call a constructor function with the new prefix, or it can use the Object.create method to make a new instance from an existing object, or it can call any function that returns an object.
- It optionally defines private instance variables and methods. These are just ordinary vars of the function.
- It augments that new object with methods. Those methods will have privileged access to the parameters and the vars defined in the second step.
- It returns that new object.

Here is a pseudocode template for a functional constructor (boldface text added for emphasis):

```
var constructor = function (spec, my) {
    var that, other private instance variables;
    my = my || {};

    Add shared variables and functions to my
    
    that = a new object;

    Add privileged methods to that

    return that;
};
```

The spec object contains all of the information that the constructor needs to make an instance.

The my object is a container of secrets that are shared by the constructors in the inheritance chain. The use of the my object is optional. If a my object is not passed in, then a my object is made.

Next, add the shared secrets to the my object. This is done by assignment:

```
my.member = value;
```

Or, more securely, we can define the functions first as private methods, and then assign them to that:

```
var methodical = function (  ) {
    ...
};

that.methodical = methodical;
```

The advantage to defining methodical in two steps is that if other methods want to call methodical, they can call methodical( ) instead of that.methodical( ). If the instance is damaged or tampered with so that that.methodical is replaced, the methods that call methodical will continue to work the same because their private methodical is not affected by modification of the instance.

If the instance is damaged or tampered with so that that.methodical is replaced, the methods that call methodical will continue to work the same because their private methodical is not affected by modification of the instance.

```
var mammal = function (spec) {
    var that = {};
    that.get_name = function (  ) {
        return spec.name;
    };
    that.says = function (  ) {
        return spec.saying || '';
    };
    return that;
};

var myMammal = mammal({name: 'Herb'});
```

In the pseudoclassical pattern, the Cat constructor function had to duplicate work that was done by the Mammal constructor. That isn’t necessary in the functional pattern because the Cat constructor will call the Mammal constructor, letting Mammal do most of the work of object creation, so Cat only has to concern itself with the differences:

```
var cat = function (spec) {
    spec.saying = spec.saying || 'meow';
    var that = mammal(spec);
    that.purr = function (n) {
        var i, s = '';
        for (i = 0; i < n; i += 1) {
            if (s) {
                s += '-';
            }
        s += 'r';
        }
        return s;
    };
    that.get_name = function () {
        return that.says() + ' ' + spec.name + ' ' + that.says();
    };
    return that;
};
var myCat = cat({name: 'Henrietta'});
```

The functional pattern also gives us a way to deal with super methods. We will make a superior method that takes a method name and returns a function that invokes that method. The function will invoke the original method even if the property is changed:

```
Object.method('superior', function (name) {
    var that = this,
        method = that[name];
    return function (  ) {
        return method.apply(that, arguments);
    };
});
```

Let’s try it out on a coolcat that is just like cat except it has a cooler get_name method that calls the super method. It requires just a little bit of preparation. We will declare a super_get_name variable and assign it the result of invoking the superior method:

We will declare a super_get_name variable and assign it the result of invoking the superior method:


```
var coolcat = function (spec) {
    var that = cat(spec),
        super_get_name = that.superior('get_name');
        that.get_name = function (n) {
            return 'like ' + super_get_name(  ) + ' baby';
    };
    return that;
}; 

var myCoolCat = coolcat({name: 'Bix'});
var name = myCoolCat.get_name(  );
//        'like meow Bix meow baby'
```

The functional pattern has a great deal of flexibility. It requires less effort than the pseudoclassical pattern, and gives us better encapsulation and information hiding and access to super methods.

##Parts##

We can compose objects out of sets of parts. For example, we can make a function that can add simple event processing features to any object.

It adds an on method, a fire method, and a private event registry:

```
var eventuality = function (that) {
    var registry = {};
    that.fire = function (event) {

// Fire an event on an object. The event can be either 
// a string containing the name of the event or an 
// object containing a type property containing the 
// name of the event. Handlers registered by the 'on' 
// method that match the event name will be invoked.         
        var array,
            func,
            handler,
            i,
            type = typeof event === 'string' ? event : event.type;

// If an array of handlers exist for this event, then 
// loop through it and execute the handlers in order.
        if (registry.hasOwnProperty(type)) {
            array = registry[type];
            for (i = 0; i < array.length; i += 1) {
                handler = array[i];

// A handler record contains a method and an optional 
// array of parameters. If the method is a name, look 
// up the function.
                func = handler.method;
                if (typeof func === 'string') {                     
                    func = this[func];
                } 

// Invoke a handler. If the record contained 
// parameters, then pass them. Otherwise, pass the 
// event object.                 
                func.apply(this,
                    handler.parameters || [event]);
            }
        }
        return this;
    };

    that.on = function (type, method, parameters) { 
// Register an event. Make a handler record. Put it 
// in a handler array, making one if it doesn't yet 
// exist for this type.
        var handler = {
            method: method,
            parameters: parameters
        };
        if (registry.hasOwnProperty(type)) {
            registry[type].push(handler);
        } else {
             registry[type] = [handler];
        }
        return this;
    };
    return that;
};
```

We could call eventuality on any individual object, bestowing it with event handling methods. We could also call it in a constructor function before that is returned: eventuality(that);

In this way, a constructor could assemble objects from a set of parts. JavaScript’s loose typing is a big benefit here because we are not burdened with a type system that is concerned about the lineage of classes. Instead, we can focus on the character of their contents.

If we wanted eventuality to have access to the object’s private state, we could pass it the my bundle.


#Chapter 6. Arrays# {#Chap6}

An array is a linear allocation of memory in which elements are accessed by integers that are used to compute offsets.

Unfortunately, JavaScript does not have anything like this kind of array.

JavaScript does not have anything like this kind of array.

Instead, JavaScript provides an object that has some array-like characteristics. It converts array subscripts into strings that are used to make properties. It is significantly slower than a real array, but it can be more convenient to use.

It converts array subscripts into strings that are used to make properties. It is significantly slower than a real array, but it can be more convenient to use.

Retrieval and updating of properties work the same as with objects, except that there is a special trick with integer property names.

Arrays have their own literal format.

##Array Literals##

Array literals provide a very convenient notation for creating new array values.

```
var empty = []; 
var numbers = [
     'zero', 'one', 'two', 'three', 'four',
     'five', 'six', 'seven', 'eight', 'nine'
]; 

empty[1]          // undefined 
numbers[1]        // 'one' 
empty.length      // 0
```

The object literal:

```
var numbers_object = {
    '0': 'zero',  '1': 'one',   '2': 'two',
    '3': 'three', '4': 'four',  '5': 'five',
    '6': 'six',   '7': 'seven', '8': 'eight',
    '9': 'nine'
};
```

Which produces a similar result.

Both numbers and numbers_object are objects containing 10 properties, and those properties have exactly the same names and values.

But there are also significant differences. numbers inherits from Array.prototype, whereas numbers_object inherits from Object.prototype, so numbers inherits a larger set of useful methods.

Numbers inherits from Array.prototype, whereas numbers_object inherits from Object.prototype, so numbers inherits a larger set of useful methods.

##Length##

Every array has a length property. Unlike most other languages, JavaScript’s array length is not an upper bound. If you store an element with a subscript that is greater than or equal to the current length, the length will increase to contain the new element.

The length property is the largest integer property name in the array plus one. This is not necessarily the number of properties in the array:


```
var myArray = []; 
myArray.length            // 0 
myArray[1000000] = true; 
myArray.length             // 1000001 
// myArray contains one property.
```

The [] postfix subscript operator converts its expression to a string using the expression’s toString method if it has one. That string will be used as the property name.

If the string looks like a positive integer that is greater than or equal to the array’s current length and is less than 4,294,967,295, then the length of the array is set to the new subscript plus one.

The length can be set explicitly. Making the length larger does not allocate more space for the array.

Making the length larger does not allocate more space for the array.

Making the length smaller will cause all properties with a subscript that is greater than or equal to the new length to be deleted:

```
numbers.length = 3; 
/ numbers is ['zero', 'one', 'two']
```

A new element can be appended to the end of an array by assigning to the array’s current length:

```
numbers[numbers.length] = 'shi';
// numbers is ['zero', 'one', 'two', 'shi']
```

It is sometimes more convenient to use the push method to accomplish the same thing:

```
numbers.push('go'); 
// numbers is ['zero', 'one', 'two', 'shi', 'go']
```

##Delete##

Since JavaScript’s arrays are really objects, the delete operator can be used to remove elements from an array:

```
delete numbers[2]; 
// numbers is ['zero', 'one', undefined, 'shi', 'go']
```

Unfortunately, that leaves a hole in the array. This is because the elements to the right of the deleted element retain their original names.

Fortunately, JavaScript arrays have a splice method.

The first argument is an ordinal in the array. The second argument is the number of elements to delete.

```
numbers.splice(2, 1); 
// numbers is ['zero', 'one', 'shi', 'go']
```

##Enumeration##

Since JavaScript’s arrays are really objects, the for in statement can be used to iterate over all of the properties of an array. Unfortunately, for in makes no guarantee about the order of the properties, and most array applications expect the elements to be produced in numerical order. Also, there is still the problem with unexpected properties being dredged up from the prototype chain.

Unfortunately, for in makes no guarantee about the order of the properties, and most array applications expect the elements to be produced in numerical order.

Also, there is still the problem with unexpected properties being dredged up from the prototype chain.


###Confusion##

A common error in JavaScript programs is to use an object when an array is required or an array when an object is required. The rule is simple: when the property names are small sequential integers, you should use an array. Otherwise, use an object.

The rule is simple: when the property names are small sequential integers, you should use an array. Otherwise, use an object.

JavaScript itself is confused about the difference between arrays and objects. The typeof operator reports that the type of an array is 'object', which isn’t very helpful.

JavaScript does not have a good mechanism for distinguishing between arrays and objects. We can work around that deficiency by defining our own is_array function:

We can work around that deficiency by defining our own is_array function:

```
var is_array = function (value) {
    return value && typeof value === 'object' && value.constructor === Array; 
};
```

Unfortunately, it fails to identify arrays that were constructed in a different window or frame. If we want to accurately detect those foreign arrays, we have to work a little harder:

```
var is_array = function (value) {
    return Object.prototype.toString.apply(value) === '[object Array]';
};
```

##Methods##

JavaScript provides a set of methods for acting on arrays. In Chapter 3, we saw that Object.prototype can be augmented.

```
Array.method('reduce', function (f, value) {
    var i;
    for (i = 0; i < this.length; i += 1) {
        value = f(this[i], value);
    }
    return value;
});
```

By adding a function to Array.prototype, every array inherits the method. If we pass in a function that adds two numbers, it computes the sum. If we pass in a function that multiplies two numbers, it computes the product:

```
// Create an array of numbers. 
var data = [4, 8, 15, 16, 23, 42]; 

// Define two simple functions. One will add two 
// numbers. The other will multiply two numbers. 
var add = function (a, b) {
    return a + b; 
}; 

var mult = function (a, b) {
    return a * b; 
}; 

// Invoke the data's reduce method, passing in the 
// add function. 
var sum = data.reduce(add, 0);    // sum is 108 

// Invoke the reduce method again, this time passing 
// in the multiply function. 
var product = data.reduce(mult, 1);
// product is 7418880
```

Because an array is really an object, we can add methods directly to an individual array:

```
// Give the data array a total function. 
data.total = function (  ) {
    return this.reduce(add, 0); 
}; 

total = data.total(  );    // total is 108
```

##Dimensions##

JavaScript arrays usually are not initialized.

If you ask for a new array with [], it will be empty. If you access a missing element, you will get the undefined value.

```
Array.dim = function (dimension, initial) {
    var a = [], i;
    for (i = 0; i < dimension; i += 1) {
        a[i] = initial;
    }
    return a;
};

// Make an array containing 10 zeros. 
var myArray = Array.dim(10, 0);
```

JavaScript does not have arrays of more than one dimension, but like most C languages, it can have arrays of arrays:

```
var matrix = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
];

matrix[2][1]    // 7
```

To make a two-dimensional array or an array of arrays, you must build the arrays yourself:

```
for (i = 0; i < n; i += 1) {
    my_array[i] = [];
} 

// Note: Array.dim(n, []) will not work here. 
// Each element would get a reference to the same 
// array, which would be very bad.
```

```
Array.matrix = function (m, n, initial) {
    var a, i, j, mat = [];
    for (i = 0; i < m; i += 1) {
        a = [];
        for (j = 0; j < n; j += 1) {
            a[j] = initial;
        }
        mat[i] = a;
    }
    return mat; 
}; 
     
// Make a 4 * 4 matrix filled with zeros. 
var myMatrix = Array.matrix(4, 4, 0);

document.writeln(myMatrix[3][3]);    // 0 
// Method to make an identity matrix. 

Array.identity = function (n) {
    var i, mat = Array.matrix(n, n, 0);
    for (i = 0; i < n; i += 1) {
        mat[i][i] = 1;
    }
    return mat;
}; 
myMatrix = Array.identity(4);
document.writeln(myMatrix[3][3]);    // 1
```

#Chapter 8. Methods# {#Chap8}


##Array##

###array.concat(item...)###

The concat method produces a new array containing a shallow copy of this array with the items appended to it. If an item is an array, then each of its elements is appended individually.


```
var a = ['a', 'b', 'c'];
var b = ['x', 'y', 'z'];
var c = a.concat(b, true); 
// c is ['a', 'b', 'c', 'x', 'y', 'z', true]
```

###array.join(separator)###

The join method makes a string from an array . It does this by making a string of each of the array ’s elements, and then concatenating them all together with a separator between them. The default separator is ','.

```
var a = ['a', 'b', 'c'];
a.push('d');
var c = a.join('');    // c is 'abcd';
```

###array.pop( )###

The pop and push methods make an array work like a stack. The pop method removes and returns the last element in this array If the array is empty, it returns undefined.

```
var a = ['a', 'b', 'c'];
var c = a.pop(  );    // a is ['a', 'b'] & c is 'c'
```

###array.push(item...)###

The push method appends items to the end of an array. Unlike the concat method, it modifies the array and appends array items whole. It returns the new length of the array:

```
var a = ['a', 'b', 'c'];
var b = ['x', 'y', 'z'];
var c = a.push(b, true); 
// a is ['a', 'b', 'c', ['x', 'y', 'z'], true] 
// c is 5;
```

###array.reverse( )###

The reverse method modifies the array by reversing the order of the elements. It returns the array:

```
var a = ['a', 'b', 'c'];
var b = a.reverse(  ); 
// both a and b are ['c', 'b', 'a']
```

###array.shift( )###

The shift method removes the first element from an array and returns it. If the array is empty, it returns undefined. shift is usually much slower than pop:

```
var a = ['a', 'b', 'c']; 
var c = a.shift(  );    // a is ['b', 'c'] & c is 'a'
```

###array.slice(start, end )###

The slice method makes a shallow copy of a portion of an array . The first element copied will be array [ start ]. It will stop before copying array [ end ]. The end parameter is optional, and the default is array .length. If either parameter is negative, array .length will be added to them in an attempt to make them nonnegative. If start is greater than or equal to array .length, the result will be a new empty array. Do not confuse slice with splice. Also see string .slice later in this chapter. 

```
var a = ['a', 'b', 'c']; 
var b = a.slice(0, 1);    // b is ['a']
var c = a.slice(1);       // c is ['b', 'c']
var d = a.slice(1, 2);    // d is ['b'] 
```

###array.sort(comparefn )###

```
var n = [4, 8, 15, 16, 23, 42]; 
n.sort(  ); 
// n is [15, 16, 23, 4, 42, 8]
```

JavaScript’s default comparison function assumes that the elements to be sorted are strings.

It isn’t clever enough to test the type of the elements before comparing them, so it converts the numbers to strings as it compares them, ensuring a shockingly incorrect result.

Fortunately, you may replace the comparison function with your own. Your comparison function should take two parameters and return 0 if the two parameters are equal, a negative number if the first parameter should come first, and a positive number if the second parameter should come first.

```
n.sort(function (a, b) {
    return a − b;
});

// n is [4, 8, 15, 16, 23, 42];
```

That function will sort numbers, but it doesn’t sort strings. If we want to be able to sort any array of simple values, we must work harder:

```
var m = ['aa', 'bb', 'a', 4, 8, 15, 16, 23, 42]; 
m.sort(function (a, b) {
    if (a === b) {
        return 0;
    }
    if (typeof a === typeof b) {
        return a < b ? −1 : 1;
    }
    return typeof a < typeof b ? −1 : 1;
}); 
// m is [4, 8, 15, 16, 23, 42, 'a', 'aa', 'bb']
```

With a smarter comparison function, we can sort an array of objects. To make things easier for the general case, we will write a function that will make comparison functions:

```
// Function by takes a member name string and returns
// a comparison function that can be used to sort an 
// array of objects that contain that member. 
var by = function (name) {
    return function (o, p) {
        var a, b;
        if (typeof o === 'object' && typeof p === 'object' && o && p) {
            a = o[name];
            b = p[name];
            if (a === b) {
                return 0;
            }
            if (typeof a === typeof b) {
                return a < b ? −1 : 1;
            }
            return typeof a < typeof b ? −1 : 1;
        } else {
            throw {
                name: 'Error',
                message: 'Expected an object when sorting by ' + name;
            };
        }
    };
}; 

var s = [
    {first: 'Joe',   last: 'Besser'},     
    {first: 'Moe',   last: 'Howard'},     
    {first: 'Joe',   last: 'DeRita'},     
    {first: 'Shemp', last: 'Howard'},     
    {first: 'Larry', last: 'Fine'},     
    {first: 'Curly', last: 'Howard'}
]; 

s.sort(by('first'));    // s is [ 
//    {first: 'Curly', last: 'Howard'}, 
//    {first: 'Joe',   last: 'DeRita'}, 
//    {first: 'Joe',   last: 'Besser'}, 
//    {first: 'Larry', last: 'Fine'}, 
//    {first: 'Moe',   last: 'Howard'}, 
//    {first: 'Shemp', last: 'Howard'} 
// ]
```

The sort method is not stable, so:

```
s.sort(by('first')).sort(by('last'));
```
is not guaranteed to produce the correct sequence.

We can modify by to take a second parameter, another compare method that will be called to break ties when the major key produces a match:

```
// Function by takes a member name string and an 
// optional minor comparison function and returns 
// a comparison function that can be used to sort an 
// array of objects that contain that member. The 
// minor comparison function is used to break ties 
// when the o[name] and p[name] are equal. 

var by = function (name, minor) {
    return function (o, p) {
        var a, b;
        if (o && p && typeof o === 'object' && typeof p === 'object') {
           a = o[name];
           b = p[name];
           if (a === b) {
               return typeof minor === 'function' ? minor(o, p) : 0;
           }
           if (typeof a === typeof b) {
               return a < b ? −1 : 1;
           }
           return typeof a < typeof b ? −1 : 1;
       } else {
           throw {
               name: 'Error',
               message: 'Expected an object when sorting by ' + name;
           };
       }
    };
}; 

s.sort(by('last', by('first')));    // s is [ 
//    {first: 'Joe',   last: 'Besser'}, 
//    {first: 'Joe',   last: 'DeRita'}, 
//    {first: 'Larry', last: 'Fine'}, 
//    {first: 'Curly', last: 'Howard'}, 
//    {first: 'Moe',   last: 'Howard'}, 
//    {first: 'Shemp', last: 'Howard'} 
// ]
```

###array.splice(start, deleteCount, item...)###

The splice method removes elements from an array, replacing them with new item s. The start parameter is the number of a position within the array . The deleteCount parameter is the number of elements to delete starting from that position. If there are additional parameters, those item s will be inserted at the position. It returns an array containing the deleted elements.

```
var a = ['a', 'b', 'c']; 
var r = a.splice(1, 1, 'ache', 'bug'); 
// a is ['a', 'ache', 'bug', 'c'] // r is ['b']
```

###array.unshift(item...)###

The unshift method is like the push method except that it shoves the item s onto the front of this array instead of at the end. It returns the array ’s new length:

```
var a = ['a', 'b', 'c']; 
var r = a.unshift('?', '@'); 
// a is ['?', '@', 'a', 'b', 'c'] // r is 5
```

##Function##

###function.apply(thisArg, argArray )###

The apply method invokes a function, passing in the object that will be bound to this and an optional array of arguments. The apply method is used in the apply invocation pattern (Chapter 4):

```

Function.method('bind', function (that) {
// Return a function that will call this function as
// though it is a method of that object.
    var method = this,
        slice = Array.prototype.slice,
        args = slice.apply(arguments, [1]);
    return function (  ) {
        return method.apply(that,
            args.concat(slice.apply(arguments, [0])));
    };
});

var x = function (  ) {
    return this.value;
}.bind({value: 666}); 

alert(x(  )); // 666
```

##Number##

###number.toExponential(fractionDigits )###

The toExponential method converts this number to a string in the exponential form. The optional fractionDigits parameter controls the number of decimal places. It should be between 0 and 20:

```

document.writeln(Math.PI.toExponential(0)); 
document.writeln(Math.PI.toExponential(2)); 
document.writeln(Math.PI.toExponential(7)); 
document.writeln(Math.PI.toExponential(16)); 
document.writeln(Math.PI.toExponential(  )); 

// Produces 
3e+0 3.14e+0 
3.1415927e+0
3.1415926535897930e+0
3.141592653589793e+0
```

###number.toFixed(fractionDigits )###

The toFixed method converts this number to a string in the decimal form. The optional fractionDigits parameter controls the number of decimal places. It should be between 0 and 20. The default is 0:

```
document.writeln(Math.PI.toFixed(0)); 
document.writeln(Math.PI.toFixed(2)); 
document.writeln(Math.PI.toFixed(7)); 
document.writeln(Math.PI.toFixed(16)); 
document.writeln(Math.PI.toFixed(  )); 

// Produces 
3 
3.14 
3.1415927
3.1415926535897930 3
```

###number.toPrecision(precision )###

The toPrecision method converts this number to a string in the decimal form. The optional precision parameter controls the number of digits of precision. It should be between 1 and 21:

```
document.writeln(Math.PI.toPrecision(2)); 
document.writeln(Math.PI.toPrecision(7)); 
document.writeln(Math.PI.toPrecision(16)); 
document.writeln(Math.PI.toPrecision(  )); 

// Produces 
3.1 
3.141593 
3.141592653589793 
3.141592653589793
```

###number.toString(radix )###

The toString method converts this number to a string. The optional radix parameter controls radix, or base. It should be between 2 and 36. The default radix is base 10. The radix parameter is most commonly used with integers, but it can be used on any number. The most common case, number .toString( ), can be written more simply as String( number ):

```

Math.PI.toString(2));
document.writeln(Math.PI.toString(8)); 
document.writeln(Math.PI.toString(16)); 
document.writeln(Math.PI.toString(  )); 

// Produces 
11.001001000011111101101010100010001000010110100011 
3.1103755242102643 
3.243f6a8885a3 
3.141592653589793
```

##Object##

###object.hasOwnProperty(name )###

The hasOwnProperty method returns true if the object contains a property having the name . The prototype chain is not examined. This method is useless if the name is hasOwnProperty:

```
var a = {member: true};
var b = Object.create(a);               // from Chapter 3 
var t = a.hasOwnProperty('member');     // t is true 
var u = b.hasOwnProperty('member');     // u is false 
var v = b.member;                       // v is true
```

##RegExp##

###regexp.exec(string )###

The exec method is the most powerful (and slowest) of the methods that use regular expressions. If it successfully matches the regexp and the string, it returns an array.

The 0 element of the array will contain the substring that matched the regexp . The 1 element is the text captured by group 1, the 2 element is the text captured by group 2, and so on. If the match fails, it returns null.


###regexp.test(string )###

The test method is the simplest (and fastest) of the methods that use regular expressions. If the regexp matches the string, it returns true ; otherwise, it returns false.

```
var b = /&.+;/.test('frank & beans'); // b is true
```

##String##

### string.charAt(pos )###

The charAt method returns the character at position pos in this string . If pos is less than zero or greater than or equal to string .length, it returns the empty string. JavaScript does not have a character type. The result of this method is a string:

If pos is less than zero or greater than or equal to string .length, it returns the empty string. JavaScript does not have a character type. The result of this method is a string:

```
var name = 'Curly'; 
var initial = name.charAt(0);    // initial is 'C'
```

###string.charCodeAt(pos )###

The charCodeAt method is the same as charAt except that instead of returning a string, it returns an integer representation of the code point value of the character at position pos in that string . If pos is less than zero or greater than or equal to string .length, it returns NaN:

If pos is less than zero or greater than or equal to string .length, it returns NaN:

```
var name = 'Curly'; 
var initial = name.charCodeAt(0);    // initial is 67
```

###string.concat(string...)###

The concat method makes a new string by concatenating other strings together. It is rarely used because the + operator is more convenient:

```
var s = 'C'.concat('a', 't');    // s is 'Cat'
```

###string.indexOf(searchString, position )###

The indexOf method searches for a searchString within a string. If it is found, it returns the position of the first matched character; otherwise, it returns −1. The optional position parameter causes the search to begin at some specified position in the string:

```
var text = 'Mississippi';
var p = text.indexOf('ss');    // p is 2 
p = text.indexOf('ss', 3);     // p is 5 
p = text.indexOf('ss', 6);     // p is −1
```

###string.lastIndexOf(searchString, position )###

The lastIndexOf method is like the indexOf method, except that it searches from the end of the string instead of the front:

```
var text = 'Mississippi'; 
var p = text.lastIndexOf('ss');    // p is 5 
p = text.lastIndexOf('ss', 3);     // p is 2 
p = text.lastIndexOf('ss', 6);     // p is 5
```
###string.localeCompare(that )###

The localeCompare method compares two strings. The rules for how the strings are compared are not specified. If this string is less than that string, the result is negative. If they are equal, the result is zero. This is similar to the convention for the array .sort comparison function:

```
var m = ['AAA', 'A', 'aa', 'a', 'Aa', 'aaa']; 
m.sort(function (a, b) {
     return a.localeCompare(b);
}); 

// m (in some locale) is 
//      ['a', 'A', 'aa', 'Aa', 'aaa', 'AAA']
```

###string.match(regexp )###

The match method matches a string and a regular expression.

###string.replace(searchValue, replaceValue )###

The replace method does a search and replace operation on this string, producing a new string. The searchValue argument can be a string or a regular expression object. If it is a string, only the first occurrence of the searchValue is replaced, so:

The searchValue argument can be a string or a regular expression object. If it is a string, only the first occurrence of the searchValue is replaced, so:

```
var result = "mother_in_law".replace('_', '-');
```

will produce "mother-in_law",

If searchValue is a regular expression and if it has the g flag, then it will replace all occurrences. If it does not have the g flag, then it will replace only the first occurrence.

The replaceValue can be a string or a function. If replaceValue is a string, the character $ has special meaning:

```
// Capture 3 digits within parens 
var oldareacode = /\((\d{3})\)/g; 
var p = '(555)666-1212'.replace(oldareacode, '$1-'); 
// p is '555-666-1212'
```

|Dollar sequence| Replacement|
|--|--|
| $$ | $ | 
|$& |The matched text|
| $ number| Capture group text|
| $` |The text preceding the match|
| $' |The text following the match|

If the replaceValue is a function, it will be called for each match, and the string returned by the function will be used as the replacement text.

```
String.method('entityify', function (  ) {
    var character = {
        '<' : '<',
        '>' : '>',
        '&' : '&',
        '"' : '"'
    };

// Return the string.entityify method, which 
// returns the result of calling the replace method. 
// Its replaceValue function returns the result of 
// looking a character up in an object. This use of 
// an object usually outperforms switch statements.

    return function (  ) {
        return this.replace(/[<>&"]/g, function (c) {
            return character[c];
        });
    }; }(  )); 
alert("<&>".entityify(  ));  // &lt;&amp;&gt;
```

###string.search(regexp )###

The search method is like the indexOf method, except that it takes a regular expression object instead of a string. It returns the position of the first character of the first match, if there is one, or −1 if the search fails.

```
var text = 'and in it he says "Any damn fool could'; 
var pos = text.search(/["']/);    // pos is 18
```

###string.slice(start, end )###

The slice method makes a new string by copying a portion of another string.

```
var text = 'and in it he says "Any damn fool could'; 
var a = text.slice(18); 
// a is '"Any damn fool could' 
var b = text.slice(0, 3); 
// b is 'and'
```

###string.split(separator, limit )###

The split method creates an array of strings by splitting this string into pieces. The optional limit parameter can limit the number of pieces that will be split. The separator parameter can be a string or a regular expression.

```
var digits = '0123456789'; 
var a = digits.split('', 5); // a is ['0', '1', '2', '3', '4']
```

```
var ip = '192.168.1.0'; 
var b = ip.split('.'); 
// b is ['192', '168', '1', '0']
```

```
var text = 'last,  first ,middle'; 
var d = text.split(/\s*,\s*/); 
// d is [ 
//    'last', 
//    'first', 
//    'middle' 
// ]
```

###string.substring(start, end )###

The substring method is the same as the slice method except that it doesn’t handle the adjustment for negative parameters. There is no reason to use the substring method. Use slice instead.

###string.toLocaleLowerCase( )###

The toLocaleLowerCase method produces a new string that is made by converting this string to lowercase using the rules for the locale. This is primarily for the benefit of Turkish because in that language `I’ converts to 1, not `i’.

###string.toLocaleUpperCase( )###

The toLocaleUpperCase method produces a new string that is made by converting this string to uppercase using the rules for the locale. This is primarily for the benefit of Turkish, because in that language `i’ converts to `', not `I’.

###string.toLowerCase( )###

The toLowerCase method produces a new string that is made by converting this string to lowercase.

###string.toUpperCase( )###

The toUpperCase method produces a new string that is made by converting this string to uppercase.

###String.fromCharCode(char...)###

The String.fromCharCode function produces a string from a series of numbers. 

```
var a = String.fromCharCode(67, 97, 116); 
// a is 'Cat'
``