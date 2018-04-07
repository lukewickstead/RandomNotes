# Advanced JavaScript #

Notes taken from Kyle Simpson's Advanced Javascript course.

> https://app.pluralsight.com/library/courses/advanced-javascript/table-of-contents

## Introduction ##

### Resources ###

- https://github.com/rwaldron/idiomatic.js/
- https://developer.mozilla.org/en-US/docs/Web/JavaScript

### ECMAScript Language Specifications ###

- http://www.ecma-international.org/ecma-262/7.0/index.html
- http://wiki.ecmascript.org/doku.php?id=proposals:proposals

## Scope ##

> Scope; where to look for things

JavaScript is actually compiled; it is not interpreted. When running line x it has already knowledge of following lines of code.

The compiler looks for blocks of scope.

JavaScript has function scope only (not quite true but).

Compilation only looks for var. When no var and a new variable name it is not taken into account within the compilation step but the execution.

The following uses two mechanisms; declaration and assignment.

```JavaScript
var foo = "bar";
```

The compiler looks through and gets all variales declarations, asking what scope it is in.

When coming to the bar function it will defer the compilation until required (JIT), foo is defined with var scope.

```JavaScript
var foo = "bar";

function bar() {
	var foo = "baz";
};

function baz(foo) {
	foo = "bam";
    bam = "yay";
};
```

When compiling baz there is a named parameter foo which is declared implicitly within the scope  of baz.

When executing there is not var interpretation; it does not exist.

LHS vs RHS (Left/ Right) of an assignment or = (equals operator)
var foo = "bar";

foo is a LHS reference
"bar" is a RHS

LHS is target and RHS is source.
 
LHS and RHS work differently when taking into account scope.

When LHS references a variable we need to know where it exists to the scope manager. It returns a references to that variable if it knows what it is or can work it out.

01 - Global scope asked for foo and it knows about it.

When executing bar we ask bar scope manager for bar we have a LHS reference to foo. It does know about it as it was declared. It is local scope as it was declared with a var.

When executing baz, we ask scope of bas for a LHS reference to foo. It is in its definition as it was implicitly decalred when declaring the locally named parameter.

Scope of bas I have LHS reference for bam. It does not know about it. It goes one up. To the global scope manager. Here it is asked for LHS reference for BAM, it does not know and therefore it creates it. ( as in not in script mode) if in script it was simply have been had not heard and not created; an error condition. to make something declared needs a var or function declaration.

If it had been a RHS reference it is different

JavaSCript has undefined, which is different to undeclared.

Undeclared; when no present declaration.

Undefined means it was declared but has not been assigned a value from it's initial state. It has not been defined with assignment.

If we had var foo inside baz; it woul declare variable foo by its named parameter and then its declation for a variable, it would say it knows about it as it was declared implicitly.


## Function declarations vs, functions expression ##

If the function keyword is the very first in a statement it is an expression. An anonymoust function expression has no name.

```JavaScript
(function () {
    // anonynous function expression 
})()


// Function expressions
function bar() { 
}


// Function declarations
var foo = function moo() {
}
```

There are three negatives for using expressions which are anonymous
- Can not call them
- You get better info on debugging during a stack trace. Anonymous functions simply says anonymous
- They are not self documenting unlike named functions

Don't use anonymous function expressions as they are pretty useless.


##BlockScope##

```JavaScript
var foo;

try {
    foo.length;
}
catch(err) {
    console.log(err); // TypeError
}

console.log(err); // Reference Error
```

TODO: Some notes on this....

##Lexical Scope vs. Dynamic Scope##

Lexical scope means compile time scope. They are set in stone during compilation.

Image of building with floors; we search a floor, if we don't find it we look on the floor above until we reach the top floor which is the global scope.

The has image of a function with a nested function. Three bubbles of scope; nested function, function and global.

###Cheating Lexical Scope###

```JavaScript
var bar = "bar";

function foo(str) {
    eval(str); // cheating
    console.log(bar); // 42
}
    
foo("var bar = 42;")''
```

The compiler cannot optimise the lookup when it sees Eval as it cannot work them out until run time.

