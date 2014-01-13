# Introduction to Algorithms: Searching, Big O and Benchmarking, and More Sorting

## Side Notes

### More on Debugging
A frequent reaction to problems in your code:
>###i am going to explode everything
###this is ridiculous
###how do i even debug this

We see that our program has bugs and maybe errors and we try to understand why it is not the program we wanted.

Instead, __try to understand the program you have written__.  If you understand why your program behaves in a way that you didn't expect, then you know how to change it.

### Read the variable scope tutorial I sent out on Hipchat yesterday:
[http://zetcode.com/lang/rubytutorial/variables/](http://zetcode.com/lang/rubytutorial/variables/)

### Commit More
You can `git commit` even if you're not connected to the internet.  I want you to commit whenever you feel like you have accomplished anything.  If you write out pseudocode in comments, commit that.

## Agenda

1. Searching Sorted Arrays
1. Benchmarking Linear VS Binary Search
1. Merge Sort
1. Benchmarking the sorts
1. Inserting into a Sorted Array


## Searching a Sorted Array
This morning you implemented BubbleSort.  We're now going to talk about precisely why having a sorted list is more useful than having an unsorted list.

Given an unsorted list of strings, how can we get the location of a particular string?  We have to search linearly through the list.  If the list doubles in length, we might have to look at twice as many strings.

Given an alphabetically sorted list of strings, what can we do? If we compare the middle element to our target, we can halve the section of the list which we are searching.  This process is called a __binary search__, because it divides the problem by 2 with every comparison.

We will write pseudocode for two ways of implementing binary search as a class, a recursive way, and a looping way.

Then you will implement both.

## Linear VS Binary Search: Asymptotic Complexity
Benchmarking is the process of recording how efficiently a piece of software executes.  We can benchmark code by recording the current time before the code we are interested in, executing our target code, then recording the new time.

```
time = Time.now
# run code you want to benchmark here
elapsed_time = Time.now - time
```

It's best to average the result of many benchmarks.

```
n_runs = 100
total_elapsed_time = 0.0
n.runs.times do
	time = Time.now
	# run code you want to benchmark here
	total_elapsed_time += Time.now - time
end
average_time = total_elapsed_time/100
```

I do this with in search_bench.rb, and have results in search_bench.csv.

As you can see in search_bench.csv, as the running time of Array#index increases linearly with the size of the array, the running time of our binary search function hardly increases at all.  In fact, it is increasing.  If linear search and binary search took the same amount of time to search an array of N integers, then it would roughly take binary search the same amount of time to search an array of 2*N integers as it would for linear search to search N+1 integers.  

This difference is tremendous.  If you go from 10,000 users to 1,000,000 users, and pages on your site examine every user record to render the page, the increase in users could cause that search to take 100 times longer if it is linear.  In log time, log2(10000) is about 13, and log2(1000000) is about 20.  The difference will probably be insignificant.

This concern with the running time of algorithms on large amounts of input is concern about the relative __Asymptotic Complexity__ of the two algorithms.  We say that binary search has __O(log(N))__ complexity, while linear search has __O(N)__ complexity.

This _Big O_ notation is used to talk about the worst case running time of an algorithm.  For large N, linear search takes time proportionate to the size of the data, while binary search takes time proportionate to the log of the size of the data.

What is the asymptotic complexity of BubbleSort?

### Merge Sort
Consider this method of sorting an array:

```
Function MergeSort(Array)
	If Array has 1 element
		return Array
	Otherwise
		Split Array into LeftHalf and RightHalf
		Let SortedLeftHalf = MergeSort(LeftHalf)
		Let SortedRightHalf = MergeSort(RightHalf)
		Let SortedArray = Merge(SortedLeftHalf, SortedRightHalf)
		return SortedArray

Function Merge(FirstArray, SecondArray)
	FirstArray and SecondArray must both be sorted
	Let OutputArray be an empty array
	While neither FirstArray nor SecondArray are empty
		Compare the starting elements of FirstArray and SecondArray
		Take the smaller one off and add it to the end of OutputArray
	Unless both FirstArray and SecondArray are empty
		Let Remainder be the non-empty one
		Add Remainder to the end of OutputArray
	return OutputArray
```

This is an elegant and fairly simple sort, called MergeSort.  Implement it in groups.  If you finish, help your classmates get it.

A real-world implementation of merge sort is more complicated, because we must re-use the array space that we start with to cut down on memory allocations.

### Inserting into a Sorted Array

Today's lab will be about the problem of inserting into a sorted array.  How can we keep an array sorted as we insert new elements into it?

##Further Reading 

[Harvard CS 50's Introduction to Algorithms](https://www.youtube.com/watch?v=MwFMs9GQMGY&list=PLF8A834F810575A94&index=7)

[Animations of Sorting Algorithms](http://www.sorting-algorithms.com/)