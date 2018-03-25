#1. Clean Code #

> LeBlanc’s law: Later equals never.

## What is clean code?

### Bjarne Stroustrup, inventor of C++

> I like my code to be elegant and efficient. The logic should be straightforward to make it hard for bugs to hide, the dependencies minimal to ease maintenance, error handling complete according to an articulated strategy, and performance close to optimal so as not to tempt people to make the code messy with unprincipled optimizations. Clean code does one thing well.

##Grady Booch, author of Object Oriented Analysis and Design with Applications

> Clean code is simple and direct. Clean code reads like well-written prose. Clean code never obscures the designer’s intent but rather is full of crisp abstractions and straightforward lines of control.

## Dave Thomas, founder of OTI, godfather of the Eclipse strategy

> Clean code can be read, and enhanced by a developer other than its original author. It has unit and acceptance tests. It has meaningful names. It provides one way rather than many ways for doing one thing. It has minimal dependencies, which are explicitly defined, and provides a clear and minimal API. Code should be literate since depending on the language, not all necessary information can be expressed clearly in code alone.

##Michael Feathers, author of Working Effectively with Legacy Code

> I could list all of the qualities that I notice in clean code, but there is one overarching quality that leads to all of them. Clean code always looks like it was written by someone who cares. There is nothing obvious that you can do to make it better. All of those things were thought about by the code’s author, and if you try to imagine improvements, you’re led back to where you are, sitting in appreciation of the code someone left for you—code left by someone who cares deeply about the craft.

## Ron Jeffries, author of Extreme Programming Installed and Extreme Programming Adventures in C#

> In recent years I begin, and nearly end, with Beck’s rules of simple code. In priority order, simple code: 
> • Runs all the tests; 
> • Contains no duplication; 
> • Expresses all the design ideas that are in the system; 
> • Minimizes the number of entities such as classes, methods, functions, and the like. 

>Of these, I focus mostly on duplication. When the same thing is done over and over, it’s a sign that there is an idea in our mind that is not well represented in the code. I try to figure out what it is. Then I try to express that idea more clearly. 

>Expressiveness to me includes meaningful names, and I am likely to change the names of things several times before I settle in. With modern coding tools such as Eclipse, renaming is quite inexpensive, so it doesn’t trouble me to change. Expressiveness goes beyond names, however. I also look at whether an object or method is doing more than one thing. If it’s an object, it probably needs to be broken into two or more objects. If it’s a method, I will always use the Extract Method refactoring on it, resulting in one method that says more clearly what it does, and some submethods saying how it is done. 

>Duplication and expressiveness take me a very long way into what I consider clean code, and improving dirty code with just these two things in mind can make a huge difference. There is, however, one other thing that I’m aware of doing, which is a bit harder to explain. 

>After years of doing this work, it seems to me that all programs are made up of very similar elements. One example is “find things in a collection.” Whether we have a database of employee records, or a hash map of keys and values, or an array of items of some kind, we often find ourselves wanting a particular item from that collection. When I find that happening, I will often wrap the particular implementation in a more abstract method or class. That gives me a couple of interesting advantages. 

> I can implement the functionality now with something simple, say a hash map, but since now all the references to that search are covered by my little abstraction, I can change the implementation any time I want. I can go forward quickly while preserving my ability to change later. 

> In addition, the collection abstraction often calls my attention to what’s “really” going on, and keeps me from running down the path of implementing arbitrary collection behavior when all I really need is a few fairly simple ways of finding what I want. 

>Reduced duplication, high expressiveness, and early building of simple abstractions. That’s what makes clean code for me.


## Ward Cunningham, inventor of Wiki, inventor of Fit, coinventor of eXtreme Programming. Motive force behind Design Patterns. Smalltalk and OO thought leader. The godfather of all those who care about code.

> You know you are working on clean code when each routine you read turns out to be pretty much what you expected. You can call it beautiful code when the code also makes it look like the language was made for the problem.


The next time you write a line of code, remember you are an author, writing for readers who will judge your effort.

Even when writing code the ratio of reading to writing code is very high, we want the reading of code to be easy, even if it makes the writing harder. Of course there’s no way to write code without reading it, so making it easy to read actually makes it easier to write.

## The Boy Scout Rule

If we all checked-in our code a little cleaner than when we checked it out, the code simply could not rot. The cleanup doesn’t have to be something big. Change one variable name for the better, break up one function that’s a little too large, eliminate one small bit of duplication, clean up one composite if statement.

Can you imagine working on a project where the code simply got better as time passed? Do you believe that any other option is professional? Indeed, isn’t continuous improvement an intrinsic part of professionalism?

#2. Meaningful Names #

##Use Intention-Revealing Names

The name of a variable, function, or class, should answer all the big questions. It should tell you why it exists, what it does, and how it is used. If a name requires a comment, then the name does not reveal its intent.

##Avoid Disinformation

Programmers must avoid leaving false clues that obscure the meaning of code.

##Make Meaningful Distinctions

Programmers create problems for themselves when they write code solely to satisfy a compiler or interpreter. For example, because you can’t use the same name to refer to two different things in the same scope, you might be tempted to change one name in an arbitrary way.

##Use Pronounceable Names

If you can’t pronounce it, you can’t discuss it without sounding like an idiot.

## Use Searchable Names

Single-letter names and numeric constants have a particular problem in that they are not easy to locate across a body of text.

##Avoid Encodings

We have enough encodings to deal with without adding more to our burden. Encoding type or scope information into names simply adds an extra burden of deciphering. It hardly seems reasonable to require each new employee to learn yet another encoding “language” in addition to learning the (usually considerable) body of code that they’ll be working in.

## Avoid Mental Mapping

Readers shouldn’t have to mentally translate your names into other names they already know. This problem generally arises from a choice to use neither problem domain terms nor solution domain terms.

## Class Names 

Classes and objects should have noun or noun phrase names like Customer, WikiPage, Account, and AddressParser. Avoid words like Manager, Processor, Data, or Info in the name of a class. A class name should not be a verb.

## Method Names

Methods should have verb or verb phrase names like postPayment, deletePage, or save. Accessors, mutators, and predicates should be named for their value and prefixed with get, set, and is

When constructors are overloaded, use static factory methods with names that describe the arguments. For example,    

```
Complex fulcrumPoint = Complex.FromRealNumber(23.0);
```

##Don’t Be Cute

If names are too clever, they will be memorable only to people who share the author’s sense of humor, and only as long as these people remember the joke.

##Pick One Word per Concept

Pick one word for one abstract concept and stick with it. For instance, it’s confusing to have fetch, retrieve, and get as equivalent methods of different classes.

The function names have to stand alone, and they have to be consistent in order for you to pick the correct method without any additional exploration.

## Don’t Pun

Avoid using the same word for two purposes. Using the same term for two different ideas is essentially a pun.

It might seem consistent because we have so many other add methods, but in this case, the semantics are different, so we should use a name like insert or append instead. To call the new method add would be a pun.

##Use Solution Domain Names

Remember that the people who read your code will be programmers. So go ahead and use computer science (CS) terms, algorithm names, pattern names, math terms, and so forth. It is not wise to draw every name from the problem domain because we don’t want our coworkers to have to run back and forth to the customer asking what every name means when they already know the concept by a different name.

## Use Problem Domain Names

When there is no “programmer-eese” for what you’re doing, use the name from the problem domain.

## Add Meaningful Context

There are a few names which are meaningful in and of themselves—most are not. Instead, you need to place names in context for your reader by enclosing them in well-named classes, functions, or namespaces.

But what if you just saw the state variable being used alone in a method? Would you automatically infer that it was part of an address?

Of course, a better solution is to create a class named Address. Then, even the compiler knows that the variables belong to a bigger concept.

## Don’t Add Gratuitous Context

Shorter names are generally better than longer ones, so long as they are clear. Add no more context to a name than is necessary.

The names accountAddress and customerAddress are fine names for instances of the class Address but could be poor names for classes. Address is a fine name for a class.

# 3. Functions

##Small! 

The first rule of functions is that they should be small


##Blocks and Indenting

This implies that the blocks within if statements, else statements, while statements, and so on should be one line long. Probably that line should be a function call. Not only does this keep the enclosing function small, but it also adds documentary value because the function called within the block can have a nicely descriptive name.

This also implies that functions should not be large enough to hold nested structures.

Therefore, the indent level of a function should not be greater than one or two. This, of course, makes the functions easier to read and understand.


##Do One Thing

FUNCTIONS SHOULD DO ONE THING. THEY SHOULD DO IT WELL. THEY SHOULD DO IT ONLY !!!

So, another way to know that a function is doing more than “one thing” is if you can extract another function from it with a name that is not merely a restatement of its implementation.

## Sections within Functions

Functions that do one thing cannot be reasonably divided into sections.

##One Level of Abstraction per Function

In order to make sure our functions are doing “one thing,” we need to make sure that the statements within our function are all at the same level of abstraction.

