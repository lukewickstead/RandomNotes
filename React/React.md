# Introduction to React

## Repo

- https://github.com/the-road-to-learn-react/hackernews-client
- https://github.com/the-road-to-learn-react/the-road-to-learn-react

## Installation

### CDN

``` JavaScript
<script crossorigin src="https://unpkg.com/react@16/umd/react.development.js">
</script>
<script crossorigin src="https://unpkg.com/react-dom@16/umd/react-dom.developmen\ t.js">
</script>
```
### NPM

> npm install react react-dom

## Creatre React App

Facebook introduced create-react-app as a zero-configuration React solution; https://reactjs.org/docs/try-react.html

> npm install -g create-react-app
> create-react-app myapp

It’s an opinionated yet zero-configuration starter kit for React

The create-react-app application is a npm project. You can use npm to install and uninstall node packages to your project. Additionally it comes with the following npm scripts for your command line:

Runs the application in http://localhost:3000
> npm start

Runs the tests
> npm test

Builds the application for production
> npm run build

## JSX

```JavaScript
var helloWorld = 'Welcome to the Road to learn React';
<h2>{helloWorld}</h2>
```

You can find all of the supported HTML attributes in the React documentation

- https://reactjs.org/docs/dom-elements.html#all-supported-html-attributes
- https://reactjs.org/blog/2015/12/18/react-components-elements-and-instances.html

## ReactDOM


```JavaScript
ReactDOM.render(
	<App />,
    document.getElementById('root')
);
```


Basically ReactDOM.render() uses a DOM node in your HTML to replace it with your JSX.

ReactDOM.render() expects two arguments. The first argument is JSX that gets rendered. The second argument specifies the place where the React application hooks into your HTML.

It doesn’t have to be an instantiation of a component.

```JavaScript
ReactDOM.render(
	<h1>Hello React World</h1>,
    document.getElementById('root') );
```

- https://reactjs.org/docs/rendering-elements.html

## Hot Module Replacement

In create-react-app it is already an advantage that the browser automatically refreshes the page when you change your source code.

Hot Module Replacement (HMR) is a tool to reload your application in the browser. The browser doesn’t perform a page refresh.

You have to add one little configuration.

```JavaScript
if (module.hot) {
	module.hot.accept();
}
```

- https://www.youtube.com/watch?v=xsSnOQynTHs


## Complex JavaScript in JSX

```JavaScript
const list = [  {
    title: 'React',
       url: 'https://facebook.github.io/react/',
       author: 'Jordan Walke',
       num_comments: 3,
       points: 4,
       objectID: 0,

},    {
    title: 'Redux',
       url: 'https://github.com/reactjs/redux',
       author: 'Dan Abramov, Andrew Clark',
       num_comments: 2,
       points: 5,
       objectID: 1,
}, ];
```

```JavaScript
class App extends Component {
	render() {
    	return (
        	<div className="App">
            	{list.map(function(item) {
                	return (
                    	<div>
                        	<span>
                            	<a href={item.url}>{item.title}</a>
                            </span>
                            <span>{item.author}</span>
                            <span>{item.num_comments}</span>
                            <span>{item.points}</span>
                        </div>
                    );
                })}
            </div>
        );
    }
}
```

But you should add one helper for React to embrace its full potential and improve its performance. You have to assign a key attribute to each list element. That way React is able to identify added, changed and removed items when the list changes.

```JavaScript
{list.map(function(item) {
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
})};
```

You should make sure that the key attribute is a stable identifier. Don’t make the mistake of using index of the item in the array.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map
- https://reactjs.org/docs/lists-and-keys.html

## ES6 Arrow Functions

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

## ES6 Classes

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

# Basics in React

## Internal Component State

Internal component state, also known as local state, allows you to save, modify and delete properties that are stored in your component.

```JavaScript

const list = [
	{
    	title: 'React',
        url: 'https://facebook.github.io/react/',
        author: 'Jordan Walke',
        num_comments: 3,
        points: 4,
        objectID: 0,
    },
];

class App extends Component {
	constructor(props) {
    	super(props);
        this.state = {
        	list: list,
        };
    }
}
```

```JavaScript
class App extends Component {
	render() {
        return (
            <div className="App">
                {this.state.list.map(item =>
                    <div key={item.objectID}>
                        <span>
                            <a href={item.url}>{item.title}</a>
                        </span>
                        <span>{item.author}</span>
                        <span>{item.num_comments}</span>
                        <span>{item.points}</span>
                    </div>
                )}
            </div>
        );
	}
}
```

Every time you change your component state, the render() method of your component will run again.

But be careful. Don’t mutate the state directly. You have to use a method called setState() to modify your state.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes#Constructor

## Unidirectional Data Flow

In order to define the onDismiss() as class method, you have to bind it in the constructor.

```JavaScript
<span>
	<button
    onClick={() => this.onDismiss(item.objectID)}
    type="button">
     	Dismiss
     </button>
 </span>
```

```JavaScript
class App extends Component {
	constructor(props) {
    	super(props);

        this.state = {
        	list,
        };

        this.onDismiss = this.onDismiss.bind(this);
    }

    onDismiss(id) {
    }

    render() {
    }
}
```

```JavaScript
onDismiss(id) {
	const updatedList = this.state.list.filter(function isNotId(item) {
    	return item.objectID !== id;
    });
}
```
IIn the next step, you can extract the function and pass it to the filter function.

```JavaScript
onDismiss(id) {
	function isNotId(item) {
    	return item.objectID !== id;
    }

    const updatedList = this.state.list.filter(isNotId); 
}
```

In addition, you can do it more concisely by using a JavaScript ES6 arrow function again.

​```JavaScript
onDismiss(id) {
	const isNotId = item => item.objectID !== id;
    const updatedList = this.state.list.filter(isNotId); 
}
```

