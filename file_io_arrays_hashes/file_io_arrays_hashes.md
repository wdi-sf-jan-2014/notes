# Intro to File I/O, Arrays, and Hashes

* Most of what we do in software has to do with reading, writing, and maintaining state
* Sometimes, state needs to be persisted: semi-permenanently preserved
* Let's introduce files as the first way that we'll work with persisted state
  * Later, of course we'll get to databases :)
  
## An old but pertinent example

The NYC Con Edison secondary electrical grid can be represented primarily in terms of its high voltage primary distribution feeders, three-phase transformers, and other components which are not pertinent to this discussion. Network contingency is important in this scenario. In order for engineers to assess contingency/failover scenarios, they need to have access to the data.

* Back in the day when I worked on the software for analyzing that data, we only had text files. 

* These were fed to us via FTP.
* We had to parse them and process them, then load them into a sql database server for reporting. Fun times.

* So, let's try to build some functionality around file input and output.

* For today, we'll do something way more fun: a choose your own adventure game!

## File Input

Let's take a look at a file containing the story of our adventure game.

Let's fork today's lab and get started on it in class:
https://github.com/ga-students/wdi_sf_6_lab_2

Now that we've forked the lab to our own github accounts, let's quickly clone our fork to our machines.

Ok, now we can work!

As a first step, let's go ahead and try to just read in the story.txt file together.
Can someone look up two ways to open and read from files in ruby?
`File.new` without block
`File.open` with block

Let's see if we can identify the parts of our story.txt file that are
important. What are those? Someone in the audience?

The pages
The questions associated with those pages

For now, let's just output those back to the screen individually.

## File Output

## Data storage and retrieval mechanisms

Ok, now that we've got that down...
Let's introduce a way to keep track of pages and their questions.

### Array

What if we just wanted to keep a list of only the pages...

Just for kicks, let's add some functionality to our file reading and figure out how to
create an array of all the pages in our book.

Just to make sure that we have all the pages, let's output all of them.

### Hash

Is this useful though for our lab?

What is the key functionality that needs to exist in our app for the
rest to work?

Page navigation, right?
 
We want to have a way to easily navigate from page to page. With an
array, we have no way of *identifying* the page.

Let's take a look at a different ruby object that might help us do just
that: the Hash object.
