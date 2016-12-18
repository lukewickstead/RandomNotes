#ES5 Modules#

Modules allow us to encapsulate our state and functionality and stop us polluting the global scope.

ES5 Modules are all constructed by hand and don't have the concept of module dependencies.

##Immediately-invoked functions expressions (IIFE)##

An IFFE is simply a function which is called imediatly. An enclosure is created around all entities within it and they are only accessible inside the function unless they are returned as part of the initial call.

```JavaScript
(function() {
    console.log('Inside the IIFE');
})();
```

This can also be done with the executing brackets are inside the function wrapper.

```JavaScript
(function() {
    console.log('Inside the IIFE');
}());
```

We can pass in parameters into our function as we would any other fucntion.

```JavaScript
(function(parameter) {
    console.log('Inside the IIFE with: ' + parameter);
}("Hello there!!!"));
```

##Revealing Module Pattern##

###The revealing module pattern as a singleton###

```JavaScript
var module = function() {

    // private members
    var privateField = '';

    function logPrivateField() {
        console.log('The private field is ' + privateField + '.');
    }

    function setPrivateField(newName) {
        privateField = newName;
    }

    function getPrivateField() {
        return privateField;
    }

    return {
        logPrivateField: logPrivateField,
        setPrivateField: setPrivateField,
        getPrivateField: getPrivateField
    };
}();

// Invoke
module.setPrivateField("Kaboom!!");
```
###The revealing module pattern as a constructor###

Variables which can be used as a constructor are by convention Pascal case (upper camel case).

```JavaScript
var Module = function() {

    // private members
    var privateField = '';

    function logsetPrivateField() {
        console.log('The private field is ' + privateField + '.');
    }

    function setPrivateField(newName) {
        privateField = newName;
    }

    function getPrivateField() {
        return privateField;
    }

    return {
        logPrivateField: logsetPrivateField,
        setPrivateField: setPrivateField,
        getPrivateField: getPrivateField
    };
}; // removed invokation

// Invoke
var foo = new Module();
foo.setPrivateField("Kaboom!!");
```