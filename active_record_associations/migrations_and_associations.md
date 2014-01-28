# Active Record - Deep Dive

## Objectives

* Understand the Concept of ORM
* Review rails migrations
  * How is a table created?
  * How is a table changed?
* Design a Database
* Create complex models with Associations
* Query Complex models

## ORM
__What is ORM?__ Object Relational Mapping.  It is a layer on top of the database that provides object oriented access to the data.


__Active Record__ is an implementation of an ORM system that is commonly used in rails.  Active record represents a table of data with a model.  A row in that table is represented by a instance of the model class.


## Migrations
A migration is a ruby script that can be run using rake and alters the database in some way.  A migration __DOES NOT ALTER__ the database until you type __rake db:migrate__ to run the script.  Migrations are created and stored in the ```db/migrate``` directory.

For example, running the following command creates a model and also creates a corresponding migration for the model:

```
rails g model student name:string --no-test-framework
```

This command creates two files:
 
```
db/migrate/20140127225429_create_studentss.rb
app/models/student.rb
```  
The first file created is the migration which can be run using ```rake db:migrate``` to create the database in SQL.  Migrations files have a format which is important to know.  The first long string of numbers is the timestamp of when the migration was created.  The second part of the filename is the name of the migration.  

The second filename is the model class.  The model inherits from ```ActiveRecord::Base``` and it is the class that represents the students database.  This model class cannot do anything to the database until a database exists in a database system like Postgres or sqlite.

### Review Questions

1. When does a SQL database actually get created in Postgres or Sqlite?
2. What does rails g model do?


### Exercise

First create a new app:

```
rails new college
```
Then create a students model, __no test frameowrk!__ and execute the migration:

```
rails g model student name:string --no-test-framework

rake db:migrate
```

Now, create a migration that would add a sid (student id) to the students model that we created earlier.  The sid is alpha numeric.  Go into rails console and create a few students.  When you are done, drop the database using ```rake db:drop```.

If you get your database is a strange state, or did something wrong with your migration do the following.  Run ```rake db:drop```.  Delete the new migration that you created in the migration directory: ```db/migrate/```.  Make sure you do not delete the migration that creates the students table. Finally delete the scehma file that was created at ```db/schema.rb```.  Running ```rake db:migrate``` will recreate the database with a students table that only has a name column.


## Model Query Reveiw

Here are some query methods for review:


```
# Returns an ActiveRecord::Relation
# The ActiveRecord::Relation contains a set of instances of the Student class.
# Each Student class represents a single row in the database.
Student.all
```

```
# Finds a single row from the database where the primary key is equal to id.
# Your primary key will typically be an id that is automatically incremented.
# Returns an instance of the student object which represents a row in the db.
Student.find(id)
```

```
# Creates a student object which represents a row in the table
# and simultaneously saves that row to the database.
Student.create(name: 'Lebron James', sid: 'Z8R54Q')
```

```
# Creates a new instance of a student object which represents a row in the db
# The database is not actually altered when new is called.
# New simply creates an object in memory, and will not persist by itself
Student.new(name: 'Sherlock Holmes', sid: 'T45F9V')
```

```
# Calling save on the newly created student object makes the actual call to
# save the row to the database.
student = Student.new(name: 'Sherlock Holmes', sid: 'T45F9V')
student.save
```

##  Database Modeling

When thinking about how to design your database, it's useful to think abstractly first and design the schema on paper or in a modeling program.  The exercise is very similar to how one thinks about designing and object oriented program.

### Exercise

Design a college database system. The system needs to keep track of a few things.  It needs to know about students and the courses that the students take.  The system must also be able to keep track of a particular students account (how much money he owes the school).  Lastly, this is a small school, so each student will be given a mentor to guide him or her through college.


## Types of Associations in ActiveRecord

Let's create an app that can be used to model a school.  The school will demonstrate all of the assocations we are interested in.

```
rails new college
```

```
bundle install
```


```
rails g model student name:string --no-test-framework
```

```
rake db:migrate
```

We forgot the sid, let's add it.

```
rails g migration AddSidToStudents sid:string --no-test-framework
```

Now create the model for a students account

```
rails g model account balance:float student:belongs_to --no-test-framework
```

```
rake db:migrate
```
#### Exercise

Look at ```db/schema.rb```.  What has been created?  What does it mean?  Also, look at ```app/models/account.rb```.  What is new here?  What does it do?


### One to One Relationships

In the previous exercise, we modeled a one to one relationship between a student and the student's account.  The association is created in the migration when we specify ```student:belongs_to```.  Below is the schema file found in ```db/schema.rb``` after rake db:migrate is run.

