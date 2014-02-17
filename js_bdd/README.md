# JavaScript BDD with Jasmine

## Objectives

1. Experience some of the differences between clean/good and unclean/bad JS
2. Learn Jasmine as a tool to help you write BDD JS specs

## Good JS vs. Bad JS

[JavaScript: The Good Parts](http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742)

### Why you should care:

#### Less bugs

Bad js is at times *very* hard to debug

#### Maintainable code

* Don't leave unused variables dangling in the wind
* Don't assign crap to variables that are undefined
* Don't use `==` when you should use `===`
* Don't make two libraries override each others' functionality by putting crap in global scope
* Keep your cyclomatic complexity down to a minimum
* Have your functions do one thing well
* Don't write assignments in `if`and `for` equality checks
* Don't assume braces

#### Lower blood pressure

#### Happier team members

### All of the above is hard to keep track of manually

### Use a tool: JSHint

[About JSHint](http://www.jshint.com/about/)

#### Exercise: take some js you've written, and dump it into JSHint

### Let's add JSHint to Sublime

#### Sublime Package Control

Forllow the Simple section of the installation instructions here: [Sublime Package Control Installation Instructions](https://sublime.wbond.net/installation)

#### JSHint Gutter

**CRUCIAL:** First, run `node -v` in your terminal. This should output the version of node on your machine. If you don't have `nodejs` installed:

* **ON MAC:** In your terminal, run this: `brew install node`
* **ON LINUX:** In your terminal, run this: `apt-get install nodejs`

Follow the Sublime Package Manager section of the instructions here:
[JSHint Gutter Installation Instructions](https://sublime.wbond.net/packages/JSHint%20Gutter)

* **If you have Sublime Text 3:**, enable Automatically linting on edit or save
* **If you have Sublime Text 2**, enable Automatically linting on save

#### Exercise: Write some js code in Sublime and play with JSHint

## JS BDD Testing with Jasmine

### Together: name some reasons why we should test our code

### Basic Jasmine syntax

#### It's like RSpec, but with JS

In RSpec, what 2 arguments do the `describe`, `it` methods take?

Like in RSpec with ruby, in Jasmine with JS, which is based on RSpec, `describe` and `it` are `functions` that are applied to/take two arguments. With RSpec, the second argument is a block; with Jasmine, the second argument is an anonymous `function`.

A test suite begins with `describe`, with two parameters:

* A `string` giving the test suite a name
* An anonymous `function` that implements the test suite

#### Together: Let's take a look at a test suite that I had begun to write

[Iterators Test Suite](spec/IteratorsSpec.js)

#### Exercise: Complete the test suite and implementation

## Your resources for today:

* [Jasmine Intro](http://jasmine.github.io/2.0/introduction.html)
* [Testing with Jasmine Screencast](http://blog.codeship.io/2013/07/30/testing-tuesday-16-javascript-testing-with-jasmine.html)
* [Jasmine Spies Screencast](http://blog.codeship.io/2013/08/06/testing-tuesday-17-how-to-spy-on-javascript-methods-with-jasmine.html)