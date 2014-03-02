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

## Backbone templates with underscore - 5 minutes

## Introduce lab for the rest of the day

Using the backbone.js docs and the basic knowledge you have gained from this lesson, build a view hierarchy for the Todos example, which we had discussed. Use underscore.js templates for rendering views, or handlebars templates. The choice is up to you, but you'll need to do some research on how to combine handlebars with backbone.js.