You could even inline it again,

​```JavaScript
onDismiss(id) {
	const updatedList = this.state.list.filter(item => item.objectID !== id);

Finally use the setState() class method to update the list in the internal component state.


​```JavaScript
onDismiss(id) {
	const isNotId = item => item.objectID !== id;
    const updatedList = this.state.list.filter(isNotId);
    this.setState({ list: updatedList });
}
```

- https://reactjs.org/docs/state-and-lifecycle.html

## Bindings 

In the previous chapter, you have bound your class method onDismiss() in the constructor.

```JavaScript
class App extends Component {
	constructor(props) {
        super(props);

        this.state = {
            list,
        };

        this.onDismiss = this.onDismiss.bind(this);
    }
}
```

The binding step is necessary, because class methods don’t automatically bind this to the class instance.

```JavaScript
this.onClickMe = this.onClickMe.bind(this);
```

The class method binding can happen somewhere else too. For instance, it can happen in the render() class method.


```JavaScript
<button
	onClick={this.onClickMe.bind(this)}
    type="button"
>
```
But you should avoid it, because it would bind the class method every time when the render() method runs.

Basically it runs every time your component updates which leads to performance implications. When binding the class method in the constructor, you bind it only once in the begining when the compoenent is instantiated.

Another thing people sometimes come up with is defining the business logic of their class methods in the constructor.

```JavaScript
class ExplainBindingsComponent extends Component {
	constructor() {
    	super();

        this.onClickMe = () => {
        	console.log(this);
        }
    }

    render() {
    	return (
        	<button
            	onClick={this.onClickMe}
                type="button"
           	>
           		Click Me
        	</button>
    	);
	}
}
```

You should avoid it too, because it will clutter your constructor over time.

```JavaScript
class ExplainBindingsComponent extends Component {
	constructor() {
    	super();
        	this.doSomething = this.doSomething.bind(this);
           	this.doSomethingElse = this.doSomethingElse.bind(this);   	}

    doSomething() {
    }

    doSomethingElse() {
    }
}
```

ast but not least, it is worth to mention that class methods can be autobound automatically without binding them explicitly by using arrow functions

```JavaScript
class ExplainBindingsComponent extends Component {
	onClickMe = () => {
    	console.log(this);
    }

    render() {
    	return (
        	<button
            	onClick={this.onClickMe}
                type="button"
            >
            	Click Me
            </button>
        );
    }
}
```

## Event Handler

In your application, you are using the following button element to dismiss an item from the list.

```JavaScript
<button
	onClick={() => this.onDismiss(item.objectID)}
    type="button" >
	Dismiss
</button>
```

That’s already a complex use case, because you have to pass a value to the class method and thus you have to wrap it into another arrow function

The following code wouldn’t work, because the class method would be executed immediately when you open the application in the browser.

```JavaScript
<button
	onClick={this.onDismiss(item.objectID)}
    type="button" >
    Dismiss
</button>
```

But when using onClick={doSomething} whereas doSomething is a function, it would be executed when clicking the button.

The item.objectID property needs to be passed to the class method to identify the item that is going to be dismissed. That’s why it can be wrapped into another function to sneak in the property. The concept is called higher-order functions in JavaScript.

```JavaScript
<button
	onClick={() => this.onDismiss(item.objectID)}
    type="button" >
  Dismiss
</button>
```

A workaround would be to define the wrapping function somewhere outside and only pass the defined function to the handler.

```JavaScript
class App extends Component {
	render() {
    	return (
        	<div className="App">
            	{this.state.list.map(item => {
                	const onHandleDismiss = () =>
                    	this.onDismiss(item.objectID);
                    return (
                    	<div key={item.objectID}>
                        	<span>
                            	<a href={item.url}>{item.title}</a>
                                </span>
                            <span>{item.author}</span>
                            <span>{item.num_comments}</span>
                            <span>{item.points}</span>               							<span>
                            	<button
                                	onClick={onHandleDismiss}
                                    type="button"
                                > Dismiss
                                </button>
                            </span>
                        </div>
            		);
            	}
            )}
        	</div>
    	);
	}
}
```

In order to keep it concise, you can transform it into a JavaScript 

```JavaScript
	<button
    	onClick={() => console.log(item.objectID)}
        type="button" >
    Dismiss
</button>
```

Often newcomers to React have difficulties with the topic of using functions in event handlers. That’s why I tried to explain it in more detail here.

In the end, you should end up with the following code in your button to have a concisely inlined JavaScript ES6 arrow function that has access to the objectID property of the item object.

```JavaScript
	<button
    	onClick={() => this.onDismiss(item.objectID)}
        type="button"
        >
    Dismiss
</button>
```

the onClick handler for the onDismiss() method is wrapping the method in another arrow function to be able to pass the item identifier. So every time the render() method runs, the handler instantiates the higher-order arrow function. It can have an impact on your application performance, but in most cases you will not notice it.

Imagine you have a huge table of data with 1000 items and each row or column has such an arrow function in an event handler. Then it is worth to think about the performance implications and therefore you could implement a dedicated Button component to bind the method in the constructor.

## Interactions with Forms and Events

You can use synthetic events in React to access the event payload.


```JavaScript
<input
	type="text"
    onChange={this.onSearchChange}
/>
```

When using a handler in your element, you get access to the synthetic React event in your callback function’s signature.

```JavaScript
class App extends Component {
	onSearchChange(event) {
    }
}
```

The event has the value of the input field in its target object.

```JavaScript
class App extends Component {
	onSearchChange(event) {
    	this.setState({ searchTerm: event.target.value });
    }
}
```

React’s this.setState() is a shallow merge. It preserves the sibling properties in the state object when updating one sole property in it.

```JavaScript
class App extends Component {
	render() {
    	return (
        	<div className="App">
            	<form>
                	<input
                    	type="text"
                        onChange={this.onSearchChange}
                    />
                </form>
                {this.state.list.filter(...).map(item =>
                )}
            </div>
        );
    }
}
```

Let’s approach the filter function in a different way this time;  a higher-order function.

```JavaScript
function isSearched(searchTerm) {
	return function(item) {
    // some condition which returns true or false
    }
}

