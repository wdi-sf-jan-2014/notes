##Objectives

- Understand user authentication and password encryption
- Understand sessions
- Learn about input validation and validators
- Learn how integrate new features into existing code base.

##Intro

Virtually all web applications require a login and authentication system of some sort. Today we build one into an existing rails app. 

The idea is that users should be able to create a profile and access it using a secure password. Certain features shall be restricted to authenticated users only. 

We are going to learn how to use session objects to *maintain state* during visits.

Along the way, we are going to introduce a few new concepts:

- Validators
- Callbacks
- Sessions & Cookies
- Encryption
- Modules

####Preparation

Starting point:

Fork 

> https://github.com/aikalima/wdi6_cook_book_blank

and clone to local workspace

Follow instructions in README, launch app, look around.

*Let's take a tour…*

##Authentication ... and authorization

There are a couple of gems that provide authentication and authorization out of the box. For example: Clearance, Authlogic, Devise. Some gems provide authorization functionality only, like CanCan. 

What's the difference between authentication and authorization?

Why roll your own?

- Practical experience shows that authentication on most sites requires extensive customization, and modifying a third-party product is often more work than writing the system from scratch. They often are a black box.

- When you write your own system, you are far more likely to understand it. 

- It's easy to build one and a great learning experience. That's what we are going to do today.


##Sessions

DIAGRAM

Inspect browser cookies:

> chrome://settings/cookies

In Rails, your application has a session for each user in which you can store small amounts of data that will be persisted between requests. The session is only available in the controller and the view.

We’ll be using sessions to implement the common pattern of “signing in”, and an optional “remember me” checkbox for persistent sessions, and automatically remembering sessions until the user explicitly signs out.

Rails uses a cookie to store a unique ID for each session. You must use a cookie, Rails will not allow you to pass the session ID in the URL as this is less secure.

What is a cookie? http://en.wikipedia.org/wiki/HTTP_cookie

This ID is used to look up the session data on the server, e.g. in a database table.

>     <%= debug(session) if Rails.env.development? %>

Let's get started.

##Hands on

OK, thinking about users, profiles, authentication, passwords etc. What are some of the features or components that you anticipate in your app:

- Sign in Page
- Sign Up page
- Sign out button
- User Page (like a profile)
- A secure password, please
- Session, so system knows who I am during visit.
- User Model

*Discuss how to start*

**Models** 

- User

**Controllers**

- User
- Session

**Routes**

- signin
- signup
- signout
- user page

Let's start with routes. "Top down". Get the easy stuff out of the way:

###Routes

> config/routes.rb

	resources :books, :recipes, :ingredients, :users, :sessions

	get '/signup' => 'users#new'
 	delete '/signout', to: 'sessions#destroy'
	get'/signin' => 'sessions#new'

###Controllers

Let's go and create controller stubs:

> rails g controller users new show create

> rails g controller sessions new destroy

Confirm that controllers were generated properly.

###Models

In routes config, we added two resources: users and sessions. How many Models? **Only one, User**! Sessions are transient, not permanent.

Let's start simple, User has a name and email:

> rails generate model User name:string email:string
> rake db:migrate

Let's learn a new gem. Everybody run:

> gem install annotate

then

> annotate

Check out models/user.rb - nice!

####Let's talk about passwords

We want passwords to be stored securely, that means we have to encrypt it. Go to Gemfile, verify that is contains: 

> gem 'bcrypt-ruby','3.0.1'

Got to: http://bcrypt-ruby.rubyforge.org/ - see what it does.

Let's add encrypted password to the User model:

We’ll start with the necessary change to the data model for users, which involves adding a password_digest column to the users table. The name digest comes from the terminology of cryptographic hash functions. By encrypting the password properly, we’ll ensure that an attacker won’t be able to sign in to the site even if they manage to obtain a copy of the database.

Create migration:

> rails generate migration add_password_digest_to_users password_digest:string

Inspect generated migration file.

