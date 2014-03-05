#Introduction To Rails

##Major Principles:
- Convention over configuration
- ["Rails is omakase"  -DHH](http://david.heinemeierhansson.com/2012/rails-is-omakase.html)
- DRY, Don't Repeat Yourself

##Model View Controller
- What is it? Why use it?
- What was it like before?

  *Models* are your business objects describing the structure and behavior of the problem your application is trying to solve. These are usually backed by an Object-Relational-Mapping framework that persists your objects to a database in the background.

  *Views* are the templates that render data to the user and all the logic surrounding presentational aspects of your app.

  *Controller* sits at the heart of everything, processing requests from clients, initiating changes in the models and triggering the rendering of the templates.

##Create a Rails Project
```rails new blog```

##Directory Structure
- MVC directories
- Environment file
- Assests folder
- Gemfile + Bundle

##Start & stop Rails
- Port numbers
- Console
- Generate models & controllers: generators

##Exercise:
- Create 10 controllers
- Ignore 9 controllers
- Create a controller with actions