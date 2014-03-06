# Backbone Models and Collections

Models and collections in backbone provide functionality for storing app data on the client side and keeping the app data in sync with the back end.

__NOTE__ This lesson will make use of a rails BlogApp in order to test out backbone models and collections.  The BlogApp is located in this directory.

## Models
A backbone model represents a single instance of a resource.  In our blog post example, a model would contain a single post.

### Exercise - Models

Using the blog app, start the rails server, go to the root path and open up the javascript console.  From the console do the following:

1. Create an empty post model
2. Set the title, text, and author on the empty post
3. Get the title from the post.
4. Get all the data in the post model as a javascript object.
5. Change the default author of the post to 'Tim' (have to change javascript in the app).  Create a new empty post model and verify that the author is set to Tim.
6. Get a single post from the server.  __HINT__ Set a urlRoot on the model.
7. Make a change to the post and save it back to the server.

## Collections
A backbone collection stores a set of models.  It provides functionality to operate on the models and keep the models in sync with the server.

### Exercise - Collections

Again using the javascript console and the BlogApp, complete the following tasks:

1. Notice the initialize function in ```blog_app.js```.  By saving the new collection of data to this.posts, where can the posts collection be accessed?
2. Using the posts collection, get all of the posts from the back end.
3. If you did not use ```Backbone.sync``` in the previous task, get all the posts using ```Backbone.sync```.
4. Create a new model object and persist it to the server at the same time.
5. Use ```findWhere``` to find the model whose id is 4.
6. Find a few models and set new values for the title or text.  Persist all of the data to the server using ```sync```.

## Model And Collection Events
Models and collections trigger events when data is altered.  It is possible for your views to listen to events on the model like add, change, reset, etc and then call the appropriate callback functions.

### Exercise - Backbone Collection Events

1. Look at ```app/assets/javascripts/views/post_test_view.js```.  Add code to the view that logs some message to the console every time an post is added to the posts collection.  Next, create a new view in the console, then add data to the collection. __Hint__ use the listenTo method on the view.
2. Write a similar method for the reset event, and trigger it somehow.
3. Write a similar method for the remove event, and trigger it somehow.
4. When exactly do these events get triggered in a collection?  Which events does ```fetch``` trigger?


## Resources

* [Backbone Docs](http://documentcloud.github.io/backbone/#)
* [Backbone Book - Models](http://addyosmani.github.io/backbone-fundamentals/#models-1)
* [Backbone Book - Collections](http://addyosmani.github.io/backbone-fundamentals/#collections)
