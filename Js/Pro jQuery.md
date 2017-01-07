#Pro jQuery 2.0 (Expert's Voice in Web Development) by Adam Freeman#


#Backgroun#

www.asp.net/ajaxlibrary/cdn.ashx and about the Google service at http://code.google.com/apis/libraries/devguide.html.

http://en.wikipedia.org/wiki/Conditional_comment

```JavaScript
<!--[if lt IE 9]>
<script src="jquery-1.10.1.js" type="text/javascript"></script>
<![endif]-->
<!--[if gte IE 9]><!-->
<script src="jquery-2.0.2.js" type="text/javascript"></script>
```

You can make jQuery relinquish control of the $ by calling the jQuery.noConflict

```JavaScript
jQuery.noConflict();
jQuery(document).ready(function() {} );
```

```JavaScript
var jq = jQuery.noConflict();
jq(document).ready(function () {
```

```JavaScript
$(document).ready(function () {
  // ... code to execute...
});
```

##Deferring the ready Event##

$.holdReady(true);

```JavaScript
setTimeout(function() {
  console.log("Releasing hold");
  $.holdReady(false);
}, 5000);

> **Tip**  You can call the holdReady method multiple times, but the number of calls to the holdReady method with the true argument must be balanced by the same number of calls with the false argument before the ready event will be triggered.

##Selecting Elements##

```JavaScript
$("img:odd").mouseenter(function(e)
```

Table 5-3. jQuery Extension Selectors

|Selector| Description|
|--|--|
|:animated| Selects all elements that are being animated. |
|:contains(text) | Selects elements that contain the specified text.|
|:eq(n) | Selects the element at the nth index (zero-based). |
|:even | Selects all the event-numbered elements (zero-based). |
|:first| Selects the first matched element. |
|:gt(n) | Selects all of the elements with an index greater than n (zero-based).|
|:has(selector)|  Selects elements that contain at least one element that matches the specified selector. |
|:last | Selects the last matched element. |
|:lt(n) | Selects all of the elements with an index smaller than n (zero-based). | 
|:odd | Selects all the odd-numbered elements (zero-based). |
|:text|  Selects all text elements.|

can be used on their own,

```JavaScript
$(":even")
```

Table 5-4. jQuery Type Extension Selectors

|Selector|  Description |
|--|--|
|:button |Selects all buttons. |
|:checkbox|  Selects all check boxes. |
|:file | Selects all file elements. |
|:header | Selects all header elements (h1, h2, and so on). |
|:hidden | Selects all hidden elements. |
|:image| Selects all image elements.  |
|:input|  Selects all input elements.|
|:last|  Selects the last matched element.|
|:parent| Selects all of the elements that are parents to other elements. |
|:password| Selects all password elements. |
|:radio |Selects all radio elements. |
|:reset| Selects all elements that reset a form.|
|:selected| Selects all elements that are selected. |
|:submit| Selects all form submission elements. |
|:visible| Selects all visible elements.|

##CONSIDERING SELECTOR PERFORMANCE##

My view is simple: it should not matter – and if it does matter, then it is a sign of some other problem.

Instead, reconsider your use of HTML elements: look for ways to minimize the content sent to the browser, take on some of the processing at the server and stop treating web applications as though they were desktop applications.

scope of a selection by providing an additional argument to the $ function. This gives the search a context,

```JavaScript
$("img:odd",$(".drow")).mouseenter(function(e)
```

When you supply a context that contains multiple elements, then each element is used as a starting point in the

If you just want to match elements starting at a given point in the document, then you can use an HTMLElement object as the context.

```JavaScript
var elem = document.getElementById("oblock");
$("img:odd",elem).mouseenter(function(e)
```

##Understanding the Selection Result##

Table 5-5. Basic jQuery Object Members

|Selector| Description| Returns
|--|--|-- |
| context| Returns the set of elements used as the search context.| HTMLElement|
|each(function)| Performs the function on each of the selected elements.| jQuery|
|get(index)| Gets the HTMLElement object at the specified index.| HTMLElement|
|index(HTMLElement) | Returns the index of the specifiedHTMLElement. | number |
|index(jQuery) |Returns the index of the first element in the jQuery object.| number |
|index(selector) | Returns the index of the first element in the jQuery object in the set of elements matched by the selector |number|
|length| Returns the number of elements contained by the jQuery object. |number|
|size() |Returns the number of elements in the jQuery object.| number|
|toArray() |Returns the HTMLElement objects contained by the jQuery object as an array.| HTMLElement[]|

##Determining the Context##

If a single HTMLElement object was used as the context, then the context property will return that HTMLElement.

no context was used or if multiple elements were used (as in the example I used

```JavaScript
var jq3 = $("img:odd", document.getElementById("oblock"));
console.log("Single context element: " +jq3.context.tagName);
```

##Dealing with DOM Objects##

Creating jQuery Objects from DOM Objects

You can create jQuery objects by passing an HTMLElement object or an array of HTMLElement objects as the argument to the $ function.

```JavaScript

var elems = document.getElementsByTagName("img");
$(elems).mouseenter(function(e) {
```

```JavaScript
$(this).css("opacity", 1.0);
```

Treating a jQuery Object as an Array

```JavaScript
var elems = $("img:odd");
for (var i = 0; i < elems.length; i++) {
   console.log("Element: " + elems[i].tagName + " " + elems[i].src);
}
```

Iterate a Function over DOM Objects

```JavaScript
$("img:odd").each(function(index, elem) {
  console.log("Element: " + elem.tagName + " " + elem.src);
```

Finding Indices and Specific Elements

```JavaScript
var elems = $("body *");

// find an index using the basic DOM API
var index = elems.index(document.getElementById("oblock"));
console.log("Index using DOM element is: " + index);

// find an index using another jQuery object
index = elems.index($("#oblock"));
console.log("Index using jQuery object is: " + index);
```

You can also pass a string to the index method. When you do this, the string is interpreted as a selector.

```JavaScript
index = imgElems.index("body *");
```

> **Tip**  We can use the index method without an argument to get the position of an element relative to its siblings.

```JavaScript
var elem = $("img:odd").get(1);
```

Modifying Multiple Elements and Chaining Method Calls

```JavaScript
$("label").css("color", "blue");
```

Another nice feature of the jQuery object is that it implements a fluent API.

```JavaScript
$("label").css("color", "blue").css("font-size", ".75em");
```

#CHAPTER 6 Managing the Element Selection#

##Expanding the Selection##

The add method allows you to expand the contents of a jQuery object by adding additional elements.

```JavaScript
var labelElems = document.getElementsByTagName("label");
var jq = $("img[src*=daffodil]");
$("img:even").add("img[src*=primula]").add(jq).add(labelElems).css("border", "thick double red");
```

> **Caution**  A common mistake is to assume that the remove method is the counterpart to the add method and will narrow the selection. In fact, the remove method changes the structure of the DOM,

##Narrowing the Selection##

Table 6-3. Methods to Filter Elements 

|Method| Description|
|--|--|
|eq(index)| Removes all of the elements except the one at the specified index. |
|filter(condition)| Removes elements that don’t match the specified condition. See the later discussion for details of the arguments you can use with this method.|
|first() | Removes all of the elements except the first.|
| has(selector), has(jQuery), has(HTMLElement), has(HTMLElement[]) | Removes elements that don’t have a descendant matched by the specified selector or jQuery object or whose descendants don’t include the specified HTMLElement objects.|
|last() | Removes all but the last element.|
|not(condition) |  Removes all elements that match the condition. See the later discussion for details of how the condition can be specified. |
|slice(start, end) | Removes all elements outside the specified range of index values.|

Reducing the Selection to a Specific Element

```JavaScript
var jq = $("label");
jq.first().css("border", "thick double red");
jq.last().css("border", "thick double green");
jq.eq(2).css("border", "thick double black");
jq.eq(-2).css("border", "thick double black");
```

> **Notice** that I call the eq method twice. When the argument to this method is positive, the index is counted from the first element in the jQuery object. When the argument is negative, the counting is done backward, starting from the last element.

Reducing the Selection by Range

```JavaScript
var jq = $("label");
jq.slice(0, 2).css("border", "thick double black");
jq.slice(4).css("border", "thick solid red");
```

The arguments to the slice method are the index to begin selection and the index to end selection. Indexes are zero-based,

If the second argument is omitted, then the selection continues to the end of the set of elements.

##Filtering Elements##

The filter method removes elements from the selection that don't meet a specified condition.

```JavaScript
$("img").filter("[src*=s]").css("border", "thick double red");
var jq = $("[for*=p]" );
$("label").filter(jq).css("color", "blue");
var elem = document.getElementsByTagName("label")[1];
$("label").filter(elem).css("font-size", "1.5em");
$("img").filter(function(index) {
  return this.getAttribute("src") == "peony.png" || index == 4;
}).css("border", "thick solid red")
```

object. If the function returns true then the element is retained, and it is removed if the function returns false.

The complement to the filter method is not, which works in much the same way but inverts the filtering process.

```JavaScript
$("img").not("[src*=s]").css("border", "thick double red");
var jq = $("[for*=p]");

$("label").not(jq).css("color", "blue");
var elem = document.getElementsByTagName("label")[1];

$("label").not(elem).css("font-size", "1.5em");

$("img").not(function(index) {
  return this.getAttribute("src") == "peony.png" || index == 4;
}).css("border", "thick solid red")
```

Reducing the Selection Based on Descendants

The has method reduces the selection to elements that have particular descendants,

```JavaScript
$("div.dcell").has("img[src*=aster]").css("border", "thick solid red");
var jq = $("[for*=p]");
$("div.dcell").has(jq).css("border", "thick solid blue");
```

##Mapping the Selection##

The function is called for every element in the source jQuery object, and the HTMLElement objects that the function returns are included in the result jQuery object,

```JavaScript
$("div.dcell").map(function(index, elem) {
  return $(elem).children()[1];
}).css("border", "thick solid blue");
```

> **Tip**  You can return only one element each time the function is called. If you want to project multiple result elements for each source element, you can combine the each and add methods,

Testing the Selection

The is method determines whether one of more elements in a jQuery object meets a specific condition.

Table 6-6. is Method Argument Types

|Arguments | Description|
|--|--|
| is(selector)|  Returns true if the jQuery object contains at least one of the elements matched by the selector.|
|is(HTMLElement[]), is(HTMLElement)|  Returns true if the jQuery object contains the specified element, or at least one of the elements in the specified array. |
|is(jQuery)|  Returns true if the jQuery object contains at least one of the elements in the argument object.|
|is(function(index)) |Returns true if the function returns true at least once.|


```JavaScript
var isResult = $("img").is(function(index){
  return this.getAttribute("src") == "rose.png";
});
```

Changing and Then Unwinding the Selection

jQuery preserves a history stack when you modify the selection by chaining methods together, and you can use a couple of methods to take advantage of this,

Table 6-7. Methods to Unwind the Selection Stack 

|Method| Description |
|--|--|
|end() | Pops the current selection off the stack and returns to the previous selection. |
|addBack(), addBack(selector) | Adds the previous selection to the current selection, with an optional selector that filters the previous selection.|

```JavaScript
$("label").first().css("border", "thick solid blue")
  .end().css("font-size", "1.5em");
```

I then call the end method to return to the previous selection (which moves the selection the first label element back to all of the label elements).

```JavaScript
$("div.dcell").children("img").addBack().css("border", "thick solid blue");
```

addBack method, which combines the previous selection (the div element) with the current selection (the img elements) in a single jQuery object.

##Navigating the DOM##

Navigating Down the Hierarchy

Table 6-8. Methods to Navigate Down the DOM Hierarchy

| Method|  Description|
|--|--|
|children() |Selects the children of all of the elements in the jQuery object. |
|children(selector) | Selects all of the elements that match the selector and that are children of the elements in the jQuery object. |
|contents() | Returns the children and text content of all the elements in the jQuery object.|
|find() | Selects the descendants of the elements in the jQuery object. | 
|find(selector) | Selects the elements that match the selector and that are descendants of the elements in the jQuery object. |
|find(jQuery), find(HTMLElement), find(HTMLElement[]) | Selects the intersection between the children of the elements in the jQuery object and the argument object.|


```JavaScript
var childCount = $("div.drow").children().each(function(index, elem) {
  console.log("Child: " + elem.tagName + " " + elem.className);
}).length;
```

```JavaScript
$("div.drow").find("img").each(function(index, elem) {
  console.log("Descendant: " + elem.tagName + " " + elem.src);
}).length;

console.log("There are " + descCount + " img descendants");
```

One of the nice features of the children and find methods is that you don’t receive duplicate elements in the selection.

Using the find Method to Create an Intersection

```JavaScript
var jq = $("label").filter("[for*=p]").not("[for=peony]");
$("div.drow").find(jq).css("border", "thick solid blue");
```

The final selection is the intersection between the descendants of the div.drow elements and my reduced set of label elements.

##Navigating Up the Hierarchy##

Table 6-9. Methods to Navigate Up the DOM Hierarchy

| Method|  Description |
|--|--|
|closest(selector), closest(selector, context)|  Selects the nearest ancestor for each element in the jQuery object that intersects with the specified selector. |
|closest(jQuery), closest(HTMLElement) | Selects the nearest ancestor for each element in the jQuery object that intersects with the elements contained in the argument object. | 
|offsetParent() | Finds the nearest ancestor that has a value for the CSS position property of fixed, absolute, or relative. |
|parent(), parent(selector) | Selects the parent for each element in the jQuery object, optionally filtered by a selector. |
|parents(), parents(selector) | Selects the ancestors for each element in the jQuery object, optionally filtered by a selector. | 
|parentsUntil(selector), parentsUntil(selector, selector)|  Selects the ancestors for each element in the jQuery object until a match for the selector is encountered. The results can be filtered using a second selector. |
|parentsUntil(HTMLElement), parentsUntil(HTMLElement, selector), parentsUntil(HTMLElement[]), parentsUntil(HTMLElement[], selector) |Selects the ancestors for each element in the jQuery object until one of the specified elements is encountered. The results can be filtered using a selector.|


Selecting Parent Elements

The parent method selects the parent element for each of the elements in a jQuery object.

```JavaScript
$("div.dcell").parent().each(function(index, elem) {
  console.log("Element: " + elem.tagName + " " + elem.id);
});

$("div.dcell").parent("#row1").each(function(index, elem) {
  console.log("Filtered Element: " + elem.tagName + " " + elem.id);
});
```

Selecting Ancestors

The parents method (note the final letter s) selects all of the ancestors of elements in a jQuery object, not just the immediate parents.

```JavaScript
$("img[src*=peony], img[src*=rose]").parents().each(function(index, elem) {
  console.log("Element: " + elem.tagName + " " + elem.className + " " + elem.id);
```

A variation on selecting ancestors is presented by the parentsUntil method. For each element in the jQuery object, the parentsUntil method works its way up the DOM hierarchy, selecting ancestor elements until an element that matches the selector is encountered.

```JavaScript
$("img[src*=peony], img[src*=rose]").parentsUntil("form").each(function(index, elem) {
  console.log("Element: " + elem.tagName + " " + elem.className + " " + elem.id);
```

Notice that elements that match the selector are excluded from the selected ancestors.

```JavaScript
$("img[src*=peony], img[src*=rose]").parentsUntil("form", ":not(.dcell)").each(function(index, elem) {
console.log("Element: " + elem.tagName + " " + elem.className + " " + elem.id);
```

Selecting the First Matching Ancestor

The closest method selects the first ancestor that is matched by a selector for each element in a jQuery object.

```JavaScript
$("img").closest(".drow").each(function(index, elem) {
  console.log("Element: " + elem.tagName + " " + elem.className + " " + elem.id);
```

```JavaScript
var contextElem = document.getElementById("row1");
$("img").closest(".drow", contextElem).each(function(index, elem) {
  console.log("Context Element: " + elem.tagName + " " + elem.className + " " + elem.id);
```

You can narrow the scope for selecting ancestors by specifying an HTMLElement object as the second argument to the method. Ancestors that are not the context object or are not descendants of the context object are excluded from the selection.

```JavaScript
var jq = $("#row1, #row2, form");

$("img[src*=rose]").closest(jq).each(function(index, elem) {
  console.log("Context Element: " + elem.tagName + " " + elem.className + " " + elem.id);
});
```

jQuery will select whichever of the elements is the nearest ancestor to the img element.

The offsetParent is a variation on the closest theme and funds the first ancestor that has a value for the position CSS property of relative, absolute, or fixed.

Such an element is known as a positioned ancestor, and finding one can be useful when working with animation

```JavaScript
$(document).ready(function() {
  $("img[src*=aster]").offsetParent().css("background-color", "lightgrey");
```

##Navigating Across the Hierarchy##

Table 6-10. Methods to Navigate Across the DOM Hierarchy 

|Method|  Description |
|--|--|
|next(), next(selector)|  Selects the immediate next sibling for each element in the jQuery object, optionally filtered by a selector. |
|nextAll(), nextAll(selector) |Selects all of the next siblings for each element in the jQuery object, optionally filtered by a selector.|
|nextUntil((selector), nextUntil(selector, selector), nextUntil(jQuery), nextUntil(jQuery, selector), nextUntil(HTMLElement[]), nextUntil(HTMLElement[], selector) | Selects the next siblings for each element up to (and excluding) an element that matches the selector or an element in the jQuery object or the HTMLElement array. The results can optionally be filtered by a selector as the second argument to the method. |
|prev(), prev(selector)| Selects the immediate previous sibling for each element in the jQuery object, optionally filtered by a selector.|
|prevAll(), prevAll(selector) |Selects all of the previous siblings for each element in the jQuery object, optionally filtered by a selector. |
|prevUntil(selector), prevUntil(selector, selector), prevUntil(jQuery)prevUntil(jQuery, selector), prevUntil(HTMLElement[]), prevUntil(HTMLElement[], selector)| Selects the previous siblings for each element up to (and excluding) an element that matches the selector or an element in the jQuery object or the HTMLElement array. The results can optionally be filtered by a selector as the second argument to the method. |
|siblings(), siblings(selector)| Selects all of the siblings for each of the elements in the jQuery object, optionally filtered by a selector.|

Selecting All Siblings

The siblings method selects all of the siblings for all of the elements in a jQuery object.

```JavaScript
$("img[src*=aster], img[src*=primula]").parent().siblings().css("border", "thick solid blue");
```

> **Notice** that only the siblings are selected, not the elements themselves. Of course, this changes if one element in the jQuery object is a sibling of another,

```JavaScript
$("#row1 div.dcell").siblings().css("border", "thick solid blue");
```

In this script, I start by selecting all of the div elements that are children of the row1 element and then call the siblings method. Each of the elements in the selection is the sibling to at least one of the other elements,

Selecting Next and Previous Siblings

```JavaScript
$("img[src*=aster]").parent().nextAll().css("border", "thick solid blue");         $("img[src*=primula]").parent().prevAll().css("border", "thick double red");
```

#CHAPTER 7 Manipulating the DOM#

##Creating New Elements##

Creating Elements Using the $ Function

```JavaScript
var newElems = $("<div class='dcell'><img src='lily.png'/></div>");
```

##CHANGES TO HTML PARSING##

If you are working with strings that might be ambiguous, you can use the parseHTML method,

The jQuery object that is returned by the $ function contains only the top-level elements from the HTML fragment.

> **Tip**  You can also provide a map object that specifies attributes that should be applied to the HTML element.

##Creating New Elements by Cloning Existing Elements##

This duplicates all of the elements in a jQuery object, along with all of their descendants.

```JavaScript
var newElems = $("div.dcell").clone();
```

> **Tip**  You can pass the value true as an argument to the clone method to include the event handlers and data associated with the elements in the copying process.


##Creating Elements Using the DOM API##

```JavaScript
var divElem = document.createElement("div");
divElem.classList.add("dcell");
var imgElem = document.createElement("img");
imgElem.src = "lily.png";
divElem.appendChild(imgElem);
```

##Inserting Child and Descendant Elements##

Once I have created elements, I can start to insert them into the document.


Table 7-2. Methods for Inserting Child and Descendant Elements

|Method| Description|
|--|--|
|append(HTML), append(jQuery), append(HTMLElement[]) | Inserts the specified elements as the last children of all of the elements in the DOM. |
|prepend(HTML), prepend(jQuery), prepend(HTMLElement[]) | Inserts the specified elements as the first children of all of the elements in the DOM. |
|appendTo(jQuery), appendTo(HTMLElement[]) | Inserts the elements in the jQuery object as the last children of the elements specified by the argument.|
|prependTo(HTML), prependTo(jQuery), prependTo(HTMLElement[]) | Inserts the elements in the jQuery object as the first children of the elements specified by the argument. |
|append(function), prepend(function) | Appends or prepends the result of a function to the elements in the jQuery object.|

> **Tip**  You can also insert child elements using the wrapInner method, which I describe in the “Wrapping the Contents of Elements” section. This method inserts a new child between an element and its existing children. Another technique is to use the html method, which I describe in Chapter 8

The elements passed as arguments to these methods are inserted as children to every element in the jQuery object, which makes it especially important to use the techniques I showed you in Chapter 6 to manage the selection so that it contains only the elements you want to work with.

```JavaScript
var newElems = $("<div class='dcell'></div>")
  .append("<img src='lily.png'/>")
  .append("<label for='lily'>Lily:</label>")
  .append("<input name='lily' value='0' required />");

newElems.css("border", "thick solid red");
$("#row1").append(newElems);
```

jQuery objects returned by these methods contain the same elements as the object on which the methods were called.

This means that chaining append calls together creates multiple new child elements for the originally selected elements.

The next behavior to point out was that newly created elements may not be attached to the document, but you can still use jQuery to navigate and modify them.

##Prepending Elements##

The complement to the append method is prepend, which inserts the new elements as the first children of the elements in the jQuery object.

```JavaScript
var orchidElems = $("<div class='dcell'/>")
  .append("<img src='orchid.png'/>")
  .append("<label for='orchid'>Orchid:</label>")
  .append("<input name='orchid' value='0' required />");

var newElems = $("<div class='dcell'/>")
  .append("<img src='lily.png'/>")
  .append("<label for='lily'>Lily:</label>")
  .append("<input name='lily' value='0' required />").add(orchidElems);

newElems.css("border", "thick solid red");
$("#row1, #row2").prepend(newElems);
```

all of the elements passed as an

I use the add method to bring both sets of elements together in a single jQuery object.

> **Tip**  The add method will also accept a string containing an HTML fragment. You can use this feature as an alternative to building up new elements using jQuery objects.

As an alternative to using the add method, you can pass multiple elements to the DOM modification methods,

```JavaScript
$("#row1, #row2").prepend(lilyElems, orchidElems);
```

Inserting the Same Elements in Different Positions

You can add new elements to the document only once.

At this point, using them as arguments to a DOM insertion method moves the elements, rather than duplicates them.


```JavaScript
$("#row1").append(newElems);         $("#row2").prepend(newElems);
```

To address this issue, you need to create copies of the elements you want to insert by using the clone method.

```JavaScript
$("#row1").append(newElems);
$("#row2").prepend(newElems.clone());
```


Inserting from a jQuery Object

You can use the appendTo and prependTo methods to change the relationship between elements,

```JavaScript
var newElems = $("<div class='dcell'/>");
$("img").appendTo(newElems);
$("#row1").append(newElems);
```

I create jQuery objects to contain a new div element and the img elements in the document. I then use the appendTo method to append the img elements as the children of the div element.

Inserting Elements Using a Function

You can pass a function to the append and prepend methods. This allows you to dynamically insert children for the elements selected by the jQuery object,

```JavaScript
$("div.drow").append(function(index, html) {
  if (this.id == "row1") {
    return orchidElems;
  } else {
    return lilyElems;
  }
```

##Inserting Parent and Ancestor Elements##

jQuery provides you with a set of methods for inserting elements as parents or ancestors of other elements. This is known as wrapping

Table 7-3. Methods for Wrapping Elements

| Method|  Description|
|wrap(HTML), wrap(jQuery), wrap(HTMLElement[]) |  Wraps the specified elements around each of the elements in the jQuery object. |
|wrapAll(HTML), wrapAll(jQuery), wrapAll(HTMLElement[]) | Wraps the specified elements around the set of elements in the jQuery object (as a single group).|
|wrapInner(HTML), wrapInner(jQuery), wrapInner(HTMLElement[]) | Wraps the specified elements around the content of the elements in the jQuery object. | 
|wrap(function), wrapInner(function)| Wraps elements dynamically using a function.|

> **Tip**  The complement to the wrapping methods is unwrap, which I describe in the “Removing Elements” section later in this chapter.

When you perform wrapping, you can pass multiple elements as the argument, but you must make sure that there is only one inner element. Otherwise, jQuery can’t figure out what to do. This means that each element in the argument must have at most one parent and at most one child.

```JavaScript
var newElem = $("<div/>").css("border", "thick solid red");
$("div.drow").wrap(newElem);
```
the wrap method to insert the div element as the parent to all of the label elements in the document.

The elements passed as arguments to the wrap method are inserted between each element in the jQuery object and their current parents.

```xml

<div class="dtable">
  <div id="row1" class="drow">
  </div>
  <div id="row2" class="drow">
  </div>
</div>
```

```xml
<div class="dtable">
  <div style="...style properties...">
    <div id="row1" class="drow">
    </div>
  </div>
  <div style="...style properties...">
    <div id="row2" class="drow">
    </div>
  </div>
</div>
```

Wrapping Elements Together in a Single Parent

When you use the wrap method, the new elements are cloned, and each element in the jQuery object gets its own new parent element.

You can insert a single parent for several elements by using the wrapAll

```JavaScript
var newElem = $("<div/>").css("border", "thick solid red");
$("div.drow").wrapAll(newElem);
```

If the selected elements don’t already share a common parent, then the new element is inserted as the parent to the first selected element.

Then jQuery moves all of the other selected elements to be siblings of the first one.

Wrapping the Content of Elements

The wrapInner method wraps elements around the contents of the elements in a jQuery object,

```JavaScript
var newElem = $("<div/>").css("border", "thick solid red");
$(".dcell").wrapInner(newElem);
```

The wrapInner method inserts new elements between the elements in the jQuery object and their immediate children.

You can also achieve the effect of the wrapInner method by using the append method.

```JavaScript
var newElem = $("<div/>").css("border", "thick solid red");
$(".dcell").each(function(index, elem) {
  $(elem).append(newElem.clone().append($(elem).children()));
});
```

Wrapping Elements Using a Function

```JavaScript
$(".drow").wrap(function(index) {
  if ($(this).has("img[src*=rose]").length > 0) {
    return $("<div/>").css("border", "thick solid blue");
  } else {
    return $("<div/>").css("border", "thick solid red");
  }
```

##Inserting Sibling Elements##

Table 7-4. Methods for Inserting Sibling  Elements |

|Method| Description|
|--|--|
|after(HTML), after(jQuery), after(HTMLElement[]) |Inserts the specified elements as next siblings to each element in the jQuery object. |
|before(HTML), before(jQuery), before(HTMLElement[]) | Inserts the specified elements as previous siblings to each element in the jQuery object. |
|insertAfter(HTML), insertAfter(jQuery), insertAfter(HTMLElement[]) | Inserts the elements in the jQuery object as the next siblings for each element specified in the argument.|
|insertBefore(HTML), insertBefore(jQuery), insertBefore(HTMLElement[]) | Inserts the elements in the jQuery object as the previous siblings for each element specified in the argument.|
|after(function), before(function)| Inserts siblings dynamically using a function.|

The before and after methods follow the same pattern you saw when inserting other kinds of element in the document.

```JavaScript
var orchidElems = $("<div class='dcell'/>")
    .append("<img src='orchid.png'/>")
    .append("<label for='orchid'>Orchid:</label>")
    .append("<input name='orchid' value='0' required />"); 

var lilyElems = $("<div class='dcell'/>")
    .append("<img src='lily.png'/>")
    .append("<label for='lily'>Lily:</label>")
    .append("<input name='lily' value='0' required />"); 
$(orchidElems).add(lilyElems).css("border", "thick solid red"); 

$("#row1 div.dcell").after(orchidElems);
$("#row2 div.dcell").before(lilyElems);
```

##Inserting Siblings from a jQuery Object##

The insertAfter and insertBefore methods insert the elements in the jQuery object as the next or previous siblings to the elements in the method argument. This is the same functionality as in the after and before methods, but the relationship between the jQuery object and the argument is reversed.

```JavaScript
var orchidElems = $("<div class='dcell'/>")
    .append("<img src='orchid.png'/>").append("<label for='orchid'>Orchid:</label>")
    .append("<input name='orchid' value='0' required />"); 

var lilyElems = $("<div class='dcell'/>")
    .append("<img src='lily.png'/>")
    .append("<label for='lily'>Lily:</label>")
    .append("<input name='lily' value='0' required />"); 

$(orchidElems).add(lilyElems).css("border", "thick solid red"); 

orchidElems.insertAfter("#row1 div.dcell");
lilyElems.insertBefore("#row2 div.dcell");
```

##Inserting Siblings Using a Function##

```JavaScript
$("#row1 div.dcell").after(function(index, html) {
            if (index == 0) {
                return $("<div class='dcell'/>").append("<img src='orchid.png'/>").append("<label for='orchid'>Orchid:</label>").append("<input name='orchid' value='0' required />").css("border", "thick solid red");
            } else if (index == 1) {
                return $("<div class='dcell'/>").append("<img src='lily.png'/>").append("<label for='lily'>Lily:</label>").append("<input name='lily' value='0' required />").css("border", "thick solid red");
            }
```


##Replacing Elements##

Table 7-5. Methods for Wrapping Elements 

|Method| Description |
|--|--|
|replaceWith(HTML), replaceWith(jQuery), replaceWith(HTMLElement[]) | Replace the elements in the jQuery object with the specified content.| 
|replaceAll(jQuery), replaceAll(HTMLElement[]) | Replace the elements specified by the argument with the elements in the jQuery object.|
|replaceWith(function) |Replaces the elements in the jQuery object dynamically using a function.|

The replaceWith and the replaceAll methods work in the same way, with the exception that the role of the jQuery object and the argument are reversed.

```JavaScript
var newElems = $("<div class='dcell'/>")
    .append("<img src='orchid.png'/>")
    .append("<label for='orchid'>Orchid:</label>")
    .append("<input name='orchid' value='0' required />").css("border", "thick solid red");

$("#row1").children().first().replaceWith(newElems); 
$("<img src='carnation.png'/>").replaceAll("#row2 img").css("border", "thick solid red");
```

In this script, I use the replaceWith method to replace the first child of the row1 div element with new content (this has the effect of replacing the aster with the orchid). I also use the replaceAll method to replace all of the img elements that are descendants of row2 with the image of a carnation.

##Replacing Elements Using a Function##

```JavaScript
$("div.drow img").replaceWith(function() {
    if (this.src.indexOf("rose") > -1) {
        return $("<img src='carnation.png'/>").css("border", "thick solid red");
    } else if (this.src.indexOf("peony") > -1) {
        return $("<img src='lily.png'/>").css("border", "thick solid red");
    } else {
        return $(this).clone();
    }
});
```

> **Tip**  If you don’t want to replace an element, then you can simply return a clone. If you don’t clone the element, then jQuery ends up removing the element entirely. Of course, you could avoid this issue by narrowing your selection, but that isn’t always an option.

##Removing Elements##

Table 7-6. Methods for Removing Elements

|Method|  Description |
|--|--|
|detach(), detach(selector)|  Removes elements from the DOM. The data associated with the elements is preserved.|
|empty() | Removes all of the child nodes from each element in the jQuery object. | 
|remove(), remove(selector) | Removes elements from the DOM. As the elements are removed, the data associated with the elements is destroyed. |
|unwrap() |Removes the parent of each of the elements in the jQuery object.|

```JavaScript
$("img[src*=daffodil], img[src*=snow]").parent().remove();
```

You can filter the elements that you remove if you pass a selector to the remove method,

```JavaScript
$("div.dcell").remove(":has(img[src*=snow], img[src*=daffodil])");
```

> **Tip**  The jQuery object returned from the remove method contains the original set of selected elements. In other words, the removal of elements is not reflected in the method result.

##Detaching Elements##

The detach method works in the same as the remove method, with the exception that data associated with the elements is preserved.

```JavaScript
$("#row2").append($("img[src*=aster]").parent().detach());
```

chapter. I tend not to use this method, because using append without detach has the same effect.

```JavaScript
$("#row2").append($("img[src*=aster]").parent());
```

##Empting Elements##

The empty method removes any descendants and text from the elements in a jQuery object.

```JavaScript
$("#row1").children().eq(1).empty().css("border", "thick solid red");
```


##Unwrapping Elements##

The unwrap method removes the parents of the elements in the jQuery object.

The selected elements become children of their grandparent elements.

```JavaScript
$("div.dcell").unwrap();
```

#CHAPTER 8 Manipulating Elements#


Working with Attributes and Properties

Table 8-2. Methods for Working with Attributes 

|Method| Description |
|--|--|
|attr(name) | Gets the value of the attribute with the specified name for the first element in the jQuery object|
|attr(name, value)| Sets the value of the attribute with the specified name to the specified value for all of the elements in the jQuery object |
|attr(map) |Sets the attributes specified in the map object for all of the elements in the jQuery object |
|attr(name, function) |Sets the specified attribute for all of the elements in the jQuery object using a function|
|removeAttr(name), removeAttr(name[]) | Remove the attribute from all of the elements in the jQuery object |
|prop(name) | Returns the value of the specified property for the first element in the jQuery object |
|prop(name, value), prop(map) | Sets the value for one or more properties for all of the elements in the jQuery object|
|prop(name, function) | Sets the value of the specified property for all of the elements in the jQuery object using a function | 
|removeProp(name) | Removes the specified property from all of the elements in the jQuery object|

When the attr method is called with a single argument, jQuery returns the value of the specified attribute from the first element in the selection.

```JavaScript
var srcValue = $("img").attr("src");
console.log("Attribute value: " + srcValue);

```
The each method can be combined with attr to read the value of an attribute for all of the elements in a jQuery object.

```JavaScript
$("img").each(function(index, elem) {
  var srcValue = $(elem).attr("src");
    console.log("Attribute value: " + srcValue);
  });

##Setting an Attribute Value##

When the attr method is used to set an attribute value, the change is applied to all of the elements in the jQuery object.

```JavaScript
$("img").attr("src", "lily.png");
```

##Setting Multiple Attributes##


You can set multiple attributes in a single method call by passing an object to the attr method. The properties of this object are interpreted as the attribute names, and the property values will be used as the attribute values.

```JavaScript
var attrValues = {
  src: "lily.png",
  style: "border: thick solid red"
};

$("img").attr(attrValues);
```

##Setting Attribute Values Dynamically##

```JavaScript
$("img").attr("src", function(index, oldVal) {
  if (oldVal.indexOf("rose") > -1) {
    return "lily.png";
  } else if ($(this).closest("#row2").length > 0) {
    return "carnation.png";
  }
});
```

##Removing an Attribute##

You can remove (unset) attributes by using the removeAttr method,

```JavaScript
$("img").attr("style", "border: thick solid red");
$("img:odd").removeAttr("style");
```

##Working with Properties##

For each form of the attr method, there is a corresponding prop method.

The difference is that the prop methods deal with properties defined by the HTMLElement object, rather than attribute values.

Often, the attributes and properties are the same, but this isn’t always the case.

A simple example is the class attribute, which is represented in the HTMLElement object using the className property.

```JavaScript
$("*[class]").each(function(index, elem) {
  console.log("Element:" + elem.tagName + " " + $(elem).prop("className"));
 
});
```

Table 8-3. Methods for Working with Classes 

|Method | Description |
|--|--|
|addClass(name name) |Adds all of the elements in a jQuery object to the specified class |
|addClass(function) | Assigns the elements in a jQuery object to classes dynamically |
|hasClass(name) |Returns true if at least one of the elements in the jQuery object is a member of the specified class|
|removeClass(name name) | Removes the elements in the jQuery object from the specified class | 
|removeClass(function) | Removes the elements in a jQuery object from classes dynamically | 
|toggleClass() | Toggles all of the classes that the elements in the jQuery object belong to |
|toggleClass(boolean) | Toggles all of the classes that the elements in the jQuery object belong to in one direction|
|toggleClass(name), toggleClass(name name) | Toggles one or more named classes for all of the elements in the jQuery object |
|toggleClass(name, boolean) | Toggles a named class for all of the elements in the jQuery object in one direction|
|toggleClass(function, boolean)| Toggles classes dynamically for all of the elements in a jQuery object|

Elements can be assigned to classes with the addClass method , removed from classes using the removeClass method, and you determine whether an element belongs to a class using the hasClass method.

```JavaScript
$("img").addClass("redBorder");
$("img:even").removeClass("redBorder").addClass("blueBorder");
console.log("All elements: " + $("img").hasClass("redBorder"));
```

Adding and Removing Classes Using a Function

```JavaScript
$("img").addClass(function(index, currentClasses) {
  if (index % 2 == 0) {
    return "blueBorder";
  } else {
    return "redBorder";
  }
});
```

The arguments to the function are the index of the element and the current set of classes for which the element is a member.

```JavaScript
$("img").removeClass(function(index, currentClasses) {
  if ($(this).closest("#row2").length > 0 & ¤tClasses.indexOf("redBorder") > -1) {
    return "redBorder";
  } else {
    return "";
  }
});
```

##Toggling Classes##

```JavaScript
function doToggle(e) {
  $("img").toggleClass("redBorder");
  e.preventDefault();
};
```

##Toggling Multiple Classes##

```JavaScript
function doToggle(e) {
  $("img").toggleClass("redBorder blueBorder");
  e.preventDefault();
};
```

##Toggling All Classes##

You can toggle all of the classes that a set of elements belong to by calling the toggleClass method with no arguments. This is a clever technique because jQuery stores the classes that have been toggled so they are applied and removed correctly.

```JavaScript
function doToggle(e) {
  $("img, label").toggleClass();
  e.preventDefault();
};
```

##Toggling Classes in One Direction##

If you pass false, the classes will only be removed, and if you pass true, the classes will only be added.

```JavaScript
function doToggleOff(e) {
  $("img, label").toggleClass("redBorder", false);
  e.preventDefault();
};

function doToggleOn(e) {
  $("img, label").toggleClass("redBorder", true);
  e.preventDefault();
};
```

##Toggling Classes Dynamically##

You can decide which classes should be toggled for elements dynamically by passing a function to the toggleClass method.

```JavaScript
function doToggle(e) {
  $("img").toggleClass(function(index, currentClasses) {
    if (index % 2 == 0) {
      return "redBorder";
    } else {
      return "";
    }
  });

  e.preventDefault();
};
```

The result from the function is the name of the classes that should be toggled. If you don’t want to toggle any classes for the elements, then you return the empty string (not returning a result for an element toggles all of its classes).

##Working with CSS##

Table 8-4. The css Method 

|Method| Description |
|--|--|
|css(name) | Gets the value of the specified property from the first element in the jQuery object |
|css(names) | Gets the value of multiple CSS properties, expressed as an array |
|css(name, value) | Sets the value of the specific property for all elements in the jQuery object | 
|css(map) | Sets multiple properties for all of the elements in a jQuery object using a map object | 
|css(name, function) | Sets values for the specified property for all of the elements in a jQuery object using a function|


Getting and Setting a Single CSS Value

```JavaScript
var sizeVal = $("label").css("font-size");
console.log("Size: " + sizeVal);
$("label").css("font-size", "1.5em");
```

> **Tip**  Although I used the actual property name (font-size) and not the camel-case property name defined by the HTMLElement object (fontSize), jQuery happily supports both.

> **Tip**  Setting a property to the empty string ("") has the effect of removing the property from the element’s style attribute.

##Getting Multiple CSS Properties##

```JavaScript
var propertyNames = ["font-size", "color", "border"];
var cssValues = $("label").css(propertyNames);
for (var i = 0; i < propertyNames.length; i++) {
 console.log("Property: " + propertyNames[i] + " Value: " + cssValues[propertyNames[i]]);
}
```

##Setting Multiple CSS Properties##

```JavaScript
$("label").css("font-size", "1.5em").css("color", "blue");
```

```JavaScript
var cssVals = {
  "font-size": "1.5em",
  "color": "blue"
};

$("label").css(cssVals);
```

##Setting Relative Values##

The css method can accept relative values, which are numeric values that are preceded by += or -= and that are added to or subtracted from the current value. This technique can be used only with CSS properties that are expressed in numeric units.

```JavaScript
$("label:odd").css("font-size", "+=5")         $("label:even").css("font-size", "-=5")
```

##Setting Properties Using a Function##

```JavaScript
$("label").css("border", function(index, currentValue) {
  if ($(this).closest("#row1").length > 0) {
    return "thick solid red";
  } else if (index % 2 == 1) {
    return "thick double blue";
  }
});
```

##Using the Property-Specific CSS Convenience Methods##

In addition to the css method, jQuery defines a number of methods that can be used to get or set commonly used CSS properties and information derived from them.

Table 8-5. Methods for Working with Specific CSS Properties


|Method | Description |
|--|--|
|height() | Gets the height in pixels for the first element in the jQuery object |
|height(value) | Sets the height for all of the elements in the jQuery object | 
|innerHeight() | Gets the inner height of the first element in the jQuery object (this is the height including padding but excluding the border and margin) | 
|innerWidth() | Gets the inner width of the first element in the jQuery object (this is the width including padding but excluding the border and margin) |
|offset() | Returns the coordinates of the first element in the jQuery object relative to the document|
|outerHeight(boolean) | Gets the height of the first element in the jQuery object, including padding and border; the argument determines if the margin is included |
|outerWidth(boolean) | Gets the width of the first element in the jQuery object, including padding and border; the argument determines whether the margin is included |
|position() | Returns the coordinates of the first element in the jQuery object relative to the offset|
|scrollLeft(), scrollTop() | Gets the horizontal or vertical position of the first element in the jQuery object| 
|scrollLeft(value), scrollTop(value) | Sets the horizontal or vertical position of all the elements in a jQuery object|
|width() | Gets the width of the first element in a jQuery object | 
|width(value) | Sets the width of all of the elements in a jQuery object |
|height(function), width(function) | Sets the width or height for all of the elements in the jQuery object using a function|


The result from the offset and position methods is an object that has top and left properties, indicating the location of the element.

```JavaScript
var pos = $("img").position();
console.log("Position top: " + pos.top + " left: " + pos.left);
```

##Setting the Width and Height Using a Function##

```JavaScript
$("#row1 img").css("border", "thick solid red")
.height(function(index, currentValue) {
  return (index + 1) * 25;
});
```

##Working with Element Content##

Table 8-6. Methods for Working with Element Content 

|Method| Description|
|--|--|
|text() | Gets the combined text contents of all the element in the jQuery object and their descendants |
|text(value) | Sets the content of each element in the jQuery object |
|html() | Gets the HTML contents of the first element in the jQuery object |
|html(value) | Sets the HTML content of each element in the jQuery object | 
|text(function), html(function) | Sets the text or HTML content using a function|

Unusually for jQuery, when you use the text method without arguments, the result that you receive is generated from all of the selected elements and not just the first one. The html method is more consistent with the rest of jQuery and returns just the content from the first element,

```JavaScript
var html = $("div.dcell").html();
console.log(html);
```
##Setting Element Content##

You can set the content of elements using either the html or text method.

```JavaScript
$("#row2 div.dcell").html($("div.dcell").html());
```

##Setting Element Content Using a Function##

```JavaScript
$("label").css("border", "thick solid red").text(function(index, currentValue) {
  return "Index " + index;
});
```

##Working with Form Elements##


Table 8-7. The val method 

|Method|  Description |
|--|--|
|val() | Returns the value of the first element in the jQuery object |
|val(value) | Sets the value of all of the elements in the jQuery object | 
|val(function) | Sets the values for the elements in the jQuery object using a function|

```JavaScript
$("input").each(function(index, elem) {
  console.log("Name: " + elem.name + " Val: " + $(elem).val());
});
```

```JavaScript
$("input").val(100);
```

```JavaScript
$("input").val(function(index, currentVal) {
  return (index + 1) * 100;
});
```

##Associating Data with Elements##


Table 8-8. Methods for Working with Arbitrary Element Data 

|Method| Description|
|--|--|
|data(key, value), data(map) | Associates one or more key/value pairs with the elements in a jQuery object |
|data(key) | Retrieves the value associated with the specified key from the first element in the jQuery object |
|data()| Retrieves the key/value pairs from the first element in the jQuery object | 
|removeData(key)|  Removes the data associated with the specified key from all of the elements in the jQuery object|
|removeData() |Removes all of the data items from all of the elements in the jQuery object|

```JavaScript
// set the data
$("img").each(function () {
  $(this).data("product", $(this)
    .siblings("input[name]").attr("name"));
  });

// find elements with the data and read the values
$("*").filter(function() {
  return $(this).data("product") != null;
}).each(function() {
  console.log("Elem: " + this.tagName + " " + $(this).data("product"));
});

// remove all data
$("img").removeData();
```
> **Note**  When you use the clone method, the data you have associated with elements are removed from the newly copied elements unless you explicitly tell jQuery that you want to keep it.

There is no dedicated selector or method, so you must make do with the filter method and a function.

#CHAPTER 9 Working with Events#

##Handling Events##

Table 9-2. Methods for Handling Events 

|Method| Description |
|--|--|
|bind(eventType, function), bind(eventType, data, function) | Adds an event handler to the elements in a jQuery object with an optional data item |
|bind(eventType, boolean) | Creates a default handler that always returns false, preventing the default action; the boolean argument controls event bubbling |
|bind(map)| Adds a set of event handlers based on a map object to all elements in the jQuery object |
|one(eventType, function), one(eventType, data, function) | Adds an event handler to each element in a jQuery object with an optional data item; the handler will be unregistered from an element once it has been executed. |
|unbind() | Removes all event handlers on all elements in the jQuery object |
|unbind(eventType) | Removes a previously registered event handler from all elements in the jQuery object| 
|unbind(eventType, boolean) | Removes a previously registered always-false handler from all elements in the jQuery object|
|unbind(Event) |Removes an event handler using an Event object|

```JavaScript
<script type="text/javascript">
  $(document).ready(function() {
      function handleMouseEnter(e) {
          $(this).css({
              "border": "thick solid red",
              "opacity": "0.5"
          });
      };

      function handleMouseOut(e) {
          $(this).css({
              "border": "",
              "opacity": ""
          });
      }
      $("img").bind("mouseenter", handleMouseEnter)
          .bind("mouseout", handleMouseOut);
  });
</script>
```

When jQuery calls the handler function, the this variable is set to the element to which the handler is attached. The object passed to the handler function is jQuery’s own Event object, which is different from the Event object defined by the DOM specification.

Table 9-3. Members of the jQuery Event Object |

|Name| Description| Returns|
|--|--|--|
|currentTarget| Gets the element whose listeners are currently being invoked |HTMLElement|
|Data|  Gets the optional data passed to the bind method when the handler was registered; see the section “Registering a Function to Handle Multiple Event Types” for details |Object| 
|isDefaultPrevented() | Returns true if the preventDefault method has been called | Boolean |
|isImmediatePropagationStopped() | Returns true if the stopImmediatePropagation method has been called | Boolean|
|isPropagationStopped() | Returns true if the stopPropagation method has been called | Boolean |
|originalEvent |Returns the original DOM Event object Event pageXpageY Returns the mouse position relative to the left edge of the document| number |
|preventDefault() | Prevents the default action associated with the event from being performed void relatedTarget For mouse events, returns the related element; this varies depending on which event has been triggered | HTMLElement |
| Result | Returns the result from the last event handler that processed this event | Object |
|stopImmediatePropagation() | Prevents any other event handlers being called for this event | void | 
|stopPropagation() | Prevents the event from bubbling but allows handlers attached to the current target element to receive the event |void| 
|Target |Gets the element that triggered the event HTMLElement timeStamp Gets the time at which the event was triggered |number|
|Type |Gets the type of the event string Which Returns the button or key that was pressed for mouse and keyboard events|

The jQuery Event object also defines most of the properties from the standard DOM Event object.

##Registering a Function to Handle Multiple Event Types##


```JavaScript
function handleMouse(e) {
    var cssData = {
        "border": "thick solid red",
        "opacity": "0.5"
    }
    if (event.type == "mouseout") {
        cssData.border = "";
        cssData.opacity = "";
    }
    $(this).css(cssData);
} 

$("img").bind("mouseenter mouseout", handleMouse); 
});
```

course, you can also use a single function and chain the bind calls, as follows:

```JavaScript
$("img").bind("mouseenter", handleMouse).bind("mouseout", handleMouse);
```

You can also register handlers using a map object. The properties of the object are the names of the events, and their values are the functions that will be invoked when the events are triggered.

```JavaScript
$("img").bind({
  mouseenter: function() {
    $(this).css("border", "thick solid red");
  }, mouseout: function() {
    $(this).css("border", "");
  }
});
```

##Providing Data to the Event Handler Function##

You can pass an object to the bind method, which jQuery will then make available to the handler function through the Event.data property.

```JavaScript
function handleMouse(e) {
    var cssData = {
        "border": "thick solid " + e.data,
    }
    if (event.type == "mouseout") {
        cssData.border = "";
    }
    $(this).css(cssData); 
} 
$("img:odd").bind("mouseenter mouseout", "red", handleMouse);
$("img:even").bind("mouseenter mouseout", "blue", handleMouse);
```

##Suppressing the Default Action##

some events have a default action when they are triggered on certain elements. A good example occurs when the user clicks a button whose type attribute is submit. If the button is contained in a form element, the default action is for the browser to submit the form. To prevent the default action from being performed, you can call the preventDefault method on the Event object,


```JavaScript
$("button:submit").bind("click", function(e) {
  e.preventDefault();
});
```

Instead of writing a one-line function as I did in Listing 9-5, you can use a different version of the bind method,

```JavaScript
$(document).ready(function() {
  $("button:submit").bind("click", false);
});
```

##Removing Event Handler Functions##

```JavaScript
$("img[src*=rose]").unbind();
```

unbind method to remove all of the handlers for the img element whose src attribute contains rose.

```JavaScript
$("img[src*=rose]").unbind("mouseout");
```

In this script I unbind only the mouseout event,

##Unbinding from Within the Event Handler Function##

```JavaScript
var handledCount = 0; 
function handleMouseEnter(e) {
    $(this).css("border", "thick solid red");
}

function handleMouseExit(e) {
    $(this).css("border", "");
    handledCount++;
    if (handledCount == 2) {
        $(this).unbind(e);
    }
}
$("img").bind("mouseenter", handleMouseEnter).bind("mouseout", handleMouseExit)
});

```

##Executing a Handler Once##

The one method lets you register an event handler that will be executed only once for an element and then removed.

```JavaScript
$("img").one("mouseenter", handleMouseEnter).one("mouseout", handleMouseOut);
```

##Performing Live Event Binding##

One limitation of the bind method is that your event handler functions are not associated with any new element that you add to the DOM.


Table 9-4. Methods for Automatically Registering Event Handlers 

|Method| Description|
|--|--|
|on(events, selector, data, function), on (map, selector, data) |  Defines handlers for events for elements that exist now or in the future |
|off(events, selector, function), off(map, selector) | Removes event handlers created using the on method|
|delegate(selector, eventType, function), delegate(selector, eventType, data, function), delegate(selector, map) | Adds an event handler to the elements that match the selector (now or in the future) attached to the elements in the jQuery object |
|undelegate(), undelegate(selector, eventType) | Removes event handlers created with the delegate method for the specified event types|

```JavaScript
$(document).on({
    mouseenter: function() {
        $(this).css("border", "thick solid red");
    },
    mouseout: function() {
        $(this).css("border", "");
    }
}, "img");
```

> **Tip**  The on method doesn’t need to add the handler functions directly to the element. In fact, it creates an event handler on the document object and looks for events that were triggered by elements that match the selector. When it sees such an event, it triggers the event handler.

Multiple events can be specified when using the on method.

```JavaScript
$("#row1").on("mouseenter mouseout", "img", handleMouse);
```

```JavaScript
$("#row1").off("mouseout", "img");
```

> **Caution**  It is important to use the same selector with the on and off methods; otherwise, the off method won’t undo the effect of on.

##Limiting DOM Traversal for Live Event Handlers##

One problem with the on method is that the events have to propagate all the way up to the document element before your handler functions are executed.

the delegate method , which allows you to specify where the event listener will be located in the document.

```JavaScript
$("#row1").delegate("img", {
  mouseenter: function() {
    $(this).css("border", "thick solid red");
  }, mouseout: function() {
    $(this).css("border", "");
  }
});
```
The main benefit of using the delegate method is speed, which can become an issue if you have a particularly large and complex document and a lot of event handlers.

> **Tip**  To remove handlers added with the delegate method, you have to use undelegate. The off method works only with the on method.

##Manually Invoking Event Handlers##

Table 9-5. Methods for Manually Invoking Event Handlers

|Method|  Description |
|--|--|
|trigger(eventType) | Triggers the handler functions for the specified event types on all of the elements in a jQuery object|
|trigger(event) |Triggers the handler functions for the specified event on all of the elements in a jQuery object|
|triggerHandler(eventType) |Triggers the handler function on the first element in the jQuery object, without performing the default action or bubbling the event|

```JavaScript
$("#row1 img").trigger("mouseenter");
```

##Using an Event Object##

You can also use an Event object to trigger other elements’ event handlers. This can be a convenient technique to use inside a handler,

```JavaScript
$("#row1 img").bind("mouseenter", function() {
  $(this).css("border", "thick solid red");
});

$("#row2 img").bind("mouseenter", function(e) {
  $(this).css("border", "thick solid blue");
  $("#row1 img").trigger(e);
});
```

This approach is convenient when you want to trigger the handlers for the event type currently being processed, but you could as easily get the same effect by specifying the event type.

##Using the triggerHandler Method##

The triggerHandler method invokes the handler functions without performing the event’s default action or allowing the event to bubble up through the DOM.

```JavaScript
$("#row1 img").triggerHandler("mouseenter");
```

> **Tip**  The result from the triggerHandler method is the result returned by the handler function, which means you cannot chain the triggerHandler method.

##Using the Event Shorthand Methods##

```JavaScript
$("img").mouseenter(function() {
  $(this).css("border", "thick solid red");
});
```

you can also use the shorthand methods as an analog to the trigger method.

```JavaScript
$("img").mouseenter();
```

```JavaScript
$("img").trigger("mouseenter");
```

##Using the Document Event Shorthand Methods##


Table 9-6. Document Event Shorthand Methods 

|Method| Description |
|--|--|
|load(function) | Corresponds to the load event, triggered when the elements and resources in the document have been loaded |
|ready(function) | Triggered when the elements in the document have been processed and the DOM is ready to use| |unload(function) |Corresponds to the unload event, triggered when the user navigates away from the page|

##Using the Browser Event Shorthand Methods##

Table 9-7. Browser Event Shorthand Methods 

|Method| Description|
|--|--|
|error(function) | Corresponds to the error event, triggered when there is a problem loading an external resource, such as an image |
|resize(function) |Corresponds to the resize event, triggered when the browser window is resized scroll(function) Corresponds to the scroll event, triggered when the scrollbars are used|

##Using the Mouse Event Shorthand Methods##

Table 9-8. Mouse Event Shorthand Methods 

|Method | Description |
|--|--|
|click(function) | Corresponds to the click event, triggered when the user presses and releases the mouse |
|dblclick(function) | Corresponds to the dblclick event, triggered when the user presses and releases the mouse twice in quick succession | 
|focusin(function) | Corresponds to the focusin event, triggered when the element gains the focus | 
|focusout(function) | Corresponds to the focusout event, triggered when the element loses the focus |
|hover(function), hover(function, function) | Triggered when the mouse enters or leaves an element; when one function is specified, it is used for both enter and exit events |
|mousedown(function) | Corresponds to the mousedown event, triggered when the mouse button is pressed over an element| 
|mouseenter(function) | Corresponds to the mouseenter event, triggered when the mouse enters the region of screen occupied by an element |
|mouseleave(function) | Corresponds to the mouseleave event, triggered when the mouse leaves the region of screen occupied by an element |
|mousemove(function) |Corresponds to the mousemouse event, triggered when the mouse is moved within the region of screen occupied by an element |
|mouseout(function) |Corresponds to the mouseout event, triggered when the mouse leaves the region of screen occupied by an element |
|mouseover(function) | Corresponds to the mouseover event, triggered when the mouse enters the region of screen occupied by an element | 
|mouseup(function) | Corresponds to the mouseup event, triggered when the mouse button is pressed over an element|

The hover method is a convenient way of binding a handler function to the mouseenter and mouseleave events.

If you provide two functions as arguments, then the first is invoked in response to the mouseenter event and the second in response to mouseleave.


If you specify only one function, it will be invoked for both events.

```JavaScript
$("img").hover(handleMouseEnter, handleMouseLeave);
  function handleMouseEnter(e) {
    $(this).css("border", "thick solid red");
  };

function handleMouseLeave(e) {
  $(this).css("border", "");
}
```

##Using the Form Event Shorthand Methods##

Table 9-9. Form Event Shorthand Methods 

|Method | Description |
|--|--|
|blur(function) | Corresponds to the blur event, triggered when an element loses the focus |
|change(function) | Corresponds to the change event, triggered when the value of an element changes | 
|focus(function) | Corresponds to the focus event, triggered when an element gains the focus |
|select(function) | Corresponds to the select event, triggered when the user selects the element value |
|submit(function) |Corresponds to the submit event, triggered when the user submits a form|

##Using the Keyboard Event Shorthand Methods##

Table 9-10. Keyboard Event Shorthand Methods 

|Method | Description |
|--|--|
|keydown(function) | Corresponds to the keydown event, triggered when the user presses a key |
|keypress(function) | Corresponds to the keypress event, triggered when the user presses and releases a key |
|keyup(function) | Corresponds to the keyup event, triggered when the user releases a key|

#CHAPTER 10 Using jQuery Effects#

##Using the Basic Effects##

Table 10-2. Basic Effects Methods 

| Method | Description | 
|--|--|
|hide() | Hides all of the elements in a jQuery object |
|hide(time), hide(time, easing) | Hides the elements in a jQuery object over the specified period of time with an optional easing style |
|hide(time, function), hide(time, easing, function) | Hides the elements in a jQuery object over the specified period of time with an optional easing style and a function that is called when the effect is complete |
|show() | Shows all of the elements in a jQuery object |
|show(time), show(time, easing) | Shows the elements in a jQuery object over the specified period of time with an optional easing style |
|show(time, function), show(time, easing, function) | Shows the elements in a jQuery object over the specified period of time with an optional easing style and a function that is called when the effect is complete | 
|toggle() | Toggles the visibility of the elements in a jQuery object |
|toggle(time), toggle(time, easing) | Toggles the visibility of the elements in a jQuery object over the specified period of time with an optional easing style |
|toggle(time, function), toggle(time, easing, function) | Toggles the visibility of the elements in a jQuery object over the specified period of time with an optional easing style and a function that is called when the effect is complete|
|toggle(boolean)| Toggles the elements in a jQuery object in one direction|


```JavaScript
if ($(e.target).text() == "Hide") {
  $("#row1 div.dcell").hide();
} else {
  $("#row1 div.dcell").show();
}
```

The first is that the transition is immediate: there is no delay or effect, and the elements just appear and disappear.

Second, calling hide on elements that are already hidden has no effect; nor does calling show on elements that are visible.

Finally, when you hide or show an element, you also show or hide all of its descendants.

> **Tip**  You can select elements using the :visible and :hidden selectors. See Chapter 5 for details of the jQuery extension CSS selectors.

##Toggling Elements##

```JavaScript
$("div.dcell:first-child").toggle();
```

> **Tip**  Notice that the structure of the document collapses around the hidden elements. If you want to hide the elements and leave space on the screen, then you can set the CSS visibility property to hidden.

## Toggling in One Direction##

```JavaScript
$("div.dcell:first-child").toggle(false);
```

##Animating the Visibility of Elements##

You can animate the process of showing and hiding elements by passing a time span to the show, hide, or toggle methods.

Table 10-3. Time Span Arguments 

|Method | Description |
|--|--|
|<number> | Specifies  duration in milliseconds |
| slow | A shorthand equivalent to 600 milliseconds |
| fast | A shorthand equivalent to 200 milliseconds |

```JavaScript
$("img").toggle("fast", "linear");
```

I have also provided an additional argument, which specifies the style of the animation, known as the easing style or easing function.

Two easing styles are available, swing and linear. When animating with the swing style, the animation starts slowly, speeds up, and then slows down again as the animation reaches conclusion. The linear style maintains a constant pace throughout the animation. If you omit the argument, swing is used.

##Using Effect Callbacks##

You can supply a function as an argument to the show, hide, and toggle methods, and the function will be called when these methods finish performing their effect. This can be useful for updating other elements to reflect the change in status,

```JavaScript
var hiddenRow = "#row2";
var visibleRow = "#row1"; 
$(hiddenRow).hide(); 

function switchRowVariables() {
    var temp = hiddenRow;
    hiddenRow = visibleRow;
    visibleRow = temp;
} 

function hideVisibleElement() {
    $(visibleRow).hide("fast", showHiddenElement);
} 

function showHiddenElement() {
    $(hiddenRow).show("fast", switchRowVariables);
}
```

> **Tip**  If you want to perform multiple sequential effects on a single element, then you can use regular jQuery method chaining. See the section “Creating and Managing the Effect Queue” for details.

You wouldn’t usually need to break out the individual functions

```JavaScript
.click(function(e) {
    $(visibleRow).hide("fast", function() {
        $(hiddenRow).show("fast", function() {
            var temp = hiddenRow;
            hiddenRow = visibleRow;
            visibleRow = temp;
        });
    });
```

##Creating Looping Effects##

You can use the callback functions to produce effects that are performed in a loop.

```JavaScript
function performEffect() {
  $("h1").toggle("slow", performEffect)
}
```

> **Tip**  Some caution is required when using the current function as the callback function. Eventually you will exhaust the JavaScript call stack, and your script will stop working.

solve this problem is with the setTimeout function,

```JavaScript
$("h1").toggle("slow", setTimeout( performEffect, 1)).
```

##USING EFFECTS RESPONSIBLY##

##Using the Slide Effects##

Table 10-4. Slide Effects Methods

| Method | Description |
|--|--|
| slideDown(), slideDown((time, function), slideDown(time, easing, function) | Show elements by sliding them down |
| slideUp(), slideUp(time, function), slideUp(time, easing, function) | Hide elements by sliding them up |
| slideToggle(), slideToggle(time, function), slideToggle(time, easing, function) | Toggle the visibility of elements by sliding them up and down |

```JavaScript
$("h1").slideToggle("fast");
```

##Using the Fade Effects##

Table 10-5. Fade Effects Methods

| Method | Description |
|--|--|
|fadeOut(), fadeOut(timespan), fadeOut(timespan, function), fadeOut(timespan, easing, function) | Hide elements by decreasing opacity |
|fadeIn(), fadeIn(timespan), fadeIn(timespan, function), fadeIn(timespan, easing, function) | Show elements by increasing opacity | 
| fadeTo(timespan, opacity), fadeTo(timespan, opacity, easing, function) | Change the opacity to the specified level | 
|fadeToggle(), fadeToggle(timespan), fadeToggle(timespan, function), fadeToggle(timespan, easing, function) | Toggle the visibility of elements using opacity |

```JavaScript
$("img").fadeToggle();
```

##Fading to a Specific Opacity##

You can use the fadeTo method to fade elements to a particular opacity. The range of opacity values is a number within the range of 0 (completely transparent) to 1 (completely opaque).

```JavaScript
$("img").fadeTo("fast", 0);
```

This has the same effect as the fadeOut method but doesn’t hide the elements at the end of the transition.

You don’t have to fade elements to the extremes of the opacity range. 

```JavaScript
$("img").fadeTo("fast", 0.4);
```

##Creating Custom Effects##

Table 10-6. Custom Effects Methods

| Method | Description | 
|--|--|
|animate(properties), animate(properties, time), animate(properties, time, function), animate(properties, time, easing, function) | Animates one or more CSS properties, with an optional time span, easing style, and callback function |
|animate(properties, options) |Animates one or more CSS properties, specifying the options|

jQuery can animate any property that accepts a simple numeric value (e.g., the height property).

> **Note**  Being able to animate numeric CSS properties means you can’t animate colors. There are a few ways to address this. The first (and to my mind best) solution is to use jQuery UI,

you might like to consider using the native browser support for CSS animations.

For details of CSS animation, see my book The Definitive Guide to HTML5,

The approach that I like least is using a jQuery plug-in.

https://github.com/jquery/jquery-color.

```JavaScript
$("h1").animate({
  height: $("h1").height() + $("form").height() + 10,
  width: ($("form").width())
});
```

##Using Absolute Target Property Values##

Notice that you specify only the final values for the animation. The

```JavaScript
$("h1").animate({
  left: 50,
  height: $("h1").height() + $("form").height() + 10,
  width: ($("form").width())
});
```

##Using Relative Target Property Values##

You can also specify your animation targets using relative values. You specify an increase by prefixing a value with += and a decrease with -=.

```JavaScript
$("h1").animate({
  height: "+=100",
  width: "-=700"
});
```

##Creating and Managing the Effect Queue##

When you use effects, jQuery creates a queue of the animations that it has to perform and works its way through them.

There are a set of methods you can use to get information about the queue or take control of it,

Table 10-7. Effects Queue Methods 

|Method | Description |
|--|--|
| queue() | Returns the queue of effects to be performed on the elements in the jQuery object |
| queue(function) | Adds a function to the end of the queue |
| dequeue() | Removes and executes the first item in the queue for the elements in the jQuery object|
|stop(), stop(clear), stop(clear, jumpToEnd) |Stops the current animation finish() Stops the current animation and clears any queued animations |
| delay(time) | Inserts a delay between effects in the queue |

You create a queue of effects by chaining together calls to effect-related methods,


```JavaScript
function cycleEffects() {
  $("h1")
    .animate({left: "+=100"}, timespan)
    .animate({left: "-=100"}, timespan)
    .animate({height: 223,width: 700}, timespan)
    .animate({height: 30,width: 500}, timespan)
    .slideUp(timespan)
    .slideDown(timespan, cycleEffects);
}
```

> **Note**  I could have used the callback functions to achieve the same effect, but that doesn’t create the effect queue, because the function that starts the next animation isn’t executed until the previous animation has completed.

##Displaying the Items in the Effect Queue##

You can use the queue method to inspect the contents of the effects queue.

object. If an effect is being executed, then the corresponding item in the queue is the string value inprogress.

If the effect is not being executed, the item in the queue is the function that will be invoked

```JavaScript
function printQueue() {
    var q = $("h1").queue();
    var qtable = $("table");
    qtable.html("<tr><th>Queue Length:</th><td>" + q.length + "</td></tr>");
    for (var i = 0; i < q.length; i++) {
        var baseString = "<tr><th>" + i + ":</th><td>";
        if (q[i] == "inprogress") {
            $("table").append(baseString + "In Progress</td></tr>");
        } else {
            $("table").append(baseString + q[i] + "</td></tr>");
        }
    }
    setTimeout(printQueue, 500);
}
```

##Stopping Effects and Clearing the Queue##

You can use the stop and finish methods to interrupt the effect that jQuery is currently performing.

For the stop method, you can provide two optional arguments to this method, both of which are boolean values. If you pass true as the first argument, then all of the other effects are removed from the queue and will not be performed. If you pass true as the second argument, then the CSS properties that are being animated by the current animation will be immediately set to their final values.

The default value for both arguments is false, which means that only the current effect is removed from the queue and that the properties that were being animated are left at the values they were set to at the moment the effect was interrupted.

If you don’t clear the queue, jQuery will move on to the next effect and begin executing it as normal.

```JavaScript
$("<button>Stop</button><button>Start</button>")
  .appendTo($("<div/>")
  .appendTo("body").css({
    position: "fixed",
    "z-index": "2",
    "border-collapse": "collapse",
    top: 100,
    left: 200
})).click(function(e) {
    $(this).text() == "Stop" ? $("h1").stop(true, true) : cycleEffects();
});
```

> **Tip**  When you call the stop method, any callback associated with the current effect will not be executed. When you use the stop method to clear the queue, no callback associated with any of the effects in the queue will be executed.

when using the finish method, the CSS properties being animated by the current effect and all of the queued effects jump to their final values.

```JavaScript
$("h1").finish();
```

When using the finish method, care must be taken with effect loops,

In order to determine the final CSS values for all of the animated properties, the finish method needs to execute all of the effects—albeit without any time delays—and that means that any callback functions are executed as well.

To avoid this, I have added a variable called finishAnimations, which I set in response to the button elements being clicked and I check before adding the next set of effects to the queue, as follows:

```JavaScript
.slideDown(timespan, function () {
  if (!finishAnimations) {
    cycleEffects();
  }
});
```

##Inserting a Delay into the Queue##

You can use the delay method to introduce a pause between two effects in the queue.

The argument to this method is the number of milliseconds that the delay should last for.

```JavaScript
$("h1").animate({
    left: "+=100"
}, timespan).animate({
    left: "-=100"
}, timespan).delay(1000).animate({
    height: 223,
    width: 700
}, timespan).animate({
    height: 30,
    width: 500
}, timespan).delay(1000).slideUp(timespan).slideDown(timespan, function() {
    if (!finishAnimations) {
        cycleEffects();
    }
});
```

##Inserting Functions into the Queue##

You can add your own functions into the queue using the queue method, and they will be executed just as the standard effect methods are.

You can use this feature to start other animations, gracefully exit a chain of animations based on an external variable, or, well, do anything that you need.

```JavaScript
$("h1").animate({
    left: "+=100"
}, timespan).animate({
    left: "-=100"
}, timespan).queue(function() {
    $("body").fadeTo(timespan, 0).fadeTo(timespan, 1);
    $(this).dequeue();
}).delay(1000).animate({
    height: 223,
    width: 700
}, timespan).animate({
    height: 30,
    width: 500
}, timespan).delay(1000).slideUp(timespan).slideDown(timespan, function() {
    if (!finishAnimations) {
        cycleEffects();
    }
});
```

The this variable is set to the jQuery object that the method was called on.

This is useful because you must make sure to call the dequeue method at some point in your function in order to move the queue onto the next effect or function.

> **Tip**  The effects I added in the custom function are added to the effect queues for the body element. Each element has its own queue, and you can manage them independently of one another.

Alternatively, you can accept a single argument to the function, which is the next function in the queue. In this situation, you must invoke the function to move the queue to the next effect,

```JavaScript
function cycleEffects() {
    $("h1").animate({
        left: "+=100"
    }, timespan).animate({
        left: "-=100"
    }, timespan).queue(function(nextFunction) {
        $("body").fadeTo(timespan, 0).fadeTo(timespan, 1);
        nextFunction();
    }).delay(1000).animate({
        height: 223,
        width: 700
    }, timespan).animate({
        height: 30,
        width: 500
    }, timespan).delay(1000).slideUp(timespan).slideDown(timespan, function() {
        if (!finishAnimations) {
            cycleEffects();
        }
    });
}
```

> **Caution**  The effect sequence will stall if you don’t invoke the next function or call the dequeue method.

## Enabling and Disabling Effect Animations ##

You can disable the animation of effects by setting the value of the $.fx.off property to true,

```JavaScript
$.fx.off = true;
```

When animations are disabled, calls to effect methods cause the elements to snap to their target property values immediately.

Looping sets of effects will quickly hit the call stack limit when animations are disabled. To avoid this, use the setTimeout method, as described earlier in this chapter.

#CHAPTER 11 Refactoring the Example: Part I#

Listing 11-2.  Adding Products to the Page

```JavaScript
$(document).ready(function() {
    var fNames = ["Carnation", "Lily", "Orchid"];
    var fRow = $("<div id=row3 class=drow/>").appendTo("div.dtable");
    var fTemplate = $("<div class=dcell><img/><label/><input/></div>");
    for (var i = 0; i < fNames.length; i++) {
        fTemplate.clone().appendTo(fRow).children().filter("img").attr("src", fNames[i] + ".png").end().filter("label").attr("for", fNames[i]).text(fNames[i]).end().filter("input").attr({
            name: fNames[i],
            value: 0,
            required: "required"
        })
    }
});
```

use the filter and end methods to narrow and broaden the selection and the attr method to set the attribute values.

##Adding the Carousel Buttons##

```JavaScript
$("<a id=left></a><a id=right></a>").prependTo("form").css({
    "background-image": "url(leftarrows.png)",
    "float": "left",
    "margin-top": "15px",
    display: "block",
    width: 50,
    height: 50
}).click(handleArrowPress).hover(handleArrowMouse)  $("#right").css("background-image", "url(rightarrows.png)").appendTo("form");
```

##Dealing with the Submit Button##

###Implementing the Carousel Event Handler Functions###

```JavaScript
var propValue = e.type == "mouseenter" ? "-50px 0px" : "0px 0px";
$(this).css("background-position", propValue);
```

```JavaScript
function handleArrowPress(e) {
    var elemSequence = ["row1", "row2", "row3"];
    var visibleRow = $("div.drow:visible");
    var visibleRowIndex = jQuery.inArray(visibleRow.attr("id"), elemSequence); 
    var targetRowIndex;
    if (e.target.id == "left") {
        targetRowIndex = visibleRowIndex - 1;
        if (targetRowIndex < 0) {
            targetRowIndex = elemSequence.length - 1
        };
    } else {
        targetRowIndex = (visibleRowIndex + 1) % elemSequence.length;
    } 
    visibleRow.fadeOut("fast", function() {
        $("#" + elemSequence[targetRowIndex]).fadeIn("fast")
    });
}
```

##Totaling the Product Selection##

```JavaScript
$("input").change(function(e) {
    var total = 0;
    $("input").each(function(index, elem) {
        total += Number($(elem).val());
    });
    $("#total").text(total);
});
```

##Disabling JavaScript##

#CHAPTER 12 Using Data Templates#

##Understanding the Problem That Templates Solve##

Data templates solve a specific problem: they allow you to programmatically generate elements from the properties and values of JavaScript objects.

##Setting Up the Template Library##

You can download the library from http://handlebarsjs.com

```JavaScript
(function($) {
    var compiled = {};
    $.fn.template = function(data) {
        var template = $.trim($(this).first().html());
        if (compiled[template] == undefined) {
            compiled[template] = Handlebars.compile(template);
        }
        return $(compiled[template](data));
    };
})(jQuery);
```

As Listing 12-2 demonstrates, it is simple to create plug-ins for jQuery, especially if you are just creating a wrapper around an existing library.

http://learn.jquery.com/plugins

A First Data Templates Example

```JavaScript
<script id="flowerTmpl" type="text/x-handlebars-template"> {{#each flowers}}
    <div class="dcell"> <img src="{{product}}.png" /> <label for="{{product}}">{{name}}:</label> <input name="{{product}}" data-price="{{price}}" data-stock="{{stock}}" value="0" required /> </div> {{/each}} </script>
<script type="text/javascript">
    $(document).ready(function() {
        var data = {
            flowers: [{
                name: "Aster",
                product: "aster",
                stock: "10",
                price: 2.99
            }, {
                name: "Daffodil",
                product: "daffodil",
                stock: "12",
                price: 1.99
            }, {
                name: "Rose",
                product: "rose",
                stock: "2",
                price: 4.99
            }, {
                name: "Peony",
                product: "peony",
                stock: "0",
                price: 1.50
            }, {
                name: "Primula",
                product: "primula",
                stock: "1",
                price: 3.12
            }, {
                name: "Snowdrop",
                product: "snowdrop",
                stock: "15",
                price: 0.99
            }]
        };
        var template = $("#flowerTmpl").template(data).appendTo("#row1");
    });
</script>
```

> **Tip**  When the data is part of the document, it is known as inline data. The alternative is remote data, which is where you get the data from a server separately from the document.

##Applying the Template##

```JavaScript
var template = $("#flowerTmpl").template(data).appendTo("#row1");
```

##Tweaking the Result##

```JavaScript
$("#flowerTmpl").template(data).slice(0, 3).appendTo("#row1").end().end().slice(3).appendTo("#row2")
```

##Using Template Logic##

One of the ways you can differentiate between the huge varieties of JavaScript template engines is to look at how the output of the templates can be varied based on different data values.

#CHAPTER 13 Working with Forms#

##Preparing the Node.js Server##

##Recapping the Form-Event Methods##

Table 13-2. The jQuery Form-Event Methods 

|Method | Event | Description |
|--|--|--|
| blur(function) | Blur | Triggered when a form element loses the focus. |
| change(function) | Change | Triggered when the value of a form element changes. | 
| focus(function) | Focus | Triggered when the focus is given to a form element. | 
| select(function) | Select | Triggered when the user selects text within a form element. | 
|submit(function) | Submit Triggered when the user wants to submit the form. |

##Dealing with Form Focus##


```JavaScript
function handleFormFocus(e) {
  var borderVal = e.type == "focus" ? "medium solid green" : "";
  $(this).css("border", borderVal);
}

$("input").focus(handleFormFocus).blur(handleFormFocus);
```

##Dealing with Value Changes##

```JavaScript
$("input").change(function (e) {
  var total = 0;
  $("input").each(function (index, elem) {
    total += Number($(elem).val());
  });
    $("#total").text(total);
  });
```

##Dealing with Form Submission##

```JavaScript
$("form").submit(function (e) {
  if ($("input").val() == 0) {
    e.preventDefault();
  }
});
``

> **Tip**  As an alternative, you can return false from the event handler function to achieve the same effect.

There are two different to submit a form programmatically.

jQuery submit method

submit method, which is defined for form elements by the HTML5

```JavaScript
$("<button>jQuery Method</button>").appendTo("#buttonDiv").click(function (e) {
  $("form").submit();
  e.preventDefault();
});

$("<button>DOM API</button>").appendTo("#buttonDiv").click(function (e) {
  document.getElementsByTagName("form")[0].submit();
  e.preventDefault();
});
```

The button elements that uses the DOM API and calls the submit method defined by the form element effectively bypasses the event handler because the submit event isn't triggered, and this means that the form will always be submitted, irrespective of the value of the first input element.

> **Tip**  My advice is to stick to the jQuery methods, of course, but if you do use the DOM method,

##Validating Form Values##

You can download the validation plug-in from http://jqueryvalidation.org

```css
<style type="text/css">
.errorMsg {color: red}
.invalidElem {border: medium solid red}
</style>
```

```JavaScript
$("form").validate({
  highlight: function (element, errorClass) {
    $(element).add($(element).parent()).addClass("invalidElem");
  }, unhighlight: function (element, errorClass) {  
    $(element).add($(element).parent()).removeClass("invalidElem");
  }, errorElement: "div",
  errorClass: "errorMsg"
});

$.validator.addClassRules({ flowerValidation: { min: 0 } })
```

```JavaScript
$("input").addClass("flowerValidation").change(function (e) {
  $("form").validate().element($(e.target));
});
```

The argument to the validate method is a map object that contains configuration settings,

A lot of the flexibility of the validation plug-in comes from the way that rules to test for valid input can be quickly and easily defined.

There are various ways of associating rules with elements and the one I tend to use works through classes. I define a set of rules and associate them with a class, and when the form is validated the rules are applied to any element contained with the form that is a member of the specified class.

elements that are members of the flowerValidation class. The rule is that the value should be equal to or greater than zero.

```JavaScript
$("input").addClass("flowerValidation").change(function(e) {
  $("form").validate().element($(e.target)); });
```

I have also set up a handler function for the change event to explicitly validate the element whose value has changed. This ensures that the user gets immediate feedback if he corrects an error.

##Using the Validation Checks##

Table 13-3. Validation Plug-in Checks 

| Checks | Description |
|--|--|
| creditcard: true | The value must contain a credit card number. |
| date: true | The value must be a valid JavaScript date. | 
| digits: true | The value must contain only digits. | 
| email: true | The value must be a valid e-mail address. | 
|max: maxVal | The value must be at least as large as maxVal. | 
|maxlength: length | The value must contain no more than length characters. |
|min: minVal | The value must be at least as large as minVal. |
| minlength: length; | The value must contain at least length characters. |
| number: true | The value must be a decimal number. |
| range: [minVal, maxVal] | The value must be between minVal and maxVal. | 
| rangelength: [minLen, maxLen] | The value must contain at least minLen and no more than maxLen characters. |
| required: true; | A value is required. url: true The value must be a URL. |

You can associate multiple rules together in a single rule. This allows you to perform complex validations in a compact and expressive way.

> **Tip**  Included in the validation plug-in distribution zip file is a file called additional-methods.js. This file defines some additional checks, including U.S. and U.K. phone numbers, IPv4 and IPv6 addresses, and some additional date, e-mail, and URL formats.

##Applying Validation Rules via Classes##

```JavaScript
$.validator.addClassRules({
  flowerValidation: {
    required: true,
    digits: true,
    min: 0,
    max: 100
  }
});
```

##Applying Validation Rules Directly to Elements##

```JavaScript
$("#row1 input").each(function (index, elem) {
  $(elem).rules("add", {
    min: 10,
    max: 20
  })
});
``

> **Tip**  You can remove rules from elements by replacing add with remove when you call the rules method.

Rules applied to elements using the rules methods are evaluated before those applied using a class.


Because I am dealing with validation for each element individually, I can tailor the checks even further,

```JavaScript
$("input").each(function(index, elem) {
    var rules = {
        required: true,
        min: 0,
        max: data.flowers[index].stock,
        digits: true
    }
    if (Number(data.flowers[index].price) > 3.00) {
        rules.max--;
    }
    $(elem).rules("add", rules);
});
```

##Applying Validation Rules via the Element Name##

Validation rules can also be applied to elements based on the value of the name attribute. Nothing in the HTML specification requires the name attribute value to be unique, and a single value is often used to categorize a group of form elements.

```JavaScript
var rulesList = new Object();
for (var i = 0; i < data.flowers.length; i++) {
  rulesList[data.flowers[i].product] = {
    min: 0,
    max: Number(data.flowers[i].stock),
  }
}
```


##Applying Validation Rules Using Element Attributes##

```xml
<input name="{{product}}" value="0" required min="0" max="{{stock}}"/>
```

##Specifying Validation Messages##

##Specifying Messages for Attribute and Name Validation##

```JavaScript
messages: {
  rose: { max: "We don't have that many roses in stock!" },
  primula: { max: "We don't have that many primulas in stock!" }
```

The syntax for setting up these validation messages can be duplicative, so I tend to create an object with the messages I want programmatically,

```JavaScript
var customMessages = new Object();
for (var i = 0; i < data.flowers.length; i++) {
  customMessages[data.flowers[i].product] = {
    max: "We only have " + data.flowers[i].stock + " in stock"
  }
}
```

##Specifying Messages for Per-Element Validation##

When applying rules to individual elements, you pass in a messages object that defines the messages you want for your checks.

```JavaScript
$("input").change(function(e) {
  $("form").validate().element($(e.target));
}).each(function(index, elem) {

$(elem).rules("add", {
    messages: {
        max: "We only have " + data.flowers[index].stock + " in stock"
    }
})
``

#Creating a Custom#

You can create a custom validation check if the built-in ones don’t suit your needs.

```JavaScript
var data = {
  flowers: [
    { name: "Aster", product: "aster", stock: "10", price: "2.99" },
```

```JavaScript
$.validator.addMethod("stock", function (value, elem, args) {
  return Number(value) < Number(args);
  }, "We don't have that many in stock");
```

```JavaScript
$("input").each(function (index, elem) {
  $(elem).rules("add", {
    stock: data.flowers[index].stock
})
```
##Defining the Validation Function##

The arguments to the custom validation function are the value entered by the user, the HTMLElement object representing the form element, and any arguments that were specified when the check is applied to an element for validation, like this:

```JavaScript
$(elem).rules("add", {     min: 0,     stock:data.flowers[index].stock }) ...
```

This is passed as is to the custom validation function:

```JavaScript
function(value, elem,args) {
 return Number(value) <= Number(args);
}
```

The value and the arguments are presented as strings, and that means I have to use the Number type to ensure that JavaScript properly compares the values as numbers.

##Defining the Validation Message##

```JavaScript
$.validator.addMethod("stock", function (value, elem, args) {
  return Number(value) < Number(args);
}, function(args) {
  return "We only have " + args + " in stock"
});
```

##Formatting the Validation Error Display##


To my mind, one of the best features of the validation plug-in is the wide range of ways that you can configure how validation error messages are displayed to the user.

```JavaScript
$("form").validate({
    highlight: function(element, errorClass) {
        $(element).add($(element).parent()).addClass("invalidElem");
    },
    unhighlight: function(element, errorClass) {
        $(element).add($(element).parent()).removeClass("invalidElem");
    },
    errorElement: "div",
    errorClass: "errorMsg"
});
```

##Setting the Class for Invalid Elements##

The errorClass option specifies a class that will be associated with invalid values. This class is applied to error message elements when they are added to the document.

```css
<style type="text/css">
  .errorMsg {color: red}
  .invalidElem {border: medium solid red}
</style>
```

##Setting the Error Message Element##

Error messages are inserted into the document as the immediate next sibling of the form element that contains the invalid value.

By default, the error message text is contained within a label element.

##Setting the Highlighting for Invalid Elements##

The highlight and unhighlight options specify functions that will be used to highlight elements that contain invalid values.

The arguments to the functions are the HTMLElement object representing the invalid element and the class specified using the errorClass option.

##Using a Validation Summary##

The validation plug-in can present the user with a single list of all the validation errors, rather than add individual messages next to each element.

```JavaScript
var plurals = {
  aster: "Asters",
  daffodil: "Daffodils",
  rose: "Roses",
  peony: "Peonies",
  primula: "Primulas",
  snowdrop: "Snowdrops"
};
```

```JavaScript
$("<div id='errorSummary'>Please correct the following errors:</div>")
  .addClass("errorMsg invalidElem")
  .append("<ul id='errorsList'></ul>").hide().insertAfter("h1"); 

$("form").validate({
    highlight: function(element, errorClass) {
        $(element).addClass("invalidElem");
    },
    unhighlight: function(element, errorClass) {
        $(element).removeClass("invalidElem");
    },
    errorContainer: "#errorSummary",
    errorLabelContainer: "#errorsList",
    wrapper: "li",
    errorElement: "div"
});
```

```JavaScript
$.validator.addMethod("stock", function(value, elem, args) {
    return Number(value) <= Number(args.data.stock);
}, function(args) {
    return "You requested " + $(args.element).val() + " " + plurals[args.data.product] + " but we only have " + args.data.stock + " in stock";
}); 

$("input").each(function(index, elem) {
  $(elem).rules("add", {
    stock: {
        index: index,
        data: data.flowers[index],
        element: elem
   }
})
}).change(function(e) {

$("form").validate().element($(e.target));
```

##Preparing the Validation Messages##

```JavaScript
var plurals = {
  aster: "Asters", 
  daffodil: "Daffodils", 
  rose: "Roses",     
  peony: "Peonies", 
  primula: "Primulas", 
  snowdrop: "Snowdrops"
}
```

```JavaScript
return "You requested " + $(args.element).val() + " " + plurals[args.data.product] + " but we only have " + args.data.stock + " in stock";
```

The link between these two stages is the argument object that I specify when applying the custom check to the form elements.

```JavaScript
stock: {
  index: index,
  data: data.flowers[index],
  element: elem
}
```

##Creating the Validation Summary##

I am responsible for creating the element that will contain the validation summary and adding it to the document.

```JavaScript
$("<div id='errorSummary'>Please correct the following errors:</div>")
  .addClass("errorMsg invalidElem")
  .append("<ul id='errorsList'></ul>")
  .hide().insertAfter("h1");
```

> **Notice** that I have used the hide method after appending these elements to the DOM. Not only am I responsible for creating the elements, but I am also responsible for ensuring that they are not visible when there are no errors.

Now that I have all the pieces in place, I can configure the validation summary, as follows:

```JavaScript
$("form").validate({
    highlight: function(element, errorClass) {
        $(element).addClass("invalidElem");
    },
    unhighlight: function(element, errorClass) {
        $(element).removeClass("invalidElem");
    },
    errorContainer: "#errorSummary",
    errorLabelContainer: "#errorsList",
    wrapper: "li",
    errorElement: "div"
});
```

The errorContainer option specifies a selector that will be made visible when there are validation errors to display.

The errorLabelContainer option specifies the element into which the individual error messages will be inserted.

The wrapper option specifies an element into which the validation message will be inserted.

Finally, the errorElement specifies the element that will contain the error text.

This is the label element by default, but I have switched to div elements to make the formatting easier.

##Tidying Up the Error Message Composition##

In the previous example, when I wanted to create a contextual error message, I did so by concatenating strings and variables, like this:

```JavaScript
$.validator.addMethod("stock", function (value, elem, args) {
  return Number(value) <= Number(args.data.stock); }, function (args) {
    return "You requested " + $(args.element).val() + " " + plurals[args.data.product] + " but we only have " + args.data.stock + " in stock"; 
});
```

The validation plug-in method provides a formatter than works in a way similar to string composition in languages like C#,

```JavaScript
return $.validator.format("You requested {0} {1} but we only have {2} in stock", 
  $(args.element).val(), 
  plurals[args.data.product], 
  args.data.stock
)
```

The $.validator.format method returns a function that isn’t evaluated until the error message is displayed, which ensures that the correct values are used when composing the string.

#CHAPTER 14 Using Ajax: Part I#

Ajax stands for Asynchronous JavaScript and XML but is generally a word in its own right these days.

The Ajax support that I use in this chapter is built into the core jQuery library, although I do briefly describe a useful plug-in at the end of the chapter.

##Using the Ajax Shorthand Methods##

Table 14-2. The jQuery Ajax Shorthand Methods

|Name| Description | 
|--|--|
| $.get() | Performs an Ajax request using the HTTP GET method | 
| $.post() | Performs an Ajax request using the HTTP POST method |

##Performing an Ajax GET Request##

```JavaScript
$(document).ready(function () {
  $.get("flowers.html", function (data) {
    var elems = $(data).filter("div").addClass("dcell");
    elems.slice(0, 3).appendTo("#row1");
    elems.slice(3).appendTo("#row2");
  });
});
```

##Processing the Response Data##

The argument passed to the success function is the data that the server has sent back in answer to my request.

To make this into something I can use with jQuery, I passed the data into the jQuery $ function so that it is parsed into a hierarchy of HTMLElement objects,

```JavaScript
var elems = $(data).filter("div").addClass("dcell");
```

> **Tip**  Notice that I have used the filter method to select only the div elements generated from the data. When parsing the data, jQuery assumes that the carriage-return characters that I added between the div elements in the flowers.html file for structure are text content and creates text elements for them. To avoid this, you can either ensure that there are no carriage returns in the documents you request or use the filter method to remove then.

##Making the Effect Easier to See##

```JavaScript
$(document).ready(function() {
    $("<button>Ajax</button>").appendTo("#buttonDiv").click(function(e) {
        $.get("flowers.html", function(data) {
            var elems = $(data).filter("div").addClass("dcell");
            elems.slice(0, 3).appendTo("#row1");
            elems.slice(3).appendTo("#row2");
        });
        e.preventDefault();
    });
});
```

##Getting Other Kinds of Data##

Of particular interest is JavaScript Object Notation (JSON) data,

```JavaScript
$("<button>Ajax</button>").appendTo("#buttonDiv").click(function(e) {
  $.get("mydata.json", function(data) {
    var tmplData = $("#flowerTmpl").template({ flowers: data }).filter("*");
    tmplData.slice(0, 3).appendTo("#row1");
    tmplData.slice(3).appendTo("#row2");
  });

  e.preventDefault();
});
```

> **Notice** that I didn’t have to do anything to convert the JSON string to a JavaScript object: jQuery does this for me automatically.

> **Tip**  Some web servers (and this includes some versions of Microsoft IIS, which I have used for this book) will not return content to browsers if they don’t recognize the file extension or data format. To make this example work with IIS, I have to add a new mapping between the file extension (.json) and the MIME type for JSON data (application/json). Until I did this, IIS would return 404—Not Found errors when mydata.json was requested.

##Providing Data to GET Requests##

To send data as part of the GET request, you pass a data object to the get method,

```JavaScript
var requestData = {
  country: "US",
  state: "New York"
};
```

```JavaScript
$.get("mydata.json",requestData, function (data) {
```

The data you provide is appended to the specified URL as a query string.

http://www.jacquisflowershop.com/jquery/flowers.html?country=US&state=New+York

##use the developer’s tools##

XHR filter (XHR refers to the XmlHttpRequest object, which is the Document Object Model (DOM) object used by jQuery to make Ajax requests).

##GET AND POST: PICK THE RIGHT ONE##

Be careful. The rule of thumb is that GET requests should be used for read-only information retrieval, while POST requests should be used for any operation that changes the application state.

In standards-compliance terms, GET requests are for safe interactions (having no side effects besides information retrieval), and POST requests are for unsafe interactions (making a decision or changing something).

##Performing an Ajax POST Request##

##Understanding Cross-Origin Ajax Requests##

I set an HTTP header, as follows: Access-Control-Allow-Origin: http://www.jacquisflowershop.com

By default, browsers limit scripts to making make Ajax requests within the same origin as the document that contains them.

When you want to make a request from one origin to another, it is known as a cross-origin request.

Fortunately, there is now a legitimate means of making cross-origin requests, defined in the Cross-Origin Resource Sharing (CORS) specification.

> **Tip**  The CORS specification is reasonably recent. It is supported by the current generation of browsers, but older browsers will simply ignore cross-origin requests. A more established approach is to use JSONP, which I describe in the section “Working with JSONP.”

The way that CORS works is that the browser contacts the second server (the Node.js server in this case) and includes an Origin header in the request. The value of this header is the origin of the document that has led to the request being made. If the server recognizes the origin and wants to allow the browser to make a cross-origin request, then it adds the Access-Control-Allow-Origin header, setting the value to match the Origin header from the request. If the response doesn’t contain this header, then the browser discards the response.

You can also set the Access-Control-Allow-Origin header to an asterisk (*), which means that cross-origin requests from any origin will be permitted. This is fine for the purposes of testing, but you should think carefully about the security implications before using this setting in a production application.

##Using the post Method to Submit Form Data##

```JavaScript
$("button").click(function(e) {
    var formData = $("form").serialize();
    $.post("http://node.jacquisflowershop.com/order", formData, processServerResponse);
    e.preventDefault();
}); 

function processServerResponse(data) {
    var inputElems = $("div.dcell").hide();
    for (var prop in data) {
        var filtered = inputElems.has("input[name=" + prop + "]").appendTo("#row1").show();
    }

$("#buttonDiv").remove();
    $("#totalTmpl").template(data).appendTo("body");
}
```


The first thing that I do is to call the serialize method on the form element. This is a helpful method that works its way through all of the form elements and creates a URL-encoded string that you can send to the server.

follows: aster=12&daffodil=20&rose=0&peony=0&primula=4&snowdrop=0

create an object that contains your data, call the serialize method to format the data properly, and then pass it to the post method. This can be a useful technique if you are collecting data from the user without using a form or if you want to be selective about the form elements that you include in the POST request.


```JavaScript
$(document).ready(function() { 
    $("button").click(function(e) {
        var requestData = {
            apples: 2,
            oranges: 10
        }; 
        $.post("http://node.jacquisflowershop.com/order", requestData, function(responseData) {
            console.log(JSON.stringify(responseData));
        }) e.preventDefault();
    })
});
```

> **Tip**  The JSON response from the server is automatically transformed into a JavaScript object by jQuery. I used the JSON.stringify method (which is supported by most browsers) to turn it back into a string so that I could display it on the console.

##Specifying the Expected Data Type##

When you use the get and post methods, jQuery has to figure out what kind of data the server is sending back in response to your request. It can be anything from HTML to a JavaScript file. To do this, jQuery relies on the information that the server provides in the response, particularly the Content-Type header.

For the most part, this works well, but on occasion jQuery needs a little help. This is usually because the server is specifying the wrong MIME type for the data in the response.

You can override the information that the server provides

This argument can be one of the following values:

xml json jsonp script html text Listing 14-12 shows

```JavaScript
$(document).ready(function () {
  $.get("mydata.json", function (responseData) {
    console.log(JSON.stringify(responseData));
  },"json");
});
```

##Avoiding the Most Common Ajax Pitfall##

the most common problem that web programmers make with Ajax, which is to treat the asynchronous request as though it were synchronous.

```JavaScript
$(document).ready(function() { 
    var elems; 
    $.get("flowers.html", function(data) {
        elems = $(data).filter("div").addClass("dcell");
    }); 
    elems.slice(0, 3).appendTo("#row1");
    elems.slice(3).appendTo("#row2");
});
```

Uncaught TypeError: Cannot call method 'slice' of undefined

##Using the Type-Specific Convenience Methods##

Table 14-4. The jQuery Ajax Type-Specific Convenience Methods 

|Name | Description |
|--|--|
| load() | Loads HTML elements and inserts them into the elements in the jQuery object on which the method has been called |
| $.getScript() | Gets and executes JavaScript code $.getJSON() Gets JSON data |

##Getting an HTML Fragment##

The load method will only obtain HTML data, which allows you to request an HTML fragment, process the response to create a set of elements, and insert those elements in the document in a single step.

```JavaScript
$(document).ready(function () {
  $("#row1").load("flowers.html");
});
```

You call the load method on the element in the document that you want to insert the new elements into and pass the URL as a method argument.

the load method is most useful when all of the elements are to be inserted in a single location and you don’t need to modify them before they are added.

##Manipulating the Elements Added by the load Method##

The key phrase is will be because the load method uses an asynchronous request to get the HTML from the server.

This means that you have to be careful if you want to manipulate the elements that the load method adds to the DOM because normal jQuery techniques won’t work.

Listing 14-16.  The Most Common Problem Code for the load Method

```JavaScript
$(document).ready(function () {
  $("#row1").load("flowers.html").children().addClass("dcell");
});
```

To address this, the load method has an optional argument that allows a callback function to be specified.

```JavaScript
$(document).ready(function () {
  var targetElems = $("#row1");
  targetElems.load("flowers.html", function () {
    targetElems.children().addClass("dcell");
  });
});
```

##Getting and Executing Scripts##

The getScript method loads a JavaScript file and executes the statements it contains.

```JavaScript
$(document).ready(function () {
  $.getScript("myscript.js");
});
```

> **Tip**  The getScript method can be used for any script file, but I find it especially useful for loading and executing scripts that are not central to a web application’s functionality, like tracker or geolocation scripts.

##Getting JSON Data##

The getJSON method obtains JSON data from the server and parses it to create JavaScript objects.

```JavaScript
$(document).ready(function() {
    $.getJSON("mydata.json", function(data) {
        var tmplElems = $("#flowerTmpl").template({
            flowers: data
        }).filter("*");
        tmplElems.slice(0, 3).appendTo("#row1");
        tmplElems.slice(3).appendTo("#row2");
    });
});
```

> **Tip**  Notice that you are passed a JavaScript object as the argument to the function. You don’t have to do anything to convert from the JSON format into an object because jQuery takes care of this for you.

##Working with JSONP##

JSONP is an alternative to CORS and works around the same-origin restriction on Ajax requests. It relies on the fact that the browser will allow you to load JavaScript code from any server, which is how the script element works when you specify a src attribute.

```JavaScript
function processJSONP(data) {
  //... do something with the data
}
```

You then make a request to the server where the query string includes your form data and a callback property, set to the name of the function you just defined, as follows:


http://node.jacquisflowershop.com/order? callback=processJSONP&aster=1     &daffodil=2&rose=2&peony=0&primula=0&snowdrop=0

The server, which needs to understand how JSONP works, generates the JSON data as normal and then creates a JavaScript statement that calls the function you created and passes in the data as an argument, as follows:

```JavaScript
processJSONP({"aster":"1","daffodil":"2","rose":"2","total":5})
```

The server also sets the content type of the response to be text/javascript, which tells the browser that it has received some JavaScript statements and should execute them. This has the effect of invoking the method you defined earlier, passing in the data sent by the server. In this way, you neatly sidestep the same-domain issues without using CORS.

> **Caution**  Cross-origin requests are restricted for good reason. Don’t use JSONP casually. It can create some serious security problems.

jQuery has convenient support for JSONP. All you have to do is use the getJSON method and specify a URL that contains callback=? in the query string. jQuery creates a function with a random name and uses this when communicating to the server, meaning you don’t have to modify your code at all.

```JavaScript
$("button").click(function(e) {
    var formData = $("form").serialize();
    $.getJSON("http://node.jacquisflowershop.com/order?callback=?", formData, processServerResponse) e.preventDefault();
}) 
function processServerResponse(data) {
    var inputElems = $("div.dcell").hide();
    for (var prop in data) {
        var filtered = inputElems.has("input[name=' + prop + ']").appendTo("#row1").show();
    }
    $("#buttonDiv, #totalDiv").remove();
    $("#totalTmpl").template(data).appendTo("body");
}
```

##Using the Ajax Forms Plug-in##

If you are interested in using Ajax solely to post form data to a server, then you might like the jQuery Form plug-in, which you can get from www.malsup.com/jquery/form and which I saved to a file called jquery.form.js.

```JavaScript
$(document).ready(function() { 
    $.getScript("myscript.js"); 
    $("form").ajaxForm(function(data) {
        var inputElems = $("div.dcell").hide();
        for (var prop in data) {
            var filtered = inputElems.has("input[name=' + prop + ']").appendTo("#row1").show();
        }
        $("#buttonDiv, #totalDiv").remove();
        $("#totalTmpl").template(data).appendTo("body");
    });
});
```

#CHAPTER 15 Using Ajax: Part II#

##Making a Simple Ajax Request with the Low-Level API##

Listing 15-1.  Using the ajax Method

```JavaScript
$(document).ready(function() {
    $.ajax("mydata.json", {
        success: function(data) {
            var tmplElems = $("#flowerTmpl").template({
                flowers: data
            }).filter("*");
            tmplElems.slice(0, 3).appendTo("#row1");
            tmplElems.slice(3).appendTo("#row2");
        }
    });
});
```

You use the ajax method by passing the URL that you want to request and a map object whose properties define a set of key/value pairs, each of which configures a setting for the request.

In this example, my map object has one property—success—which specifies the function to call if the request is successful.

I request the mydata.json file from the server and use it with a data template to create and insert elements into the document,

##Understanding the jqXHR Object##

The result returned by the ajax method is a jqXHR object that you can use to get details about and interact with the Ajax request.

The jqXHR object is a superset of the XMLHttpRequest object that is defined as part of the World Wide Web Consortium (W3C) standard that underpins browser support for Ajax, adapted to work with the jQuery deferred object features

You can simply ignore the jqXHR object for most Ajax requests, which is exactly what I suggest you do. The jqXHR object is useful when you need more information about the response from the server than would otherwise be available.

Table 15-2. The jqXHR Members 

| Member | Description |
| readyState | Returns the progress of the request through its life cycle from unsent (value 0) to complete (value 4) |
| status | Returns the HTTP status code sent back by the server | 
| statusText | Returns the text description of the status code |
| responseXML | Returns the response if it is an XML document |
| responseText | Returns the response as a string |
| setRequestHeader(name, value) | Sets a header on the request |
| getAllResponseHeaders() | Returns all of the headers in the response as a single string |
| getResponseHeader(name) | Returns the value of the specified response header | 
| abort() | Terminates the request |

> **Tip**  The jqXHR object can be used to configure the Ajax request, but this is more easily done using the configuration options for the ajax method,

```JavaScript
$(document).ready(function() {
    var jqxhr = $.ajax("mydata.json", {
        success: function(data) {
            var tmplElems = $("#flowerTmpl").template({
                flowers: data
            }).filter("*");
            tmplElems.slice(0, 3).appendTo("#row1");
            tmplElems.slice(3).appendTo("#row2");
        }
    }); 
    var timerID = setInterval(function() {
        console.log("Status: " + jqxhr.status + " " + jqxhr.statusText);
        if (jqxhr.readyState == 4) {
            console.log("Request completed: " + jqxhr.responseText);
            clearInterval(timerID);
        }
    }, 100); 
});
```

Using the result of the ajax method doesn’t change the fact that the request is performed asynchronously,

> **Tip**  I rarely use the jqXHR object and never when it is the result of the ajax method. If I want to work with the jqXHR object (typically to get additional information about the response from a server), then I usually do so through the event handler settings that I describe in the section “Handling Ajax Callbacks.”

##Setting the Request URL##

As an alternative to passing the URL for the request as an argument to the ajax method, you can define a url property in the map object,

```JavaSCript
$.ajax({
  url: "mydata.json",
  success: function (data) {
    var tmplElems = $("#flowerTmpl").template({flowers:
```

##Making a POST Request##

You set the HTTP method for requests using the type setting. The default is to make GET requests,

```JavaSCript
$.ajax({
  url: $("form").attr("action"),
  data: $("form").serialize(),
  type: "post",
  success: processServerResponse
})

  e.preventDefault();
```

##GOING BEYOND GET AND POST##

You can use the type property to specify any HTTP method, but you may have difficulty using anything other than GET or POST because many firewalls and application servers are configured to discard other kinds of request. If you want to use other HTTP methods, then you can make a POST request, but add the X-HTTP-Method-Override header, setting it to the method you want to use, as follows: X-HTTP-Method-Override: PUT This convention is widely supported by web application frameworks and is a common way of creating RESTful web applications, which you can learn more about at http://en.wikipedia.org/wiki/Representational_state_transfer. See the section “Setting Timeouts and Headers” for details of how to set a header on a jQuery Ajax request.

##Handling Ajax Callbacks##

Several properties let you specify callback functions for key points in the life of an Ajax request.


Table 15-3. The Ajax Event Properties 

| Setting | Description |
|--|--|
| beforeSend | Specifies a function that will be called before the Ajax request is started |
| complete | Specifies a function that will be called when the Ajax request succeeds or fails |
| error | Specifies a function that will be called when the Ajax request fails |
| success | Specifies a function that will be called when the Ajax request succeeds |

> **Tip**  The settings described in Table 15-3 are related to local callbacks, meaning that they deal with individual Ajax requests. You can also use a series of global events, which I describe in the section “Using the Global Ajax Events.”

##Dealing with Successful Requests##

```JavaSCript
$.ajax({
  url: "mydata.json",
  success: function (data, status, jqxhr) {
    console.log("Status: " + status);
    console.log("jqXHR Status: " + jqxhr.status + " " + jqxhr.statusText);
    console.log(jqxhr.getAllResponseHeaders());
```

The status argument is a string that describes the outcome of the request.

The final argument is a jqXHR object. You don’t have to poll the status of the request before working with the jqXHR object since you know the function is executed only when the request has successfully completed.

##Dealing with Errors##

```JavaSCript
$(document).ready(function() {
    $.ajax({
        url: "NoSuchFile.json",
        success: function(data, status, jqxhr) {
            var tmplElems = $("#flowerTmpl").template({
                flowers: data
            }).filter("*");
            tmplElems.slice(0, 3).appendTo("#row1");
            tmplElems.slice(3).appendTo("#row2");
        },
        error: function(jqxhr, status, errorMsg) {
            $("<div>").addClass("error").text("Status: " + status + " Error: " + errorMsg).insertAfter("h1");
        }
    });
});
```

The arguments passed to the error callback function are a jqXHR object, a status message, and the error message from the server response.

Table 15-4. The Error Status Values 

|Setting | Description |
|--|--|
| abort | Indicates that the request was aborted (using the jqXHR object) |
| error | Indicates a general error, usually reported by the server |
| parsererror | Indicates that the data returned by the server could not be parsed |
| timeout | Indicates that the request timed out before the server responded |

The value of the errorMsg argument varies based on the status. When the status is error, then errorMsg will be set to the text portion of the response from the server.

##Dealing with Completed Requests##

Listing 15-7.  Using the Complete Property

```JavaScript
$(document).ready(function() {
    $.ajax({
        url: "mydata.json",
        success: function(data, status, jqxhr) {
            var tmplElems = $("#flowerTmpl").template({
                flowers: data
            }).filter("*");
            tmplElems.slice(0, 3).appendTo("#row1");
            tmplElems.slice(3).appendTo("#row2");
        },
        error: function(jqxhr, status, errorMsg) {
            $("<div>").addClass("error").text("Status: " + status + " Error: " + errorMsg).insertAfter("h1");
        },
        complete: function(jqxhr, status) {
            console.log("Completed: " + status);
        }
    });
});
```

The callback function specified by the complete property is called after the functions specified by the success and error properties.

jQuery passes the jqXHR object and a status string to the callback function. The status string will be set to one of the values shown in Table 15-5

Table 15-5. The Ajax Event Settings 

| Setting | Description |
|--|--|
| abort | Indicates that the request was aborted (using the jqXHR object) |
| error | Indicates a general error, usually reported by the server |
| notmodified | Indicates that the requested content has not been modified since it was last requested (see the section “Ignoring Unmodified Data” for more details) |
| parsererror | Indicates that the data returned by the server could not be parsed |
| success | Indicates that the request completed successfully |
| timeout | Indicates that the request timed out before the server responded |

You might be tempted to use the complete setting to specify a single function that can handle all outcomes of a request, but doing so means you don’t benefit from the way that jQuery processes data and errors. A better approach is to use the success and error settings and carefully organize the arguments on the common function,

```JavaScript
$(document).ready(function() {
    $.ajax({
        url: "mydata.json",
        success: function(data, status, jqxhr) {
            handleResponse(status, data, null, jqxhr);
        },
        error: function(jqxhr, status, errorMsg) {
            handleResponse(status, null, errorMsg, jqxhr);
        }
    }); 
    function handleResponse(status, data, errorMsg, jqxhr) {
        if (status == "success") {
            var tmplElems = $("#flowerTmpl").template({
                flowers: data
            }).filter("*");
            tmplElems.slice(0, 3).appendTo("#row1");
            tmplElems.slice(3).appendTo("#row2");
        } else {
            $("<div>").addClass("error").text("Status: " + status + " Error: " + errorMsg).insertAfter("h1");
        }
    }
});
```

##Configuring Requests Before They Are Sent##

The beforeSend property lets you specify a function that will be called before the request is started.

```JavaScript
$.ajax({
    url: "NoSuchFile.json",
    success: function(data, status, jqxhr) {
        handleResponse(status, data, null, jqxhr);
    },
    error: function(jqxhr, status, errorMsg) {
        handleResponse(status, null, errorMsg, jqxhr);
    },
    beforeSend: function(jqxhr, settings) {
        settings.url = "mydata.json";
    }
});
```

The arguments passed to the callback function are the jqXHR object and the settings object that you passed to the ajax method.

##Specifying Multiple Event Handler Functions##

you can set the success, error, complete, and beforeStart properties to an array of functions and each of them will be executed when the corresponding event is triggered.

```JavaScript
$.ajax({
  url: "mydata.json",
  success: [processData, reportStatus],
});
```

##Setting the Context for Events##

The context property lets you specify an element that will be assigned to the this variable when an event function is enabled.

```JavaScript
$.ajax({
  url: "mydata.json",
  context: $("h1"),
```

##Using the Global Ajax Events##

jQuery also defines a set of global events, which you can use to monitor all Ajax queries that are made by your application.


Table 15-6. jQuery Ajax Event Methods 

| Method | Description |
|--|--|
| ajaxComplete(function) | Registers a function to be called when an Ajax request completes (irrespective of whether it was successful) |
| ajaxError(function) | Registers a function to be called when an Ajax requests encounters an error | 
| ajaxSend(function) | Registers a function to be called before an Ajax request commences | 
| ajaxStart(function) | Registers a function to be called when an Ajax request starts | 
| ajaxStop(function) | Registers a function to be called when all Ajax requests complete | 
| ajaxSuccess(function) |Registers a function to be called when an Ajax request succeeds |

These methods are used to register handler functions and must be applied to the document element

The ajaxStart and ajaxStop methods do not pass any arguments to handler functions, but the other methods provide the following arguments: An Event object describing the event A jqXHR object describing the request The settings object that contains the configuration for the request

The ajaxError method passes an additional argument to the handler function, which is the description of the error that has occurred.

the functions will be triggered for events from all Ajax requests,

you need to call these methods before you start making Ajax requests to ensure that the handler functions are properly triggered.

```JavaScript
$(document).ajaxStart(function() {
    displayMessage("Ajax Start")
}).ajaxSend(function(event, jqxhr, settings) {
    displayMessage("Ajax Send: " + settings.url)
}).ajaxSuccess(function(event, jqxhr, settings) {
    displayMessage("Ajax Success: " + settings.url)
}).ajaxError(function(event, jqxhr, settings, errorMsg) {
    displayMessage("Ajax Error: " + settings.url)
}).ajaxComplete(function(event, jqxhr, settings) {
    displayMessage("Ajax Complete: " + settings.url)
}).ajaxStop(function() {
    displayMessage("Ajax Stop")
});
```

##Controlling Global Events##

```JavaScript
$.ajax({
  url: "mydata.json",
  global: $("#globalevents:checked").length > 0,
```

When the global setting is false, the Ajax request doesn’t generate the global Ajax events.

##Configuring the Basic Settings for an Ajax Request##

There are a group of settings that allow you to perform basic configuration of the Ajax request. These are the least interesting of the settings available, and they are largely self-evident.

Table 15-7. Basic Request Configuration Settings

| Setting | Description |
|--|--|
| accepts | Sets the value of the Accept request header, which specifies the MIME types that the browser will accept. By default, this is determined by the dataType setting. |
| cache | If set to false, the content from the request will not be cached by the server. By default, the script and jsonp data types are not cached, but everything else is. |
| contentType | Sets the Content-Type header for the request. | 
| dataType | Specifies the data type that is expected from the server. When this setting is used, jQuery will ignore the information provided by the server about the response type. See Chapter 14 for details of how this works. |
| headers | Specifies additional headers and values to add to the request; see the following discussion for a demonstration. | 
| jsonp | Specifies a string to use instead of a callback when making JSONP requests. This requires coordination with the server. See Chapter 14 for details about JSONP. |
| jsonpCallback | Specifies the name for the callback function, replacing the randomly generated name that jQuery uses by default. See Chapter 14 for details of JSONP. |
| password | Specifies a password to use in response to an authentication challenge. |
| scriptCharset | When requesting JavaScript content, tells jQuery that the script is encoded with the specified character set. | 
| timeout | Specifies the timeout (in milliseconds) for the request. If the request times out, then the function specified by the error setting will be called with a status of timeout. |
| username |Specifies a username to use in response to an authentication challenge.|

##Setting Timeouts and Headers##

```JavaScript
$.ajax("mydata.json", {
  timeout: 5000,
  headers: { "X-HTTP-Method-Override": "PUT" },
```

> **Caution**  The timer starts as soon as the request is passed to the browser, and most browsers put limits on the number of concurrent requests. This means you run the risk of timing out requests before they even start. To avoid this, you must have some awareness of the limits of the browser and the volume and expected duration of any other Ajax requests that are in progress.

Additional headers are specified using a map object.

##Sending JSON Data to the Server##

When you need to send data to the server, you can do so using the JSON format: it is a compact and expressive data format and easy to generate from JavaScript objects.

```JavaScript

$.ajax({
  url: $("form").attr("action"),
  contentType: "application/json",
  data: JSON.stringify($("form").serializeArray()),
  type: "post",
```

have used the contentType setting to specify a value of application/json, which is the MIME type for JSON.

##Using Advanced Configuration Settings##

##Making the Request Synchronously##

The async property specifies whether the request will be performed asynchronously. Setting this property to true (which is the default value used if the property isn't defined) means that it will performed asynchronously; a value of false means that the request will be performed synchronously.

```JavaScript
$.ajax("flowers.html", {
  async: false,
  success: function(data, status, jqxhr) {
    elems = $(data).filter("div").addClass("dcell");
  }
});
```

##Ignoring Unmodified Data##

You can use the ifModified property to receive data only if the response has changed since the last time you queried it; this is determined by the Last-Modified header in the response.

The default value for this setting is false, which tells jQuery to ignore the header and always return the data.

```JavaScript
$.ajax("mydata.json", {
  ifModified: true,
  success: function (data, status) {
```

Dealing with the Response Status Code

The statusCode property allows you to respond to the different status codes that can be returned in HTTP responses.

```JavaScript
$.ajax({
  url: "mydata.json",
  statusCode: {
    200: handleSuccessfulRequest,
    404: handleFailedRequest,
    302: handleRedirect
  }
});
```

##Cleaning Up the Response Data##

The dataFilter property specifies a function that will be called to process the data returned by the server. This is a useful feature when the server sends you data that aren’t quite what you need, either because the formatting isn’t perfect or because it contains data that you don’t want processed.

```JavaScript
$.ajax({
  url: "mydata.json",
  success: function
```

```JavaScript
dataType: "json",
dataFilter: function (data, dataType) {
  if (dataType == "json") {
    var filteredData = $.parseJSON(data);
    filteredData.shift();
    return JSON.stringify(filteredData.reverse());
    } else {
      return data;
    }
  }
});
```

##Managing Data Conversion##

when jQuery receives some JSON data, it presents the success function with a JavaScript object, rather than the raw JSON string. You can control these conversions using the converters property.

The value for this setting is an object that maps between data types and functions that are used to process them.

```JavaScript
converters: {
  "text html": function(data) {
    return $(data);
  }
}
```

I registered a function for the text html type. Notice that you use a space between the components of the MIME type (as opposed to text/html).

> **Tip**  The data types don’t always match the MIME types that are returned by the server. For example, application/json is usually presented as "text json" to the converters method.

##Setting Up and Filtering Ajax Requests##

##Defining Default Settings##

The ajaxSetup method specifies settings that will be used for every Ajax request, freeing you from having to define all of the settings you are interested in for each and every request.

```JavaScript
$.ajaxSetup({
    timeout: 15000,
    global: false,
    error: function(jqxhr, status, errorMsg) {
        $("<div class=error/>").text("Status: " + status + " Error: " + errorMsg).insertAfter("h1");
    },
    converters: {
        "text html": function(data) {
            return $(data);
        }
    }
});
```

##Filtering Requests##

You can use the ajaxPrefilter method if you want to dynamically tailor the settings for individual requests,

```JavaScript
$.ajaxPrefilter("json html", function(settings, originalSettings, jqxhr) {
    if (originalSettings.dataType == "html") {
        settings.timeout = 2000;
    } else {
        jqxhr.abort();
    }
});
```

The arguments to the ajaxPrefilter method are a set of data types and a callback function that will be executed when a request for those data types is made. If you omit the data type and just specify the function, it will be invoked for all requests.

The arguments passed to the callback function are the settings for the request (which includes any defaults you have set using the ajaxSetup method); the original settings passed to the Ajax method (which excludes any default values) and the jqXHR object for the request. You make changes to the object passed as the first argument, as shown in the example.

#CHAPTER 34 Using the jQuery Utility Methods#

jQuery includes a number of utility methods that perform advanced operations on jQuery objects or which supplement the JavaScript language to provide features that are usually present in programing languages.

##Queues Revisited: Using General Purpose Queues##


Table 34-2. Queue Methods 

| Method | Description |
|--|--|
| clearQueue(<name>) | Removes any functions that have not yet been run in the specified queue. |
| queue(<name>) | Returns the specified queue of functions to be performed on the elements in the jQuery object.|
| queue(<name>, function) | Add a function to the end of the queue. |
| dequeue(<name>) | Removes and executes the first item in the queue for the elements in the jQuery object.|
| delay(<time>, <name>) | Insert a delay between effects in the specified queue.|

When these methods are used without specifying a queue name, jQuery defaults to fx, which is the queue for visual effects.

I can use any other queue name to create a queue of functions.

```JavaScript
$(document).ready(function() { 
    var elems = $("input"); 
    elems.queue("gen", function(next) {
        $(this).val(100).css("border", "thin red solid");
        next();
    }); 
    elems.delay(1000, "gen"); 
    elems.queue("gen", function(next) {
        $(this).val(0).css("border", "");
        $(this).dequeue("gen");
    }); 
    $("<button>Process Queue</button>").appendTo("#buttonDiv").click(function(e) {
        elems.dequeue("gen");
        e.preventDefault();
    }); 
});
```

In this example, I add three functions to a queue called gen that operates on the input elements in the document.

##Manually Processing Queue Items##

Of course, you don’t have to trigger one queued function from another – you could rely on an external trigger to dequeue each item, such as the user pressing the button I added to the document.

Listing 34-2.  Dequeuing Functions Explicitly

```JavaScript
$(document).ready(function() { 
    $("input").queue("gen", function() {
        $(this).val(100).css("border", "thin red solid");
    }).queue("gen", function() {
        $(this).val(0).css("border", "");
    }).queue("gen", function() {
        $(this).css("border", "thin blue solid");
        $("#dequeue").attr("disabled", "disabled");
    }); 
    $("<button id=dequeue>Dequeue Item</button>").appendTo("#buttonDiv").click(function(e) {
        $("input").dequeue("gen");
        e.preventDefault();
    });
});
```

##Utility Methods for Arrays##

Table 34-3. Utility Methods for Working with Arrays 

| Method | Description |
|--|--|
| $.grep(<array>, function), $.grep(<array>, function, <invert>) | Filters the contents of an array based on a function.|
| $.inArray(<value>, <array>) | Determines if a particular item in contained in an array.|
| $.map(<array>, function), $.map(<array>, <map>) | Projects an array or map object using a function. |
| $.merge(<array>, <array>) | Appends the contents of the second array to the first. |
| $.unique(HTMLElement[]) | Sorts an array of HTMLElement objects into document order and removes any duplicates.|

##Using the Grep Method##

The grep method allows us to find all of the elements in an array that are matched by a filter function.

```JavaScript
var filteredArray = $.grep(flowerArray, function(elem, index) {
  return elem.indexOf("p") > -1;
});
```

You can supply an additional argument to the grep method – if this argument is true, then the filtering process is inverted and the result contains those elements that the function filtered out.

```JavaScript
var filteredArray = $.grep(flowerArray, function(elem, index) {
  return elem.indexOf("p") > -1;
},true);
```

##Using the inArray Method##

The inArray method determines if an array contains a specified value – the method returns the index of the item if it is in the array and -1 otherwise.

```JavaScript
flowerArray));
```

##Using the Map Method##

The map method uses a function to project the contents of an array or a map object into a new array, using a function to determine how each item is represented in the result.

```JavaScript
var result = $.map(flowerArray, function(elem, index) {
  return index + ": " + elem;
});
```

You can use the map method to selectively project an array – there will be no corresponding item in the result if you don’t return a value from the function for the item being processed.

```JavaScript
var result = $.map(flowerArray, function(elem, index) {
  if (elem != "rose") {
    return index + ": " + elem;
  }
});
```

##Using the Merge Method##

```JavaScript
var flowerArray = ["aster", "daffodil", "rose", "peony", "primula", "snowdrop"];
var additionalFlowers = ["carnation", "lily", "orchid"];
$.merge(flowerArray, additionalFlowers);
```

The items from the second array are appended to the first array, and the array specified by the first argument is modified by the merge process.

##Using the Unique Method##

The unique method sorts an array of HTMLElement objects into the order in which they appear in the document and removes any duplicate elements.

```JavaScript
$.merge(selection, $("img[src*=aster]"));
```

The sorting process is done in-place, meaning that the array passed as the argument to the unique method is modified.

##Utility Methods for Types##

jQuery provides a set of methods that are useful for determining the nature of a JavaScript object

Table 34-4. Utility Methods for Working with Types

| Method | Description |
|--|--|
|$.isArray(Object) | Returns true if the object is an array. |
| $.isEmptyObject(Object) | Returns true if the object doesn’t define any methods or properties. |
| $.isFunction(Object) | Returns true if the object is a function. |
| $.isNumeric(Object) | Returns true if the object is a number. |
| $.isWindow(Object) | Returns true if the object is a Window. |
| $.isXMLDoc(Object) | Returns true if the object is an XML document. |
| $.type(Object) | Returns the built-in JavaScript type for the object.|

Most of these methods are simple – you pass an object to the method, which returns true if the object is of the type that the method detects and false otherwise.

```JavaScript
function myFunc() {
  console.log("Hello!");
}

console.log("IsFunction: " +$.isFunction(myFunc));
console.log("IsFunction: " +$.isFunction("hello"));
```

##Using the Type Method##

The type method is slightly different in that is returns the base JavaScript type of an object. The result will be one of the following strings: boolean number string function array date regexp object

```JavaScript
console.log("Type: " +$.type(jq));
```

##Utility Methods for Data##

jQuery defines a number of utility methods that can be useful for working with various kinds of data


Table 34-5. Utility Methods for Working with Data 

| Method | Description |
|--|--|
| serialize() | Encodes a set of form elements into a string suitable for submission to a server. |
| serializeArray() | Encodes a set of form elements into an array ready for encoding into JSON. |
| $.parseJSON(<json>) | Creates a JavaScript object from JSON data. |
| $.parseXML(<xml>) | Creates an XMLDocument object from an XML string. |
| $.trim(String) | Removes all whitespace from the beginning and end of a string.|

##Serializing Form Data##

The serialize and serializeArray methods are a convenient way to extract the details from a set of form elements in a way that is useful for regular or Ajax form submissions.

```JavaScript
var formArray = $("form").serializeArray();
console.log("JSON: " + JSON.stringify(formArray))

var formString = $("form").serialize();
console.log("String: " + formString)
```

##Parsing Data##

The parseJSON and parseXML methods are especially useful when dealing with the results of Ajax requests.

```JavaScript

var dataObject = $.parseJSON(jsonData)

for (var prop in dataObject) {
  console.log("Property: " + prop + " Value: " + dataObject[prop])
}

e.preventDefault();
```

##Trimming Strings##

The trim method removes all of the whitespace from the start and end of string – this includes spaces, tabs, and newlines.

```JavaScript
var resultString = $.trim(sourceString);
```

##Other Utility Methods##

There are a number of jQuery methods that don’t neatly fit into another category, but which can still be useful

Table 34-6. Other Utility Methods

| Method | Description |
|--|--|
|$.contains(HTMLElement, HTMLElement) | Returns true if the first element contains the second element. |
| $.now() | Returns the current time, shorthand for new Date().getTime().|

##Checking Element Containment##

The contains method checks to see if one element contains another. Both arguments are expressed as HTMLElement objects, and the method returns true if the element represented by the first argument contains the element represented by the second argument.

```JavaScript
($.contains(elem, this)) {
```

> **Tip**  This method only works on HTMLElement objects – if you want to perform the same check on jQuery objects, then consider using the find method,


##CHAPTER 36 Using Deferred Objects##

Deferred objects is the jQuery term for a set of enhancements to the way callbacks are used. When using deferred objects, callbacks can be used in any situation and not just for events; and they provide a lot of options and control over when and how callback functions are executed.