class App extends Component {
}
```

The returned function has access to the item object because it is the function that is passed to the filter function.

```JavaScript
function isSearched(searchTerm) {
	return function(item) {
    	return item.title.toLowerCase().includes(searchTerm.toLowerCase());
    }
}
class App extends Component {
}
```

How would that look like in JavaScript ES5? You would use the indexOf()

```JavaScript
// ES5
string.indexOf(pattern) !== -1

// ES6
string.includes(pattern)
```

Another neat refactoring can be done with an ES6 arrow function again.

```JavaScript
// ES5 function
isSearched(searchTerm) {
	return function(item) {
    	item.title.toLowerCase().indexOf(searchTerm.toLowerCase()) !== -1;
    }
}

// ES6
const isSearched = searchTerm => item => item.title.toLowerCase().includes(searchTerm.toLowerCase());
```
Function which returns a function (higher-order functions).

ES6, you can express these more concisely with arrow functions.

```JavaScript
class App extends Component {
	render() {
    	return (
        	<div className="App">
            	<form>
                	<input
                    	type="text"
                        onChange={this.onSearchChange}
                    />
				</form>                	{this.state.list.filter(isSearched(this.state.searchTerm)).map(item =>
                    )}
            </div>
        );
    }
}
```

- https://en.wikipedia.org/wiki/Higher-order_function
- https://reactjs.org/docs/handling-events.html

## ES6 Destructuring

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

## Controlled Components

Form elements such as <input>, <textarea> and <select> hold their own state in plain HTML. They modify the value internally once someone changes it from the outside. In React that’s called an uncontrolled component, because it handles its own state.

In React, you should make sure to make those elements controlled components.

```JavaScript
class App extends Component {
	render() {
    	const { searchTerm, list } = this.state;
        return (
        	<div className="App">
            	<form>
                	<input
                    	type="text"
                        value={searchTerm}
                        onChange={this.onSearchChange}
                    />
                </form>
            </div>
        );
    }
}
```

That’s it. The unidirectional data flow loop for the input field is self-contained now. The internal component state is the single source of truth for the input field.

- https://reactjs.org/docs/forms.html
- https://github.com/the-road-to-learn-react/react-controlled-components-examples

## Split Up Components

You have one large App component now. You can start to split it up into chunks of smaller components.

```JavaScript
class App extends Component {
	render() {
    	const { searchTerm, list } = this.state;
        return (
        	<div className="App">
            	<Search />
                <Table />
            </div>
        );
    }
}
```

You can pass those components properties which they can use themselves.

```JavaScript
class App extends Component {
	render() {
    	const { searchTerm, list } = this.state;
        return (
        	<div className="App">
            	<Search
                	value={searchTerm}
                    onChange={this.onSearchChange}
                />
                <Table
                	list={list}
                    pattern={searchTerm}
                    onDismiss={this.onDismiss}
                />
            </div>
        );
    }
}
```

```JavaScript
class Search extends Component {
	render() {
    	const { value, onChange } = this.props;
        return (
        	<form>
            	<input
                	type="text"
                    value={value}
                    onChange={onChange}
                />
            </form>
        );
    }
}
```

```JavaScript
class Table extends Component {
	render() {
    	const { list, pattern, onDismiss } = this.props;
        return (
        	<div>
            	{list.filter(isSearched(pattern)).map(item =>
                	<div key={item.objectID}>
                    	<span>
                        	<a href={item.url}>{item.title}</a>
                            </span>
                        <span>{item.author}</span>
                        <span>{item.num_comments}</span>
                        <span>{item.points}</span>
                        <span>
                        	<button
                            	onClick={() => onDismiss(item.objectID)}
                                type="button"
                            >
                            	Dismiss
                            </button>
                        </span>
                    </div>
                )}
            </div>
        );
    }
}
```

The props, short form for properties, have all the values you have passed to the components when you used them in your App component.

## Composable Components 

The children prop. You can use it to pass elements to your components from above, which are unknown to the component itself, but make it possible to compose components into each other.

```JavaScript
function WelcomeDialog() {
  return (
    <FancyBorder color="blue">
      <h1 className="Dialog-title">
        Welcome
      </h1>
      <p className="Dialog-message">
        Thank you for visiting our spacecraft!
      </p>
    </FancyBorder>
  );
}

function FancyBorder(props) {
  return (
    <div className={'FancyBorder FancyBorder-' + props.color}>
      {props.children}
    </div>
  );
}
```

https://reactjs.org/docs/composition-vs-inheritance.html

## Reusable Components

```JavaScript
class Button extends Component {
	render() {
    	const {
        	onClick,
            className,
            children,
        } = this.props;

        return (
        	<button
            	onClick={onClick}
                className={className}
                type="button"
            >
            	{children}
            </button>
        );
    }
}
```

```JavaScript
<Button onClick={() => onDismiss(item.objectID)}>
	Dismiss
</Button>
```

## Component Declarations

Functional stateless components as alternative for ES6 class components.

- They are functions and have no local state
- They cannot access or update the state with this.state or this.setState()
- They have no bound this object.
- They have no lifecycle methods.

A rule of thumb is to use functional stateless components when you don’t need local state or component lifecycle methods.

```JavaScript
function Search(props) {
	const {
    	value,
        onChange,
        children
    } = props;
    return (
        <form>
            {children}
            <input
            type="text"
            value={value}
            onChange={onChange}/>
        </form>
    );
}
```

The best practice is to use it in the function signature to destructure the props.

```JavaScript
function Search({ value, onChange, children }) {
	return (
    	<form>
        	{children}
            <input
            	type="text"
                value={value}
                onChange={onChange} />
        </form>
    );
}
```

Arrow functions allow you to keep your functions concise.

```JavaScript
const Search = ({ value, onChange, children }) =>
	<form>
    	{children}
        <input
        	type="text"
            value={value}
            onChange={onChange} />
    </form>