```
create_table "accounts", force: true do |t|
  t.decimal  "balance"
  t.integer  "student_id"
  t.datetime "created_at"
  t.datetime "updated_at"
end

add_index "accounts", ["student_id"], name: "index_accounts_on_student_id"
```

And here is the sql statement that gets created as a result of create account migration:

```
CREATE TABLE "accounts"
  ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
   "balance" decimal,
   "student_id" integer,
   "created_at" datetime,
   "updated_at" datetime
  );
CREATE INDEX "index_accounts_on_student_id" ON "accounts" ("student_id");   
```

The __student_id__ column in the sql statement is the important column for the one to one association.  The student_id column corresponds to the primary key of the students table.  The __student_id__ column on the accounts table is called a __foreign key__ since the value in that column is the primary key for another table.

In order for rails to understand that an association is happening, we have to add the information to our model.  In ```app/model/student.rb``` add the has_one association:

```
class Student < ActiveRecord::Base
  has_one :account
end
```

#### Exercise

Open ```rails console```.  Next create a student this way:

```
s = Student.create(name: 'Some Name', sid: 'A123CDE')
```

Next, create an account, using the create_account method on the student instance:

```
s.create_account(balance: 0.0)
```

Now try accessing the account:

```
s.account
```

The association works the other way as well.

__What happened in this exercise?__

### One to Many Relationship

The following migration creates an example one to many relationship.  In the example, there is a students table and a mentors table.  A mentor has many students and a student has one mentor.

```
rails g model mentor name:string --no-test-framework

rails g migration AddMentorToStudents mentor:belongs_to --no-test-framework

rake db:migrate
```

To be able to use the association, we have to add the relationship to the model

In ```app/models/student.rb``` a student belongs to a mentor.

```
class Student < ActiveRecord::Base
  # has_one :account is from our previous example
  has_one :account
  belongs_to :mentor
end
```

In ```app/models/mentor.rb``` we need to specify the association.  One mentor has many students.

```
class Mentor < ActiveRecord::Base
  has_many :students # Note students is plural
end
```

#### Exercise

The has_many relationship is new. Open up ```rails console```.  Create a new mentor.  Give the mentor a few students and see what has_many has added.  

__Hint__: After a mentor has been created and you have found a student, use ```mentor << student``` and then try ```mentor.students```.  Also checkout ```mentor.students.exists?``` or ```mentor.students.create()```

### Many To Many Relationship

The last important relationship is a many to many mapping.  In the example below,  a student can be in many classes and a class can have many students.  To model the relationship, we will need a __through table__.  A through table captures the many to many relationship between students and classes.

```
rails g model course name:string description:string --no-test-framework

rake db:migrate

rails g model enrollment student:belongs_to course:belongs_to --no-test-framework
```

We now have 3 models involved in the many to many relationship: ```course```, ```student```, and ```enrollment```.  We need to add the associations to the models:


This is the enrollments model.  Since we generated the model and the assocation, this class shouldn't need to be altered.

```
class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
end
```

The Course model specifies that that course has_many enrollments, and also that it has many students through the enrollments model.

```
class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments
end
```

The Student model works similarly to the Course:

```
class Student < ActiveRecord::Base
  has_one :account
  belongs_to :mentor
  has_many :enrollments
  has_many :courses, through: :enrollments
end
```

Notice most of the assocations are the same except for ```has_many students, through:enrollments``` and ```has_many :courses, through :enrollments```.	These associations allow us to do SQL joins very easily.

For example, the following code:

```
s = Student.take
s.courses
```

Produces this sql statement when ```s.courses``` is executed

```
SELECT "courses".* FROM "courses" 
INNER JOIN "enrollments"
ON "courses"."id" = "enrollments"."course_id"
WHERE "enrollments"."student_id" = ?  [["student_id", 1]]
```

We can also add a course, student association very easily.  Let's add a random association

```
s = Student.create(name: 'Fake Name', sid: 'UD9988V')
c = Course.take
c.students << s

c.students
```

Maybe we want to get all students enrolled in all courses:

```
Student.joins(:courses)
```

The above implementation has some performance issues though.  If we want to display all associations between students and courses, we'd have to write code like this:

```
students = Student.joins(:courses)

students.each do |student|
  students.courses.each do |course|
  	cname = course.name
  	# Do something with the course name
  end
end
```

Unfortunately, this creates a new SQL statement on each inner loop iteration, which is __very expensive__ for large data sets.