A very high level of abstraction, such as getHtml(); others that are at an intermediate level of abstraction, such as: String pagePathName = PathParser.render(pagePath); and still others that are remarkably low level, such as: .append(”\n”).

Mixing levels of abstraction within a function is always confusing. Readers may not be able to tell whether a particular expression is an essential concept or a detail.

##Reading Code from Top to Bottom: The Stepdown Rule

We want the code to read like a top-down narrative.5 We want every function to be followed by those at the next level of abstraction so that we can read the program, descending one level of abstraction at a time as we read down the list of functions. I call this The Step-down Rule.

## Switch Statements

It’s hard to make a small switch statement.Even a switch statement with only two cases is larger than I’d like a single block or function to be. It’s also hard to make a switch statement that does one thing.

By their nature, switch statements always do N things.

We can make sure that each switch statement is buried in a low-level class and is never repeated.

- http://en.wikipedia.org/wiki/Single_responsibility_principle
- http://www.objectmentor.com/resources/articles/srp.pdf
- http://en.wikipedia.org/wiki/Open/closed_principle
- http://www.objectmentor.com/resources/articles/ocp.pdf

My general rule for switch statements is that they can be tolerated if they appear only once, are used to create polymorphic objects, and are hidden behind an inheritance relationship so that the rest of the system can’t see them [G23]. Of course every circumstance is unique, and there are times when I violate one or more parts of that rule.

## Use Descriptive Names

It is hard to overestimate the value of good names.

Remember Ward’s principle: “You know you are working on clean code when each routine turns out to be pretty much what you expected.”

Don’t be afraid to make a name long.

Be consistent in your names. Use the same phrases, nouns, and verbs in the function names you choose for your modules.

Consider, for example, the names includeSetup-AndTeardownPages, includeSetupPages, includeSuiteSetupPage, and includeSetupPage. The similar phraseology in those names allows the sequence to tell a story.

## Function Arguments

The ideal number of arguments for a function is zero (niladic). Next comes one (monadic), followed closely by two (dyadic). Three arguments (triadic) should be avoided where possible. More than three (polyadic) requires very special justification—and then shouldn’t be used anyway.

Our readers would have had to interpret an argument each time they saw it in different methods. Setting arguments to class variables reduces this.

Arguments are even harder from a testing point of view. Imagine the difficulty of writing all the test cases to ensure that all the various combinations of arguments work properly.

With two arguments the problem gets a bit more challenging. With more than two arguments, testing every combination of appropriate values can be daunting.

Output arguments are harder to understand than input arguments. When we read a function, we are used to the idea of information going in to the function through arguments and out through the return value.

## Common Monadic Forms

There are two very common reasons to pass a single argument into a function. You may be asking a question about that argument, as in boolean fileExists(“MyFile”). Or you may be operating on that argument, transforming it into something else and returning it.

You should choose names that make the distinction clear, and always use the two forms in a consistent context.

A somewhat less common, but still very useful form for a single argument function, is an event. In this form there is an input argument but no output argument.

Use this form with care. It should be very clear to the reader that this is an event. Choose names and contexts carefully.

Using an output argument instead of a return value for a transformation is confusing. If a function is going to transform its input argument, the transformation should appear as the return value.

Indeed, StringBuffer transform(StringBuffer in) is better than void transform-(StringBuffer out), even if the implementation in the first case simply returns the input argument. At least it still follows the form of a transformation.


##Flag Arguments

It immediately complicates the signature of the method, loudly proclaiming that this function does more than one thing.

Mousing over render(boolean isSuite) helps a little, but not that much. We should have split the function into two: renderForSuite() and renderForSingleTest().

##Dyadic Functions

There are times, of course, where two arguments are appropriate. For example, Point p = new Point(0,0); is perfectly reasonable.

Even obvious dyadic functions like assertEquals(expected, actual) are problematic. How many times have you put the actual where the expected should be? The two arguments have no natural ordering. The expected, actual ordering is a convention that requires practice to learn.

##Triads 

Functions that take three arguments are significantly harder to understand than dyads.

##Argument Objects

When a function seems to need more than two or three arguments, it is likely that some of those arguments ought to be wrapped into a class of their own.

```
Circle makeCircle(double x, double y, double radius);
Circle makeCircle(Point center, double radius);
```

##Argument Lists

Functions that take variable arguments can be monads, dyads, or even triads. But it would be a mistake to give them more arguments than that.    

```
void monad(Integer… args);
void dyad(String name, Integer… args);
void triad(String name, int count, Integer… args);
```

##Verbs and Keywords

In the case of a monad, the function and argument should form a very nice verb/noun pair.

For example, write(name) is very evocative. Whatever this “name” thing is, it is being “written.” An even better name might be writeField(name), which tells us that the “name” thing is a “field.”

This last is an example of the keyword form of a function name. Using this form we encode the names of the arguments into the function name. For example, assertEquals might be better written as assertExpectedEqualsActual(expected, actual). This strongly mitigates the problem of having to remember the ordering of the arguments.

## Have No Side Effects

Side effects are lies. Your function promises to do one thing, but it also does other hidden things.

##Output Arguments


```
appendFooter(s);
```

It doesn’t take long to look at the function signature and see:    

```
public void appendFooter(StringBuffer report)
```

Anything that forces you to check the function signature is equivalent to a double-take. It’s a cognitive break and should be avoided.

In the days before object oriented programming it was sometimes necessary to have output arguments. However, much of the need for output arguments disappears in OO languages because this is intended to act as an output argument. In other words, it would be better for appendFooter to be invoked as:    

```
report.appendFooter();
```

In general output arguments should be avoided. If your function must change the state of something, have it change the state of its owning object.

## Command Query Separation

```
public boolean set(String attribute, String value);
```

```
if (set(”username”, ”unclebob”))…
```

It’s hard to infer the meaning from the call because it’s not clear whether the word “set” is a verb or an adjective.

The real solution is to separate the command from the query so that the ambiguity cannot occur.    

```
if (attributeExists(”username”)) {      
    setAttribute(”username”, ”unclebob”);
    …
}
```
 
##Prefer Exceptions to Returning Error Codes

Returning error codes from command functions is a subtle violation of command query separation.

It promotes commands being used as expressions in the predicates of if statements.

```
if (deletePage(page) == E_OK)
```

When you return an error code, you create the problem that the caller must deal with the error immediately.

If you use exceptions instead of returned error codes, then the error processing code can be separated from the happy path code and can be simplified:


##Extract Try/Catch Blocks

Try/catch blocks are ugly in their own right. They confuse the structure of the code and mix error processing with normal processing. So it is better to extract the bodies of the try and catch blocks out into functions of their own.

```
public void delete(Page page) {      
try {
    deletePageAndAllReferences(page);      
}      
    catch (Exception e) {        
    logError(e);      
    }    
}
```

## Error Handling Is One Thing

Functions should do one thing. Error handing is one thing. Thus, a function that handles errors should do nothing else.

###The Error.java Dependency Magnet

Returning error codes usually implies that there is some class or enum in which all the error codes are defined.    

```
public enum Error {
    OK,
    INVALID,       
    NO_SUCH, 
    LOCKED, 
    OUT_OF_RESOURCES,
    WAITING_FOR_EVENT;
}
``` 

Classes like this are a dependency magnet; many other classes must import and use them.

Thus, when the Error enum changes, all those other classes need to be recompiled and redeployed.

When you use exceptions rather than error codes, then new exceptions are derivatives of the exception class. They can be added without forcing any recompilation or redeployment. This is an example of the Open Closed Principle (OCP)

##Don’t Repeat Yourself

Duplication may be the root of all evil in software.

 
##Structured programming, 

Aspect Oriented Programming, Component Oriented Programming, are all, in part, strategies for eliminating duplication.

Structured Programming Some programmers follow Edsger Dijkstra’s rules of structured programming.14 Dijkstra said that every function, and every block within a function, should have one entry and one exit.

While we are sympathetic to the goals and disciplines of structured programming, those rules serve little benefit when functions are very small. It is only in larger functions that such rules provide significant benefit.

##Bibliography 

- Kernighan and Plaugher, The Elements of Programming Style, 2d. ed., McGraw-Hill, 1978. 
- Robert C. Martin, Agile Software Development: Principles, Patterns, and Practices, Prentice Hall, 2002. 
- Design Patterns: Elements of Reusable Object Oriented Software, Gamma et al., Addison-Wesley, 1996. 
- The Pragmatic Programmer, Andrew Hunt, Dave Thomas, Addison-Wesley, 2000
- Structured Programming, O.-J. Dahl, E. W. Dijkstra, C. A. R. Hoare, Academic Press, London, 1972.


#4. Comments


> Don’t comment bad code—rewrite it: Brian W. Kernighan and P. J. Plaugher.
 
Nothing can be quite so helpful as a well-placed comment

Comments are, at best, a necessary evil.