```

The last step was especially useful to enforce only to have props as input and JSX as output. Nothing in between.

You could do something in between by using a block body in your ES6 arrow function.

```JavaScript
const Search = ({ value, onChange, children }) => {
	// do something

    return (
    	<form>
        	{children}
            <input
            	type="text"
                value={value}
                onChange={onChange} />
        </form>
    );
}
```

- https://reactjs.org/docs/components-and-props.html

## Styling Components

Don’t forget to use React className instead of class as HTML attribute.

```JavaScript
<div className="page">
	<div className="interactions">
```

Define JavaScript objects and pass them to the style attribute of an element.

Inline style.

```JavaScript
<span style={{ width: '40%' }}>
```

You could define the style objects outside of your elements to make it cleaner.


```JavaScript
const smallColumn = {   width: '10%', };
<span style={smallColumn}>. In
```

- https://github.com/css-modules/css-modules
- https://github.com/styled-components/styled-components

# Getting Real with an API

## Lifecycle Methods

These methods are a hook into the lifecycle of a React component.

They can be used in ES6 class components, but not in functional stateless components.

You already know two lifecycle methods that can be used in an ES6 class component: constructor() and render().

The constructor is only called when an instance of the component is created and inserted in the DOM. The component gets instantiated. That process is called mounting of the component.

The render() method is called during the mount process too, but also when the component updates. Each time when the state or the props of a component change, the render() method of the component is called.

The mounting of a component has two more lifecycle methods: componentWillMount() and componentDidMount().

The constructor is called first, componentWillMount() gets called before the render() method and componentDidMount() is called after the render() method.

Overall the mounting process has 4 lifecycle methods. They are invoked in the following order:

- constructor()
- componentWillMount()
- render()
- componentDidMount()

But what about the update lifecycle of a component that happens when the state or the props change? Overall it has 5 lifecycle methods in the following order:

- componentWillReceiveProps()
- shouldComponentUpdate()
- componentWillUpdate()
- render()
- componentDidUpdate()

- Last but not least there is the unmounting lifecycle . It has onyl one lifecycle method; componentWillUnmount()

- constructor(props)
	-It is called when the component gets initialized. You can set an initial component state and bind class methods during that lifecycle method.
- componentWillMount()
	- It is called before the render() lifecycle method. That’s why it could be used to set internal component state, because it will not trigger a second rendering of the component. Generally it is recommended to use the constructor() to set the initial state.
- render()
	- This lifecycle method is mandatory and returns the elements as an output of the component. The method should be pure and therefore shouldn’t modify the component state. It gets an input as props and state and returns an element.
- componentDidMount()
	- It is called only once when the component mounted. That’s the perfect time to do an asynchronous request to fetch data from an API. The fetched data would get stored in the internal component state to display it in the render() lifecycle method.
componentWillReceiveProps(nextProps)
	- The lifecycle method is called during an update lifecycle. As input you get the next props. You can diff the next props with the previous props, by using this.props, to apply a different behavior based on the the diff. Additionally, you can set state based on the hext props.
- shouldComponentUpdate(nextProps, nextState)
	- It is always called when the component updates due to state or props changes. You will use it in mature React applications for performance optimizations. Depending on a boolean that you return from this lifecycle method, the component and all its children will render or will not render on an update lifecycle. You can prevent the render lifecycle method of a component.
- componentWillUpdate(nextProps, nextState)
	 The lifecycle method is immediately invoked before the render() method. You already have the next props and next state at your disposal. You can use the method as last opportunity to perform preparations before the render method gets executed. Note that you cannot trigger setState() anymore. If you want to compute a state based on the next props, you have to use componentWillReceiveProps()
- componentDidUpdate(prevProps, prevState)
	- The lifecycle method is immediately invoked after the render() method. You can use it as opportunity to perform DOM operations or to perform further asynchrnoous.
- componentWillUnmount() - It is called before you destroy your component. You can use the lifecycle method to perform any clean up tasks.

There is one more lifecycle method: componentDidCatch(error, info). It was introduced in React 16 and is used to catch errors in components.


- https://reactjs.org/blog/2017/07/26/error-handling-in-react-16.html
- https://reactjs.org/docs/state-and-lifecycle.html
- https://reactjs.org/docs/react-component.html

## Fetching Data

There was one lifecycle method mentioned that can be used to fetch data: componentDidMount()

In JavaScript ES6, you can use template strings to concatenate strings.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals

```JavaScript
// ES6
const url = `${PATH_BASE}${PATH_SEARCH}?${PARAM_SEARCH}${DEFAULT_QUERY}`; 

// ES5 var url = PATH_BASE + PATH_SEARCH + '?' + PARAM_SEARCH + DEFAULT_QUERY; 

console.log(url);
// output: https://hn.algolia.com/api/v1/search?query=redux
```

```JavaScript
setSearchTopStories(result) {
	this.setState({ result });
}