Here is another way to write the query that gets us the data we want without having to do unneeded SQL statements in the background.

```
results = Student.joins(:courses).select('students.name, courses.name as cname')

# returns the course name for the first association in the array of results
results[0].cname
```

## College App

Now we can turn our models into an app.  Let's demonstrate what we have learned by making an app that shows all the courses as well as a show page for a particular course.  The show page should list all the students enrolled in the course.

First, lets clean up the data in the models.  Add the following code to ```db/seeds.rb```

```
mentors = []
mentors << Mentor.create(name: 'Mary')
mentors << Mentor.create(name: 'Max')
mentors << Mentor.create(name: 'Rodger')
mentors << Mentor.create(name: 'Janet')
mentors << Mentor.create(name: 'Jacob')

students = []
students << Student.create(name: 'John', sid: 'RD1234', mentor_id: mentors.sample.id)
students << Student.create(name: 'Mark', sid: 'PQ1234', mentor_id: mentors.sample.id)
students << Student.create(name: 'Larry', sid: 'LM1234', mentor_id: mentors.sample.id)
students << Student.create(name: 'Laura', sid: 'Z3434', mentor_id: mentors.sample.id)
students << Student.create(name: 'Leslie', sid: 'RD1999', mentor_id: mentors.sample.id)
students << Student.create(name: 'Apple', sid: 'AB1551', mentor_id: mentors.sample.id)
students << Student.create(name: 'Fiona', sid: 'MM1299', mentor_id: mentors.sample.id)
students << Student.create(name: 'North', sid: '4ZZZZ9', mentor_id: mentors.sample.id)

i = 0
while i < students.length
  if (i % 2 == 0)
	Account.create(balance: 0.0, student_id: students[i].id)
  else
	Account.create(balance: 3000.0, student_id: students[i].id)
  end 
  i += 1
end


courses = []
courses << Course.create(name: 'CS101', description: 'Intro to CS')
courses << Course.create(name: 'CS201', description: 'Algorithms and Data Structures')
courses << Course.create(name: 'CS250', description: 'Databases')
courses << Course.create(name: 'CS285', description: 'Networking')
courses << Course.create(name: 'CS210', description: 'Human Computer Interaction')

courses[0].students << students[-1]
courses[0].students << students[-2]
courses[0].students << students[-3]
courses[0].students << students[-4]

courses[1].students << students[0]
courses[1].students << students[1]
courses[1].students << students[2]
courses[1].students << students[3]

courses[2].students << students[3]
courses[2].students << students[4]

courses[3].students << students[4]
courses[3].students << students[5]
courses[3].students << students[6]
courses[3].students << students[2]

courses[4].students << students[-1]
courses[4].students << students[-2]
```

Now we can populate some data.  Do the following:

```
rake db:drop

rake db:migrate

rake db:seed
```

Next, let's focus on the routes:

```
College::Application.routes.draw do
  root 'courses#index'

  get '/courses', to: 'courses#index', as: 'courses'
  get '/courses/:id', to: 'courses#show', as: 'course'

end
```

We need a courses controller to display our list of courses.  Next we generate a controller:

```
rails g controller courses --no-test-framework
```

Now let's get our list of courses showing on the root page.  Inside ```app/controllers/students_controller.rb``` add the index method.

```
def index
  @courses = Course.all
end
```

Now create ```app/views/courses/index.html.erb``` and add the logic to display our courses:


	<h3>Courses</h3>
	<ul>
	  <% @courses.each do |c| %>
		<li>
		  <%= link_to c.name, course_path(c) %>
		</li>
	  <% end %>
	</ul>

Now, start the server, ```rails s``` and verify that we can see some courses.

The next step is to show a specific course and all the students that are enrolled in the course.  That is now very easy since we have associations in our table.  First, modify the courses controller:

```
def show
  id = params.require(:id)
  @course = Course.find(id)
  @students = @course.students
end
```
Now our view can iterate over ```@courses``` and ```@students```.  Let's create the view file at ```app/view/courses/show.html.erb```:

    <h4><%= @course.name %> (<%= @course.description %>)</h4>
  
    <h5>Enrolled:</h5>
    <ul>
    <% @students.each do |s| %>
      <li>
        <%= s.name %> 
      </li>
    <% end %>

Now our app is able to do joins without much coding effort.


# References

* [Active Record Associtaions](http://guides.rubyonrails.org/association_basics.html)
* [Active Record Query Interface](http://guides.rubyonrails.org/active_record_querying.html)
* [Migrations](http://guides.rubyonrails.org/migrations.html)


