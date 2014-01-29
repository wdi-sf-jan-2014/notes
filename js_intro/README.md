# JavaScript Introduction

## While waiting for lesson to start:
* <h3>Install Node.js - go to http://nodejs.org/</h3>
* <h3>Go to your working directory</h3>
* <h3>Clone repository: https://github.com/spencereldred/JavaScript-Intro</h3>

## Learning Objectives
* <h3>Overview - why JavaScript</h3>
* <h3>Today's work flow: Node, Developer Console</h3>
* <h3>Understand Data Types</h3>
	* <h3>Comments</h3>
	* <h3>Numbers</h3>
	* <h3>Values & Expressions</h3>
	* <h3>Conditionals</h3>
	* <h3>Reference Types</h3>
	* <h3>Undefined</h3>
	* <h3>False</h3>
* <h3>Understand JavaScript Object Literal</h3>
* <h3>Understand JavaScript Control Flow</h3>
	* <h3>Conditionals (if-else)</h3>
	* <h3>While loop</h3>
	* <h3>For loop</h3>
	* <h3>Switch case</h3>

## Why Javascript? We want high performance web sites!

* <h3> Client side programming:</h3>
	* <h3> Interaction with the DOM.</h3>
	* <h3> Respond to DOM events: click, submit...</h3>
	* <h3> Send requests to the server.</h3>
	* <h3> Act on response from the server.</h3>
* <h3> Server side programming with Node.js.</h3>

## Resources:
* <h3> Code School free course on the Developer Tools.</h3>
		https://www.codeschool.com/courses/discover-devtools
* <h3>JavaScript Alonge:</h3>
		https://leanpub.com/javascript-allonge/read#leanpub-auto-a-pull-of-the-lever-prefaces
* <h3>MDN JavaScript Reference</h3>
		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
* <h3>W3Schools JavaScript Reference</h3>
		http://www.w3schools.com/jsref/default.asp

## Comments:
* <h3> Ruby uses '#' to indicate a comment line.</h3>
* <h3> JavaScript uses '//' for line comment.</h3>

## Numbers:
* <h3> Ruby has Integers and Floats.</h3>
* <h3> JavaScript we have just Numbers.</h3>

## Values & Expressions
* <h3> Computers return values when you give them expressions. </h3>
* <h3> Give the computer a value and it returns a value, thus values are expressions as well. </h3>
	
		// values are expressions
		console.log(42);
		//=> 42

		// addition is an expression
		console.log(2 + 2);
		//=> 4

		// string concatenation is an expression
		console.log("hello" + " world");
		//=> "hello world"

## Conditionals: always use Triple Equal "===" or "!=="
* <h3> Check to see if two values are identical with the "===" strict equality.</h3>

		console.log("Always use triple equal sign to test equality.")

		console.log(42 === 42);
		//=> true

		console.log(3 === "3");
		//=> false

		// Double equal operator gives the wrong result!!
		console.log(3 == "3");
		//=> true

		console.log(2 + 2 === 4);
		//=> true

		console.log("foo" !== "bar");
		//=> true
		
## Reference Types: 
### Even if they have the same values and are the same type, reference types are not strictly equal.
* <h3> Arrays are unique structures.</h3>

		console.log("Arrays are reference-type data structures.")
		console.log([1,2,3] === [ 2-1, 1+1, 2+1]);
		//=> false

		console.log([1,2,3] === [1,2,3]);
		//=> false


## Undefined
* <h3> When something is "undefined" it has no value.</h3>
* <h3> Oddly enough "undefined" is a value.</h3>

		
		console.log("undefined is a value-type.");
		console.log(undefined === undefined);
		//=> true

## False
* <h3>0, false, null, undefined, Empty String: ""</h3>
		
		console.log("False Tester:");
		// Try: 0, "", undefined, null, false. Anything else is true!
		if(0) { 
		  console.log(true);
		} else {
		  console.log(false);
		}

## JavaScript Object Literals
	var micky_mouse = {
                    "first_name": "Micky",
                    "last_name": "Mouse",
                    "address": "Disneyland"
                  }
	var micky = {
                    "first_name": "Micky",
                    "last_name": "Mouse",
                    "address": "Disneyland"
                  }

	// ##### JS Object Literals are reference types
	// Access a literal value with ".key" syntax!
	console.log(micky_mouse.first_name);
	// This also works
	console.log(micky_mouse["first_name"]);

	console.log("Are JS Object Literals values? ")
	if(micky_mouse === micky ) {
	  console.log(true );
	} else {
	  console.log(false );
	}


## Conditional (if-else)
	console.log("if - else if - else:")
	// var state = "red";
	var state = "green";
	// var state = "blue";

	// "message" is an example of a JavaScript Object Literal.
	var message = {
                "failing": "Tests are failing.",
                "passing": "Tests are passing.",
                "refactor": "Time to refactor."
              }
	if (state === "red") {	
	
	  console.log(message.failing);
	  
	} else if (state === "green") {
	
	  console.log(message.passing);
	  
	} else { // Time to refactor.
	
	  console.log(message.refactor);
	  
	}

## While loop
	var a = [1,2,3,4];
	var b = [1,2,3,4];

	console.log("While Loop:")
	
	var i = 0;
	
	while(i < a.length){
	
		console.log("The element at index " + i + " is: " + a[i]);
		i++;
		
	}

## For loop

	var mixed = [1, "two", "three", true];
	
	console.log("For Loop:")
	
	// Most common mistake is using commas instead of "semicolons" inside the loop declaration.
	
	for(var i = 0; i < mixed.length; i++) {
	
	  console.log("The element at index " + i + " is: " + mixed[i]);
	  
	}
## Switch Case
	var expression = "label2"

	switch (expression) {
	 	case "label1":
    		console.log("First case: label1");
    		break;
		case "label2":
    		console.log("Second case: label2");
    		break;
		case "labelN":
		    console.log("Nth case: labelN");
		    break;
		default:
		    console.log("Default case.");
		    break;
		}


## Exercise: Implement a routine that checks to see if two arrays are identical.
* <h3> Set "result" to "true" if the two arrays are equal, and to "false" if the two arrays are unequal.</h3>

## Afternoon Lab: 
* <h3> Turn array compare exercise into a function that returns true or false.</h3>
* <h3>Code School - DevTools Levels 1-4.</h3>




