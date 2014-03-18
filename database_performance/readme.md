# An Introduction to Database Performance

## Objective
The goal of this lesson is to introduce you to several different sorts of performance problems which plague Rails apps.  For the lab, I've made the slowest app, which you will make fast.

## Agenda
* Introduce a slow rails app
* Unindexed query
* SQL explain
* What is an index?
* N + 1 queries
* Compound indexes
* Uniqueness Validation and Indices

### The First Principle of Optimization
__Always benchmark__!  If you make optimization changes without knowing first how slow you were, and second how fast you got, you will complicate your code for know benefit.  The instincts of programmers about what causes a program be slow or memory-inefficient are frequently wrong.  Optimizing before it is necessary or without benchmarking is called __premature optimization__.

### The Lab

We will be working on the lab at https://github.com/wdi-sf-jan-2014/slowest_lab today.  There are a variety of slow pieces to the lab and you should try to speed up as many as possible.

### Rails action logs

The starting point of your optimization will almost always be the Rails action logs or a program which aggregates those logs like [NewRelic](http://newrelic.com/) or [Splunk](http://www.splunk.com/).

```
Started POST "/sessions" for 127.0.0.1 at 2014-03-18 08:22:36 -0700
Processing by SessionsController#create as HTML
  Parameters: {"utf8"=>"✓", "authenticity_token"=>"NH0H6lbC5IQRpV1ZMEIt3reZzov92Cf8tcvAQMRRtRo=", "session"=>{"email"=>"fae_sauer@mcglynn.ca", "password"=>"[FILTERED]"}, "commit"=>"Sign in as User.first"}
  User Load (0.5ms)  SELECT "users".* FROM "users" WHERE "users"."email" = 'fae_sauer@mcglynn.ca' LIMIT 1
Redirected to http://localhost:3000/
Completed 302 Found in 161ms (ActiveRecord: 3.7ms)

```

From your logs you have the key information about what is happening in your app.  What requests are being made?  How long do they take?  How much of that time is spent in the database?  How much of that time is spent in the views?  This is your first clue as to where to look for slow code.

### SQL Explain

Every SQL database provides `EXPLAIN` functionality which can be prepended to a `SELECT` statement (`EXPLAIN SELECT ...`) in order to get information about how the database plans to execute the query.  Rails also provides an `explain` method on relations, which gives the result of `EXPLAIN`ing every query in the relation.  

### SQL Indexes

An SQL index is the analog in databases of sorting an array.  When we tell the database to index a column on a table, we are telling it to build a separate list, sorted by that column and usually stored as a [B-Tree](http://en.wikipedia.org/wiki/B-tree), which links back into the main table.

Without an index, we'll see linear `O(N)` growth in the amount of time it takes to get a record from a table.  When we add an index, we increase the memory overhead and slow down insertions and deletions, but speed up searches.

```
CREATE INDEX title_index ON films (title);
```

SQL indexes are also the only way to make sure that a column has a uniqueness constraint.  Uniqueness validation at the Rails level is helpful for maintaining a good user experience, but two requests executing in parallel can create a pair of conflicting models.  In our production setups where we have multiple processes dealing with requests, this can happen easily,

Suppose a user clicks twice on a form submission button, or a bug in your ajax causes the request to submit twice.  Let's use an example of liking a post.
* First both processes recieve likes#create requests.
* Both processes check whether there is already a like for that user on that post and see that there is not.
* Both processes then insert a new like into the database.
* Now there are two invalid likes in the database.

To avoid this, the database itself has to maintain the uniqueness constraint:

```
CREATE UNIQUE INDEX likes_u_index ON likes (post_id, user_id);
```

To make these indexes from rails, we create a migration and use the `add_index` method.  We can also pass `:unique => true` as an option when we're adding the column.

```
add_index :likes, [:post_id, :user_id], :unique => true
```

### 1 + N Queries

One of the errors it's easy to make in Rails is to forget to use joins.  Suppose we have some code in the controller:

```
@groups = current_user.groups
```

Then some code in the view:

```
<%= for group in groups %>
	Members of <%= group.name %>
	<ul>
		<%= for u in group.members %>
			<li>
				<%= u.name %>
			</li>
		<% end %>
	</ul>
<% end %>
```

This will create 1 query which gets all the user's groups, then N queries, one for each group, which get the users of that group.

Instead, we use a Rails helper which gets all the users of all the groups in one query, then attaches them to the group objects.

```
@groups = current_user.groups.includes(:members)
```

Then without any changes to the view, iterating through `group.members` will not create any queries.  These can be nested: `current_user.groups.includes(:members => :profile)`

### ActiveRecord object bloat

Your application cannot handle loading millions of ActiveRecord objects from the database.  If you are loading a huge amount of data, ActiveRecord has to go through it bit by bit to put it into nice objects for you.  Paginate your queries so you don't bring in more data than the user can actually look at.  A good example of what not to do is in DashboardsController in the lab.

### Other Database features to look into:
* Foreign key constraints: If there is a column `user_id` in the `posts` table, a foreign key constraint can prevent you from doing anything which would result in a row in `posts` having a value in `user_id` without a corresponding row in `users`.
* Common Table Expressions in Postgres: CTEs are a great way to extract tree-like data from the database.  It's like recursive search, but Postgres does it internally.

## Resources
* [Migrations in Rails](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html)
* [add_index in Rails](http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index)
* [Indexes in Postgresql](http://www.postgresql.org/docs/9.3/static/sql-createindex.html)
* [The Postgresql user guide to Explain](http://www.postgresql.org/docs/9.3/static/using-explain.html)
* [The Rails guide to Rails explain](http://guides.rubyonrails.org/active_record_querying.html#running-explain)