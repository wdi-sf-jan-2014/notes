

[todo_spa](http://wdi-sf-jan-2014.github.io/todo_spa/)

# SPA App
## Lesson Discussion



## A Note This

### AFTER
    var App = {
      msg:"hello world!", 
      logMsg: function(){
        console.log(this);
        console.log(this.msg)
      }, 
      Views: {
        msg: "Best App, sorta", 
        logMsg: App.logMsg
      }
    };


    App.Views.logMsg()

### BEFORE

  var App = {}

  App.msg = "Hello, World!";

  App.logMsg = function(){
     console.log(this);
     console.log(this.msg) 
  }
  App.Views = {msg: "Best App, sorta"};

  App.Views.logMsg = App.logMsg;

  App.Views.logMsg()


## SPA APP

First,

  rails g controller todos index --no-test-framework
 

We neeed to work with the `todo.js` and the `todos/index.html.erb`


`todos/index.html.erb`
    
    <div id="testCon">
    </div>
    

All template information:
`./templates/test.hbs`
    <div>
     {{ msg }}
    </div>

All application logic:
`/todos.js`

    $(function(){
        var testObj = {msg: "Hello, world!"};
        var $myTest = $(HandlebarsTemplates.test(testObj));
        
          $("#testCon").append($myTest);
    });
    












