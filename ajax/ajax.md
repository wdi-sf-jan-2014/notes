# AJAX


__AJAX: Ssynchronous JavaScript And XML__  Allows for asynchronous requests in the browser.  In other words, http requests can be made to the back end server, without reloading the page.  AJAX gives the developer the ability to create more interactive and responsive pages which result in a better user experience.

AJAX is a bit of a misnomer now.  XML used to be a common data transfer format on the web, but JSON has replaced it in popularity.

## Objectives

* Feel comfortable making an ajax request with both GET and POST.
* Understand the security model of ajax requests.

## How The Internet Works - A Brief Review

Demo the request response lifecycle and what happens at each step.  More information can be found at [How Stuff Works](http://computer.howstuffworks.com/internet/basics/internet.htm) or this [Stanford White Paper](http://www.stanford.edu/class/msande91si/www-spr04/readings/week1/InternetWhitepaper.htm).

## JQuery .ajax

The .ajax method in jQuery allows the user to make an asychronous request.  The result of the request gets handled in a javascript callback function.

__What are callback functions?__ A way to handle the result of an asynchronous task.

The documentation for the .ajax method is in the [jQuery docs](https://api.jquery.com/jQuery.ajax/).  Here is an example request in the javascript console.  Note the first piece of javascript that inserts a new script tag for jQuery:

__Getting jQuery Loaded Dynamically__

```
var jq = document.createElement("script");

jq.type = "text/javascript";
jq.src = '//code.jquery.com/jquery-2.1.0.min.js';

document.body.appendChild(jq);
```

__Sample AJAX Request__

```
var url = "http://www.omdbapi.com/?i=tt1611224";

$.ajax(url, { type: 'get' }).done(function(data) { alert(data); });
```


Since the data returned is a JSON string, it must be parsed to be turned into a javascript object:

```
var url = "http://www.omdbapi.com/?i=tt1611224";

$.ajax(url, { type: 'get' }).done(function(data) {
                                    movieData = JSON.parse(data);
                                    alert(movieData.Title);
                                   });

```

The ```.done``` function will be executed when the ajax get request is completed successfully.  To handle failed requests, an error function can also be passed in to ```.fail```:


```
var url = "http://www.omdbapi.com/fake/path";

var success = function(data) {
                movieData = JSON.parse(data);
                alert(movieData.Title);
              };
              
var failure = function(jqXHR) {
                alert("HTTP Status Code = " + jqXHR.status);
              };


$.ajax(url, { type: 'get' }).done(success).fail(failure);
 
```

### Exercise - OMDB API

Go to ```http://www.omdbapi.com/```.  We will use the javascript console to make ajax requests.  Write an ajax GET request for ```http://www.omdbapi.com/?i=tt1611224```.  Upon a successful GET, the page should alert the title of the movie.

Once you have completed that, change the code such that instead of alerting the title, a new H1 tag is added to the document at the top of the page.  The H1 tag should contain the title of the movie.  Also, the id of the H1 tag should be the imdbID.

__HINT__ Look through the jQuery docs to find the method to insert the new h1 tag into the document.  Also, document.body.firstChild is the first html element in the body of the page.

## Get

jQuery provides a shorthand way of writing an ajax GET request.  The [jQuery.get](https://api.jquery.com/jQuery.get/) method allows the caller to make the same request but without specifying the type.  Here is a similar query rewritten with .get:

```
var url = "http://www.omdbapi.com/?i=tt1611224";

$.get(url).done(function(data) {
                   movieData = JSON.parse(data);
                   alert(movieData.Title);
                 });

```

Similarly to the ```.ajax``` method, errors can be handled with ```.fail```.  Try the following:

```
var url = "http://www.omdbapi.com/bad/route";

$.get(url).done(function(respData) {
              movieData = JSON.parse(respData);
              alert(movieData.Title);
            })
           .fail(function(jqXHR) {
              alert("You Got An Error, SON! " + jqXHR.status )
           });

```

### Exercise

Look up [jQuery.then](http://api.jquery.com/deferred.then/). Read about how .then is used.  Write a get request using jQuery.get and handle the result with .then, instead of .done.


## Post

Below is an example post request written with [jQuery.ajax]() and specifying a type.   

__.ajax__

```
$.ajax({
  type: "post",
  url: "http://www.mysite.com/resource/path",
  data: { name: "John", age: 16 }
}).done(function( response ) {
    alert( "Data Saved: " + JSON.stringify(response) );
  });
```

The same request written with [jQuery.post()]() and not specifying a type.

__.post__

```
$.post("http://www.mysite.com/resource/path.json",
   { name: "John", age: 16 }
}).done(function( response ) {
    alert( "Data Saved: " + JSON.stringify(response) );
  });
```

### Authenticity Tokens And CSRF

In ```app/views/layout/application.html.erb``` look at the following tag:


```
<%= csrf_meta_tags %>
```

#### Exercise

Open up a rails app and go to any page.  What html does the csrf_meta_tags method generate?

### Using Auth Token

To get the auth token on a page, use:

```
var authParam = $('meta[name=csrf-param]').attr('content');
var authToken = $('meta[name=csrf-token]').attr('content');
```

The ```authParam``` is the name of the paramter to be sent to the rails server, and the ```authToken``` is the value to be used for the ```authParam```.

To make a request that passes the auth token, do the following:

```
var data = {};
data[authParam] = authToken;
data.name = "John";
data.age = 16;

$.post("http://www.mysite.com/resource/path.json",
  data
).done(function( response ) {
    alert( "Data Saved: " + JSON.stringify(response) );
 })
 .fail(function(jqXHR) (
    alert( "Data was not saved!");
 });
```

## Same Origin Policy

The same origin policy is important to understand when making ajax requests.  It states that you can only make AJAX requests to an endpoint with the same protocol, domain and port number as the site in which the script originated from.  In other words, say you have a javascript file running on http://www.mysite.com.  Here are some examples that will, or will not allow ajax requests:

| URL Requested                |  Allowed?               |
| ----------------------------           | :---------------------: |
| http://www.mysite.com/tests  |Allowed, protocol, domaina and port match|
| __https__://www.mysite.com/tests | __NOT ALLOWED__, protocol does not match |
| http://__home.mysite__.com/tests    | __NOT ALLOWED__, domain does not match |
| http://www.mysite.com:__3000__/tests | __NOT ALLOWED__, port does not match |
| http://www.mysite.com/?query=string | Allowed, protocol, domain and port match |

## JSONP

JSONP is a hacky way of circumventing the same origin policy.  It uses a script tag that is dynamically added to the page as a work around to making a request to a different origin.  The server that receives the request must know that the request is JSONP and it must wrap the result in a callback method that is defined by the caller.  Check the resources section for more reading.


## Resources

[jQuery AJAX api Reference](http://api.jquery.com/jQuery.ajax/)

[Same Origin Policy](http://en.wikipedia.org/wiki/Same-origin_policy)

[JSONP](http://en.wikipedia.org/wiki/JSONP)

## Lab
[Link Checker AJAX Lab](https://github.com/wdi-sf-jan-2014/LinkCheckerWithAJAX)






