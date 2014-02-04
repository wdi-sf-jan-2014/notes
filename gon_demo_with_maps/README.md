# GON Demo With Google Maps

The app demos how to get data out of your rails model and into a javascript variable so that you can assess and use the data dynamically in your page.

## Getting Started

To run the app, you need to do a few things:

```
bundle install

rake db:migrate

rake db:seed
```

This will get the application ready to run, but in order to use google maps, you must replace the ```INSERT_API_KEY_HERE``` text with your own google maps api key.  The change must be made in ```app/views/layouts/application.html.erb```.

After completing these steps you should be able to run ```rails s``` and see the data from the database on the map.

## Using GON in your app

In order to use GON in your app, you must do the following:

* Add the gon gem to your ```Gemfile``` then ```bundle install``` and restart the server
* Add the ```<%= include_gon %>``` to the ```<head>``` of your html document.  This change will likely be in ```application.html.erb```.
* To pass data to your javascript, add a gon assignment to your controller.  An example assignment is ```gon.locations = @locations``` in ```app/controllers/locations_controller.rb```.
* Then in your javascript, you can access gon.locations.  You can see an example of using gon.locations in ```app/assets/applications.js```


## Resources

* [GON Github](https://github.com/gazay/gon)
* [Google Maps Docs](https://developers.google.com/maps/documentation/javascript/)