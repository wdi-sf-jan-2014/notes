###Resources:

- http://www.howtogeek.com/56002/htg-explains-how-does-email-work
- https://en.wikipedia.org/wiki/Email
- http://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol
- http://guides.rubyonrails.org/v2.3.8/action_mailer_basics.html


Intial version of demo app, without ActionMailer:

- https://github.com/aikalima/wdi6_cook_book_forgot_blank

Final version of demo app, using ActionMailer

- https://github.com/aikalima/wdi6_cook_book_forgot_final

##Objectives

- Understand basics of emails
- Learn how to send email from the command line
- Understand how to send emails from your Rails application

##Intro

The idea of email originated in the early 60s, way before the world wide web. Our forebearers just figured out how to connect computers - now what? Send messages!

Various forms of one-to-one electronic messaging were used in the 1960s. People communicated with one another using systems developed for specific mainframe computers. As more computers were interconnected standards were developed to allow users of different systems to e-mail one another. **SMTP** grew out of these standards developed during the 1970s.

**Simple Mail Transfer Protocol (SMTP)** is an Internet standard for electronic mail (e-mail) transmission across Internet Protocol (IP) networks. 

An Internet email message consists of three components:

- the message envelope
- the message header
- and the message body

The **message envelope** is like the addresses on the outside of an envelope, which are used by mail transport software to route and deliver the email

The **message header** contains control information like an originator's email address and one or more recipient addresses. Usually descriptive information is also added, such as a subject header field and a message submission date/time stamp.

the **message body** contains the actual email text, like an HTTP body contains html.

Today's email systems are based on a store-and-forward model. Email servers accept, forward, deliver, and store messages. Neither the users nor their computers are required to be online simultaneously; they need connect only briefly, typically to a mail server, for as long as it takes to send or receive messages.

*Quick looks at diagram*

http://www.howtogeek.com/56002/htg-explains-how-does-email-work

###Send an email 'old school'

>  echo "Hello" | mail -v -s "Test" mguehrs@gmail.com
>  
>  echo "To me …" | mail -v -s "Test 2" markus


##Email in Rails - ActionMailer

Action Mailer allows you to send emails from your application using a mailer model and views. So, in Rails, emails are used by creating models that inherit from ActionMailer::Base that live alongside other models in app/models. Those models have associated views that appear alongside controller views in app/views.

**Goal: Add Cook Book app Welcome Email … and forgot password feature**

      
###Generate ActionMailer

First, use rails generator to create an action mailer class.

> rails generate mailer UserMailer

Check out what's been created.

**mailers/user_mailer.rb**
Mailers are very similar to Rails controllers. They also have methods called "actions" and use views to structure the content. Where a controller generates content like HTML to send back to the client, a Mailer creates a message to be delivered via email.
 
	class UserMailer < ActionMailer::Base
  		default from: "from@example.com"
	end 
	
###Let's go create email templates

Email templates are just like views! 

Let's start with the welcome email. We are creating two versions, HTML and plain text. Why? Some email clients don't support HTML, they can render text only. The system sends both versions in the same email message (body), the email client decides which one to use. 

####HTML version: views/user_mailer/welcome_email.html.erb

	<html>
  		<head>
    		<meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
  		</head>
  		<body>
    		<h1>Welcome to Le Cook Book app, <%= @user.name %></h1>
    		<p>
      			You have successfully signed up to http://localhost:3000,
      			your username is: <%= @user.email %>.<br/>
    		</p>
    		<p>
      		To login to the site, just follow this link: <%= @url %>.
    		</p>
    		<p>Thanks for joining and have a great day!</p>
  		</body>
	</html>

####Text version: views/user_mailer/welcome_email.text.erb

	Welcome to example.com, <%= @user.name %>
	===============================================

	You have successfully signed up to http://localhost:3000,
	your username is: <%= @user.email %>.

	To login to the site, just follow this link: <%= @url %>.

	Thanks for joining and have a great day!

Notice that bot templates use the same instance variables. The content is the same, only the file type/presentation is different.

For sake of simplicity, we hard coded the url. Please read this section on how to do it right:

- http://guides.rubyonrails.org/action_mailer_basics.html#generating-urls-in-action-mailer-views

####Implement User Mailer

	class UserMailer < ActionMailer::Base
  		default from: "mguehrs@gmail.com"

  		def welcome_email(user)
    		@user = user
    		@url  = 'http://localhost:3000/signin'
    		mail(to: @user.email, subject: 'Welcome to Le Cook Book app')
  		end

	end
	
####Call USerMailer

Send welcome email when user is created (conreollers/users_controller.rb -> create):

	UserMailer.welcome_email(@user).deliver	
      
      
###Configure mail gateway

Mail settings are configured in:

**config/environemnts/*.rb**

**Let's look at development.rb:** 
The basic configuration is using local sendmail process. That's good for development!

	config.action_mailer.raise_delivery_errors = true
	config.action_mailer.delivery_method = :sendmail
	config.action_mailer.perform_deliveries = true

**Better:** Configure real smtp server, it has to be accessible though. Google is nice and they let us use their smtp servers. Ask your ISP if you can use their smtp servers. Here's a sample configuration:

	config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = {
  		address:              'smtp.gmail.com',
  		port:                 587,
  		domain:               'example.com',
  		user_name:            '<username>',
  		password:             '<password>',
  		authentication:       'plain',
  		enable_starttls_auto: true  }


##More: 'Forgot Password' feature

###Prep work already done

Added a few routes in config/routes.rb:

	get '/forgot' => 'users#forgot_password'
	post '/send_reset' => 'users#send_reset'
	get '/reset/:token' => 'users#reset_password'
	
Added two new methods in controllers/user_controller.rb:

	#get '/reset/:token' => 'user#reset_password'
  	def reset_password
    	@token = params[:token]
    	@user = User.find_by_remember_token @token
    	render :reset_password
  	end

  	#post '/send_reset' => 'user#reset_password'
  	def send_reset
    	# email in param
    	email = params[:email]
    	user = User.find_by_email email
    	if user.nil?
      		flash[:error] = "No such email:" + email
    	else
      		UserMailer.forgot_password_email(user).deliver
      		flash[:success] = "Please check your email for reset instructions ..."
    	end
    render :forgot_password
  	end	
      
###To finish: go and create:

####views/user_mailer/forgot_password_email.html.erb

	<!DOCTYPE html>
		<html>
  			<head>
    			<meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
  			</head>
  		<body>
    		<h1>Your chance to reset le password, <%= @user.name %></h1>
    		<p> Follow this link: <%= @url %>.</p>
  		</body>
	</html>

Add forgot_password method to user mailer:

####mailers/user_mailer.rb

	def forgot_password_email(user)
		@user = user
		@url  = 'http://localhost:3000/reset/'+user.remember_token
		mail(to: @user.email, subject: 'Reset your password')
	end	   

####controllers/users_controller.rb

In send_reset method, uncomment:

	UserMailer.forgot_password_email(user).deliver
