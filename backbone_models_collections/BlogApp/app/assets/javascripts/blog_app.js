window.BlogApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.posts = new this.Collections.Posts();
  }
};

$(document).ready(function(){
  BlogApp.initialize();
});