componentDidMount() {
	const { searchTerm } = this.state;

fetch(`${PATH_BASE}${PATH_SEARCH}?${PARAM_SEARCH}${searchTerm}`)
	.then(response => response.json())
    .then(result => this.setSearchTopStories(result))
    .catch(error => error);
}
```

```JavaScript
render() {
	const { searchTerm, result } = this.state;

    if (!result) { return null; }

    return (
    	<div className="page">
        ...
        	<Table
            	list={result.hits}
                pattern={searchTerm}
                onDismiss={this.onDismiss} />
        </div>
    );
}
```

There are third-party node packages that you can use to substitute the native fetch API: superagent and axios

- https://www.robinwieruch.de/react-fetching-data/
- https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API
- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals

Exercises: read more about ES6 template strings read more about the native fetch API read more about data fetching in React

## Conditional Rendering

When you want to make a decision to render either one or another element or nothing.

Expressed by an if-else statement in JSX.

```JavaScript
if (!result) { return null;}
```

You can simply use a ternary operator in your JSX.

```JavaScrip
{ result
	? <Table
    	list={result.hits}
        pattern={searchTerm}
        onDismiss={this.onDismiss} />
    : null
}
```

A third option is the logical && operator. In JavaScript a true && 'Hello World' always evaluates to ‘Hello World’. A false && 'Hello World' always evaluates to false.


```JavaScript
const result = true && 'Hello World';
console.log(result);
// output: Hello World

const result = false && 'Hello World';
console.log(result);
// output: false
```

```JavaScript
{ result &&
	<Table
    	list={result.hits}
        pattern={searchTerm}
        onDismiss={this.onDismiss}
    />
}
```

You can read about more alternatives in an exhaustive list of examples for conditional rendering approaches.

- https://reactjs.org/docs/conditional-rendering.html
- https://www.robinwieruch.de/conditional-rendering-react/

## Client- or Server-side Search

In React you will often come across the preventDefault() event method to suppress the native browser behavior.

```JavaScript
onSearchSubmit(event) {
	const { searchTerm } = this.state;
    this.fetchSearchTopStories(searchTerm);
    event.preventDefault();
}
```
- https://reactjs.org/docs/events.html


## Error Handling 

```JavaScript
fetchSearchTopStories(searchTerm, page = 0) {
	fetch(`${PATH_BASE}${PATH_SEARCH}?
    	${PARAM_SEARCH}${searchTerm}&${PARAM_PAGE}\
        ${page}&${PARAM_HPP}${DEFAULT_HPP}`)
    .then(response => response.json())
    .then(result => this.setSearchTopStories(result))
    .catch(error => this.setState({ error }));   }
