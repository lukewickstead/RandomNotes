# const and let

ES6 comes with two more options to declare your variables: const and let.

A variable declared with const cannot be re-assigned or re-declared. It cannot get mutated (changed, modified).


- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let


# Object Initializer

```JavaScript
const name = 'Robin';
const user = {
    name: name,
};
```

When the property name in your object is the same as your variable name, you can do the following:

```JavaScript
const name = 'Robin';
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
name: 'Robin',
};

// ES6
const key = 'name';
const user = {
	[key]: 'Robin',
};
```

- https://developer.mozilla.org/enUS/docs/Web/JavaScript/Reference/Operators/Object_initializer

# Destructuring

```JavaScript
const user = {   firstname: 'Robin',   lastname: 'Wieruch', };

// ES5
var firstname = user.firstname;
var lastname = user.lastname;
console.log(firstname + ' ' + lastname); // output: Robin Wieruch

// ES6
const { firstname, lastname } = user;
console.log(firstname + ' ' + lastname); // output: Robin Wieruch
```

A best practice for readability is to use multilines

```JavaScript
const {
	firstname,
    lastname
} = user;
```

The same goes for arrays. You can destructure them too.

```JavaScript
const users = ['Robin', 'Andrew', 'Dan'];
const [
	userOne,
    userTwo,
    userThree
] = users;

console.log(userOne, userTwo, userThree); // output: Robin Andrew Dan
```

Local state object in the App component can get destructured the same way.

```JavaScript
render() {
    const { searchTerm, list } = this.state;
    return (
        <div className="App">
            {list.filter(isSearched(searchTerm)).map(item =>
            )}
        </div>
    );
}
```
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment

# Spread Operators

React embraces immutable data structures.

You can use JavaScript ES6 Object.assign().

It takes as first argument a target object. All following arguments are source objects. These objects are merged into the target object.

```JavaScript
const updatedHits = { hits: updatedHits }; const updatedResult = Object.assign({}, this.state.result, updatedHits);
```

Latter objects will override former merged objects when they share the same property names.

That would already be the solution. But there is a simpler way in JavaScript ES6 and future JavaScript releases.

The spread operator, when it is used, every value from an array or object gets copied to another array or object.

```JavaScript
const userList = ['Robin', 'Andrew', 'Dan'];
const additionalUser = 'Jordan'; const allUsers = [ ...userList, additionalUser ];
console.log(allUsers);
// output: ['Robin', 'Andrew', 'Dan', 'Jordan']
```

Can merge two arrays

```JavaScript
const oldUsers = ['Robin', 'Andrew'];
const newUsers = ['Dan', 'Jordan']; const allUsers = [ ...oldUsers, ...newUsers ];
console.log(allUsers); // output: ['Robin',
```

Now let’s have a look at the object spread operator. It is not JavaScript ES6 but create-react-app incorporated the feature in the configuration.

```JavaScript
const userNames = { firstname: 'Robin', lastname: 'Wieruch' };
const age = 28;
const user = { ...userNames, age };

console.log(user);
// output: { firstname: 'Robin', lastname: 'Wieruch', age: 28 }
```

Multiple objects can be spread like in the array spread example.

```JavaScript
const userNames = { firstname: 'Robin', lastname: 'Wieruch' }; const userAge = { age: 28 };
const user = { ...userNames, ...userAge };

console.log(user);
// output: { firstname: 'Robin', lastname: 'Wieruch', age: 28 }
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax

Exercises: read more about the ES6 Object.assign() read more about the ES6 array spread operator the object spread operator is briefly mentioned


# ES6 Arrow Functions

```JavaScript
function expression
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
        <div key={item.objectID}>
            <span>
                <a href={item.url}>{item.title}</a>
            </span>
            <span>{item.author}</span>
            <span>{item.num_comments}</span>
            <span>{item.points}</span>
        </div>
    );
)}
```

In a concise body an implicit return is attached. Thus you can remove the return statement.

```JavaScript
{list.map(item =>
	<div key={item.objectID}>
    	<span>
        	<a href={item.url}>{item.title}</a>
        </span>
        <span>{item.author}</span>
        <span>{item.num_comments}</span>
        <span>{item.points}</span>
    </div>
)}
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions

# ES6 Classes

JavaScript ES6 introduced classes.

```JavaScript
class Developer {
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
const robin = new Developer('Robin', 'Wieruch');
console.log(robin.getName()); // output: Robin Wieruch
```

React uses JavaScript ES6 classes.

```JavaScript
import React, { Component } from 'react';

class App extends Component {
	render() {
    }
}

```

The App class extends from Component. The Component class encapsulates all the implementation details of a React component. It enables developers to use classes as components in React.

The render() method has to be overridden, because it defines the output of a React Component. It has to be defined.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes

## Modules

You can export one or multiple variables. It is called a named export.

```JavaScript
const firstname = 'robin';
const lastname = 'wieruch';

export { firstname, lastname };
```

And import them in another file with a relative path to the first file.

```JavaScript
import { firstname, lastname } from './file1.js';

console.log(firstname);
// output: robin
```

You can also import all exported variables from another file as one object.

```JavaScript
file2.js import * as person from './file1.js';

console.log(person.firstname);
// output: robin
```

Imports can have an alias.

```JavaScript
import { firstname as foo } from './file1.js';
console.log(foo);
// output: robin
```

Last but not least there exists the default statement. It can be used for a few use cases:

- to export and import a single functionality
- to highlight the main functionality of the exported API of a module
- to have a fallback import functionality

```JavaScript
// file1.js
const robin = {
	firstname: 'robin',
    lastname: 'wieruch',
};

export default robin;
```

You can leave out the curly braces for the import to import the default export.

```JavaScript
import developer from './file1.js';
console.log(developer);
// output: { firstname: 'robin', lastname: 'wieruch' }
```

Export the variables directly

```JavaScript
export const firstname = 'robin'; export const lastname = 'wieruch';
```

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export
- https://read.amazon.com/ref=kcr_app_surl_cloudreader