In strict mode, an eval creates a new scope for the evaluated code in a string to optimize it. 
Never use Eval!?!?! The settimeout with a string syntax is the same...... TODO: find out. SetTimeOut with a reference is fine.......

Also we can cheat with the with keyword.

```JavaSCript
var obj = {
    a: 2,
    b: 3,
    c: 4
};

obj.a = obj.b + obj.c;
obj.c = obj.b - obj.a;

with(obj) {
    a = b + c;
    d = b - a;
    d = 3; // ?? This does not create a new property on obj, it goes up the scope until global and creates a global reference.
}

obj.d; // undefined;
d; // 3 oops!!
```

In strict mode the with keyword is completely removed.

Dynamic scope means run time 

###IIFE###

Immediately executed function expression

```JavaScript
var foo = "foo";

(function MyIffe()) {      //This can be named or anonymous which would be better
    var foo = "foo2";
    console.log(foo); // "foo2";
})();

console.log(foo); // "foo";
```

The IFFE has its own scope so everything is hidden from the outside world.

We can pass in parameters or dependencies into the IFFE

```JavaScript
var foo = "foo";

(function MyIffe(bar)) {      //This can be named or anonymous which would be better
    var foo = bar;
    console.log(foo); // "foo";
})(foo);

console.log(foo); // "foo";
```

###Let Scope###

Block scope with the let keyword in ES6. It implicitly hijacks the scope and adds it to that instead of the containing one.


```JavaScript
function foo() {
    var bar = "bar";
    
    for(let i=0l i<bar.length; i++) {
        console.log(bar.charAt(i));
    }
    
    console.log(i); // ReferenceError
    
}

foo();

```

```JavaScript
function foo() {
    if(bar) {
        let baz = bar;
        
        if(baz) {
            let bam = baz;
        }
        
        console.log(bam); // Error
    }

    console.log(baz); // Error
}

foo("bar");
```

Catch blocks of a try catch have their own scope;

```JavaScript
try{ throw void 0 } catch {
    foo = "bar";
    console.log(foo) // "bar"
}

console.log(foo) // Error

```


### Dynamic Scope ###

Lexical scoping is defined at author time, dynamic scoping is defined at runtime.


### Hoisting ###

Hoisting is the concept of variables being defined at compile time; LHS are all run first before RHS. If a variable exists on a RHS before it is defined it appears the variable is 'hoisted' up to the top to be declared before it is actually defined.


```JavaScript

var a = b();
var c = d();

a;      // returns c which is undefined
c;      //  Attempts to execute a function which is undefined. Function expressions don't get hosited


var d = function b() {
    return b();
}
```

The above with hoisting works such as .....


```JavaScript

function b() {
    return c;
}


var a;
var c;
var d;

a = b();
c = d();

a;      // returns c which is undefined
c;      //  Attempts to execute a function which is undefined. Function expressions don't get hosited


d = function b() {
    return b();
}
```

This proves that fucntions are hoisted before variables.



```
foo(); // "foo"

vart foo = 2;

function foo() {
    console.log("bar");
}

function foo() {
    console.log("foo");
}

```

TODO: What does this output


Function declarations hoist; todo but why?!?!?!

variables declarations don't get hoistes?!?!



Mutual recursion; two mutual functions call each other. This would be impossible without hoisting.

```
a(1);           // ???

function a(foo) {
    if(foo > 20>) return foo;
    return b(foo+2);
}

function b(foo) {
    return c(foo) +21);
}
 
function c(foo) {
    return a(foo * 2);
}

```

Hoisting: let gotcha. Referencing in the temporal dead zone. You get an error. In short you don't hoist lets

```
function foo(bar) {
    if(bar) {
        console.log(baz); // ReferenceError
        let baz = bar;
    }
}

```


###The this Keyword###

This works more like dynamic scopec rather than lexical compilation.

There are four rules for what this is bound to.


```JavaScript
function foo() {
    console.log( this.bar);
}

var bar = "bar1";
var o2 = { bar: "bar2", foo: foo };
var o3 = { bar: "bar3", foo: foo };

foo();      // "bar1"
o2.foo();   // "bar2"
o2.foo();   // "bar3"

```