```

```JavaScript
if (error) {
	return <p>Something went wrong.</p>;
}
```

- https://reactjs.org/blog/2017/07/26/error-handling-in-react-16.html

## Axios instead of Fetch

Native fetch API. However, not all browsers, especially older browsers, support it. In addition, once you start to test your application in a headless browser environment (there is no browser, instead it is only mocked), there can be issues regarding the fetch API.

isomorphic-fetch), but we won’t go down this rabbit hole in this book.

Axios is a library that solves only one problem, but it solves it with a high quality: performing asynchronous requests to remote APIs.

First, you have to install axios on the command line:

> npm install axios


```JavaScript
import React, { Component } from 'react';
import axios from 'axios'; import './App.css';
```

And last but not least, you can use it instead of fetch().

It takes the URL as argument and returns a promise. You don’t have to transform the returned response to JSON anymore.

Wraps the result into a data object in JavaScript.

```JavaScript
fetchSearchTopStories(searchTerm, page = 0) {
	axios(`${PATH_BASE}${PATH_SEARCH}?
    	${PARAM_SEARCH}${searchTerm}&${PARAM_PAGE}\
        ${page}&${PARAM_HPP}${DEFAULT_HPP}`)
    .then(result => this.setSearchTopStories(result.data))
    .catch(error => this.setState({ error }));
```

- You can make the GET request explicit by calling axios.get()
- HTTP POST with axios.post() instead.

> Command Line Warning: Can only update a mounted or mounting component. This usually means you\  called setState, replaceState, or forceUpdate on an unmounted component. This i\ s a no-op.

Because you should be able to access it directly on the component instance without relying on React’s local state management.

```JavaScript
class App extends Component {
	_isMounted = false;

    constructor(props) {
    }

    componentDidMount() {
    	this._isMounted = true;

        const { searchTerm } = this.state;
        this.setState({ searchKey: searchTerm });
        this.fetchSearchTopStories(searchTerm);
    }

    componentWillUnmount() {
    	this._isMounted = false;
    }
}
```

Avoid calling this.setState() on your component instance even though the component already unmounted.

```JavaScript
class App extends Component {
	fetchSearchTopStories(searchTerm, page = 0) {
    	axios(`${PATH_BASE}${PATH_SEARCH}?
        	${PARAM_SEARCH}${searchTerm}&${PARAM_PAGE}\
            ${page}&${PARAM_HPP}${DEFAULT_HPP}`)
        .then(result => this._isMounted && .setSearchTopStories(result.data))
        .catch(error => this._isMounted && this.setState({ error }));
    }
}
```

- https://github.com/the-road-to-learn-react/react-alternative-class-component-syntax
- https://www.robinwieruch.de/why-frameworks-matter/

# Code Organising and Testing #

## Code Organization with ES6 Modules

In the following, I will propose several module structures you could apply.

One possible module structure could be: Folder Structure

- src/
	- index.js
	- index.css
	- App.js
	- App.test.js
	- App.css
	- Button.js
	- Button.test.js
	- Button.css
	- Table.js
	- Table.test.js
	- Table.css
	- Search.js
	- Search.test.js
	- Search.css

Or

- src/
	- index.
	- index.css
	- App/
		- index.js
		- test.js
		- index.css
    - Button/
    	- index.js
    	- test.js
    	- index.css
    - Table/
    	- index.js
    	- test.js
    	- index.css
    - Search/
		- index.js
		- test.js
		- index.css

When you use the index.js naming convention, you can omit the filename from the relative path.

```JavaScript
import {
	DEFAULT_QUERY,
    DEFAULT_HPP,
    PATH_BASE,
    PATH_SEARCH,
    PARAM_SEARCH,
    PARAM_PAGE,
    PARAM_HPP,
} from '../constants';
```

The convention was introduced in the node.js world. The index file is the entry point to a module.

It describes the public API to the module. External modules are only allowed to use the index.js file to import shared code from the module.

## Snapshot Tests with Jest

The foundation for testing in React are component tests which can be generalized as unit tests and a part of it as snapshot tests.

In this chapter, you will focus on another kind of tests: snapshot tests. That’s were Jest comes into play.

Fortunately create-react-app already comes with Jest, so you don’t need to worry about setting it up.

You have to export the components,

```JavaScript
class App extends Component {
}

export default App;

export {
	Button,
    Search,
    Table,
};
```

You can run the tests with:

> npm test

These tests make a snapshot of your rendered component and run this snapshot against future snapshots.

When a future snapshot changes, you will get notified in the test. You can either accept the snapshot change, because you changed the component implementation on purpose, or deny the change and investigate for the error.

Jest stores the snapshots in a folder. Only that way it can validate the diff against a future snapshot.

Before writing your first snapshot test with Jest, you have to install an utility library.

> npm install --save-dev react-test-renderer

```JavaScript
import React from 'react';
import ReactDOM from 'react-dom';
import renderer from 'react-test-renderer';
import App from './App';

describe('App', () => {

	it('renders without crashing', () => {
    	const div = document.createElement('div');
        ReactDOM.render(<App />, div);
        ReactDOM.unmountComponentAtNode(div);
    });

    test('has a valid snapshot', () => {
    	const component = renderer.create(
        	<App />
        );

    	let tree = component.toJSON();
    	expect(tree).toMatchSnapshot();
	});
});
```

Basically the renderer.create() function creates a snapshot of your App component. It renders it virtually and stores the DOM into a snapshot.

Let’s add more tests for our independent components. First, the Search component:

```JavaScript
import React from 'react';
import ReactDOM from 'react-dom';
import renderer from 'react-test-renderer';
import App, { Search } from './App';

describe('Search', () => {
	it('renders without crashing', () => {
    	const div = document.createElement('div');
        ReactDOM.render(<Search>Search</Search>, div);
        ReactDOM.unmountComponentAtNode(div);
    });

    test('has a valid snapshot', () => {
    	const component = renderer.create(
        	<Search>Search</Search>
        );
        let tree = component.toJSON();
        expect(tree).toMatchSnapshot();
    });
});
```

Last but not least, the Table component that you can pass a bunch of initial props to render it with a sample list.

```javascript
import App, { Search, Button, Table } from './App';

describe('Table', () => {
	const props = {
    	list: [
        	{ title: '1', author: '1', num_comments: 1, points: 2, objectID: 'y' },
            { title: '2', author: '2', num_comments: 1, points: 2, objectID: 'z' },
            ],
		};

        it('renders without crashing', () => {
        	const div = document.createElement('div');
            ReactDOM.render(<Table { ...props } />, div);
        });

        test('has a valid snapshot', () => {
        	const component = renderer.create(
            <Table { ...props } />
        );

        let tree = component.toJSON();
        expect(tree).toMatchSnapshot();
    });
});
```

- https://facebook.github.io/jest/docs/en/tutorial-react.html

## Unit Tests with Enzyme

You can use it to conduct unit tests to complement your snapshot tests in Jest.
Let’s see how you can use enzyme. First you have to install it since it doesn’t come by default with create-react-app

> npm install --save-dev enzyme react-addons-test-utils enzyme-adapter-react

Second, you need to include it in your test setup and initialize its Adapter for using it with React.

```JavaScript
import React from 'react';
import ReactDOM from 'react-dom';
import renderer from 'react-test-renderer';
import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import App, { Search, Button, Table } from './App';

Enzyme.configure({adapter: new Adapter()});
```

You will use shallow() to render your component and assert that the table  has two items.

```JavaScript
//src/App.test.js
import React from 'react';
import ReactDOM from 'react-dom';
import renderer from 'react-test-renderer'; 
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import App, { Search, Button, Table } from './App';

describe('Table', () => {
	const props = {
    	list: [
        	{ title: '1', author: '1', num_comments: 1, points: 2, objectID: 'y' },
            { title: '2', author: '2', num_comments: 1, points: 2, objectID: 'z' },
		],
	};
	
      it('shows two items in list', () =? {
      	const element = shallow(
      		<Table { ...props } />
      	);
      	
      	expect(element.find('.table-row').length).toBet(2);
	}); 
});      	
```

Shallow renders the component without its child components. That way, you can make the test very dedicated to one component.

Enzyme has overall three rendering mechanisms in its API. You already know shallow(), but there also exist mount() and render(). Both instantiate instances of the parent component and all child components. Additionally mount() gives you access to the component lifecycle methods. But when to use which render mechanism? Here some rules of thumb:

- Always begin with a shallow test 
- If componentDidMount() or componentDidUpdate() should be tested, use mount()
- If you want to test component lifecycle and children behavior, use mount() 
- If you want to test a component’s children rendering with less overhead than mount() and you are not interested in lifecycle methods, use render().

- https://github.com/airbnb/enzyme0

## Component Interface with ProtoTypes

React comes with a built-in type checker to prevent bugs. You can use PropTypes to describe your component interface.

All the props that get passed from a parent component to a child component get validated.

First, you have to install a separate package for React. 

> npm install prop-types

Then declare the props on each component.

```JavaScript
import PropTypes from 'prop-types';

Button.propTypes = {
	onClick: PropTypes.func,
    className: PropTypes.string,
    children: PropTypes.node,
}
```
The basic PropTypes for primitives and complex objects are:
- PropTypes.array
- PropTypes.bool
- PropTypes.func
- PropTypes.number
- PropTypes.object
- PropTypes.string

Additionally you have two more PropTypes to define a renderable fragment (node), e.g. a string, and a React element:

- PropTypes.node
- PropTypes.element

But for several props you want to enforce that they are defined.

```JavaScript
Button.propTypes = {
	onClick: PropTypes.func.isRequired,
    className: PropTypes.string,
    children: PropTypes.node.isRequired,
};
```

You can define the content of an array PropType more explicitly:

```JavaScript
Table.propTypes = {
	list: PropTypes.arrayOf(
    	PropTypes.shape({
        	objectID: PropTypes.string.isRequired,
            author: PropTypes.string,
            url: PropTypes.string,
            num_comments: PropTypes.number,       
            points: PropTypes.number,
		})
	).isRequired,
    onDismiss: PropTypes.func.isRequired,
};
```

You can define default values with defaultProps; ensures that the property is set to a default value when the parent component didn’t specify it.                

```JavaScript
const Button = ({
	onClick,
    className,
    children
}) =>
	<button
    	onClick={onClick}
        className={className}
        type="button"
	>
		{children}
	</button>

Button.defaultProps = {
	className: '',
};
```
- https://reactjs.org/docs/typechecking-with-proptypes.html

​              

# Advanced React Components #

## Ref a DOM Element #

The ref attribute gives you access to a node in your elements.

Usually that is an anti pattern

Three use cases:
- to use the DOM API (focus, media playback etc.)
-  to invoke imperative DOM node animations
-   to integrate with a third-party library that needs the DOM node (e.g. D3.js)

The this object of an ES6 class component helps us to reference the DOM node with the ref attribute.

```JavaScript
<input
	type="text"
    value={value}
    onChange={onChange}
    ref={(node) => { this.input = node; }}
/>
```

```JavaSccript
class Search extends Component {
	componentDidMount() {
    	if(this.input) {
        	this.input.focus();
		}
	}
}
```

In a functional stateless component without the this object?

```JavaScript
const Search = ({
	value,
    onChange,
    onSubmit,
    children
}) => {
	let input;
    return (
    	<form onSubmit={onSubmit}>
    		<input
            	type="text"
                value={value}
                onChange={onChange}
                ref={(node) => input = node}
			/>
            <button type="submit">
                {children}
            </button>
        </form>
	);
}
```
- https://reactjs.org/docs/refs-and-the-dom.html
- https://www.robinwieruch.de/react-ref-attribute-dom-node/

## Loading …

Show a loading indicator when you submit a search; define a reusable Loading component
                
```JavaScript 
const Loading = () =>
	<div>Loading ...</div>
```

```JavaScript
{ isLoading
	? <Loading />
    : <Button
    	onClick={() => this.fetchSearchTopStories(searchKey, page + 1)}>
    	More
	</Button>
}
```

## Higher-Order Components

They take any input - most of the time a component, but also optional arguments - and return a component as output.
                
```JavaScript
function withFoo(Component) {
	return function(props) {
    	return <Component { ...props } />;
	}
}
```
One neat convention is to prefix the naming of a HOC with with
                

```JavaScript
const withFoo = (Component) => (props) =>
	<Component { ...props } />
```

```JavaScript
const withLoading = (Component) => (props) =>
	props.isLoading
    	? <Loading />
        : <Component { ...props } />
```

In general it can be very efficient to spread an object, like the props object in the previous example, as input for a component.

```JavaScript
// before you would have to destructure the props before passing them 
const { foo, bar } = props;
<SomeComponent foo={foo} bar={bar} />

// but you can use the object spread operator to pass all object properties <SomeComponent { ...props } />
```

However, the input component may not care about the isLoading property. You can use the ES6 rest destructuring to avoid it.

```JavaScript
const withLoading = (Component) => ({ isLoading, ...rest }) => 
	isLoading
    	? <Loading />
        : <Component { ...rest } />
```

```JavaScript
const withLoading = (Component) => ({ isLoading, ...rest })
	=> isLoading
    	? <Loading />
        : <Component { ...rest } /> 

const ButtonWithLoading = withLoading(Button);
```

While the HOC consumes the loading property, all other props get passed to the Button component.

```JavaScript
<ButtonWithLoading
	isLoading={isLoading}
    onClick={() => this.fetchSearchTopStories(searchKey, page + 1)}>
    	More
	</ButtonWithLoading>
```

Higher-order components are an advanced technique in React. They have multiple purposes like improved reusability of components, greater abstraction, composability of components and manipulations of props, state and view.

I encourage you to read the gentle introduction to higher-order components:
- https://www.robinwieruch.de/gentle-introduction-higher-order-components/
                
## Advanced Sorting

You can use a utility library for such cases. Lodash

> npm install lodash

```JavaScript
import { sortBy } from 'lodash';
```

You can define sort functions whereas each function takes a list and returns a list of items sorted by a specific property.  You will need one default sort function

```JavaScript
const SORTS = {
	NONE: list => list,
    TITLE: list => sortBy(list, 'title'),
    AUTHOR: list => sortBy(list, 'author'),
    COMMENTS: list => sortBy(list, 'num_comments').reverse(),
    POINTS: list => sortBy(list, 'points').reverse(), 
};

class App extends Component {
}
```

```JavaScript
this.state = {
	results: null,
    searchKey: '',
    searchTerm: DEFAULT_QUERY,
    error: null,
    isLoading: false,
    sortKey: 'NONE',
};

onSort(sortKey) {
	this.setState({ sortKey });
}
```

```JavaScript
class App extends Component {
	 render() {
     	const {
        	searchTerm,
            results,
            searchKey,
            error,
            isLoading,
            sortKey
		} = this.state;
        
         return (
          	<div className="page">
            	<Table
                	list={list}
                    sortKey={sortKey}
                    onSort={this.onSort}
                    onDismiss={this.onDismiss}
				/>
			 </div>
		);
	}
}
```

```JavaScript
const Table = ({
	list,
    sortKey,
    onSort,
    onDismiss }) =>
    	<div className="table">
        	{SORTS[sortKey](list).map(item =>
            	<div key={item.objectID} className="table-row">        
                </div>
			)}
		</div>
```

Extend the Table with a row of column headers that use Sort components in columns to sort each column.

```JavaScript
<div className="table">
    <div className="table-header">
        <span style={{ width: '40%' }}>
        	<Sort
            	sortKey={'TITLE'}
            	onSort={onSort}
        	>
        	Title
        </Sort>
        </span>
```

Each Sort component gets a specific sortKey and the general onSort() function.


```JavaScript 
const sortClass = ['button-inline'];

if (sortKey === activeSortKey) {
	sortClass.push('button-active');
}

return (
	<Button
    	onClick={() => onSort(sortKey)}
        className={sortClass.join(' ')}
	>
		{children}
	</Button>
);
```

The way to define the sortClass is a bit clumsy, isn’t it? There is a neat little library to get rid of this. First you have to install it. 

> npm install classnames

Now you can use it to define your component className with conditional classes.

```JavaScript
import classNames from 'classnames';

const sortClass = classNames(
	'button-inline',
    { 'button-active': sortKey === activeSortKey }
);
```

- https://github.com/JedWatson/classnames

# State Management in React and beyond

## Lifting State

The whole sort functionality is only used in the Table component. You could move it into the Table component, because the App component doesn’t need to know about it at all.

The process of refactoring substate from one component to another is known as lifting state.

The process of lifting state can go the other way as well: from child to parent component. It is called as lifting state up.

- https://www.robinwieruch.de/learn-react-before-using-redux/
- https://reactjs.org/docs/lifting-state-up.html

## Revisited: setState()

The method setState() doesn’t take only an object. In its second version, you can pass a function to update the state.
                
```JavaScript
this.setState((prevState, props) => {
});
```

When you update the state depending on the previous state or props.

The React setState() method is asynchronous. React batches setState() calls and executes them eventually.

``` JavaScript
setSearchTopStories(result) {
	const { hits, page } = result;
    
    this.setState(prevState => {
    	const { searchKey, results } = prevState;
        
        const oldHits = results && results[searchKey]
        	? results[searchKey].hits
            : [];
	
		const updatedHits = [
        	...oldHits,
            ...hits
		];
        
        return {
        	results: {
            	...results,
                [searchKey]: { hits: updatedHits, page }
                },
			isLoading: false
		};
	});
}
```

That’s one more advantage to use a function over an object. The function can live outside of the component. But you have to use a higher-order function to pass the result to it. After all, you want to update the state based on the fetched result from the API.

```JavaScript
setSearchTopStories(result) {
	const { hits, page } = result; 
    this.setState(updateSearchTopStoriesState(hits, page));
}
```

The updateSearchTopStoriesState() function has to return a function. It is a higher-order function. You can define this higher-order function outside of your App component. Note how the function signature changes slightly now.                

```JavaScript
const updateSearchTopStoriesState = (hits, page) => (prevState) => {   
	const { searchKey, results } = prevState;
    
    const oldHits = results && results[searchKey]
    	? results[searchKey].hits
        : [];
        
	const updatedHits = [
    	...oldHits,
        ...hits
	];
    
    return {
    	results: {
        	...results,
            [searchKey]: { hits: updatedHits, page }
		},
        isLoading: false
	};
};
```

That’s it. The function over an object approach in setState() fixes potential bugs yet increases readability and maintainability of your code. Furthermore, it becomes testable outside of the App component. You could export it and write a test for it as exercise.

- https://reactjs.org/docs/state-and-lifecycle.html#using-state-correctly

## Taming the State

To address the problem of scaling state management, you might have heard of the libraries Redux or MobX. You can use either of these solutions in a React application. They come with extensions, react-redux and mobx-react, to integrate them into the React view layer.

- https://mobx.js.org/
- https://redux.js.org/introduction
- https://roadtoreact.com/
- https://www.robinwieruch.de/redux-mobx-confusion/
- https://www.robinwieruch.de/redux-mobx-confusion/

# Final Steps to Production

You will use the free hosting service Heroku.

## Eject

The following step and knowledge is not necessary to deploy your application to production.
                
react-app comes with one feature to keep it extendable but also to prevent a vendor lock-in.

In your package.json you will find the scripts to start, test and build your application. The last script is eject

It is a one-way operation. Once you eject, you can’t go back!

If you would run npm run eject, the command would copy all the configuration and dependencies to your package.json and a new config/ folder. You would convert the whole project into a custom setup with tooling that includes Babel and Webpack. After all, you would have full control over all these tools.

The official documentation says that create-react-app is suitable for small to mid size projects. You shouldn’t feel obligated to use the “eject” command.

- https://github.com/facebook/create-react-app#converting-to-a-custom-setup

## Deploy your App

Heroku is a platform as a service where you can host your application.

They offer a seamless integration with React.

Deploy a create-react-app in minutes. It is a zero-configuration deployment which follows the philosophy of create-react-app

You need to fulfill two requirements before you can deploy your application to Heroku: install the Heroku CLI create a free Heroku account

- https://devcenter.heroku.com/articles/heroku-cli
- https://www.heroku.com/

If you have installed Homebrew, you can install the Heroku CLI from command line:

> brew update
> brew install heroku-toolbelt

Now you can use git and Heroku CLI to deploy your application.

> git init
> heroku create -b https://github.com/mars/create-react-app-buildpack.git 
> git add . 
> git commit -m "react-create-app on Heroku" 
> git push heroku master 
> heroku open

- https://github.com/mars/create-react-app-buildpack
- https://blog.heroku.com/deploying-react-with-zero-configuration
- https://www.robinwieruch.de/git-essential-commands