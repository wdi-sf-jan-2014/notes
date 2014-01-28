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
