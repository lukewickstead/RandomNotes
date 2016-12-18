#ES2015 JavaScript Modules#

JavaScript now allows modules built into the core language. Currently in 2016 there is still very little support for ES2015.

Transpilers such as Babel and TypeScript can be used to generate browser compliant JavaScript a range of defined versions including targetting defined module version types.

##Module Definition##

- The Import keyword is used to define a dependency on other modules and allows their exposed functionality and state to be used
- Scope is contained to the file as long as the var keyword is used.
- The Export keyword is used to note what entities are exposed and accessible outside of the modules

```JavaScript
// Importing other modules
import fooDoo from as foo './foo.js';
import { one, two, three } from './moo.js';

// private members
var foo = "";

function functionOne() {
	fooDoo.callingAnotherModulwe();
}

function functionTwo() {
}

function functionThree() {
}

export function functionFour() {
}

// export can be agaionst each item to be exported or at the end
export { functionOne, functionTwo, functionThree as funcThree };
```


###Default Exports###

If only have one item to export, we can export via default:

```JavaScript
// foo.js
export default function function  functionOne() {
	// do something
}
```

This can be imported with:

```JavaScript
// Import default export from a module
import foo from './foo.js';

// Import default and other export entities
import foo, {moo, doo as loo} from './foo.js';
```