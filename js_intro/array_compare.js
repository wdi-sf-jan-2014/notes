
console.log("The file: array_compare.js loaded and this statement ran.");

// ############### Values and Expressions ############

console.log(42); //=> 42. Values are expressions.

console.log(2 + 2); //=> 4. Arithmetic operations are expressions.

console.log("hello" + " world"); //=> "hello world". String concatenation is an expression.

// ################ Equality #####################
// Always use the "triple equal" operator to test for equality!
console.log("Always use triple equal sign to test equality.")

console.log(42 === 42); //=> true

console.log(3 === "3"); //=> false

console.log(3 == "3"); //=> true. Double equal operator gives the wrong result!!

console.log(2 + 2 === 4); //=> true

console.log("foo" !== "bar"); //=> true

// ############# Reference Type ###################
//Arrays are unique structures.

console.log("Arrays are reference-type data structures.")

console.log([1,2,3] === [ 2-1, 1+1, 2+1]);//=> false

console.log([1,2,3] === [1,2,3]); //=> false


// ############# Undefined is a value ######################

console.log("undefined is a value-type.")
console.log(undefined === undefined); //=> true

// ##########  FALSE ###########

console.log("False Tester:");
if(0) { // Try: 0, "", undefined, null, false. Anything else is true!
  console.log(true);
} else {
  console.log(false);
}

// ############# JavaScript Object Literals ################
// ##### JS Object Literals are reference types

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

console.log(micky_mouse.first_name); // Access an object literal value with ".key" syntax!

console.log(micky_mouse["first_name"]); // This also works.

console.log("Are JS Object Literals values? ")
if(micky_mouse === micky ) {
  console.log(true );
} else {
  console.log(false );
}

// ################  Conditional ##############

console.log("if - else if - else:");  // if - else if - else
// var state = "red";
var state = "green";
// var state = "blue";

var message = {  // "message" is an example of a JavaScript Object Literal.
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

// ##########  While Loop: ########

var a = [1,2,3,4];
var b = [1,2,3,4];
console.log("While Loop:")
var i = 0;
while(i < a.length){
  console.log("The element at index " + i + " is: " + a[i]);
  i++;
}

// ###########  For Loop:  ############

var mixed = [1, "two", "three", true];
console.log("For Loop:"); // Common mistake: commas instead of "semicolons" inside for loop.
for(var i = 0; i < mixed.length; i++) {
  console.log("The element at index " + i + " is: " + mixed[i]);
}


// ########### Switch - case #############

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

// ################ Exercise #################
// Since arrays are reference types,
// we cannot use "===" to compare them.
// Write a routine that would compare two arrays.
// Create a variable "result".
// Set "result" to "true" if the two arrays are equal,
// and to "false" if the two arrays are unequal.