If our programming languages were expressive enough, or if we had the talent to subtly wield those languages to express our intent, we would not need comments very much—perhaps not at all.

So when you find yourself in a position where you need to write a comment, think it through and see whether there isn’t some way to turn the tables and express yourself in code. Every time you express yourself in code, you should pat yourself on the back. Every time you write a comment, you should grimace

The older a comment is, and the farther away it is from the code it describes, the more likely it is to be just plain wrong.

It is possible to make the point that programmers should be disciplined enough to keep the comments in a high state of repair, relevance, and accuracy. I agree, they should. But I would rather that energy go toward making the code so clear and expressive that it does not need the comments in the first place.

Truth can only be found in one place: the code.

##Comments Do Not Make Up for Bad Code

One of the more common motivations for writing comments is bad code.

Clear and expressive code with few comments is far superior to cluttered and complex code with lots of comments.

##Explain Yourself in Code

It takes only a few seconds of thought to explain most of your intent in code. In many cases it’s simply a matter of creating a function that says the same thing as the comment you want to write.

##Good Comments

###Legal Comments

Sometimes our corporate coding standards force us to write certain comments for legal reasons.

Where possible, refer to a standard license or other external document rather than putting all the terms and conditions into the comment.

###Informative Comments

It is sometimes useful to provide basic information with a comment. For example, consider this comment that explains the return value of an abstract method:    

```
// Returns an instance of the Responder being tested.    
protected abstract Responder responderInstance();
```

For example, in this case the comment could be made redundant by renaming the function:  responderBeingTested. 

Here’s a case that’s a bit better:    

```
// format matched kk:mm:ss EEE, MMM dd, yyyy    
Pattern timeMatcher = Pattern.compile(      “\\d*:\\d*:\\d* \\w*, \\w* \\d*, \\d*”);
```

Still, it might have been better, and clearer, if this code had been moved to a special class that converted the formats of dates and times. Then the comment would likely have been superfluous


###Explanation of Intent 

Sometimes a comment goes beyond just useful information about the implementation and provides the intent behind a decision.

###Clarification 

Sometimes it is just helpful to translate the meaning of some obscure argument or return value into something that’s readable.

###Warning of Consequences

Sometimes it is useful to warn other programmers about certain consequences.

```
// Don't run unless you    
// have some time to kill.    
public void _testWithReallyBigFile()
{
    writeLinesToFile(10000000);
}
```

###TODO Comments

It is sometimes reasonable to leave “To do” notes in the form of //TODO comments. In

###Amplification

A comment may be used to amplify the importance of something that may otherwise seem inconsequential.

###Javadocs in Public APIs

If you are writing a public API, then you should certainly write good javadocs for it.

But keep in mind the rest of the advice in this chapter. Javadocs can be just as misleading, nonlocal, and dishonest as any other kind of comment.

##Bad Comments

Most comments fall into this category. Usually they are crutches or excuses for poor code or justifications for insufficient decisions, amounting to little more than the programmer talking to himself.

###Mumbling

Plopping in a comment just because you feel you should or because the process requires it, is a hack. If you decide to write a comment, then spend the time necessary to make sure it is the best comment you can write.


###Redundant Comments

The comment probably takes longer to read than the code itself.

###Misleading Comments

Sometimes, with all the best intentions, a programmer makes a statement in his comments that isn’t precise enough to be accurate.

###Mandated Comments

It is just plain silly to have a rule that says that every function must have a javadoc, or every variable must have a comment.

Comments like this just clutter up the code, propagate lies, and lend to general confusion and disorganization.

###Journal Comments

Sometimes people add a comment to the start of a module every time they edit it.

Long ago there was a good reason to create and maintain these log entries at the start of every module. We didn’t have source code control systems that did it for us

###Noise Comments

```
/**      
    * Returns the day of the month.      
    *
    * @return the day of the month.
*/
public int getDayOfMonth()
{
    return dayOfMonth;
}
```

Replace the temptation to create noise with the determination to clean your code. You’ll find it makes you a better and happier programmer.

###Scary Noise

If authors aren’t paying attention when comments are written (or pasted), why should readers be expected to profit from them?

Don’t Use a Comment When You Can Use a Function or a Variable


###Position Markers

Sometimes programmers like to mark a particular position in a source file.

There are rare times when it makes sense to gather certain functions together beneath a banner like this. But in general they are clutter that should be eliminated—especially

###Closing Brace Comments

If you find yourself wanting to mark your closing braces, try to shorten your functions instead.

###Attributions and Bylines

Source code control systems are very good at remembering who added what, when. There is no need to pollute the code with little bylines.

###Commented-Out Code

Few practices are as odious as commenting-out code. Don’t do this!

There was a time, back in the sixties, when commenting-out code might have been useful. But we’ve had good source code control systems for a very long time now.

###HTML Comments

HTML in source code comments is an abomination, as you can tell by reading the code below. It makes the comments hard to read in the one place where they should be easy to read—the editor/IDE.

###Nonlocal Information

If you must write a comment, then make sure it describes the code it appears near. Don’t offer systemwide information in the context of a local comment.

Of course there is no guarantee that this comment will be changed when the code containing the default is changed.

###Too Much Information

Don’t put interesting historical discussions or irrelevant descriptions of details into your comments.

###Inobvious Connection

The connection between a comment and the code it describes should be obvious. If you are going to the trouble to write a comment, then at least you’d like the reader to be able to look at the comment and the code and understand what the comment is talking about.

The purpose of a comment is to explain code that does not explain itself.

It is a pity when a comment needs its own explanation.

###Function Headers

Short functions don’t need much description. A well-chosen name for a small function that does one thing is usually better than a comment header.

###Javadocs in Nonpublic Code

As useful as javadocs are for public APIs, they are anathema to code that is not intended for public consumption.

##Bibliography

- Kernighan and Plaugher, The Elements of Programming Style, 2d. ed., McGraw-Hill, 1978.

#5. Formatting {#Chapter4}

When people look under the hood, we want them to be impressed with the neatness, consistency, and attention to detail that they perceive.

You should take care that your code is nicely formatted. You should choose a set of simple rules that govern the format of your code, and then you should consistently apply those rules.

It helps to have an automated tool that can apply those formatting rules for you.


##The Purpose of Formatting

First of all, let’s be clear. Code formatting is important. It is too important to ignore and it is too important to treat religiously. Code formatting is about communication, and communication is the professional developer’s first order of business.

The functionality that you create today has a good chance of changing in the next release, but the readability of your code will have a profound effect on all the changes that will ever be made.

###Vertical Formatting

Small files are usually easier to understand than large files are.

###The Newspaper Metaphor

Think of a well-written newspaper article. You read it vertically.

As you continue downward, the details increase until you have all the dates, names, quotes, claims, and other minutia.

The name, by itself, should be sufficient to tell us whether we are in the right module or not. The topmost parts of the source file should provide the high-level concepts and algorithms.

Detail should increase as we move downward, until at the end we find the lowest level functions and details in the source file.

###Vertical Openness Between Concepts

Nearly all code is read left to right and top to bottom. Each line represents an expression or a clause, and each group of lines represents a complete thought. Those thoughts should be separated from each other with blank lines.

This extremely simple rule has a profound effect on the visual layout of the code. Each blank line is a visual cue that identifies a new and separate concept.

###Vertical Density

If openness separates concepts, then vertical density implies close association. So lines of code that are tightly related should appear vertically dense.

###Vertical Distance

Concepts that are closely related should be kept vertically close to each other [G10].

But then closely related concepts should not be separated into different files unless you have a very good reason. Indeed, this is one of the reasons that protected variables should be avoided.

Vertical separation should be a measure of how important each is to the understandability of the other. We want to avoid forcing our readers to hop around through our source files and classes.

####Variable Declarations.

Variables should be declared as close to their usage as possible. Because our functions are very short, local variables should appear a the top of each function,


####Control variables 

For loops should usually be declared within the loop statement.

In rare cases a variable might be declared at the top of a block or just before a loop in a long-ish function.


####Instance variables

On the other hand, instance variables should be declared at the top of the class.

This should not increase the vertical distance of these variables, because in a well-designed class, they are used by many, if not all, of the methods of the class.

####Dependent Functions. 

If one function calls another, they should be vertically close, and the caller should be above the callee, if at all possible. This gives the program a natural flow.

As an aside, this snippet provides a nice example of keeping constants at the appropriate level [G35]. The “FrontPage” constant could have been buried in the getPageNameOrDefault function, but that would have hidden a well-known and expected constant in an inappropriately low-level function. It was better to pass that constant down from the place where it makes sense to know it to the place that actually uses it.

###Conceptual Affinity.

Certain bits of code want to be near other bits. They have a certain conceptual affinity. The stronger that affinity, the less vertical distance there should be between them. Such as:

- One function calling another, or a function using a variable.
- A group of functions perform a similar operation.
- They share a common naming scheme and perform variations of the same basic task.

