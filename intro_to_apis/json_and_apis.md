# JSON and APIs
APIs are essential to web development.  In order to make an interesting interactive web application, you will most likely be calling at least 1 API.

## Objectives
* Understand what an API is and why it's useful
* Get comfortable with the JSON format


# What is an API?
An API is an application programming interface.
## Why APIs
* Abstraction layer for making requests
* Creates reusable functionality
* 



## API Examples
* [Google Maps](https://developers.google.com/maps/documentation/javascript/)
* [Yelp](http://www.yelp.com/developers/documentation)
* [Flikr](http://www.flickr.com/services/api/)
* [OMDB](http://www.omdbapi.com/)

### Exercise
Lets look at an example of an api call in the wild. Next, go to [OMDB](http://www.omdbapi.com/) and make a request for the movie cars that was made in the year 2006.  Take a look at what is returned.



# JSON
__JSON => JavaScript Object Notation__ It is the de facto data exchange format of the web.  The structure of JSON is a key value pair hash, very similar to hashes in Ruby.

## JSON Examples

__Empty JSON__

```
{ }
```

__Hash__

```
{ "name" : "Fluffy", age"": 5, species : "dog"}
```

__Array__

```
["Fluffy", "Buster", "Mochi", "Russel"]
```

__Complex JSON__

```
{ "Animals":[ { "name": "Fluffy", "age": 5, "species": "dog"},
              { "name": "Buster", "age": 10, "species": "cat"},
              { "name": "Mochi", "age": 4, "species": "dog"},
              { "name": "Russel", "age": 5, "species": "dog"}
            ],
  "Clients":[ { "name": "Tim", "num_children": 0},
              { "name": "Angelina", "num_children": 6}
            ]
}
```

## Using JSON in Ruby Code
Ruby gives us a tool to easily parse JSON into an object.  Try the following in pry:


```
require 'json'


result = JSON.parse('{ "name" : "Fluffy", "age": 5, "species" : "dog"}')

puts result.to_s

puts result['name']

```



### Exercise

Now using the JSON object below, print the name of all of the animals to the screen along with the animal's age.  Here is the code to start with and the sample output.

```
require 'json'

result = JSON.parse( '{"Animals":[ { "name": "Fluffy", "age": 5, "species": "dog"},
              { "name": "Buster", "age": 10, "species": "cat"},
              { "name": "Mochi", "age": 4, "species": "dog"},
              { "name": "Russel", "age": 5, "species": "dog"}
            ],
  "Clients":[ { "name": "Tim", "num_children": 0},
              { "name": "Angelina", "num_children": 6}
            ]
}')

puts result.to_s
```

```
Fluffy - 5 years old
Buster - 10 years old
Mochi - 4 years old
Russel - 5 years old
```

# Making API Requests

There is a gem called Typhoeus that simplifies making HTTP requests in ruby.  The project can be found on github: [https://github.com/typhoeus/typhoeus](https://github.com/typhoeus/typhoeus)

## Gets Requests with Typhoeus

Typhoeus can do get requests:


```
require 'typhoeus'

response = Typhoeus.get("www.google.com")

puts response.body

```

It can also add parameters:

```
require 'typhoeus'

response = Typhoeus.get("www.google.com", :params => {:name => "Tim" })

puts response.body

```

The above request is the same as typing ```http://www.google.com/?name=Tim``` in your browser.

### Exercise

Write a small ruby program that makes a request to ```http://www.omdbapi.com/``` and gets the movie cars made in 2006.  Print the response to the screen.

# Lab
[Sinatra API lab](https://gist.github.com/tigarcia/807021585cb7225ffd50#file-sinatra_omdb_json_api_lab-md)