> rake db:migrate
> annotate

####Password and Password confirmation

We expect to have users confirm their passwords, a common practice on the web. We could enforce this at the controller layer, but it’s conventional to put it in the model and use Active Record to enforce the constraint. Remember: Skinny Controllers / Fat Models.
 
The method is to add password and password_confirmation attributes to the User model, and then require that the two attributes match before the record is saved to the database.

Unlike the other attributes we’ve seen so far, the password attributes will be **virtual—they will only exist temporarily in memory**, and will not be persisted to the database. These virtual attributes are implemented automatically by

> has_secure_password

Simply add has_secure_password to the User Model and make password attributes accessible:

	class User < ActiveRecord::Base
  		attr_accessible :email, :name, :password, :password_confirmation

  		has_secure_password
	end

*For explanation, go to http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password*

has_secure_password adds *authenticate* method to User objects, so you can do:

> user.authenticate(password)

OK, this is good for now. Obviously, we would like to add password validation, checking for existence and minimum length. We defer on that for now.

Let's try what we have in Rails console.

###YOU DO - rails console (5 min)

**create user with password in rails console, inspect result**

Works!

###Views

Let's talk about the UI. We need:

- Sign in page: email, password, 'sign in' button
- Sign up page: name, email, password, password confirmation, 'sign up' button
- Sign out: It's just a link
- Profile page: display user info

Take a look at layouts/application and _header files. The content is yielded in a bootstrap grid column spanning 10 cols. That's where our pages will go.

###YOU DO - complete forms (25min)

**create views/users/new.html.erb**

	<h1>Sign up</h1>

	<div class="row">
  		<div class="span6 offset3">
    	
    		FORM GOES HERE
    		
    	</div>
	</div>


**create views/users/show.html.erb** (profile page)

	<div class="row">
  		<aside class="span4">
    		USER INFO GOES HERE
  		</aside>
	</div>

**create views/sessions/new.html.erb** (sign in page)


	<h1>Sign in</h1>

	<div class="row">
  		<div class="span6 offset3">
			FORM GOES HERE
  		</div>
	</div>

Verify that views work:

**Show:** http://localhost:3000/users/1

**Error: add dummy data to show method**

	def show
		@user = User.new
		@user.name = "Markus"
		@user.email = "abc@ddd.com"
	end

**New:** http://localhost:3000/signup

**Error: add dummy data to new method**

    @user = User.new
    
**New:** http://localhost:3000/signin   

**Finally, add links to nav**

	<ul class="nav pull-right">
            <% if signed_in? %>
              <li><%= link_to "My profile", current_user %></li>
              <li>
                <%= link_to "Sign out", signout_path, method: "delete" %>
              </li>
            <% else %>
              <li><%= link_to "Sign up", signup_path %></li>
              <li><%= link_to "Sign in", signin_path %></li>
            <% end %>
    </ul>

**All is good** 

###Controllers

Let's work on those controllers

###sessions_controller.rb

**create method** -> sign in ! Here is what it needs to do:
It shall:

- find user by email
- display error if user not found
- authenticate user
- display error if not authenticated
- if OK, redirect to user page (profile)


		def create
    		signin_params = params[:session]
    		user=User.find_by_email(signin_params[:email].downcase)
    		if user && user.authenticate(signin_params[:password])
      			# Sign the user in and redirect to the user's show page.
      			# sign_in user
      			redirect_to user
    		else
      			# Create an error message and re-render the signin form.
      			flash.now[:error]='Invalid email/password combination'
      			render :new
    		end
  		end


**destroy method** -> sign out !

	def destroy
      # sign_out
      redirect_to root_url
	end	

###users_controller.rb
  	
User controller implements RESTful methods. The **create** method is special. It also sign in user.	
  	
	def show
    	@user = User.find(params[:id])
  	end

  	def new
    	@user = User.new()
  	end

  	def create
    	@user=User.new(params[:user])
    	if @user.save
      		flash[:success] = "Welcome to the Cook Book app!"
      		# sign_in @user
      		redirect_to @user
    	else
      		render'new'
    	end
  	end

  	def update
    	@user = User.find(params[:id])
    	@user.update_attributes(params[:user])
    	render :show
  	end
  
    	
