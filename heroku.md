# To the Internet:  Deploying with Heroku

## Agenda
* What is Heroku?
* What You Should Already Have Done
* Sinatra on Heroku
* Rails on Heroku
* Deploying with Secrets

## What is Heroku?

Heroku is a platform for deploying applications which allows us to deploy small websites for free without worrying about most of the configuration which it takes to deploy an application on a _bare metal_ server, an actual computer which we control.

[heroku.com](heroku.com)

## What You Should Already Have Done

You should already have signed up for an account on [heroku.com](heroku.com) and downloaded the heroku toolbelt from [https://toolbelt.heroku.com/](https://toolbelt.heroku.com/).  

## Sinatra on Heroku

App.rb:

```
require 'sinatra'
get '/' do
  "Great website"
end
```

Gemfile: 

```
source "https://rubygems.org"
```

Procfile:

```
web: ruby app.rb
```

## Rails on Heroku

### Using Postgres instead of SQLite3
Heroku uses postgres as the default database.  In the Gemfile, remove 'sqlite3' and and add 'pg'.  

```
gem 'pg'
```

In config/database.yml, change the settings to use the postgres adapter.

```
development:
  adapter: postgresql
  database: <your-app-name>-development
  host: "localhost"
  port: 5432
  encoding: unicode
```

You need the host, the port, and the adapter.  You shouldn't need to change the database name.  

### Add Heroku's rails configuration gem to your Gemfile

This makes it so your app logs in a way that Heroku likes.

```
gem 'rails_12factor', :group => :production
```

### Keeping Secrets

Our applications have secrets.  They all have a secret_key_base which needs to be secret.  We're all going to be making API calls, and most of those api calls require a secret key.  You'll put these secrets in the environment.

Default config/initializers/secret_key_base:

```
# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
YourApp::Application.config.secret_key_base = 'f441fabe00f77e050292827c3b5ee2b8621d5d6fc92e97edca4671638bf1d415388d77933a5ef96d08d66f3cb5cba3fa7752a8a2a7257992c3dda31751bdc877'

```

What it should be:

```
# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
YourApp::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']

```

This looks in the environment which the application is running in for the secret key.  Then we can set this config variable using `heroku config:set KEY=VALUE`

To generate a new value for SECRET_KEY_BASE, use the `rake secret` command to generate a new key, then copy that into `heroku config:set SECRET_KEY_BASE=<value>`

To have secrets on your local machine, use the `.env` file. In your project's root directory, make a file called `.env`, laid out as follows:

```
KEY1=VALUE1
KEY2=VALUE2
```

Then if you run a command with `foreman run <command>`, those variables will be available through ENV in your code.


If you want to have the commands `heroku config:push` and `heroku config:pull` to move environment variable back and forth from `.env` to heroku config all at once, you can run `heroku plugins:install git://github.com/ddollar/heroku-config.git` to install that plugin.

## Resources

[Heroku Rails 4 Tutorial](https://devcenter.heroku.com/articles/getting-started-with-rails4)

