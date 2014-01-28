// Exercise: Let's have a function return a function

// Your goal is to write a function, which returns a function,
// applying the function, which evaluates to a function that when applied
// evaluates to 'Hello World'. Perform the definition and application in
// one statement. Log the return value to the console.

// currently this code throws an error that looks like this:
// exercises.js:15
// )()();
//    ^
// TypeError: undefined is not a function
//     at Object.<anonymous> (/Users/alex/Documents/work/freelance/Clients/GeneralAssembly/courses/WDI/wdi-sf-jan-2014/notes/js_functions/exercises.js:15:4)
//     at Module._compile (module.js:456:26)
//     at Object.Module._extensions..js (module.js:474:10)
//     at Module.load (module.js:356:32)
//     at Function.Module._load (module.js:312:12)
//     at Function.Module.runMain (module.js:497:10)
//     at startup (node.js:119:16)
//     at node.js:901:3

(
  function () {
    // TODO: place the rest of your code here
  }
  // pay attention to the two function applications below
  // the first one applies the outer function to no args
  // the second one applies no arguments to the function
  // returned by the first function
)()(); 

// Exercise: describe the crazy example below in words by commenting the code 

// We've seen this
(function (x) { return x; })(2);

// What happens is this:
// 
// * JavaScript parses this whole thing as an expression made up of several sub-expressions.
// * It then starts evaluating the expression, including evaluating sub-expressions
// * One sub-expression, function (x) { return x } evaluates to a function.
// * Another, 2, evaluates to the number 2.
// * JavaScript now evaluates applying the function to the argument 2. Here’s where it gets interesting…
// * An environment is created.
// * The value ‘2’ is bound to the name ‘x’ in the environment.
// * The expression ‘x’ (the right side of the function) is evaluated within the environment we just created.
// * The value of a variable when evaluated in an environment is the value bound to the variable’s name in that environment, which is ‘2’
// * And that’s our result.

// Describe the thing below in words; the first two steps are copied from above
// * JavaScript parses this whole thing as an expression made up of several sub-expressions.
// * It then starts evaluating the expression, including evaluating sub-expressions
(function (x) { 
  return (function (y) { 
    return x; 
  }) 
})(4)(2);
