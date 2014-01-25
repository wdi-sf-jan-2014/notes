# Rails View
* <h3> Understand steps to set up rails app. </h3>
	* <h4> Start Sublime</h4>
	* <h4> Edit Gemfile - 'pry'</h4>
	* <h4> Bundle Install</h4>
	* <h4> Edit .gitignore file</h4>
	* <h4> Add Bootstrap</h4>
* <h3> Understand steps to get rails app running.</h3>
	* <h4> Setup first route</h4>
	* <h4> Setup first Controller</h4>
	* <h4> Setup first View page</h4>
* <h3> Understand helpers: link_to, form_for, button_to</h3>
* <h3>Understand partial files and how "render partials".</h3>
* <h3>Build out views and routes</h3>


## Start a Rails App
	$ rails -v
	$ rails new movies 
	
## Start Sublime:
	# change to the new project directory
	$ cd movies
	
	# ope Sublime
	$ subl .

## Edit Gemfile:
		source 'https://rubygems.org'
		ruby '2.0.0'
		
		gem 'rails', '4.0.2'
		
		gem 'sqlite3'
		
		gem 'pry', :group => :development
		
		# Use SCSS for stylesheets ..... rest stays the same ...	
* <h3> Run bundle install.</h3>

		$ bundle install
		$ bundle update
	
## Now Edit the ".gitignore" File. 
* <h3>Files listed in the .gitignore file will not be available to add, commit and push to github. They will be ignored!</h3>
* <h3>Ignore other unneeded files.</h3>
		
		# Ignore other unneeded files
		doc/
		*.swp
		*~
		.project
		.DS_Store
		.idea
		.secret

## Add Bootstrap
* <h3>Copy bootstrap.min.css into app/assets/stylesheets directory</h3>
* <h3>Copy bootstrap.min.js into app/assets/javascripts directory</h3>
## Let's try it:
	$ rails s
	# Got to localhost:3000
	# Should see default page
	

## Add routes

* <h3>Edit config/routes.rb</h3>
	
		Movies::Application.routes.draw do
			
			root 'movies#index'
		
		end
 
* <h3>Reload "localhost:3000" and review error message.</h3>
* <h3>The error message says we need a controller, we do!</h3>


## Generate controller:


		$ rails generate controller movies 
		
		# Convention: controller names are plural and written in CamelCase. 
		# This will create an actual controller name that is in snake_case.
		
		# if you used the wrong name and want to undo the controller generation use:
		$ rails destroy controller movies
		
		
* <h3> Reload "localhost:3000" and review error message.</h3>
* <h3> The error message says we need an index method in our controller, let's make one!</h3>

## Create index method
	class MoviesController < ApplicationController
	
		def index
		end
		
	end
* <h3> Reload "localhost:3000" and review error message.</h3>
* <h3> The error message says we have a missing template movies/index. We are getting there!</h3>

## Create app/views/movies/index.html.erb
	<h1>Rails Movie App</h1>

* <h3> Reload "localhost:3000" - page should load!</h3>

