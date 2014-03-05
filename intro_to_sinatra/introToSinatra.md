# Intro to Web Application Frameworks
## First Principles with Sinatra


| OBJECTIVE|
| :---    |
| We will use the concepts discussed in client-server model and request-response handling in a simple web application, use our first web application framework, and be able to build a simple web application.|

| Self-Assesment  |
| :---        |
| can setup a simple Sinatra App, i.e. just app.rb |
| know the basic file structure of an app, i.e. `/views`,`/stylesheets`|
| know the basic syntax of an app, keywords, and format of data |
| know the flow a request-response and the associatied scope |
| know routing within an App and the associated HTTP verbs|
| become familiar with erb |
| become familiar with REST-ful routing design|


|Connection to Larger Concepts|
| :---- |
| Demonstrate the use of HTTP verbage |
| Demonstrate the client-server model |
| Intro navigating file structure and serving content |
| Introduce a helpful Design Pattern (REST)|
| Configuration over Convention |

### Materials for Lesson

* `gem install sinatra` 
  * then `gem install sinatra-contrib`
*  `require "sinatra"` and `require "sinatra-reloader"`


## Pre-Thoughts -- Opening part I:
### (=< 15 min)

### Just a little File-Server
---

Webrick is a simple HTTP and HTTPS server in ruby. You'll see it a lot and it can help motivate looking at the `request` and `response` cycle.

With just a few lines of code we can start up a server to  server the files in a directory.
  
  require 'webrick'
  
  root = File.expand_path '.'
  server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
  trap "INT" do server.shutdown; end
  server.start
  
Hmmm... But what does this mean?


  require 'webrick'

  # File.expand_path just gets 
  # the absolute path for a given 
  # relative path, i.e. "." (the current directory)
  root = File.expand_path '.'
  
  # Sets the server to respond to localhost:8000
  # and servers the file specified as root
  server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
  
  # Needed to start and stop the server
  trap "INT" do server.shutdown; end
  server.start

In your terminal try the following,
  
  $ ruby app.rb
and hit `CTRL + C` to shut it down it.

  
Travel to [localhost:8000](localhost:8000) and check out *your* folder structure.

### Taking new routes
----
That's cool. This doesn't really demonstrate how to handle a `request` and a `response`.

If we wanted our server to handle a simple `request` and `response` their is a method called `#mount_proc`. With this we can define a `route` and tell the server how to *respond*.

  require 'webrick'

  root = File.expand_path '.'
  server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
  
  server.mount_proc '/hello' do |req, res|
   res.body = 'Hello, world!'
  end
  
  trap "INT" do server.shutdown; end
  server.start

> Now we can go to a whole new route [localhost:8000/hello](localhost:8000/hello). 

### A classy route 
---

Recall we had a lot of talk about `HTTP Verbs` and it would be nice to respond to those differently. Webrick lets you create a `servlet` to get more customized behavior.


  require 'webrick'

  root = File.expand_path '.'
  server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
  
  
  # Servlet
  class Simple < WEBrick::HTTPServlet::AbstractServlet
    # Handle the GET request
     def do_GET request, response

        response.status = 200
        response['Content-Type'] = 'text/plain'
        response.body = 'My new Hello, World!'
      end
  end
  

  server.mount "/hello", Simple
  
  trap "INT" do server.shutdown; end
  server.start
  

## Opening Part II: Sinatra 
### (=< 45 min)

[Sinatra in the wild](http://www.sinatrarb.com/wild.html)

The webrick example should feel motivational, but it's just way too much work for everything we want to be doing to have to look up the api information for each web server. People have created `middleware` to handle communication between a server and their web application logic, abstracting away lot of the madness. In Ruby, a popular middleware for doing this is called `Rack`.


### Abstracting away
-----

 in some `app.rb` file

  require 'rack'
  
  class HelloWorld
    def call(env)
      [200, {"Content-Type" => "text/html"}, ["Hello, Rack!"]]
    end
  end
  
  # Interface with our Webrick  server
  Rack::Handler::WEBrick.run HelloWorld.new, :Port => 8000


 In terminal try
  
  $ ruby app.rb
 
 > Note: The point here is that *Rack* is now handling the web server interface for us.
 
 
 
### A Framework is born
-----

The abstraction for the Middleware makes dealing with the webserver convient, but it doesn't necessarily try to simplify our application development process. In fact, there should be a simple way to write applications that should work with our middleware. This is our *Web Application Framework*, e.g. Sinatra and Rails.



## Code Along 
### Familiarizing ourselves with Sinatra 

Let's Setup:

  $ gem install sinatra

After install go to working directory and create an `/app.rb` file


  require 'sinatra'
  
  class App < Sinatra::Base
      #Routes
      #get is a request with relative url and a block to execute
      get '/' do
          'Hello, World!'
      end
  end

then we can run the application in terminal using

  $ ruby app.rb
  
 Navigate to [localhost:4567/](localhost:4567).  This is a classical sinatra app setup, and we will mostly stick to this.
 
 -----

 
 Right now, our application directory looks like
 
  /app_folder
    -/app.rb

As a differnt way of setting up a more modular app we make use of a  configuration setup in a seperate file called `config.ru`

`./app.rb`

  ### Change the require
  require 'sinatra/base'
  
  class App < Sinatra::Base
      #Routes
      #get is a request with relative url and a block to execute
      get '/' do
          'Hello, World!'
      end
  end

Add the following config file

`./config.ru`

  require './app'
  run App

Start the application in terminal using `rackup`

  $ rackup
  
will start the server on port "9292", i.e. go to [localhost:9292](localhost:9292), but we can change this using

  $ rackup -p 8000
  
However, note this deviates away from our more preferred classical setup, so we won't really be using it during instructional exercises.

----

### Gemfile and Sinatra-Reloader

Our folder structure is now

    /app_folder
      -/app.rb
      -/config.ru

Now, what if there are some gems we want to use with our app, but we want to keep track of for deployment later. We keep track of these gems in a `Gemfile`.


`Gemfile`

  gem 'sinatra'
  # Useful contributions to sinatra
  gem 'sinatra-contrib'
  gem 'pry'
  
Then we install them using `bundler`

  $ bundle install 

which will create a `Gemfile.lock` with the current setup of your app, and a `.bundle` folder with an `install.log`. Our file structure has now evolved into the following

  
    /app_folder
      -/app.rb
      -/config.ru
      -/Gemfile
      -/Gemfile.lock
      -/.bundle
        -/install.log
        
Let's make use of `sinatra/relaoder` that comes with the `sinatra-contrib`, so we don't have to keep stopping and starting our server for every change.

`./app.rb`

  require 'sinatra'
  require 'sinatra/reloader'

    get '/' do
        'Hello, World'
    end

or if you were using that `config.ru` setup, you'll need to write

`./app.rb`

  require 'sinatra/base'
  require 'sinatra/reloader'
  
  class App < Sinatra::Base
      configure :development do
       register Sinatra::Reloader
      end
      
      get '/' do
          'Hello, World'
      end
  end

---


## Routing and HTTP verbs
How does Sinatra "handle" requests?

Answer: Routes! 

*Routes* are essentially an HTTP method and a regular expression to match the requested URL.

e.g. 

How does Sinatra use it?
    
    Sinatra will look through each handler you've defined in the order you've     defined them and use the first handler it finds that meets the criteria.     For this reason, you should put your most specific handlers on top, and     your most vague handlers on the bottom. 

