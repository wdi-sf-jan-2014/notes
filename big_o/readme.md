# Algorithmic Complexity: The Big O

## Agenda
* What is algorithmic complexity?
* Revisit the Trie vs Compressed Trie
* Why do we care?
* Common choices
* How do we calculate it?
* Some Complexity Classes

### What is Algorithmic Complexity?

Often in software engineering, we need to choose between algorithms and data structures which are suited to different tasks.  We need to analyse our own tasks, and the data we will be using, and make informed decisions about what tools to use.  Sometimes one tool is better in every way than another, but more often we have to sacrifice memory use for computation speed, or sacrifice speed of deletions to increase speed of insertions, and so on.

Big O statements for an algorithm f tend to be in the form: `f is in O(g(n))`.  This means: For large n, the resource usage (usually running time) of `f` less than the resource usage of `g`, in the worst case and therefore for all cases.  Often what is meant is: For large n, the worst case running time of `f` is asymptotically the same as the worst case running time of `g`.  

Asymptotically the same means that there are two constants `a` and `b` such `a*g < f < b*g` for all n.

### Why do we care?

First, it is important that the algorithms used in our applications will behave well as the amount of data our application is operating on increases.  For instance, in the absence of indexing, a database feature we will talk about next week, the ActiveRecord code `User.where(:name => "Delmer")` will take `O(n)` time.  This means that if the number of users in our database doubles, it will take twice as long to find Delmer.  With indexing, this will take `O(log(n))` time, meaning that the amount of time used to find Delmer will double if the number of users in our database is __squared__.  This is the difference between the app collapsing into a slow and unresponsive grave when the number of users gets to thousands and the app continuing calmly to a hundred thousand or a million users.

Second, you will get these sorts of questions in interviews.

### How is the Big O of a procedure calculated?

We consider all possible input to the algorithm, and choose the one which will perform the worst.  Then consider the algorithm line by line.

For each operation which takes some minimal amount of time, add 1.  

For a linear loop which goes through each piece of the input, multiply the operations inside of that by the size of the input (usually called N).

For a loop which chooses a section of the input, then focuses in on that section, that will be log time.

### Common Choices:
* To Index or not to Index? (tree vs list)
* Should this be a hash or an array?
* Should some data be cached?

### Some Complexity Classes:
* O(1) - Constant time
   * Get the first value of a list
   * Random sample from a list

* O(logN) - Divide and Pick
   * Typical of algorithms that divide the input, then look at one of the sections
   * Searching sorted data

* O(N) - For each ....
   * Sum an array

* O(NlogN) - Divide and pick a section for every piece of input
   * Sorting with quicksort, merge sort, or other optimized sort.

* O(N^2) - For each piece of data, look at the data you haven't looked at yet (the rest of the list)
   * Insertion sort
         
* O(N^3)
	* Naive Matrix Multiplication
   * Drawing a graph with force layout

* O(c^n) - One new piece of data doubles the work is 2^n.
  * Playing chess: looking one more move ahead multiplies the work

* O(n!) - List all combinations of a set, every possible subset.  Impossibly slow and hardly ever needed.
  * Naive travelling salesman
  
## Resources:
* Good introduction to complexity analysis by Dionysis Zindros [http://discrete.gr/complexity/](http://discrete.gr/complexity/)
* Overview of selected data structures, operations, and their complexity: [http://bigocheatsheet.com/](http://bigocheatsheet.com/)
* The classic Algorithms textbook by Cormen, Leierson, Rivest, and Stein: [http://mitpress.mit.edu/books/introduction-algorithms](http://mitpress.mit.edu/books/introduction-algorithms)
