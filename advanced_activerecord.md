
##Advanced ActiveRecord

###Goals

- Understand the power of Active Record
- How to leverage ActiveRecord and to_json for api design

###Intro

Active Record is a simple object-relational mapping (ORM) framework. ORM: Connecting two worlds that evolved alongside, but hardly talked to each other: RDBMS and OO.

Up until now, we've covered how to build basic queries using Active Record. After building a handful of projects you should be comfortable making these queries. We'll go over the basics again.

Active Record is much more powerful than just simple CRUD actions on individual records. It gives you a Ruby-ish interface to do almost anything you can do with bare-metal SQL statements. 

You can cherry-pick individual groups of records based on specific criteria and order them however you want. You can join tables manually or query using associations set up by Rails. You can return lists of records or perform basic math like counts and averages.

If you're used to using raw SQL to find database records, then you will generally find that there are better ways to carry out the same operations in Rails. 

**Active Record insulates you from the need to use SQL in most cases.**

**An ActiveRecord object represent a row in a tabel**

###Today's demo system

I'm going to show you parts of the backend and the api of one of my projects, todayinberlin.com. We are going to use a database of movies and events that are on right now in Berlin. The db contains two weeks worth of data.

Today's lesson is not a code along. There's also no lab lab part today. We'd rather like you to apply today's topics in the mini-project. If you want to follow along 'hans on', please fork and clone:

> https://github.com/aikalima/active_records_rails

Quick tour:

- model diagram: Film/Event -> Screening -> Venue
- routes
- controller
- models
	
###Types of queries

If you follow along, please fire up rails console in the project diretory.

Quick recap. Genrally, there are queries returning:

-	a single object
-	a list of objects

####Retrieving Single Objects

Most simple cases: Pick any or you have the id and simply go after it.

	Category.find(44)
	
Simple find expects object identity parameter.

	Film.first
	Film.take
	Film.last

What's the difference between first and take? first orders by id and picks first, take has no particular ordering.

*Finders* always return the first element found. Two flavors that do exactly the same, it's a matter of personal preference. I believe the first one to be more expressive
	
	Film.find_by(name: "Citizen Kane")
	Film.find_by_name("Citizen Kane")
	
**Note:** adding ! raises exception if record cannot be found, instead of retuning nil.

	Film.find_by!(name: "Jaws")

####Retrieving Multiple Objects	
	
We all have used:

	Film.all

First/Take also take parameter:

	Film.first 10
	
Most common case is defining conditions used to filter results. The **where** method allows you to specify conditions to limit the records returned, representing the WHERE-part of the SQL statement.
	
####String conditions with ? placeholder:

	Film.where("name = ?", "Citizen Kane")		
	Film.where("name LIKE ?", "Monu%")
	
####Array conditions:

	favs = ["Citizen Kane","Nebraska"]
	Film.where("name in (?) ", favs)

####Hash conditions 

That's the most common type of condition, it's preferred over string conditions. If you can, avoid ? notation. Sometimes you have to use it, for LIKE queries, for example (see above).

Equality:

	Film.where(name: "Citizen Kane")
	
Why is it a hash condition? Above is basically:

	Film.where({name: "Citizen Kane"})

There's your hash.	

Range: 	

 	lower = DateTime.new(2014,02,14)
	upper = DateTime.new(2014,02,15)
	Event.where(datetime: lower..upper).count

Subset:

	Film.where(name: favs) 
		
##Joins:

Simple use case for JOINS:

Let's say you want to find all films with categories. Since Films have category_ids, that's easy:

	Film.where('category_id is not NULL').select(:category_id, :name)

Now, how to find all categories that contain films, and return objects for each film/category? Categories don't have film_ids. Answer JOIN:

	Category.joins(:films).select("categories.id", "films.name", "categories.sub")

Since we join, we can reference columns in both tables.

####Types of joins

Let's take a look at this pic:

http://i.imgur.com/1m55Wqo.jpg

#####INNER JOINS

The most common JOIN, it's the default in Rails. INNER JOINS exclude relationships that don't exist.

Return a Category object for all categories with films:

	Category.joins(:films) 
	
Note that you will see duplicate categories if more than one film has the same category. Use uniq method to see unique categories

	Category.joins(:films).uniq 
	
