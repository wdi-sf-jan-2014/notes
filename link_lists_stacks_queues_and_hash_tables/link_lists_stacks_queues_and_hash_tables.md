# Data Structures & Algorithms

## Topics
The theme for this lesson is understanding data structures and your code on a deeper level.  Here are the topics we'll cover:


* Arrays: a more in depth look
* Link Lists
* Stacks and Queues
* Hash Tables: another in depth look

## Arrays: More In Depth

Ruby is implemented in C, so in one way or another, the code you write is evetually converted to C before it gets exectued.  In the C language, the memory for a program must be managed by the developer.  In other words, when some data structure, like an array is created, the developer must request how much memory he wants (how many array cells) before he starts using the array.  When the developer is done with the array, he must delete that memory that he allocated.

__What happens if the array needs to hold more data than the number of cells that were allocated?__

In order to implement a modern array, which does not have an explicit limit on the number of cells in the array, the developer must write code to create a new array whenever the array grows beyond the bounds of its memory size.  This operation is O(n) because a new array needs to be allocated in memory, then every item within the existing array must be copied over to the new array.

__DISCUSSION: What happens when the ruby method ```unshift``` is called on an array?__


## Link Lists

A `linked` list is a data structure of storing a collection items. To start a `linked list` is a collection of nodes, and each `node` has a `value` and a *referenece* to the `next` node. This links each node together through a chain of references. The linked list only needs to store the first node in the chain to maintain the collection of nodes.


### Conceptual Overview

A `linked` list is a data structure of storing a collection items. To start a `linked list` is a collection of nodes, and each `node` has a `value` and a *referenece* to the `next` node. This links each node together through a chain of references. The linked list only needs to store the first node in the chain to maintain the collection of nodes.

### How to make one?

What ingredients do we need from description above?

* Node, a class for items in our collection
    *  Node#value, to store a the `value` of an object.
    *  Node#next, to store the reference to the `next` node.
* List
    * List#node to store the first node in the collection
    * List#tail, a reference to the last item in the collection of nodes list's next node.
    * List#head, a reference to the first node in the list. 


Just to reiterate, a linked list a *collection* of **items** where each *item* in the collection in an object with two attributes a *value* and a *reference* to the *next* item, and the last item has a **nil** reference.



    [ValOne,nextRef] [ValTwo,nextRef] [LastVal,nillRef]
	   ---------       	 --------            ----------
	  |   	| _ |    \  |     | _ |    \    |    |\\ //|
	  |  1  ||_====== ) |  2  ||_====== ) … | 5  | ) ( |
	  |     |   |    /  |     |   |    /    |    |// \\|
	   ---------         ---------           ----------


> NOTE: it might be helpful to avoid writing shorthand for a list like an array, i.e. [1,2,3], so to avoid confusion, we might write our list with parens, i.e. (1,2,3).


### Exercise

Draw out a linked list.  Visualize insert, remove and iteration.

## Stacks and Queues

Stacks and queues are data structures that are commonly used to preserve a certain type of order on the data.  A stack is a Last In First Out data structure or LIFO data structure. A queue, on the other hand, is a First In First Out data structure, or FIFO data structure. 

__Real World Examples__:

* A stack of clothes in your drawer - LIFO
* A line at the grocery store - FIFO
* Bot queue for the class - FIFO
* The call stack in ruby - LIFO

## Hash Tables

[An explanation of how hash tables work](http://www.sparknotes.com/cs/searching/hashtables/section1.html)

## Resources

[Ruby's Implementation of Arrays](http://rxr.whitequark.org/mri/source/array.c)
[http://en.wikipedia.org/wiki/Linked_list#Singly_linked_list](http://en.wikipedia.org/wiki/Linked_list#Singly_linked_list)
[http://en.wikipedia.org/wiki/Linked_list#Doubly_linked_list](http://en.wikipedia.org/wiki/Linked_list#Doubly_linked_list)
[http://en.wikipedia.org/wiki/Linked_list#Linearly_linked_lists](http://en.wikipedia.org/wiki/Linked_list#Linearly_linked_lists)
[http://www.sitepoint.com/rubys-missing-data-structure/](http://www.sitepoint.com/rubys-missing-data-structure/)
[An explanation of how hash tables work](http://www.sparknotes.com/cs/searching/hashtables/section1.html)


