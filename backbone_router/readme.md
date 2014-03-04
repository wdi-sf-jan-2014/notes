# The Backbone Router

### Our objective is to use Backbone Router to make multi-view client side apps which work smoothly with the browser and user.

## Agenda

* Review the Backbone View
* Look at some examples of client side apps
* A Few Principles of Client Side UX
* Backbone Router basics
* What's the point?

## Backbone View Review

What do Backbone Views do?

* Render HTML
* Render subViews
* Handle Events
* Update themselves

## Client Side Apps

* [Farm Fresh to You](http://www.farmfreshtoyou.com/) has client side components, does not use backbone, and is a little infuriating.
* [USA Today](http://www.usatoday.com/) uses Backbone
* [Hulu](http://www.hulu.com/) uses Backbone, try looking at the `Hulu` object in the JS console.
* [Kahn Academy](https://www.khanacademy.org/science/physics/) uses backbone in the topic pages
* [Trello](https://trello.com) uses Backbone

## A Few Principles of Client Side UX

Well designed Javascript maintains the web standard user flow.  Try to not make the web worse with your javascript code.

>If I'm looking at some content, I should be able to copy the contents of the address bar, send the link to someone else, and they should see the same content if it is public.  

>If I click through a link, then go back, I should be looking at the same content.

>When I click or interact with the page in some other way, I should see the page react.

These are basic principles which will help you not make your users angry and sad.

## The Backbone Router Basics

The essence of routing in Backbone is that we want to simulate changing pages without actually changing the page.  Our router object has a list of routes, and when we are simulating changing a page, we call `router.navigate("routeName")`, or `router.navigate("routeName", {trigger: true)` if we want the callback to run.  Unlike a Rails controller and router, we don't use the Backbone Router to deal with deletions or updates, just simulated GETs which we want to go into the browser history.

```
App.Routers.Main = Backbone.Router.extend({

  routes: {
    "path":                 "callbackName", 
    "anotherPath/:param":   "otherCallback",
  },
	
  callbackName: function(){
    // Do whatever you want to do when /path is visited.
    // This is a analagous to a controller action.
  },
	
  otherCallback: function(param){
  
  }

});

$(function(){
	App.router = new App.Routers.Main();
	Backbone.history.start({pushState: true})
});
```

## The Docs

Remember to look at the docs: `http://backbonejs.org/#Router`

## The Assignment

Integrate the backbone router into the SpaTodos app, and add a show view for a single task which has space for a more detailed description.  I've set up a branch `backbone_router_lab` in the github repo at `https://github.com/wdi-sf-jan-2014/todo_spa`.  Get that branch and work from there. 
