// exercise 1 solution
console.log(
  (function () {
     return (function () {
       return 'Hello World';
     });
  })()()
);

// exercise 2 solution
// * JavaScript parses this whole thing as an expression made up of several sub-expressions.  // * It then starts evaluating the expression, including evaluating sub-expressions
// * One sub-expression 
// function (x) { 
//   return (function (y) { 
//     return x; 
//   }) 
// }
// evaluates to a function.
// Another, 4, evaluates to the number 4.
// Another, 2, evaluates to the number 2.
// JavaScript now evaluates applying the function to the argument 4.
// An environment is created
// The value 4 is bound to the name x in the environment
// The expression
// function (y) {
//   return x;
// }
// evaluates to a function within that environment
// Which is returned by the environment
// The returned function is applied to the argument 2.
// There is no x in that returned function's environment.
// Where does it come from?
//
//
// LEAD INTO THE REST OF THE LESSON...

// exercise 3 solution
var circumference = function (radius) { 
  var Pi = 3.14159265;
  return 2 * Pi * radius; 
};

// exercise 4 solution

// the key idea here is to have the students describe how 
// function environments have a reference to their parent 
// environment
