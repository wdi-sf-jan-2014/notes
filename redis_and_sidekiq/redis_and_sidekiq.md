# Redis and Sidekiq

__Objectives__

* Understand what Redis and Sidekiq are useful for and how they work at a high level
* Be able to write a Sidekiq worker
* Deploy Redis and Sidekiq to Heroku using the Unicorn server

## What is Redis?

Redis is a data storage system that stores data in memory.  The data is only written to a single computer and is not guarentteed to be saved  to disk on every request. In other words, if Redis goes down, there may be some data loss. Redis is useful for data that you are ok with losing.  Redis is not a replacement for a relational database.


## Installing And Running Redis

On __OS X__:

```
brew install redis
```
On __Linux__:

```
sudo apt-get install redis
```

To run the Redis server do:

```
redis-server
```

And to interact with Redis in the terminal, run the redis command line interface:

```
redis-cli
```

### Exercise

In the redis-cli, try out some of the available commands defined in the [redis commands document](http://redis.io/commands/#).  In particular, try using the string commands ```GET``` and ```SET``` as well as the list commands ```LPUSH```, ```RPUSH```, and ```LINDEX```.

## What is Sidekiq?

Sidekiq is a framework for executing background jobs within a rails application.  It is a gem file that runs within your server process so it has access to all of the rails environment, including ActiveRecord models.  Under the covers, Sidekiq uses Redis to store a queue of jobs.  Resque is a very similar technology that was used in the past.  The main difference is that Resque will use more memory than Sidekiq for the same ammount of work.

### Exercise

Watch the [railscast on sidekiq](http://railscasts.com/episodes/366-sidekiq).  Discuss sidekiq and when it would be useful.  Implement the code highlighting example from the railscast.  Try __NOT__ to cheat!


## Link Checker Example
We are going to make an app that checks a website to see if it has any dead links on the page.  The website will be very simple.  For a given url, it will get the contents of the page, follow all of the links on that page, and then show the results of the check.

First, create the app:

```
rails new LinkChecker
```

Next edit our routes in ```config/routes.rb```:

```
LinkChecker::Application.routes.draw do
  root 'sites#new'
  get '/site/new', to: 'sites#new', as: 'new_site'
  post '/sites', to: 'sites#create', as: 'sites'
  get '/site/:id', to: 'sites#show', as: 'site'
  get '/linkfarm', to: 'sites#linkfarm'
end
```

Add a controller:

```
rails generate controller sites new create show --no-test-framework --no-helper
```
Next, get rid of the files we don't need:

```
rm app/assets/javascripts/sites.js.coffee app/assets/stylesheets/sites.css.scss
rm app/views/sites/create.html.erb
```

Also, open up ```config/routes.rb``` and remove the routes that were created that we do not need.  Your routes.rb file should look just like the routes file above.

Then create the models. In this project we are modeling two things.   There is a website, or a site.  A site is an html page that we want to check for dead links.  A site will have many urls on the site.  So there is a 1 to Many relationship.

```
rails generate model site url:string --no-test-framework
```

```
rails g model link url:string http_response:integer site:belongs_to --no-test-framework
```

Next the models need to know about how they are associated.  In ```app/models/link.rb``` add:

```
belons_to :site
```

And in ```app/models/site.rb``` add:

```
has_many :links
```

Next, add all the necessary gems to the ```Gemfile```:

```
gem 'pg'

gem 'nokogiri'

gem 'typhoeus'

gem 'dotenv-rails', :groups => [:development, :test]
```

Also remember to edit ```config/database.yml``` to use postgresql and edit ```config/initializers/secret_token.rb``` to use environment variables instead of exposing the secret keys.

### Link Checker Algorithm

This section provides a brief description of what the link checker will be donig in create.  Here is an algorithm in puesdo code:

```
Get the parameter for the url to check
Create a site record in the database (Save the url)
Use Nokogiri to get the page and parse the contents
Use Nokogiri to get all anchor tags
For each anchor tag, do:
   Get the href from the anchor tag
   Make sure the href starts with http, https or is a relative path
   Use Typhoeus to get the linked page
   Create a new recored in the DB for the link (Saves link url, and http response code)
end

redirect to the show page for the site
```

### Main Link Checker Code in Create

```
def create
  require 'open-uri'
  url = params.require(:site)[:url]
  site = Site.create(url: url)
  uri = URI.parse(url)
  domain = uri.scheme + '://' + uri.host
  domain += ':' + uri.port.to_s if uri.port != 80 && uri.port != 443
  contents = Nokogiri::HTML(open(url))
  contents.css('a').each do |link|
    link_href = link.attributes['href'].value
    if (link_href.starts_with? '/')
      link_href = domain + link_href
    end

    if (link_href.starts_with? 'http://', 'https://')
      response = Typhoeus.get(link_href)

      site.links.create(url: link_href, http_response: response.response_code)
    end  
  end
  
  redirect_to site_path(site)
end
```

### Exercise

__Discussion__ What is wrong with the performance of the code?  How could it be improved?

## Unicorn

Up until now, we have used the Thin web server.  It is a reliable web server, that works for development, but does not work in the real world.  The problem is that Thin can only accept one connection at a time.  This section describes switching to the Unicorn web server.

### Unicorn in Development

To use unicorn in development, simply add these gems to your Gemfile:

```
gem 'unicorn'

gem 'unicorn-rails', :groups => [:development, :test]
```

And then bundle install.  This will make the ```rails server``` command use unicorn in development instead of Thin.  Also, the default number of concurrent connections is set to 1 in development.  To boost it up a little higher for testing, add the following to your .env file:

```
UNICORN_WORKERS=2
```

### Unicorn in Production (Heroku)

For Heroku, Unicorn requires a Profile that describes how to run our web server.  In the root of your project, add a file, ```Procfile``` with this line:

```
web: bundle exec unicorn -p $PORT -E $RACK_ENV -c ./config/unicorn.rb
```



## Resources

* [Redis Quick Start Guide](http://redis.io/topics/quickstart) - Ignore the installing Redis section
* [Redis Data Types](http://redis.io/topics/data-types)
* [Sidekiq RailsCast](http://railscasts.com/episodes/366-sidekiq)
* [Sidekiq Wiki](https://github.com/mperham/sidekiq/wiki)
* [Running Unicorn on Heroku](https://devcenter.heroku.com/articles/rails-unicorn)