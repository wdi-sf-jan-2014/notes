# Responding with JSON

We often want our applications to respond to HTTP requests with a __data transfer__ format like JSON rather than a __markup language__ like HTML.  In your own work, you have made requests to APIs that return JSON.  Another reason which will be more concrete next week is that if you write Javascript code which makes AJAX requests from your user's browser, that code will be much easier to write if your site can return JSON responses.  

Our mini-project this week will require you all to make websites which interact with each other.  You will all expose the same JSON API, and once your sites are working, they will come together into a distributed system which will allow data to spread across the network. 

## Today's Agenda

  *  Review responding with formats in Rails
  *  Discuss appropriate responses for JSON POSTs
  *  Revisit CSRF protection
  *  Specify our errors
  *  Review deadlock
  *  JSON endpoints exercise

## Rails Format JSON

In our Rails controller lesson, we introduced the idea of responding to different __formats__ with different code.  A user or client of our applicaiton might access our resource and want our response in one of a variety of different formats.  The two main formats we will use are HTML for browsers which want to render a web page, and JSON for browsers or any other client type which wants just data.

Recall our example from the [Rails controller lesson](/rails_controllers_rest/RailsController.md):

```
respond_to do |format|
    format.html
    format.json { render :json => @@movie_db }
    format.xml { render :xml => @@movie_db.to_xml }
end
```

Each method on the object passed to the respond_to block corresponds to a format.  The json block is called for a request which ends in ".json" and so on.  In this way, we can specify a block for each kind of response.  If there are queries that we only need to do for HTML responses, we can do it in the format.html response.  If there are queries we only need to for JSON responses, we can do them in the block.

## To_JSON in detail

Rails's `render :json => <object_to_render>` functionality calls `to_json` on whatever you pass to it, and that calls `as_json`.  `as_json` takes a variety of options which can be used to bring in associations, include or exclude fields and more.

[http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json](http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json)
			
## Responding to JSON posts

It doesn't make sense to respond to a successful JSON POST to a create endpoint with a redirect.  Instead, you should respond with a 2xx and whatever information the client might need, like the id of the created record.  Here is an example of one acceptable response code scheme for successful requests.

| RESTful request | HTML response code | JSON response code |
|:---------------:|:------------------:|:------------------:|
| index           | 200                | 200                |
| new             | 200                | 404                |
| create          | 302                | 201 (200 is OK)    |
| show            | 200                | 200                |
| edit            | 200                | 404                |
| update          | 302                | 200                |
| delete          | 302                | 200                |

The new and edit actions are for showing forms, which don't exist for clients other than browsers.  Responses on errors will be different also.  An attempt to __show__ a non-existent record might give a 404 to a json client and redirect an html client to a search page.  A good JSON endpoint will return an error in a JSON format.

To make decisions about this, read the documentation of various JSON apis and commentary comparing them.  Here are some examples:

  * https://dev.twitter.com/docs/error-codes-responses
  * https://blog.apigee.com/detail/restful_api_design_what_about_errors
  * http://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/APIError.html
  
As you use APIs and decide which ones you like working with, and which ones you despise, you'll develop opinions about how APIs should be designed.
  

## CSRF protection with JSON POSTS

The default `exception` policy of responding to requests prevents a JSON post to an endpoint without a CSRF token.  Since the main reason for CSRF protection is to prevent session hijacking, we can change the policy in `ApplicationController` to `null_session`.  That means we process requests without CSRF tokens as if there was no session cookie in the request.

```
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
  protect_from_forgery with: :null_session
end
```

## Rescue from and specifying your errors

When you write an API, you are writing an interface for other programmers to use.  Your errors should be sensible.  When you use strong parameters to specify permitted parameters, if a parameter is missing, it raises an ActionController::ParameterMissing exception.  For a JSON request, we should render a JSON response:

```
  rescue_from ActionController::ParameterMissing, :only => :create do |err|
    respond_to do |f|
      f.html do 
        redirect_to new_site_path
      end
      f.json {render :json  => {:error => err.message}, :status => 422}
    end
  end
```

## Concurrency and deadlock

* Dining philosophers
* Deadlocked server demo
	