###Vertical Ordering

In general we want function call dependencies to point in the downward direction. That is, a function that is called should be below a function that does the calling.

###Horizontal Formatting

Programmers clearly prefer short lines.

The old Hollerith limit of 80 is a bit arbitrary, and I’m not opposed to lines edging out to 100 or even 120. But beyond that is probably just careless.

I personally set my limit at 120.

###Horizontal Openness and Density

We use horizontal white space to associate things that are strongly related and disassociate things that are more weakly related.

Surrounded the assignment operators with white space to accentuate them.

I didn’t put spaces between the function names and the opening parenthesis. This is because the function and its arguments are closely related.

I separate arguments within the function call parenthesis to accentuate the comma and show that the arguments are separate.

Another use for white space is to accentuate the precedence of operators.

```
return b*b - 4*a*c;
```

Notice how nicely the equations read. The factors have no white space between them because they are high precedence. The terms are separated by white space because addition and subtraction are lower precedence.

Unfortunately, most tools for reformatting code are blind to the precedence of operators and impose the same spacing throughout. So subtle spacings like those shown above tend to get lost after you reformat the code.

###Horizontal Alignment

If I have long lists that need to be aligned, the problem is the length of the lists, not the lack of alignment.

The length of declarations in a class suggests that this class should be split up.

###Indentation

This allows them to quickly hop over scopes, such as implementations of if or while statements, that are not relevant to their current situation.

Without indentation, programs would be virtually unreadable by humans.

###Breaking Indentation.

It is sometimes tempting to break the indentation rule for short if statements, short while loops, or short functions. Whenever I have succumbed to this temptation, I have almost always gone back and put the indentation back in.

###Dummy Scopes

Sometimes the body of a while or for statement is a dummy, as shown below. I don’t like these kinds of structures and try to avoid them.

```
while (dis.read(buf, 0, readBufferSize) != -1);
```

###Team Rules

Remember, a good software system is composed of a set of documents that read nicely. They need to have a consistent and smooth style.

#6. Objects and Data Structure


There is a reason that we keep our variables private. We don’t want anyone else to depend on them. We want to keep the freedom to change their type or implementation on a whim or an impulse

##Data Abstraction

It represents more than just a data structure. The methods enforce an access policy. You can read the individual coordinates independently, but you must set the coordinates together as an atomic operation.

```
public class Point
{
    public double x;
    public double y;
}
```

The above on the other hand, is very clearly implemented in rectangular coordinates, and it forces us to manipulate those coordinates independently. This exposes implementation.

Indeed, it would expose implementation even if the variables were private and we were using single variable getters and setters.

Hiding implementation is not just a matter of putting a layer of functions between the variables. Hiding implementation is about abstractions! A class does not simply push its variables out through getters and setters. Rather it exposes abstract interfaces that allow its users to manipulate the essence of the data, without having to know its implementation.

We do not want to expose the details of our data. Rather we want to express our data in abstract terms.

This is not merely accomplished by using interfaces and/or getters and setters. Serious thought needs to be put into the best way to represent the data that an object contains. The worst option is to blithely add getters and setters.

##Data/Object Anti-Symmetry

Objects hide their data behind abstractions and expose functions that operate on that data. Data structure expose their data and have no meaningful functions.

 So if I add a new shape, none of the existing functions are affected, but if I add a new function all of the shapes must be changed!

There are ways around this that are well known to experienced object-oriented designers: VISITOR, or dual-dispatch, for example. But these techniques carry costs of their own and generally return the structure to that of a procedural program.

Again, we see the complimentary nature of these two definitions; they are virtual opposites! This exposes the fundamental dichotomy between objects and data structures: 

> Procedural code (code using data structures) makes it easy to add new functions without changing the existing data structures. OO code, on the other hand, makes it easy to add new classes without changing existing functions. 

The complement is also true: 

> Procedural code makes it hard to add new data structures because all the functions must change. OO code makes it hard to add new functions because all the classes must change.

Mature programmers know that the idea that everything is an object is a myth. Sometimes you really do want simple data structures with procedures operating on them.

##The Law of Demeter

There is a well-known heuristic called the Law of Demeter2 that says a module should not know about the innards of the objects it manipulates.

This means that an object should not expose its internal structure through accessors because to do so is to expose, rather than to hide, its internal structure.

- http://en.wikipedia.org/wiki/Law_of_Demeter

More precisely, the Law of Demeter says that a method f of a class C should only call the methods of these: 
- C
- An object created by f
- An object passed as an argument to f
- An object held in an instance variable of C 

The method should not invoke methods on objects that are returned by any of the allowed functions. In other words, talk to friends, not to strangers.

```
final String outputDir = ctxt.getOptions().getScratchDir().getAbsolutePath();
```

This kind of code is often called a train wreck because it look like a bunch of coupled train cars.

It is usually best to split them up as follows:    

```
Options opts = ctxt.getOptions();    
File scratchDir = opts.getScratchDir();    
final String outputDir = scratchDir.getAbsolutePath()
```

Whether this is a violation of Demeter depends on whether or not ctxt, Options, and ScratchDir are objects or data structures. If they are objects, then their internal structure should be hidden rather than exposed, and so knowledge of their innards is a clear violation of the Law of Demeter. On the other hand, if ctxt, Options, and ScratchDir are just data structures with no behavior, then they naturally expose their internal structure, and so Demeter does not apply.

If the code had been written as follows, then we probably wouldn’t be asking about Demeter violations.    

```
final String outputDir = ctxt.options.scratchDir.absolutePath; 
```
This issue would be a lot less confusing if data structures simply had public variables and no functions, whereas objects had private variables and public functions.

##Hybrids

This confusion sometimes leads to unfortunate hybrid structures that are half object and half data structure.

They have functions that do significant things, and they also have either public variables or public accessors and mutators that, for all intents and purposes, make the private variables public, tempting other external functions to use those variables the way a procedural program would use a data structure. This is sometimes called Feature Envy from [Refactoring].

Such hybrids make it hard to add new functions but also make it hard to add new data structures. They are the worst of both worlds.


##Hiding Structure 

What if ctxt, options, and scratchDir are objects with real behavior? Then, because objects are supposed to hide their internal structure, we should not be able to navigate through them.

Consider this code from (many lines farther down in) the same module:    

```
String outFile = outputDir + “/” + className.replace('.', '/') + “.class”;    
FileOutputStream fout = new FileOutputStream(outFile);    
BufferedOutputStream bos = new BufferedOutputStream(fout); 
```
The admixture of different levels of detail is a bit troubling. Dots, slashes, file extensions, and File objects should not be so carelessly mixed together, and mixed with the enclosing code.

So, what if we told the ctxt object to do this?    

```
BufferedOutputStream bos = ctxt.createScratchFileStream(classFileName); 
```

That seems like a reasonable thing for an object to do! This allows ctxt to hide its internals and prevents the current function from having to violate the Law of Demeter by navigating through objects it shouldn’t know about.

##Data Transfer Objects

The quintessential form of a data structure is a class with public variables and no functions. This is sometimes called a data transfer object, or DTO.

They often become the first in a series of translation stages that convert raw data in a database into objects in the application code.

Somewhat more common is the “bean” form shown in Listing 6-7. Beans have private variables manipulated by getters and setters. The quasi-encapsulation of beans seems to make some OO purists feel better but usually provides no other benefit.

```
public class Address {

    private String street;      
    private String streetExtra;      
    private String city;      
    private String state;      
    private String zip;      

    public Address(
        String street, 
        StringstreetExtra,                      
        String city, 
        String state, 
        String zip) 
    {        
        this.street = street;        
        this.streetExtra = streetExtra;        
        this.city = city;        
        this.state = state;        
        this.zip = zip;      
    }      
  
    public String getStreet() 
    {        
        return street;
    }

// other public accessors
```

##Active Record 

Active Records are special forms of DTOs. They are data structures with public (or bean-accessed) variables; but they typically have navigational methods like save and find. Typically these Active Records are direct translations from database tables, or other data sources.

Unfortunately we often find that developers try to treat these data structures as though they were objects by putting business rule methods in them. This is awkward because it creates a hybrid between a data structure and an object.

##Conclusion 

Objects expose behavior and hide data. This makes it easy to add new kinds of objects without changing existing behaviors. It also makes it hard to add new behaviors to existing objects. Data structures expose data and have no significant behavior. This makes it easy to add new behaviors to existing data structures but makes it hard to add new data structures to existing functions. In any given system we will sometimes want the flexibility to add new data types, and so we prefer objects for that part of the system. Other times we will want the flexibility to add new behaviors, and so in that part of the system we prefer data types and procedures. Good software developers understand these issues without prejudice and choose the approach that is best for the job at hand.


##Bibliography 

- Refactoring: Improving the Design of Existing Code, Martin Fowler et al., Addison-Wesley, 1999.


# 7. Error Handling

