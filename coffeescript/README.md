# CoffeeScript

## Why CoffeeScript (15 min)

* CoffeeScript is a programming language that has "nice" (Ruby like) syntax that compiles into JavaScript.
* CoffeeScript is easier to write and easier to read than JavaScript.
* Works well with AngularJS. Used together, front end programming feel like Ruby on Rails.
* Very well documented.
	* Documentation and CoffeeScript to JavaScript converter:
		* http://jashkenas.github.io/coffee-script/
	* JavaScript to CoffeeScript converter:
		* http://js2coffee.org/
	* The Little Book on Coffee
		* http://arcturo.github.io/library/coffeescript/index.html
	* WikiPedia - included in rails since 3.1
		* http://en.wikipedia.org/wiki/CoffeeScript

## Student Learning Objectives

By the end of this lesson you should be able to:

* 1) write any JavaScript function as a CoffeeScript function
* 2) write a list comprehension (loop) in CoffeeScript utilizing conditional filters
* 3) create an Object in Coffeescript with attributes and behaviors


## Installation

	# Everyone should have node and npm installed. npm (node package manager) comes with node.

	# test for node:
	$ node -v
	v0.10.25

	# test for npm:
	$ npm -v
	1.3.24

	# get node and npm from: http://nodejs.org

	# If node and npm are installed, install CoffeeScript
	$ sudo npm install -g coffee-script

	# test installation
	$ coffee -v
	=> CoffeeScript version 1.7.1


## Summary of Features / Quirks

* No var keyword.
* No semicolons.
* Indentation is super important
	* indent two spaces to start a new block
	* improper indentation is the source of lots of problems
* Parenthesis are not required:
	* CoffeeScript convention is to use parenthesis on everything except the outermost one
* Parenthesis are required to run a function: function_name( )
* CoffeeScript supports string interpolation
* Comments use hashtag #. CoffeeScript comments do not compile into the .js file.
* @ === this, example:  @name === this.name
* CoffeeScript implicitly returns the last statement, JavaScript implicitly returns undefined
* CoffeeScript was created by Jeremy Ashkenas, who also created Backbone.js and Underscore.js.


## Configuration

	# Configure directory to automatically compile your CoffeeScript into JavaScript
	# Rails does it automatically!

	# compiles name.coffee to name.js everytime name.coffee is changed
	$ coffee -bcw name.coffee


## Functions, List Comprehensions, Conditionals (30 min):
## Functions
* Functions are declared with the "Skinny Arrow": ->
	* "->" converts to "function(){ }"
	* functions use "Fat Arrow" => to bind the current value of "this"
* All CoffeeScript functions have a return value
	* like Ruby there is an implicit return of the last line in your function
* CoffeeScript functions are all named functions
* CoffeeScript supports default settings for parameters

		# JavaScript:
		my_function = function(parameter) {
		  console.log("This is my parameter: " + parameter)
		}

		# CoffeeScript:
		my_function = (parameter) ->
		  console.log "This is my parameter: #{parameter}" # string interpolation!


## Arrays
* can be written vertically if you really hate commas
* vertical arrays are easier to review and edit

		months = ["January", "February", "March"]

		months = [
			"January"
			"February"
			"March"
		]

## Ranges
* very much like ruby ranges

    	# inclusive range assignment
    	range = [1..6] => [1,2,3,4,5,6]

    	# non-inclusive range assignment
    	range = [1...6] => [1,2,3,4,5]

    	# can get subsets of an array
    	range[1..3] => [2,3,4]
    	range[0..2] => [1,2,3]

## Conditionals

	# two line conditional:
	if x < 5
	  alert 'x is less than 5'

	# One line conditional:
	alert 'x is less than 5' if x < 5

	# if then format
	if x < 5 then alert 'x is less than 5'

	if x < 5
	  alert 'x is less than 5'
	else
	  alert 'x is greater than or equal to 5'

	if x < 5 alert 'x is less than 5' else alert 'x is greater than or equal to 5'


## Operators:
<h3>

<table>
  <thead>
    <tr>
      <th>Operation</th>
      <th>JavaScript</th>
      <th>CoffeeScript</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td> Equality</td>
      <td> === </td>
      <td> ==, is</td>
    </tr>
    <tr>
      <td> Inequality</td>
      <td> !== </td>
      <td> !=, isnt </td>
    </tr>
    <tr>
      <td> Logical Negative </td>
      <td> ! </td>
      <td> not </td>
    </tr>
    <tr>
      <td> Logical AND </td>
      <td> && </td>
      <td> and </td>
    </tr>
    <tr>
      <td> Logical OR </td>
      <td> || </td>
      <td> or </td>
    </tr>
    <tr>
      <td> Logical True </td>
      <td> true </td>
      <td> true, yes, on </td>
    </tr>
    <tr>
      <td> Logical False </td>
      <td> false </td>
      <td> false, no, off </td>
    </tr>
  </tbody>
</table>

</h3>


## Chained Comparison

	if ( x < length && length < y ) { alert 'in between' }

	if x < length < y
	  alert 'in between'


## List Comprehensions / Loops

	months.forEach (month,index) ->
	  console.log "Month: #{month}"

	for month in months
	  console.log "Month: #{month}"

	console.log "Month: #{month}" for month in months

	# Filtering with "when"
	console.log "Month: #{month}" for month in months when month isnt "February"

## Exercise 1 (15 min):

* Write a function that takes an array of numbers and prints to the console numbers divisible by 7
* Use a range to create an array of numbers from 1 to 100
* Loop through the array with a list comprehension use a filter to select the numbers divisible by 7
* write the CoffeeScript. compile it. copy the compiled JavaScript into the console to run it.

## Objects, Existence: (15 min)

## Object

	my_pet =
	  name: "Fluffy"
	  species: "Cat"
	  age: 3
	  # name needs the @ symbol: @name === this.name
	  voice: -> alert "Meow, my name is #{@name}"

	console.log my_pet.name
	console.log my_pet.species
	my_pet.voice()

## Existence Operator: ?
* tests for existence of a variable or object
* just at question mark to the end of a variable or object
* don't overuse the existence operator

		# Initialize variable to zero if it does not exist.

		if not variable?
		  variable = 0

		varible = 0 if not variable?

		variable = 0 unless variable?

		variable ?= 0  # combined existance test, conditional assignment

## Exercise 3: (30 min)

* Redo Haters Lab - rewrite the JS in CS.
* https://gist.github.com/DelmerGA/7a90af280d0a393f668d
* If you don't want to use your previous lab, Rafi's Hater's Lab solution is in the repo: "index.html" and "lab.js".
* Create a haters.coffee file that compiles into haters.js.
* include the compiled file, haters.js, in your html page.


## Lab Assignment:

* Redo last nights AngularJS lab in CoffeeScript

##@@@@@@@ Other Stuff @@@@@@@

## Switch Statement
* very much like Ruby shorthand

		plate_umpire_call = switch number_outs
			when 0 then "No outs, play ball."
			when 1 then "One out, play ball."
			when 2 then "Two outs, play ball."
			else "The side is retired!"


