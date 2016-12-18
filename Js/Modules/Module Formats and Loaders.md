#JavaScript Module Formats & Loaders#

There are a number of defined module formats. These can be used in conjunction with a number of module loaders.

The module formats include:

- Asynchronous Module Defintion (AMD)
	- Popular on client side (web browsers)
- CommonJS
	- Popular on server side (node js)
- Universal Module Definition (UMD)
	- Tries to be comptable with both AMD and CommonJS format
	- Useful when modules are required to be loaded on both the client and server side
- ES2015 native format
- System.register
	- Used with popular SystemJS, which can load modules in many formats

The module loaders include:

- RequireJS
	- Usesd the AMD module format
	- Used predominantly on the browser where asynchrnonous module loading is more critical
- SystemJS
	- Supports AMD, CommonJS, UMD and System.register formats
	- Used by Node.Js

##Asynchronous Module Definition (AMD)##

AMD modules can be loaded with a numbe of module loaders; here we look at RequireJS.

> **Note:** The whole of the syntax (barring config) is the AMD format.The require function is the defined module format which RequireJS provides when we import it.

###Creating and Importing Modules###

Prefered Client side module format. Allows modules to be loaded as Asynchronously which is ideal when loading in a browser.

- The require.config paths element is used to alias a common library to it's current version.
- The define funciton is used to declare a module.
	- Modules can exist in one common file or as seperate files
	- Define takes the module name and an array of dependant modules,
    - The function passed to the define takes an argument for each export from each dependant module 
	- The return statement defines the exposed functionality and state (puplic API)

```JavaScript
require.config({
    paths: {
        jquery: 'jquery-2.1.1.min'
    }
});

define("amdModuleExample", [jquery], function($) {
    "use strict";

    function methodOne (param) {
		console.log("amdModuleExample.methodOne: " + param)
    }

	 function methodTwo (param) {
		console.log("amdModuleExample.methodTwo: " + param)
    }

    return {
        methodOne: methodOne,
		methodTwo: methodTwo
    };
});
```

###Including RequireJs In a Web Page###

The data-main attribute is used to define the initial main module along with the location of the RequireJs library.

```html
<script data-main="js/main" src="node_modules/requirejs/require.js"></script>
```

###Dependency Locations###

The following rules are used to locate the module

- The same file
	- "MyModule"
- The file name relative to the directory defined in the data-main attribute
	- "MyModule"
	- "./MyModule"
- Using relative paths
	- "subDir/moduleName"
- Using aliases in the config paths which can contain paths


###Bootloading###

It is good practice to bootload your code with a main.js.

```JavaScript
require.config({
    paths: {
        jquery: 'jquery-2.1.1.min'
    }
});

require(["app"], function (app) {
    app.init();
});
```

You starting nmodule will be defined within app.js

###Optimising With R###

Even though AMD supports asrynchronous module loading, it can still suffer from performance issues due to the number of requests to the server.

RequireJS contains the R module which can be used to flatten your modular code into one minimised file.

Create a build.js file which can be called via a tool such as Grnut.Js

```JavaScript
// build/build.js
({
	// Paths are relative to the build directory (build/build.js)
	name: "main",
	baseUrl: "../src/js",
	mainConfigFile: "../src/js/main.js",
	out: "../src/js/main-optimized.min.js",
	generateSourceMaps: true,
	preserveLicenseComments: false,
	optimize: "uglify2"
})
```

R is thhe called by:

> node build\r.js build/build.config.js

###Unit Testing###

Squire.js is a dependency injector for RequireJS. It can be used to make mocking dependencies easy!

https://github.com/iammerrick/Squire.js

##CommonJS##

CommonJS is the preferred format for NodeJS

The file is scopped to itself and any variables do not pollute the global space; as long as they use the var keyword.

- require("moduleName") is used to import a dependency
- module.exports is used to expose functionality and state
- The whole file is the module

```JavaScript

var fooModule = require('./foo.js');

// private members
var foo = "";
var moo = fooModule.ImportedMethod();

function functionOne(newName) {
    playerName = newName;
}

function functionTwo() {
    return playerName;
}

module.exports = {
    functionOne: functionOne,
    functionTwo: functionTwo
};
```

> **Note: **module.exports is the same as exports though the former should be preferred. When exporting one single function or entity as 'exports = thisFunction' causes problems.

##SystemJS Module Loader##

SystemJS can be used to load all module types on the client end.

> https://github.com/systemjs/systemjs

Install SystemJS with NPM.

The following can be used to improt the initial modulae on a webpage. The config us used to declare which module format is being use.

```JavaScript

<script src "node_modules/systemjs/dist/systemjs"></script>

<!-- Configure the module format and load in our initiall module -->
<script>
   System.config({
      meta: {
         format: 'cjs' // CommonJS
      }
   });

	System.import('js/app.js');
</script>
```