I mean that it is nearly impossible to see what the code does because of all of the scattered error handling. Error handling is important, but if it obscures logic, it’s wrong.

##Use Exceptions Rather Than Return Codes

You either set an error flag or returned an error code that the caller could check.

The problem with these approaches is that they clutter the caller. The caller must check for errors immediately after the call.

Unfortunately, it’s easy to forget. For this reason it is better to throw an exception when you encounter an error. The calling code is cleaner. Its logic is not obscured by error handling.

```
public void sendShutDown() {
    try {
        tryToShutDown();
    } catch (DeviceShutDownError e)
    {
        logger.log(e);
    }
}
```

The code is better because two concerns that were tangled, the algorithm for device shutdown and error handling, are now separated. You can look at each of those concerns and understand them independently.

##Write Your Try-Catch-Finally Statement First

One of the most interesting things about exceptions is that they define a scope within your program. When you execute code in the try portion of a try-catch-finally statement, you are stating that execution can abort at any point and then resume at the catch.

In a way, try blocks are like transactions.

Try to write tests that force exceptions, and then add behavior to your handler to satisfy your tests.

This will cause you to build the transaction scope of the try block first and will help you maintain the transaction nature of that scope.

##Use Unchecked Exceptions

What price? The price of checked exceptions is an Open/Closed Principle1 violation. If you throw a checked exception from a method in your code and the catch is three levels above, you must declare that exception in the signature of each method between you and the catch. This means that a change at a low level of the software can force signature changes on many higher levels.

One of the lowest level functions is modified in such a way that it must throw an exception.

The net result is a cascade of changes that work their way from the lowest levels of the software to the highest!

Encapsulation is broken because all functions in the path of a throw must know about details of that low-level exception.

Given that the purpose of exceptions is to allow you to handle errors at a distance, it is a shame that checked exceptions break encapsulation in this way.

##Provide Context with Exceptions

Each exception that you throw should provide enough context to determine the source and location of an error. In Java, you can get a stack trace from any exception; however, a stack trace can’t tell you the intent of the operation that failed. Create informative error messages and pass them along with your exceptions. Mention the operation that failed and the type of failure.

If you are logging in your application, pass along enough information to be able to log the error in your catch.

##Define Exception Classes in Terms of a Caller’s Needs

There are many ways to classify errors. We can classify them by their source:

When we define exception classes in an application, our most important concern should be how they are caught.

We know that the work that we are doing is roughly the same regardless of the exception, we can simplify our code considerably by wrapping the API that we are calling and making sure that it returns a common exception type:

```
LocalPort port = new LocalPort(12);
try {
    port.open();
} catch (PortDeviceFailure e) {
    reportError(e);
    logger.log(e.getMessage(), e);
} finally {
      …
}
```

```
public class LocalPort {
    private ACMEPort innerPort;

    public LocalPort(int portNumber) {
        innerPort = new ACMEPort(portNumber);
    }

    public void open() {
        try {
            innerPort.open();        
        } catch (DeviceResponseException e) {          
            throw new PortDeviceFailure(e);       
        } catch (ATM1212UnlockedException e) {
            throw new PortDeviceFailure(e);        
        } catch (GMXError e) {
            throw new PortDeviceFailure(e);
        }
   }
   …
}
```

Wrappers like the one we defined for ACMEPort can be very useful. In fact, wrapping third-party APIs is a best practice. When you wrap a third-party API, you minimize your dependencies upon it: You can choose to move to a different library in the future without much penalty. Wrapping also makes it easier to mock out third-party calls when you are testing your own code.

One final advantage of wrapping is that you aren’t tied to a particular vendor’s API design choices. You can define an API that you feel comfortable with.

Often a single exception class is fine for a particular area of code. The information sent with the exception can distinguish the errors.

Use different classes only if there are times when you want to catch one exception and allow the other one to pass through.

## Define the Normal Flow

If you follow the advice in the preceding sections, you’ll end up with a good amount of separation between your business logic and your error handling.

Most of the time this is a great approach, but there are some times when you may not want to abort.

```
try {
    MealExpenses expenses = expenseReportDAO.getMeals(employee.getID());
    m_total += expenses.getTotal();
} catch(MealExpensesNotFound e) {
    m_total += getMealPerDiem();
}
```

The exception clutters the logic.

```
MealExpenses expenses = expenseReportDAO.getMeals(employee.getID());
m_total += expenses.getTotal();
```

We can change the ExpenseReportDAO so that it always returns a MealExpense object. If there are no meal expenses, it returns a MealExpense object that returns the per diem as its total:

```
public class PerDiemMealExpenses implements MealExpenses {
    public int getTotal() {
    // return the per diem default
    }
} 
```

This is called the SPECIAL CASE PATTERN [Fowler]. You create a class or configure an object so that it handles a special case for you. When you do, the client code doesn’t have to deal with exceptional behavior. That behavior is encapsulated in the special case object.

##Don’t Return Null

When we return null, we are essentially creating work for ourselves and foisting problems upon our callers.

If you are tempted to return null from a method, consider throwing an exception or returning a SPECIAL CASE object instead.

We can return null, but does it have to? If we change getEmployee so that it returns an empty list, we can clean up the code:

Fortunately, Java has Collections.emptyList(), and it returns a predefined immutable list that we can use for this purpose:    

```
public List<Employee> getEmployees() {
    if( .. there are no employees .. )        
        return Collections.emptyList();    
}
```

##Don’t Pass Null

Returning null from methods is bad, but passing null into methods is worse.

There is another alternative. We could use a set of assertions:    

```
public class MetricsCalculator
{
    public double xProjection(Point p1, Point p2)
    {
        assert p1 != null : “p1 should not be null”;        
        assert p2 != null : “p2 should not be null”;        
        return (p2.x – p1.x) * 1.5;
    }
}
```

It’s good documentation, but it doesn’t solve the problem. If someone passes null, we’ll still have a runtime error.

The rational approach is to forbid passing null by default. When you do, you can code with the knowledge that a null in an argument list is an indication of a problem, and end up with far fewer careless mistakes.

## Bibliography

- Agile Software Development: Principles, Patterns, and Practices, Robert C. Martin, Prentice Hall, 2002.



# 8. Boundaries 

By James Grenning 

We seldom control all the software in our systems.

##Using Third-Party Code

There is a natural tension between the provider of an interface and the user of an interface. Providers of third-party packages and frameworks strive for broad applicability so they can work in many environments and appeal to a wide audience. Users, on the other hand, want an interface that is focused on their particular needs.

```
public class Sensors {
    private Map sensors = new HashMap();      
    public Sensor getById(String id) {
        return (Sensor) sensors.get(id);
}
//snip
```

The interface at the boundary (Map) is hidden. It is able to evolve with very little impact on the rest of the application. The use of generics is no longer a big issue because the casting and type management is handled inside the Sensors class. This interface is also tailored and constrained to meet the needs of the application. It results in code that is easier to understand and harder to misuse. The Sensors class can enforce design and business rules.

We are not suggesting that every use of Map be encapsulated in this form. Rather, we are advising you not to pass Maps (or any other interface at a boundary) around your system.

If you use a boundary interface like Map, keep it inside the class, or close family of classes, where it is used. Avoid returning it from, or accepting it as an argument to, public APIs.

##Exploring and Learning Boundaries

It’s not our job to test the third-party code, but it may be in our best interest to write tests for the third-party code we use.

We would not be surprised to find ourselves bogged down in long debugging sessions trying to figure out whether the bugs we are experiencing are in our code or theirs.

Learning the third-party code is hard. Integrating the third-party code is hard too. Doing both at the same time is doubly hard.

Instead of experimenting and trying out the new stuff in our production code, we could write some tests to explore our understanding of the third-party code. Jim Newkirk calls such tests learning tests.1

In learning tests we call the third-party API, as we expect to use it in our application. We’re essentially doing controlled experiments that check our understanding of that API.

Now we know how to get a simple console logger initialized, and we can encapsulate that knowledge into our own logger class so that the rest of our application is isolated from the log4j boundary interface.

##Learning Tests Are Better Than Free

The learning tests end up costing nothing. We had to learn the API anyway, and writing those tests was an easy and isolated way to get that knowledge.

Not only are learning tests free, they have a positive return on investment. When there are new releases of the third-party package, we run the learning tests to see whether there are behavioral differences.

They will fix bugs and add new capabilities. With each release comes new risk. If the third-party package changes in some way incompatible with our tests, we will find out right away.

##Using Code That Does Not Yet Exist

There is another kind of boundary, one that separates the known from the unknown. There are often places in the code where our knowledge seems to drop off the edge.

In Figure 8-2, you can see that we insulated the CommunicationsController classes from the transmitter API (which was out of our control and undefined). By using our own application specific interface, we kept our CommunicationsController code clean and expressive.

Once the transmitter API was defined, we wrote the TransmitterAdapter to bridge the gap.

