# Morning

## Git workflow

All future assignments will start in the [WDI SF Jan 2014 Organization](https://github.com/wdi-sf-jan-2014).

Each assignment will be under its own public repo.

### Fork the assignment

### Clone to your machine

### Push to your fork

### Issue a PR against the assignment repo

## Red, Green, Refactor 

The goals of Behavior Driven Development are to:

* Allow you to focus on the behavior of your app
  * Given a set of preconditions
  * When the user does something
  * What should the user expect?

* Encourage you to write the minimum amount of code necessary

* Give you confidence that your functionality works

* Document and describe your app's functionality

### Test workflow

1. We want to write tests that fail (Red)
2. Write the behaviors that make our tests pass (Green)
3. Clean up our code for the common code smells (Refactor)

## RSpec Test Suite

Each assignment will have a test suite. Some assignments will have tests for ruby code, some will have tests for JS, and some will have both.

Today, we'll talk about just RSpec.

### Installing RSpec

Let's follow the git workflow for [today's assignment repository](https://github.com/wdi-sf-jan-2014/todo-with-rspec).

Take a look at the gemfile.

Let's pay attention to the following lines:

```
group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
end
```

What does that do?

Let's run `bundle install`.

Let's initialize the `/spec` directory:

`rails generate rspec:install`

That adds the following files:

* `spec/spec_helper.rb`
* `.rspec`

We use these files for setting configuration options.

Let's run our specs!

`bundle exec rspec`

The first spec that fails is a request spec.

We have a bunch of failures! Red! :)

Generally, we are going to write our tests and functionality outside-in. We will start with defininig a route, then writing a controller action, then write a view, and finally jump into the model, as necessary.

Let's see how this all fits together.

Request specs check the entire workflow and lifecycle of a request to the application. They hit every layer of the stack: the router, the controller, the views, the models. First, we'll work with Request specs, and then dive down into Controller specs, and the Model specs, on an as needed basis.

Generally, for request specs, we want to test the following:

* Issue a specific HTTP verb-based request to a route
* Is a specific HTTP response code returned?
* At a high level, do we see the data we want on the screen?

### Exercise: students, fix the first failing spec

Read the failing spec together. 

A spec is made up of examples in `describe` blocks and other blocks like `context`.

Emphasize that the first example that we need to get to pass is that issuing a `GET` request to the specified route results in a result code of `200`.

Let's fix one of the failures and make our first example pass.

### Installing guard

As we keep working on implementing the functionality and going through the Red, Green, Refactor cycle, we begin to notice ourselves doing the same thing over and over again:

`rake spec`

or

`bundle exec rspec`

Just like when we write functionality, we should strive to keep our workflow just as DRY as our code.

To that end, let's make it so. We'll use a tool called `guard` to continuously run our specs with any changes that we introduce to either the spec or the functionality it specifies.

Let's first add some gems to our `Gemfile`'s `:development` and `:test` groups:

```
  gem 'launchy'
  gem 'database_cleaner'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ &crarr; 
    /darwin/i
  gem 'guard-rspec'
```

Let's not forget to `bundle install`

Then, let's run the following command:

```
guard init rspec
```

Finally, let's run `guard` to get guard started.

Now, let's write our spec file. Boom! Awesomesauce.

We no longer have to keep running our specs every time we make a change. Our testing lives have just been leveled up significantly.

Let's level it up even further.

You know how you keep having to refresh your browser when you make changes? That's annoying. Yet another thing to keep track of. Let's DRY that up.

Let's add `guard-livereload` to our `Gemfile`.

`bundle install`

Let's init by typing `guard init livereload`.

Let's add the livereload extension to chrome.
http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-

Start our rails server.

Now run `guard` again and navigate to `http://0.0.0.0:3000` in your browser. Enable livereload, and make a change in a view, and write the file. OOOH! Delicious.

Now, lunch.

# Afternoon

# Resources

## Morning
https://github.com/rspec/rspec-rails
http://railscasts.com/episodes/257-request-specs-and-capybara?view=asciicast
https://www.relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec
http://railscasts.com/episodes/264-guard?view=asciicast
https://github.com/guard/guard-livereload

## Afternoon
https://www.relishapp.com/rspec/rspec-rails/v/2-14/docs/controller-specs
https://www.relishapp.com/rspec/rspec-rails/v/2-14/docs/mocks/mock-model


