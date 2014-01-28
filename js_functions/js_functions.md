# JavaScript Functions

Every programming language has one or two things that you really have to
grok in order to understand the rest of the language and its idioms.

In order to use libraries that are available to you, as well as to write 
your own JS, you ought to understand these idioms thoroughly.

## Examples

* In ruby everything is an object

* In java you can't do anything without declaring a class

* In c or c++ you need to understand pointers

### Some examples with Google Maps API

* [Simple Map](https://developers.google.com/maps/documentation/javascript/examples/map-simple)
* [Ground Overlays](https://developers.google.com/maps/documentation/javascript/examples/groundoverlay-simple)
* [Overlaying an Image](https://developers.google.com/maps/documentation/javascript/examples/maptype-image-overlay)

## Objective

Understand why this function always returns true regardless of the argument:

```
(function (value) {
  return (function (copy) {
    return copy === value;
  })(value);
})("Hello World");

(function (value) {
  return (function (copy) {
    return copy === value;
  })(value);
})([1, 2, 3]);
```

### Sub-objectives

* Functions as environments << This is absolutely key
* Function declaration vs function expression
  * Function declaration
  * Function expression
  * Anonymous function expression
  * Immediately-invoked function expressions (IIFE)

### In JS, you have to grok functions!

## Functions in JS are values

### Our first function

Fire up your chrome developer tools console

Type in `3` and press enter. You get `3` back. The JS console returns
the value `3` right back. Awesome.

Now, type in:

```
(function () {});
```

What do you see? 

```
function () {}
```

Just like with the number `3`, functions are values!

Just as an aside, doesn't that look like a lambda in ruby a little bit?
In JS, that is an anonymous function. Very similar... and very cool, as
you'll see shortly.

### What can you do with values in ruby?

* store references to values
* perform operations on values with operators
* pass them around between methods

#### When it comes to JS that last one is the most important

## Functions are a reference type

Before we do anything else with functions, let's talk about their type.

Spencer has spoken about the difference between value types and
reference types. 

Type in the following into the JS Developer Tools console:

```
(function () {}) === (function () {});
```

That returns `false`.

So based on the return value, what kind of type are functions?

## Let's revisit our bare bones function

To use a function in JS, we apply it to some arguments
This is not necessarily different from ruby, but it's important to think
about what that statement really means and how it sounds different from
ruby.

In ruby, you generally say something like:
"Call a method on this object, and pass in some arguments"

In JS, you should say something like:
"Apply the function to the arguments... x, y, z"

Let's apply the function we wrote before to zero arguments.

```
(function () {})();
```

That returns `undefined`. Remember what Spencer said about `undefined`?
In JS, `undefined` is the absence of value. 

### Why does the above return `undefined`?

Let's dissect a function first.

```
// defining a function means writing the word
// function
// followed by a list of 0 or more arguments
// followed by the body of the function, 
//   which may have 0 or more JS statements

function () {

}
```

#### The `return` keyword.

Unlike with ruby, which has implicit return, JS does *not* have implicit
return. This is why functions that don't have a `return` statement
return `undefined`.

```
(function () { 
  return 'Hello ' + 'World';
})();

  // 'Hello World'
```

The `return` keyword creates a return statement that immediately
terminates the function application and returns the result of evaluating
its expression.

##### You Do: Let's have a function return a function

[Exercises](exercises.js)

### Let's dissect a complicated example

Why does applying the function below to any argument always return
`true`?

```
(function (value) {
  return (function (copy) {
    return copy === value;
  })(value);
})("Hello World");

(function (value) {
  return (function (copy) {
    return copy === value;
  })(value);
})([1, 2, 3]);
```

#### Let's talk about arguments and parameters

```
// when applied to a value referencing an array this function 
// logs every element in the array to the console
(function (array) {
  for (var i = 0; i < array.length; i++) {
    console.log(array[i]);
  }
})([1,2,3]);
```

In prior examples we have been applying functions to no arguments.
In this one, we are applying a function to one argument.

#### Notice what I said there: a value referencing an array

Let's apply a function to two arguments:

```
// when applied to the value of pi and to the radius
// returns the circumference of the circle with the radius
(function (pi, radius) { return 2 * pi * radius })(3.14159265, 1 + 2);
```

* we are applying a function to more than one argument
* take a look at what happens to `1 + 2`. That expression is evaluated,
before the function is applied to the value
* from this, we infer that functions are applied to values
  * another way of saying this is that JS uses the "call by value" evaluation strategy

#### What about environments?

Let's take a look at another example:

```
(function (x) { 
	return (function (y) { 
		return x; 
	}) 
})(4)(2);
```

First of all, what does the function return?

=> 4

Why?

Let's dissect that.

* The first x, the one in function (x) ..., is an argument. 
* The y in function (y) ... is another argument. 
* The second x, the one in { return x }, is not an argument, it’s an expression referring to a variable. 
* Arguments and variables work the same way whether we’re talking about function (x) { return (function (y) { return x }) } or just plain function (x) { return x }.

**What's important is that every time a function is invoked, a new *environment* is created**

An environment is a possibly empty dictionary that maps variables to values by name.

The x in the expression that we call a “variable” is itself an expression that is evaluated by looking up the value in the environment.

How does the value get put in the environment? Well for arguments, that is very simple. When you apply the function to the arguments, an entry is placed in the dictionary for each argument. So when we write:

```
(function (x) { return x })(2)
  //=> 2
```

What happens is this:

* JavaScript parses this whole thing as an expression made up of several sub-expressions.
* It then starts evaluating the expression, including evaluating sub-expressions
* One sub-expression, function (x) { return x } evaluates to a function.
* Another, 2, evaluates to the number 2.
* JavaScript now evaluates applying the function to the argument 2. Here’s where it gets interesting…
* An environment is created.
* The value ‘2’ is bound to the name ‘x’ in the environment.
* The expression ‘x’ (the right side of the function) is evaluated within the environment we just created.
* The value of a variable when evaluated in an environment is the value bound to the variable’s name in that environment, which is ‘2’
* And that’s our result.

#### You do: Describe the crazy example in the terms above

[Exercises](exercises.js)

#### Free variables and environments

What we arrive at is the idea that a function always has a reference to its immediate parent environment.

Let's take a look at the environments created by each function in our example from the exercises:

```
(function (x) { 
	// { x: 4, '..': global environment }
	return (function (y) { 
		// { y: 2, '..': { x: 4 } }
		return x; 
	}) 
})(4)(2);
```

Notice the double ellipses... they reference one level up. It's kind of like `..` in the terminal.

### Function naming

#### var

Spencer had spoken about the `var` keyword as a way to declare a variable that refers to a value.

Naturally, in js, we may declare a variable that stores a reference to a function:

```
var circumference = function (pi, radius) { 
	return 2 * pi * radius; 
};

// Let's apply the function to two arguments:
circumference(3.14, 2);
// => 12.56
```

Let's try one more thing:

```
circumference.name;
```

What I'd like to emphasize is that we've not actually explicitly named our function. We simply have a reference to the function value.

We may easily reassign to `circumference` and we'll lose our function reference forever and won't be able to call it again.

```
circumference = 2;
circumference(3.14, 2);
// => TypeError: Property 'circumference' of object #<Object> is not a function
```
##### So what does `var` actually do?

The `var` keyword introduces one or more bindings in the current function’s environment. 

Reimplement the above circumference function, by binding the value of PI to the function's environment.

[Exercises](exercises.js)

#### named function expressions vs function declarations

This is not so exciting. Let's implement a named function.

```
var c = function circumference (radius) {
	var Pi = 3.14;
	return 2 * pi * radius;
};
```

You'd think you could call this function by name, like so:

```
circumference(2);
```

This fails.

This does not:

```
c(2);
```

Take a look at the name:

```
c.name;
```

It turns out that while we have indeed created a named function, whose name is circumference, we've not actually *declared* a function. Instead, what we had done was that we wrote a named function expression.

That's not super useful - at least not in this context.

Let's actually write a function declaration:

```
function circumference (radius) {
	var Pi = 3.14;
	return 2 * pi * radius;
}
```

Ahh, joy:

```
circumference(2);
circumference.name;
```

We are awesome.

## Back to our objective... 

[Exercises](exercises.js)