The ADAPTER encapsulated the interaction with the API and provides a single place to change when the API evolves.

This design also gives us a very convenient seam3 in the code for testing. Using a suitable FakeTransmitter, we can test the CommunicationsController classes.

##Clean Boundaries

Good software designs accommodate change without huge investments and rework.

Code at the boundaries needs clear separation and tests that define expectations.

We should avoid letting too much of our code know about the third-party particulars.

We manage third-party boundaries by having very few places in the code that refer to them.

We may wrap them as we did with Map, or we may use an ADAPTER to convert from our perfect interface to the provided interface.

Either way our code speaks to us better, promotes internally consistent usage across the boundary, and has fewer maintenance points when the third-party code changes.

##Bibliography 

- Test Driven Development, Kent Beck, Addison-Wesley, 2003
- Design Patterns: Elements of Reusable Object Oriented Software, Gamma et al., Addison-Wesley, 1996
- Working Effectively with Legacy Code, Addison-Wesley, 2004

#9. Unit Tests {#Chapter9}

In the mad rush to add testing to our discipline, many programmers have missed some of the more subtle, and important, points of writing good tests.

##The Three Laws of TDD

Consider the following three laws:1 1. 

- Professionalism and Test-Driven Development, Robert C. Martin, Object Mentor, IEEE Software, May/June 2007 (Vol. 24, No. 3) pp. 32–36 
	- http://doi.ieeecomputersociety.org/10.1109/MS.2007.85

**First Law** You may not write production code until you have written a failing unit test.
 
**Second Law** You may not write more of a unit test than is sufficient to fail, and not compiling is failing. 

**Third Law** You may not write more production code than is sufficient to pass the currently failing test.

These three laws lock you into a cycle that is perhaps thirty seconds long. The tests and the production code are written together, with the tests just a few seconds ahead of the production code.

The sheer bulk of those tests, which can rival the size of the production code itself, can present a daunting management problem.

##Keeping Tests Clean

What this team did not realize was that having dirty tests is equivalent to, if not worse than, having no tests. The problem is that tests must change as the production code evolves.

The dirtier the tests, the harder they are to change. The more tangled the test code, the more likely it is that you will spend more time cramming new tests into the suite than it takes to write the new production code.

From release to release the cost of maintaining my team’s test suite rose. Eventually it became the single biggest complaint among the developers.

They stopped cleaning their production code because they feared the changes would do more harm than good. Their production code began to rot. In the end they were left with no tests, tangled and bug-riddled production code, frustrated customers, and the feeling that their testing effort had failed them.

The moral of the story is simple: Test code is just as important as production code. It is not a second-class citizen. It requires thought, design, and care. It must be kept as clean as production code.

##Tests Enable the -ilities

It is unit tests that keep our code flexible, maintainable, and reusable. If you have tests, you do not fear making changes to the code! Without tests every change is a possible bug.

But with tests that fear virtually disappears. The higher your test coverage, the less your fear. You can make changes with near impunity to code that has a less than stellar architecture and a tangled and opaque design. Indeed, you can improve that architecture and design without fear!

##Clean Tests

Readability is perhaps even more important in unit tests than it is in production code.

The same thing that makes all code readable: clarity, simplicity, and density of expression.

In a test you want to say a lot with as few expressions as possible.

In the end, this code was not designed to be read. The poor reader is inundated with a swarm of details that must be understood before the tests make any real sense.

The BUILD-OPERATE-CHECK pattern is made obvious by the structure of these tests.

The first part builds up the test data, the second part operates on that test data, and the third part checks that the operation yielded the expected results.

- http://fitnesse.org/FitNesse.AcceptanceTestPatterns

Notice that the vast majority of annoying detail has been eliminated. The tests get right to the point and use only the data types and functions that they truly need.

###Domain-Specific Testing Language

The tests in Listing 9-2 demonstrate the technique of building a domain-specific language for your tests. Rather than using the APIs that programmers use to manipulate the system, we build up a set of functions and utilities that make use of those APIs and that make the tests more convenient to write and easier to read.

These functions and utilities become a specialized API used by the tests.

This testing API is not designed up front; rather it evolves from the continued refactoring of test code that has gotten too tainted by obfuscating detail.

###A Dual Standard

The code within the testing API does have a different set of engineering standards than production code. It must still be simple, succinct, and expressive, but it need not be as efficient as production code.

That is the nature of the dual standard. There are things that you might never do in a production environment that are perfectly fine in a test environment.

##One Assert per Test

Those tests come to a single conclusion that is quick and easy to understand.

See Dave Astel’s blog entry: http://www.artima.com/weblogs/viewpost.jsp?thread=35578

Notice that I have changed the names of the functions to use the common given-when-then convention.

Unfortunately, splitting the tests as shown results in a lot of duplicate code.

We can eliminate the duplication by using the TEMPLATE METHOD pattern and putting the given/when parts in the base class, and the then parts in different derivatives.

Or we could create a completely separate test class and put the given and when parts in the @Before function, and the when parts in each @Test function.

But this seems like too much mechanism for such a minor issue. In the end, I prefer the multiple asserts.

I think the single assert rule is a good guideline.7 I usually try to create a domain-specific testing language that supports

But I am not afraid to put more than one assert in a test. I think the best thing we can say is that the number of asserts in a test ought to be minimized.

##Single Concept per Test

Perhaps a better rule is that we want to test a single concept in each test function.

So probably the best rule is that you should minimize the number of asserts per concept and test just one concept per test function.

## F.I.R.S.T.

Object Mentor Training Materials. 

Clean tests follow five other rules that form the above acronym:

**Fast** Tests should be fast.

**Independent** Tests should not depend on each other. One test should not set up the conditions for the next test. You should be able to run each test independently and run the tests in any order you like. Cascading of downstream failures, making diagnosis difficult and hiding downstream defects.

**Repeatable** Tests should be repeatable in any environment. You should be able to run the tests in the production environment, in the QA environment, and on your laptop while riding home on the train without a network.

**Self-Validating** The tests should have a boolean output. Either they pass or fail.

**Timely** The tests need to be written in a timely fashion. Unit tests should be written just before the production code that makes them pass. If you write tests after the production code, then you may find the production code to be hard to test. You may decide that some production code is too hard to test. You may not design the production code to be testable.

##Bibliography

- Behavior Driven Development for Ruby Programmers, Aslak Hellesøy, David Chelimsky, Pragmatic Bookshelf, 2008. 
- Design Patterns: Elements of Reusable Object Oriented Software, Gamma et al., Addison-Wesley, 1996.

#10. Classes 

By Jeff Langr.


##Class Organization

Following the standard Java convention, a class should begin with a list of variables. Public static constants, if any, should come first. Then private static variables, followed by private instance variables. There is seldom a good reason to have a public variable.

Public functions should follow the list of variables. We like to put the private utilities called by a public function right after the public function itself. This follows the stepdown rule and helps the program read like a newspaper article.

##Encapsulation 

We like to keep our variables and utility functions private, but we’re not fanatic about it.

Sometimes we need to make a variable or utility function protected so that it can be accessed by a test.

For us, tests rule. If a test in the same package needs to call a function or access a variable, we’ll make it protected or package scope. However, we’ll first look for a way to maintain privacy. Loosening encapsulation is always a last resort.

##Classes Should Be Small!

The first rule of classes is that they should be small.

With functions we measured size by counting physical lines. With classes we use a different measure. We count responsibilities.

The name of a class should describe what responsibilities it fulfills. In fact, naming is probably the first way of helping determine class size. If we cannot derive a concise name for a class, then it’s likely too large. The more ambiguous the class name, the more likely it has too many responsibilities. For example, class names including weasel words like Processor or Manager or Super often hint at unfortunate aggregation of responsibilities.

We should also be able to write a brief description of the class in about 25 words, without using the words “if,” “and,” “or,” or “but.”

##The Single Responsibility Principle

The Single Responsibility Principle (SRP) states that a class or module should have one, and only one, reason to change.

At the same time, many developers fear that a large number of small, single-purpose classes makes it more difficult to understand the bigger picture. They are concerned that they must navigate from class to class in order to figure out how a larger piece of work gets accomplished. However, a system with many small classes has no more moving parts than a system with a few large classes.

The primary goal in managing such complexity is to organize it so that a developer knows where to look to find things and need only understand the directly affected complexity at any given time.

Each small class encapsulates a single responsibility, has a single reason to change, and collaborates with a few others to achieve the desired system behaviors.

##Cohesion 

Classes should have a small number of instance variables. Each of the methods of a class should manipulate one or more of those variables.

In general the more variables a method manipulates the more cohesive that method is to its class. A class in which each variable is used by each method is maximally cohesive.

In general it is neither advisable nor possible to create such maximally cohesive classes; on the other hand, we would like cohesion to be high. When cohesion is high, it means that the methods and variables of the class are co-dependent and hang together as a logical whole.