## Controller Instance Variables
* <h3>Let's create some controller instance variables.</h3>
* <h3> app/controllers/movies_controller.rb:</h3>

		class MoviesController < ApplicationController
		    @@movies_db = [
					{"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "type"=>"movie"},
					{"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "type"=>"movie"},
					{"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "type"=>"movie"}]

			def index
				@movies = @@movie_db				
			end
			
		end

## Re-open app/views/movies/index.html.erb
	<h1>Rails Movie App</h1>
	
	<% @movies.each do |movie| %>
	
	  <!-- <a href="/movies/<%#= movie['imdbID'] %>"><%#= movie["title"] %></a> - <%#= movie["year"] %></br> -->
	  
	  <%= link_to movie["title"], movie_path(movie['imdbID']) %> - <%= movie["year"] %></br>
	  
	  <%= button_to "delete", {controller: :movies, action: :destroy, id: movie["imdbID"] }, :method => :delete %>
	  <%= button_to "edit", {controller: :movies, action: :edit, id: movie["imdbID"] }, :method => :get %>
	
	<% end %>
	
	<%= link_to 'Add Movie to DB', new_movie_path %>


* <h3>Edit config/routes.rb</h3>
	
		Movies::Application.routes.draw do
			
			root 'movies#index'
			
			get 'movies'  => 'movies#index', as: :movies
			
			get 'movies/:id/edit' => 'movies#edit', as: :edit_movie
			
			get 'movies/:id' => 'movies#show', as: :movie
			
			get 'movies/new' => 'movies#new', as: :new_movie
			
			patch 'movies/:id' => 'movies#update'
			
			delete 'movies/:id' => 'movies#destroy'
		
		end

## Create and open app/views/movies/new.html.erb
	
	<h2>Add movie to database</h2>

	<form action="/movies" method="post">
	  Title: <input name='movie[title]' type="text" /><br>
	  Year: <input name='movie[year]' type="text" />
	  <input name="commit" type="submit" value="Create" />
	</form>

	<h2>Add another movie</h2>
	<%= form_for :movie, url: new_movies_path do |f| %>
	  <%= label_tag(:title, "Title:") %> <%= f.text_field :title %></br>
	  <%= label_tag(:year, "Year:") %> <%= f.text_field :year %></br>
	  <%= f.submit "Create" %>
	<% end %>

## Add new method to controller

	def new
    end

## Create a partial file: _form_new.html.erb
	<%= form_for :movie, url: new_movies_path do |f| %>
	  <%= label_tag(:title, "Title:") %> <%= f.text_field :title %></br>
	  <%= label_tag(:year, "Year:") %> <%= f.text_field :year %></br>
	  <%= f.submit "Create" %>
	<% end %>
## Edit new.html.erb
	
	# delete the old html form, add render partial statement
	
	<h2>Add movie to database</h2>
	<%= render  partial: "form_new" %>

## Add show method to controller

	def show
    	@movie = {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "type"=>"movie"}
    end
## Create and edit show.html.erb

	<h1>Show Movie</h1>

	<p style="color:red"><%= flash[:message] %></p>

	<h3><%= @movie["title"] %></h3> The year is <%= @movie["year"] %>

	<p><%= link_to "Back", :back %></p>

## Add edit method to controller
	def edit
    	@movie = {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "type"=>"movie"}
    end

## Create and edit edit.html.erb

	<h2>Edit movie</h2>

	<form action="/movies/<%= @movie["imdbID"]%>" method="post" >
	  <input name="_method" type="hidden" value="patch" />
	  Title: <input name='movie[title]' type="text" value="<%= @movie['title'] %>" /><br>
	  Year: <input name='movie[year]' type="text" value="<%= @movie['year'] %>" />
	  <input name="commit" type="submit" value="Save changes" />
	</form>
	
	<%= form_for :movie, method: :patch, url: movie_path do |f| %>
		<%= label_tag(:title, "Title:") %> <%= f.text_field :title, value: @movie['title'] %></br>
		<%= label_tag(:year, "Year:") %> <%= f.text_field :year, value: @movie['year'] %></br>
		<%= f.submit "Save Changes" %>
	<% end %>
	
	
* <h3> Exercise: </h3>
	* <h4> Move the "form_for" in edit.html.erb into a partial.</h4>
	 
		



## Additional Reading / Reference - rubyonrails.org
* <h4>Getting Started: http://guides.rubyonrails.org/getting_started.html</h4> 
* <h4>Action View: http://guides.rubyonrails.org/action_view_overview.html#localized-views</h4>
* <h4>Layouts and Rendering: http://guides.rubyonrails.org/layouts_and_rendering.html</h4>
* <h4>Form Helpers: http://guides.rubyonrails.org/form_helpers.html</h4>
* <h4>Button Tag Documentation: http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-button_tag</h4>