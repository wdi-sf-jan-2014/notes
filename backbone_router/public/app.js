window.App = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  start: function(){
    this.router = new this.Routers.Main();
    Backbone.history.start({pushState: true});
    this.makeNav();
  },

  makeNav: function(){
    var view = new this.Views.Nav();
    $('#header').html(view.render().$el);
  }
};

App.Routers.Main = Backbone.Router.extend({
  routes: {
    "other(/:param)": "other",
    "": "main",
    "*actions": "defaultRoute"
  },

  main: function(){
    var view = new App.Views.Index();
    $('#main').html(view.render().$el);
  },

  other: function(param){
    var view = new App.Views.Other({model: param});
    $('#main').html(view.render().$el);
  },

  defaultRoute: function(){
    $('#main').text("Default");
  }
});

App.Views.Index = Backbone.View.extend({
  tagname: "div",
  id: "greatDiv",
  render: function(){
    this.$el.text("Index Route");
    return this;
  }
});

App.Views.Other = Backbone.View.extend({
  tagname: "div",
  render: function(){
    var text = "Other Route";
    if(this.model){
      text += ".  Param is: " + this.model;
    }
    this.$el.text(text);
    return this;
  }
});

App.Views.Nav = Backbone.View.extend({
  tagname: "div",
  events: {
    "click a": "linkClicked"
  },
  render: function(){
    this.$el.html('<a href="/">Index Route</a> <a href="/other">Other Route</a>');
    return this;
  },
  linkClicked: function(event){
    event.preventDefault();
    var path = event.target.pathname;
    App.router.navigate(path, {trigger: true});
  }
});

$(function(){
  // this code obviously belongs in a model or collection
  // but, we're not talking about models or collections just yet :)
  App.start();
});