The strategy of keeping functions small and keeping parameter lists short can sometimes lead to a proliferation of instance variables that are used by a subset of methods. When this happens, it almost always means that there is at least one other class trying to get out of the larger class.

##Maintaining Cohesion Results in Many Small Classes

So breaking a large function into many smaller functions often gives us the opportunity to split several smaller classes out as well. This gives our program a much better organization and a more transparent structure.

> Knuth’s wonderful book Literate Programming.

##Organizing for Change

Any modifications to the class have the potential of breaking other code in the class.

The code in each class becomes excruciatingly simple. Our required comprehension time to understand any class decreases to almost nothing. The risk that one function could break another becomes vanishingly small.

From a test standpoint, it becomes an easier task to prove all bits of logic in this solution, as the classes are all isolated from one another.

Equally important, when it’s time to add the update statements, none of the existing classes need change!

Our restructured Sql logic represents the best of all worlds. It supports the SRP. It also supports another key OO class design principle known as the Open-Closed Principle, or OCP: Classes should be open for extension but closed for modification.

In an ideal system, we incorporate new features by extending the system, not by making modifications to existing code.

##Isolating from Change

We learned in OO 101 that there are concrete classes, which contain implementation details (code), and abstract classes, which represent concepts only. A client class depending upon concrete details is at risk when those details change. We can introduce interfaces and abstract classes to help isolate the impact of those details.

We design TokyoStockExchange to implement this interface. We also make sure that the constructor of Portfolio takes a StockExchange reference as an argument:

If a system is decoupled enough to be tested in this way, it will also be more flexible and promote more reuse.

The lack of coupling means that the elements of our system are better isolated from each other and from change.

By minimizing coupling in this way, our classes adhere to another class design principle known as the Dependency Inversion Principle (DIP).

In essence, the DIP says that our classes should depend upon abstractions, not on concrete details.

##Bibliography 

 - Object Design: Roles, Responsibilities, and Collaborations, Rebecca Wirfs-Brock et al., Addison-Wesley, 2002
 - Agile Software Development: Principles, Patterns, and Practices, Robert C. Martin, Prentice Hall, 2002
 - Literate Programming, Donald E. Knuth, Center for the Study of language and Information, Leland Stanford Junior University, 1992

#11. Systems {#Chapter11}

By Dr. Kevin Dean Wampler

##Separate Constructing a System from Using It

>Software systems should separate the startup process, when the application objects are constructed and the dependencies are “wired” together, from the runtime logic that takes over after startup.

New'ing up a class causes a a hard-coded dependency upon that object.

Testing can be a problem. If MyServiceImpl is a heavyweight object, we will need to make sure that an appropriate TEST DOUBLE1 or MOCK OBJECT gets assigned to the service field before this method is called during unit testing.

Hence, the global setup strategy (if there is one) is scattered across the application, with little modularity and often significant duplication.

The startup process of object construction and wiring is no exception. We should modularize this process separately from the normal runtime logic and we should make sure that we have a global, consistent strategy for resolving our major dependencies

##Separation of Main

One way to separate construction from use is simply to move all aspects of construction to main, or modules called by main, and to design the rest of the system assuming that all objects have been constructed and wired up appropriately.

Notice the direction of the dependency arrows crossing the barrier between main and the application. They all go one direction, pointing away from main.

This means that the application has no knowledge of main or of the construction process. It simply expects that everything has been built properly.

##Factories

Sometimes, of course, we need to make the application responsible for when an object gets created.Read more at location 3731

In this case we can use the ABSTRACT FACTORY pattern to give the application control of when to build the LineItems, but keep the details of that construction separate from the application code.

Again notice that all the dependencies point from main toward the OrderProcessing application. This means that the application is decoupled from the details of how to build a LineItem.

## Dependency Injection 

A powerful mechanism for separating construction from use is Dependency Injection (DI), the application of Inversion of Control (IoC) to dependency management.

JNDI lookups are a “partial” implementation of DI, where an object asks a directory server to provide a “service” matching a particular name.    

```
MyService myService = (MyService)(jndiContext.lookup(“NameOfMyService”)); 
```


The invoking object doesn’t control what kind of object is actually returned (as long it implements the appropriate interface, of course), but the invoking object still actively resolves the dependency. 

True Dependency Injection goes one step further.

## Scaling Up

> Software systems are unique compared to physical systems. Their architectures can grow incrementally, ifwe maintain the proper separation of concerns.

## Cross-Cutting Concerns

Note that concerns like persistence tend to cut across the natural object boundaries of a domain.

##Pure Java AOP Frameworks

Fortunately, most of the proxy boilerplate can be handled automatically by tools.

The client believes it is invoking getAccounts() on a Bank object, but it is actually talking to the outermost of a set of nested DECORATOR14 objects that extend the basic behavior of the Bank POJO.

##Test Drive the System Architecture

To recap this long discussion, 

> An optimal system architecture consists of modularized domains of concern, each of which is implemented with Plain Old Java (or other) Objects. The different domains are integrated together with minimally invasive Aspects or Aspect-like tools. This architecture can be test-driven, just like the code.

##Optimize Decision Making

> The agility provided by a POJO system with modularized concerns allows us to make optimal, just-in-time decisions, based on the most recent knowledge. The complexity of these decisions is also reduced.

##Use Standards Wisely, When They Add Demonstrable Value

Standards make it easier to reuse ideas and components, recruit people with relevant experience, encapsulate good ideas, and wire components together. However, the process of creating standards can sometimes take too long for industry to wait, and some standards lose touch with the real needs of the adopters they are intended to serve.

##Systems Need Domain-Specific Languages

Domain-Specific Languages (DSLs), which are separate, small scripting languages or APIs in standard languages that permit code to be written so that it reads like a structured form of prose that a domain expert might write.

A good DSL minimizes the “communication gap” between a domain concept and the code that implements it, just as agile practices optimize the communications within a team and with the project’s stakeholders.

DSLs, when used effectively, raise the abstraction level above code idioms and design patterns. They allow the developer to reveal the intent of the code at the appropriate level of abstraction.

> Domain-Specific Languages allow all levels of abstraction and all domains in the application to be expressed as POJOs, from high-level policy to low-level details.

##Bibliography 

- [Alexander]: Christopher Alexander, A Timeless Way of Building, Oxford University Press, New York, 1979. 
- [AOSD]: Aspect-Oriented Software Development port, http://aosd.net
- [ASM]: ASM Home Page, http://asm.objectweb.org/ [AspectJ]: http://eclipse.org/aspectj 
- [CGLIB]: Code Generation Library, http://cglib.sourceforge.net/ 
- [Colyer]: Adrian Colyer, Andy Clement, George Hurley, Mathew Webster, Eclipse AspectJ, Person Education, Inc., Upper Saddle River, NJ, 2005. 
- [DSL]: Domain-specific programming language, http://en.wikipedia.org/wiki/Domain-specific_programming_language 
- [Fowler]: Inversion of Control Containers and the Dependency Injection pattern, http://martinfowler.com/articles/injection.html 
- [Goetz]: Brian Goetz, Java Theory and Practice: Decorating with Dynamic Proxies, http://www.ibm.com/developerworks/java/library/j-jtp08305.html [Javassist]: Javassist Home Page, http://www.csg.is.titech.ac.jp/~chiba/javassist/ 
- [JBoss]: JBoss Home Page, http://jboss.org 
- [JMock]: JMock—A Lightweight Mock Object Library for Java, http://jmock.org 
- [Kolence]: Kenneth W. Kolence, Software physics and computer performance measurements, Proceedings of the ACM annual conference—Volume 2, Boston, Massachusetts, pp. 1024–1040, 1972. 
- [Spring]: The Spring Framework, http://www.springframework.org [Mezzaros07]: XUnit Patterns, Gerard Mezzaros, Addison-Wesley, 2007. 
- [GOF]: Design Patterns: Elements of Reusable Object Oriented Software, Gamma et al., Addison-Wesley, 1996.

#12. Emergence  {#Chapter12}

> By Jeff Langr

##Getting Clean via Emergent Design##

According to Kent, a design is “simple” if it follows these rules: 

- Runs all the tests
- Contains no duplication
- Expresses the intent of the programmer
- Minimizes the number of classes and methods 

The rules are given in order of importance.

##Simple Design Rule 1: Runs All the Tests##

First and foremost, a design must produce a system that acts as intended.

A system that is comprehensively tested and passes all of its tests all of the time is a testable system.

##Simple Design Rules 2–4: Refactoring##

Once we have tests, we are empowered to keep our code and classes clean. We do this by incrementally refactoring the code.

This is also where we apply the final three rules of simple design: Eliminate duplication, ensure expressiveness, and minimize the number of classes and methods.

###No Duplication###

Duplication is the primary enemy of a well-designed system.


##Expressive##

 Most of us have had the experience of working on convoluted code.

The majority of the cost of a software project is in long-term maintenance.

