###Resources: 

- http://guides.rubyonrails.org/routing.html
- http://guides.rubyonrails.org/action_controller_overview.html
	
	
##Controller Overview

*DIAGRAM* - Review MVC and Rails folders

We already know 'controller type' objects from pre-rails days. Examples ...

Controller is the C in MVC. After routing has determined which controller to use for a request, your controller is responsible for making sense of the request and producing the appropriate output. Luckily, Action Controller does most of the groundwork for you and uses smart conventions to make this as straightforward as possible.

Controllers are like the glue between Views and Models.

In Rails, Controllers are subclasses of ApplicationController.

Another way to look at it: Controller creates an HTTP response and sends it back to the browser. Usually the response is an HTML page, sometimes something else.

Any ideas what Controller might generate aside from HTML?


###CRUD, REST and Resource Routing

Introduce concept of CRUD

CRUD stands for Create, Read, Update and Delete - the four basic functions of persistent storage 

Example: SQL

*DIAGRAM* - table

Operation			SQL	  			HTTP / RAILS
Create				INSERT	 		POST
Read (Retrieve)		SELECT			GET
Update (Modify)		UPDATE			PUT/PATCH
Delete (Destroy)	DELETE			DELETE

*see also 'photos' resource example in: http://guides.rubyonrails.org/routing.html*

Now the CRUD pattern is also applied to network applications, more specifically web applications. Here it's called REST

Representational state transfer - REST is an architecture style for designing networked applications.

RESTful applications use HTTP requests to post data (create and/or update), read data (e.g., make queries), and delete data. Thus, REST uses HTTP for all four CRUD (Create/Read/Update/Delete) operations.

For most conventional RESTful applications, the controller will receive the request (this is invisible to you as the developer), fetch or save data from a model and use a view to create HTML output. If your controller needs to do things a little differently, that's not a problem, this is just the most common way for a controller to work.

###Naming convention

The naming convention of controllers in Rails favors pluralization of the last word in the controller's name

> ClientsController, MoviesController, PlanesController

**Following this convention** will allow you to use the default route generators. 


###Methods and actions, instance variables, parameters

A controller is a Ruby class which inherits from ApplicationController and has methods just like any other class. 

Controller can have instance variables which can be used in Views (remember Sinatra?)

> Show instance variables, use <%= debug @something %>

Delmer introduced the **Rails Router** yesterday. The Rails router recognizes URLs and dispatches them to a controller's action. It can also generate paths and URLs, avoiding the need to hardcode strings in your views.

> Look at routes file: config/routes.rb

Rails does REST routing out of the box, it's called **Resource Routing**. The 'resource' is the thing (Object) that is being CRUDed. 

> in routes.rb: replace routes with 
> **resources :movies**

> Show rake routes

> Show mock sample resources :books , access and inspect error messages, very neat.

> rake routes again

Let's look at the Controller in **app/controller/movies_controller.rb**:

####show
	def show
    	@movie = @@movie_db.find do |m|
      		m["imdbID"] == params[:id]
    	end
    	binding.pry
    	if @movie.nil?
      		flash.now[:message] = "Movie not found" if @movie.nil?
      		@movie = {}
    	end
	end
	
**demo binding.pry**
	
###The Flash

The flash is a special part of the session which is cleared with each request. This means that values stored there will only be available in the next request, which is useful for passing error messages etc.

By default, adding values to the flash will make them available to the next request, but sometimes you may want to access those values in the same request. For example, if the create action fails to save a resource and you render the new template directly, that's not going to result in a new request, but you may still want to display a message using the flash. To do this, you can use flash.now

In general, use **flash.now**, it'll do what you want.

###Creating Responses … rendering different things

by default, rails controller render HTML

But it can also render nothing:

	def nada
		render nothing: true
	end	

add route: get 'nada' => 'movies#nada' - inspect response in Chrome developer console

Way more useful is rendering json. This comes in handy when you build your own APIs, like omdb. Let's add the option to add json and xml to the index page

	respond_to do |format|
    	format.html
    	format.json { render :json => @@movie_db }
    	format.xml { render :xml => @@movie_db.to_xml }
	end

To get jsown, request URL .../movies.json  Voila!


### A word about integrating bootstrap

Find gem or download files? Your call. Options:

http://stackoverflow.com/questions/18371318/installing-bootstrap-3-on-rails-app

### Remaining REST methods

####edit

	def edit
   		@movie = @@movie_db.find do |m|
      	m["imdbID"] == params[:id]
    	end

    	if @movie.nil?
      		flash.now[:message] = "Movie not found" if @movie.nil?
      		@movie = {}
    	end
	end

####create

	def create
    	# create new movie object from params
    	movie = params.require(:movie).permit(:title, :year)
    	movie["imdbID"] = rand(10000..100000000).to_s
    	# add object to movie db
    	@@movie_db << movie
    	# show movie page
    	# render :index
    	redirect_to action: :index
  	end

##Lab 01/22/14

Extend the movie app:
  	
####update

	implement
	
####destroy

	implement
 

#### add bootstrap navigation bar 

- nav bar shall have links to new, edit and home page

####add 'search' feature (that's not REST)

- Add a new view with a search box (or incorporate into exiting view)
- Add search controller method
- Make OMDB API call retrieving movies
- Add each movie to the movie_db, redirect to home page
 	