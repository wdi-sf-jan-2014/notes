# Better, Cleaner JS Views

## Objective

* Write cleaner and thinner JS views with templates and Backbone.View

## Group exercise - 5 minutes

Take 5 minutes and in groups of 4-5 people come up with your top 3 concerns or observations about writing JS that appends, removes, or updates DOM elements based on data that you get, delete, or update in your rails app via its JSON endpoints.

### List and discuss the findings from each group - 10 minutes

## Revisiting the Todo SPA - 10 minutes

### Whiteboard:

* A list of Todos may be represented as a `<ul></ul>` element. 
* The `<ul></ul>` contains the individual Todo items, represented as `<li></li>` elements.
* Each `<li></li>` contains:
	* a toggle button allowing the user to either check off or uncheck the todo
	* a label telling the user what the text of the todo is
	* a delete button for removing the todo item
	
### Group exercise - 5 minutes

Take 5 minutes and in groups of 4-5 people write as many things as possible that may happen to the `<ul></ul>` and its subviews at any level below `<ul></ul>`.

### List and discuss the findings from each group - 10 minutes

## Break - 5 minutes
---
## The responsibilities of views - 5 minutes

### Rendering themselves

### Responding to DOM events on themselves and their children

## Backbone.View Essentials - 5 minutes

### `initialize` function
### `tagName` property and its relationship to `view.el`
### `render` function
### `events` hash

## Introduce lab for the rest of the day

* Fork and clone [Spa App repo](https://github.com/wdi-sf-jan-2014/todo_spa), if you don't already have it
* `git fetch` from there and switch to the `with_backbone` branch
* Start the jasmine server by running `rake jasmine`
* [Run the specs](http://localhost:8888)
* You should have some specs passing, and some failing
* Refactor by moving the event handling functionality into the Backbone view
* Consider whether you need to create individual subviews
* Come up with new functionality of your own and build the views with Backbone.View
	* If you do this, see if you can write some specs for the new views/functionality