In order to minimize the potential for defects as we introduce change, it’s critical for us to be able to understand what a system does.

As systems become more complex, they take more and more time for a developer to understand, and there is an ever greater opportunity for a misunderstanding.

Therefore, code should clearly express the intent of its author.

The clearer the author can make the code, the less time others will have to spend understanding it. This will reduce defects and shrink the cost of maintenance.

You can express yourself by choosing good names. We want to be able to hear a class or function name and not be surprised when we discover its responsibilities.

Small classes and functions are usually easy to name, easy to write, and easy to understand.

Design patterns, for example, are largely about communication and expressiveness.

Well-written unit tests are also expressive.

The primary goal of tests is to act as documentation by example.

Someone reading our tests should be able to get a quick understanding of what a class is all about.

Remember, the most likely next person to read the code will be you.

Care is a precious resource.

##Minimal Classes and Methods

In an effort to make our classes and methods small, we might create too many tiny classes and methods.

So this rule suggests that we also keep our function and class counts low.

High class and method counts are sometimes the result of pointless dogmatism.

Our goal is to keep our overall system small while we are also keeping our functions and classes small. Remember, however, that this rule is the lowest priority of the four rules of Simple Design.

So, although it’s important to keep class and function count low, it’s more important to have tests, eliminate duplication, and express yourself.

## Conclusion ##

Is there a set of simple practices that can replace experience? Clearly not.

#13. Concurrency 

“Objects are abstractions of processing. Threads are abstractions of schedule.”

Writing clean concurrent programs is hard—very hard. It is much easier to write code that executes in a single thread.

It is also easy to write multithreaded code that looks fine on the surface but is broken at a deeper level. Such code works fine until the system is placed under stress.

## Why Concurrency? ##

Concurrency is a decoupling strategy. It helps us decouple what gets done from when it gets done.

In single-threaded applications what and when are so strongly coupled that the state of the entire application can often be determined by looking at the stack backtrace.

Decoupling what from when can dramatically improve both the throughput and structures of an application.

From a structural point of view the application looks like many little collaborating computers rather than one big main loop.

This can make the system easier to understand and offers some powerful ways to separate concerns.

Some systems have response time and throughput constraints that require hand-coded concurrent solutions.

## Myths and Misconceptions ##

Consider these common myths and misconceptions:

- Concurrency always improves performance.
- Design does not change when writing concurrent programs.

Here are a few more balanced sound bites regarding writing concurrent software: 

- Concurrency incurs some overhead, both in performance as well as writing additional code. 
- Correct concurrency is complex, even for simple problems.
- Concurrency bugs aren’t usually repeatable, so they are often ignored as one-offs2 instead of the true defects they are. 
- Concurrency often requires a fundamental change in design strategy.

## Challenges ##

What makes concurrent programming so difficult?

Let’s say we create an instance of X, set the lastIdUsed field to 42, and then share the instance between two threads. Now suppose that both of those threads call the method getNextId();

The surprising third result3 occurs when the two threads step on each other.

## Concurrency Defense Principles ##

### Single Responsibility Principle ###

The SRP5 states that a given method/class/component should have a single reason to change. Concurrency design is complex enough to be a reason to change in it’s own right and therefore deserves to be separated from the rest of the code. Unfortunately, it is all too common for concurrency implementation details to be embedded directly into other production code. Here are a few things to consider:

- Concurrency-related code has its own life cycle of development, change, and tuning.
- Concurrency-related code has its own challenges, which are different from and often more difficult than nonconcurrency-related code.
- The number of ways in which miswritten concurrency-based code can fail makes it challenging enough without the added burden of surrounding application code.

**Recommendation:** Keep your concurrency-related code separate from other code.

### Corollary: Limit the Scope of Data ###

One solution is to use the synchronized keyword to protect a critical section in the code that uses the shared object.

It is important to restrict the number of such critical sections.

The more places shared data can get updated, the more likely: 

- You will forget to protect one or more of those places—effectively breaking all code that modifies that shared data.
- There will be duplication of effort required to make sure everything is effectively guarded (violation of DRY7). 7. [PRAG].
- It will be difficult to determine the source of failures, which are already hard enough to find.

**Recommendation:** Take data encapsulation to heart; severely limit the access of any data that may be shared.

### Corollary: Use Copies of Data ###

A good way to avoid shared data is to avoid sharing the data in the first place. In some situations it is possible to copy objects and treat them as read-only.
In other cases it might be possible to copy objects, collect results from multiple threads in these copies and then merge the results in a single thread.

However, if using copies of objects allows the code to avoid synchronizing, the savings in avoiding the intrinsic lock will likely make up for the additional creation and garbage collection overhead.

### Corollary: Threads Should Be as Independent as Possible ###

Consider writing your threaded code such that each thread exists in its own world, sharing no data with any other thread.

**Recommendation:** Attempt to partition data into independent subsets than can be operated on by independent threads, possibly in different processors.

## Know Your Library ##

Java 5 offers many improvements for concurrent development over previous versions. There are several things to consider when writing threaded code in Java 5:

- Use the provided thread-safe collections.
- Use the executor framework for executing unrelated tasks.
- Use nonblocking solutions when possible.
- Several library classes are not thread safe.

### Thread-Safe Collections ###

ConcurrentHashMap implementation performs better than HashMap in nearly all situations. It also allows for simultaneous concurrent reads and writes, and it has methods supporting common composite operations that are otherwise not thread safe.

### Know Your Execution Models ###

- Bound Resources
- Mutual Exclusion
- Starvation 
- Deadlock
- Livelock

Given these definitions, we can now discuss the various execution models used in concurrent programming.

#### Producer-Consumer ####

http://en.wikipedia.org/wiki/Producer-consumer One or more producer threads create some work and place it in a buffer or queue.

The queue between the producers and consumers is a bound resource. This means producers must wait for free space in the queue before writing and consumers must wait until there is something in the queue to consume.

#### Readers-Writers ####

http://en.wikipedia.org/wiki/Readers-writers_problem

#### Dining Philosophers ####

http://en.wikipedia.org/wiki/Dining_philosophers_problem

### Beware Dependencies Between Synchronized Methods ###

However, if there is more than one synchronized method on the same shared class, then your system may be written incorrectly.

**Recommendation:** Avoid using more than one method on a shared object.

Add a note
There will be times when you must use more than one method on a shared object.

- Client-Based Locking—Have the client lock the server before calling the first method and make sure the lock’s extent includes code calling the last method.
- Server-Based Locking—Within the server create a method that locks the server, calls all the methods, and then unlocks. Have the client call the new method.
- Adapted Server—create an intermediary that performs the locking. This is an example of server-based locking, where the original server cannot be changed.

### Keep Synchronized Sections Small ###

Locks are expensive because they create delays and add overhead.

On the other hand, critical sections13 must be guarded.

Writing Correct Shut-Down Code Is Hard

**Recommendation:** Think about shut-down early and get it working early. It’s going to take longer than you expect. Review existing algorithms because this is probably harder than you think.

### Testing Threaded Code ###

**Recommendation:** Write tests that have the potential to expose problems and then run them frequently, with different programatic configurations and system configurations and load. If tests ever fail, track down the failure. Don’t ignore a failure just because the tests pass on a subsequent run.

That is a whole lot to take into consideration. Here are a few more fine-grained recommendations:

- Treat spurious failures as candidate threading issues.
- Get your nonthreaded code working first.
- Make your threaded code pluggable.
- Make your threaded code tunable.
- Run with more threads than processors.
- Run on different platforms.
- Instrument your code to try and force failures.

### Treat Spruious Failures as Candidate Threading Issues ###

**Recommendation:** Do not ignore system failures as one-offs.

### Get Your Nonthreaded Code Working First ###

**Recommendation:** Do not try to chase down nonthreading bugs and threading bugs at the same time. Make sure your code works outside of threads.

### Make Your Threaded Code Pluggable ###

**Recommendation:** Make your thread-based code especially pluggable so that you can run it in various configurations.

### Make Your Threaded Code Tunable ###

Early on, find ways to time the performance of your system under different configurations. Allow the number of threads to be easily tuned.

### Run with More Threads Than Processors ###

Things happen when the system switches between tasks. To encourage task swapping, run with more threads than processors or cores. The more frequently your tasks swap, the more likely you’ll encounter code that is missing a critical section or causes deadlock.

### Run on Different Platforms ###

**Recommendation:** Run your threaded code on all target platforms early and often.

### Instrument Your Code to Try and Force Failures ###

There are two options for code instrumentation:

- Hand-coded
- Automated

### Hand-Coded ###

You can insert calls to wait(), sleep(), yield(), and priority() in your code by hand.

Automated You could use tools like an Aspect-Oriented Framework, CGLIB, or ASM to programmatically instrument your code.

There is a tool called ConTest,18 developed by IBM that does something similar, but it does so with quite a bit more sophistication. 

http://www.alphaworks.ibm.com/tech/contest