###Remember Token

Because HTTP is a stateless protocol, web applications requiring user signin must implement a way to track each user’s progress from page to page. One technique for maintaining the user signin status is to use a traditional Rails session (via the special session function) to store a remember token equal to the user’s id:

Don't use user ID, it can be spoofed. So let's add remember token to User Model:

 > rails generate migration add_remember_token_to_users
 
Edit migration file:
 
	class AddRememberTokenToUsers < ActiveRecord::Migration
  		def change
    		add_column :users, :remember_token, :string
    		add_index  :users, :remember_token
  		end
	end

Run:

 > rake db:migrate
 
Verify db/schema.rb, make sure it contains the new colum in user table:

	create_table "users", :force => true do |t|
		t.string   "name"
		t.string   "email"
		t.datetime "created_at",      :null => false
		t.datetime "updated_at",      :null => false
		t.string   "password_digest"
		t.string   "remember_token"
	end
 
The remember_token introduces several new elements to the User model (app/models/user.rb). First, we add a callback method to create a remember token immediately before creating a new user in the database:

> before_create :create_remember_token
 
In User Model, add a method that creates token. It's a *private* method, i.e. it cannot be called from outside the class, it's hidden from the world.

	private

  		def create_remember_token
    		self.remember_token = SecureRandom.urlsafe_base64
  		end 

and add "callback":

	before_save :create_remember_token
	

###SessionsHelper
  	
Now we can signin / sign out user, but it's not persisted in the session, the signin info is basically gone after the request completed.

We’re now in a position to start implementing our signin model, namely, remembering user signin status “forever” and ending the session only when the user explicitly signs out. The signin functions themselves will end up crossing the traditional Model-View-Controller lines; in particular, **several signin functions will need to be available in both controllers and views.** 

Ruby provides a module facility for packaging functions together and including them in multiple places, and that’s the plan for the authentication functions. 

We could make an entirely new module for authentication, but the Sessions controller already comes equipped with a module, namely, SessionsHelper.

Moreover, such helpers are automatically included in Rails views, so all we need to do to use the Sessions helper functions in controllers is to include the module into the Application controller 


**Here's the SessionHelper code** 

	def sign_in(user)
    	cookies.permanent[:remember_token] = user.remember_token
    	# current_user is avilable in controllers and views!
    	# This is an is an assignment, which we must define - see below
    	# note that next line is a call to setter 'def current_user=(user)' below
    	current_user = user
  	end
   
	def signed_in?
    	!current_user.nil?
  	end

	# Authorization: signed_in_user is called in a before_filter
  	# callback in each controller, see books/ingredients/recipe controllers
  	# Ensures access to create/edit functions on if signed in.
  	def signed_in_user
    	unless signed_in?
      		# If not signed in, save current location in session object
      		# to be able to redirect after successful sign in.
      		session[:return_to] = request.url
      		# prompt sign in page
      		redirect_to signin_url, notice: "Please sign in."
   	 	end
  	end

  	# signs out user by deleting @current_user and session cookie
  	def sign_out
    	@current_user = nil
    	cookies.delete(:remember_token)
  	end

  	# Getter and setter for @current_user
  	def current_user=(user)
    	@current_user = user
  	end

  	# if current_user doesn't exist, check session cookie for user session
  	# If exists, get the user record that belongs to that session.
  	def current_user
    	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  	end
      

Important: include SessionsHelper Module in application_controller.rb

	include SessionsHelper

Allow access to edit features only for signed in users: books_controller.rb / ingredients_controller.rb / recipes_controller.rn

	before_filter :signed_in_user, only: [:create, :new, :edit, :update]


Now use: Use sign_in , sign_out methods in user and session controllers.


      		













