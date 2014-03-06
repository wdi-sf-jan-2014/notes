BlogApp.Collections.Posts = Backbone.Collection.extend({
  model : BlogApp.Models.Post,

  url : '/posts'

});