- Default blinding
    - Default in strict maps to undefined otherwise the global object. Strict mode as defined within the scope; here it would be the foo function.
- Implicit Binding; o2.foo(); this is then mapped to o2
- Explicit; pass in this binding with call or apply; foo.call(obj);
- Hard binding ( which is now in ES5) below is mock of this.
    - var orig = foo;
    - foo = function() { orig.call(obj); };
    - This can be refactored to a bind function
    - function bind(fn, o) {
        return function() {
            fn.call(o);
        }
    }
- new put in front of any function turns it into a constructor call. 4 things occur
    - a brand new empty object is created
    - that object gets linked to another  object
    - gets bound to the this keyword
    - if that function does not return anything; it will implicitly return the this binding

```JavaScript
var o1 = {
    bar: "bar1",
    foo: function() {
        baz()
    }
}

function baz() {
    console.log(this.bar);
}

var bar = "bar2"
foo();      // ???

```

Presedence of bindings rules;
-  Was the function called with new; then use this object
-  Was it called with call or apply ( explicit). This incldues our hard binding.
-  Was the  function called wih a containint/owning oject (context) implicit rulek
-  Default rule; except in strict mode.
 
## Closures ##

Closure is when a function remembers its lexical scope even when the function is executed outside that lexical scope.


```JavaScript
function foo() {
    var bar = "bar";
    
    fucntion baz() {
        console.log(bar)
    }
    
    bam();
}    

function bam(baz) {
    baz();  // "bar";
}

foo();
}
```



##Examples of Closure##

```JavaScript
function foo() {
    var bar = "bar";
    
    setTimeout(fucntion () {
        console.log(bar)
    }, 1000);
    
}    

foo();
```


```JavaScript
function foo() {
    var bar = "bar";
    
    $("#btn).click((fucntion (wevt) {
        console.log(bar)
    });

}    

foo();
```

```JavaScript
for(var i=1; i<=5; i++) {
    setTimeout(fuinction() {
        console.log("I: " + i);
    }, i*1000);
}
```

To fix the above and create closure we can create an IFFE.

```JavaScript
for(var i=1; i<=5; i++) {
    (fuinction(i) {
        setTimeout(fuinction() {
            console.log("I: " + i);
        }, i*1000);
    })(i);
}
```

Let in a for loops creates an i variable for each iteration in the loop. Therefore we can fix the scope by using a let.

```JavaScript
for(let i=1; i<=5; i++) {
    setTimeout(fuinction() {
        console.log("I: " + i);
    }, i*1000);
}
```

This is not a closure as there is no function scope transported out. The function just passes state out.

```JavaScript
var foo = (function() {
    var o = { bar: "bar" };
    
    return { obj: o };
})();

console.log(foo.obj.bar);   // "bar"
```


## Classic Module Pattern

- There must be an outer wrapping function being executed
- There must be one ore more functions which are returned

```JavaScript
var foo = (function(){
    var o = { bar: "bar" };
    
    return {
      bar: function() {
          console.log(o.bar); 
      }  
    };
})();


foo.bar();      // "bar"
```

Another flavour; modified module pattern....

```JavaScript
var foo = (function(){
    var publicAPI = { 
        bar: function() {
            publicAPI.baz();
        },
        baz: function() {
            console.log("baz");
        } 
    };
    
    return publicAPI;
})();


foo.bar();      // "bar"
```

Module loader style:

```JavaScript
define("foo", function(){
    var o = { bar: "bar" };
    return {
        bar: function bar() {
            console.log(o.bar);
        }
    };
});
```

Native module support ins ES6.:

```JavaScript
//foo.js
var o = { bar: "bar" };

export function bar() {
    return o.bar;
}

export function baz() {
    console.log(o.bar);
}

```

```JavaScript
import bar from "foo";
bar();
```

```JavaScript
module foo from "foo";
foo.bar();
```

# ProtoType #

Every single object is build by a constructor function.

A constructor makes an object linked to its own prototype

Foo.prototype
a1.__prototype__ is nick named dunder proto.

a1.constructor === Foo;
a1.__proto__ === Object.getPrototypeOf(a1);
a1.__proto__ == a2.__proto__
a1.__proto__ == a2.onstructor.prototype