Count of films that are currently screening

	Film.joins(:screenings).uniq.count
	
You can add conditions to join. Return all dramas currently screening:

	Film.joins(:screenings).where(category_id: 32)
	
You can Group by attribute, here name:

	Film.joins(:screenings).where(category_id: 32).uniq.group(:name)
		
And group with condition: Only those 'having' some condition:
	
	Film.joins(:screenings).uniq.group(:name).having("description != ?", "")

Do something with result, print names of those:

	Film.joins(:screenings).uniq.group(:name).having("description != ?", "").each do |f| puts f.name end

Very useful: pluck. Plucks attributes from result set - returns array containing attributes.

	Film.joins(:screenings).load.uniq.group(:name).having("description != ?", "").pluck(:name)
		

#####LEFT JOIN aka LEFT OUTER JOIN

The inclusive JOIN.

Take all films and match them up with screenings, even if no matching screening exists.

	Film.joins('LEFT JOIN screenings ON screenings.screenable_id = films.id').uniq.count

Return category object for all films, including those which don't have films:

	Category.joins('LEFT JOIN films ON films.category_id = categories.id')
	
Which films don't have categories?

	Film.joins('LEFT JOIN categories ON films.category_id = categories.id where films.category_id is NULL')		

Show films that are not screening:

	Film.joins('LEFT JOIN screenings ON screenings.screenable_id = films.id WHERE screenings.screenable_id IS NULL').uniq.count
	
The reverse is same as INNER JOIN, implemented with LEFT JOIN:

	Film.joins('LEFT JOIN screenings ON screenings.screenable_id = films.id').where('screenable_id is NOT NULL').count	
#####How about RIGHT JOINS?

	Film.joins('RIGHT JOIN screenings ON screenings.screenable_id = films.id WHERE screenings.screenable_id IS NULL').uniq.count

Oops:
> ActiveRecord::StatementInvalid: SQLite3::SQLException: RIGHT and FULL OUTER JOINs are not currently supported		

###Find by sql

If you ActiveRecord doesn't support desired query, you can always resoir to SQL, but it should be your last resort. The first LEFT JOIN query can be written as

	Film.find_by_sql("SELECT * FROM films LEFT JOIN screenings ON screenings.screenable_id = films.id")
	
So let's try that RIGHT JOIN

	Film.find_by_sql('SELECT * FROM films RIGHT JOIN screenings ON screenings.screenable_id = films.id WHERE screenings.screenable_id IS NULL')

Still no luck! It's just not suppored in ActiveRecord.
	
	
###Find or build a new object

It's common that you need to find a record or create it if it doesn't exist. No need to test for existance and using elaborate if statements. Simply use: 

- find_or_initialize_by
- find_or_create_by
	
That's new and create, respectively	
	
	Film.find_or_initialize_by(name: "Citizen Kane")
	
	new_film = Film.find_or_initialize_by(name: "Citizen Kane") do |f|
		f.detail_url = "node/34253"
	end
	
	new_film.save

Very convenient.		
	
###Scopes

Scoping allows you to specify commonly-used queries which can be referenced as method calls on the association objects or models. 

My question: why not make them method calls in the first place?

To create a scope, use scope method, pass scope name and a block with conditions:

	scope :with_description, -> { where('description != ""') }

Which is the same as:

	def self.with_description
		where('description != ""')
	end	
	
I personally prefer the latter, but former is more concise.

###Callbacks

Simple example. In Film model:

	after_find do |f|
    	puts "Found: " + f.name
	end

http://guides.rubyonrails.org/active_record_callbacks.html

###Loading Assocoations & advanced to_json

Active Record lets you specify in advance all the associations that are going to be loaded. This is possible by using the includes method on the Model. With includes, Active Record ensures that all of the specified associations are loaded using the minimum possible number of queries.

####joins vs includes


	result = Film.includes(:category).limit(1)
 
	result.first.category
	
Only one SQL statement!


	result = Film.joins(:category).limit(1)
	
	result.first.category
	
Two SQL statements!

The question we need to ask is “are we using any of the related model’s attributes?” If the answer is “yes” we should be using includes.

If we aren’t using any category information using includes is rather inefficient as we’re getting all of the related category information. In this case the correct option is to use is joins; this way we’re not getting Category information we don’t need.
	

**api / to_josn demo**	
 


	






