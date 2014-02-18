# Javascript Templating and XSS

## Agenda

* #### Clarify updating pull requests
* #### An XSS example
* #### Templates in JS/HTML
* #### Templates in Rails/JS
* #### A Note on sharing templates

## Updating pull requests
Commit and push, it will smoothly update your pull request.  

We do not grade.  We aren't interested in what you had finished the day we wanted to move on from an assignment, we're interested in what kind of work you can produce right now.  That's what we can build on.

## The XSS Attack
### What is XSS?
An XSS or Cross Site Scripting attack occurs when the attacker is able to insert custom strings into the page unfiltered.  In other words, the application developer mistakenly trusts some data as being safe to insert into the DOM.  
#### Trusting the query string
Let's look a simple XSS attack in query_string_xss.html.  
#### Trusting the database data
Let's look at a slightly more sophisticated attack in stored_data_xss/.  It's a Sinatra app so we'll have to start it up.

## Templates with Handlebars.js

We will be using handlebars as a templating system.  Read more about it at their website: [http://handlebarsjs.com/](http://handlebarsjs.com/)

It's a templating system analagous to ERB which has many of the same features.  Partials, conditionals, etc.

Handlebars templates can be brought into your javascript in three ways:

1. Write the templates inline in a script tag or other piece of the DOM.
2. Write the templates inline in a string.
2. Precompile the templates into javascript functions and include them via script tags.  In the context of Rails, a gem will do this for us automatically.  This is the best way.

To install the handlebars compiler at your shell:

`npm install handlebars@1.3 -g`

Then you can use it:

`handlebars <template>.handlebars -f <outputfile>.js`

The name of the template becomes the 

Let's look at  query_string_fixed.html

### Templating exercise

I'm going to quickly demo an XSS vulnerability on a working solution to LinkCheckerAjax.  If you finished, augment your solution with Handlebars.js templates inline in strings. If you didn't, just make it so something goes onto the page with a Handlebars template.

## Types of XSS
### Reflective
The attacker sends the victim to the application with an XSS attack in the victim's request.  The application reflects that XSS attack back to the victim, and the victim's browser executes it.
### Stored
The attacker inserts a payload into the application's database and the application replays it to the victim.
### Dom Based
The attacker modifies the DOM in a way that causes the application's javascript to go crazy and execute an attack.

## XSS in the Real World
* Through an Amazon book: [http://drwetter.eu/amazon/](http://drwetter.eu/amazon/)

   The book in question: [http://www.amazon.com/The-Web-Application-Hackers-Handbook/dp/1118026470](http://www.amazon.com/The-Web-Application-Hackers-Handbook/dp/1118026470)
* Facebook XSS through embedded rendered JS: [https://www.acunetix.com/websitesecurity/xss-facebook/](https://www.acunetix.com/websitesecurity/xss-facebook/)
* Facebook/Yelp XSS: [http://techcrunch.com/2010/05/11/yelp-security-hole-puts-facebook-user-data-at-risk-underscores-problems-with-instant-personalization/](http://techcrunch.com/2010/05/11/yelp-security-hole-puts-facebook-user-data-at-risk-underscores-problems-with-instant-personalization/)
* Similar attack on Facebook/Yelp the next day: [http://techcrunch.com/2010/05/11/another-security-hole-found-on-yelp-facebook-data-once-again-put-at-risk/](http://techcrunch.com/2010/05/11/another-security-hole-found-on-yelp-facebook-data-once-again-put-at-risk/)

## Handlebars and Rails
We'll use a gem called handlebars_assets to take handlebars templates from raw templates in `assets/javascripts/templates` to compiled template functions in your javascript.

Here's the handlebars_assets page: [https://github.com/leshill/handlebars_assets](https://github.com/leshill/handlebars_assets)

Gemfile:

```gem 'handlebars_assets'```

Application.js:

```
//= require handlebars.runtime
//= require_tree ./templates
```

Now any templates in the `app/assets/javascripts/templates` folder or any subfolders will be loaded in your app.

### Templating in Rails exercise

Let's go back to LinkCheckerAjax and set it up to be nicer and more 'Railsy'.  We'll install our new gem, set it up in application.js, and get rid of some strings of HTML.  If you didn't finish LinkChecker Ajax, just extract your inline handlebars template from earlier into a template file.

## A Note on Sharing Templates

What's the difference between ERB and Handlebars?

	