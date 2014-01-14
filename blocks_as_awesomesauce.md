# Blocks as awesomesauce

Collections of data are everywhere. 

Here we have a classroom of students. 

Outside we have bus routes with bus schedules.

At Amoeba Records, we have rows upon rows of music by various artists, that serve as a hipster safari for the music lovers whom peruse its treasures.

If you are a landlord, you want to manage a collection of apartment units inside your building.

We've been playing quite a bit with `Array` and `Hash`. Mastering these two extremely powerful ruby objects is essential to being an effective ruby programmer.

However, to understand how to use `Array` and `Hash` like Jedis, we really have to ***grok*** how blocks work.

**Blocks, procs, and lambdas are ruby's most powerful and most misunderstood awesomesauce.**

## Goals

### Grok block semantics really well
### Grok how `Array#each` and other iterators work under the hood

## A deep look at `Array#each`

###Syntax and rules

```
arr = [1, 2, 3, 4]

# syntax with braces
arr.each { |a| puts a }

# syntax with do/end
arr.each do |a|
	a *= 5
	puts a
end

# useless syntax without an argument
arr.each { puts "kinda useless" }

```

* A block may be a set of ruby statements and expressions between braces or a do/end pair.
	* **Explain why is a hash literal not a block even though it looks a little like a block?**

* May start with an argument list between vertical bars.

* **It may appear only immediately after a method invocation.**

	* **You can't write a free floating block**
	
* **The optional block argument must be the last in the list when passing it to a function. Ruby checks for an associated block. If a block is present, it is converted to an object of class `Proc` and assigned to the block argument. If no block is present, the argument is set to `nil`.**

```
def example(&block)
	puts block.inspect
end

# call example and pass in a block
example { "a block" }

# call example and don't pass in a block
example

```
###Btw

Blocks may be passed into a ruby method implicitly. You don't need to specify a `&block` argument when you define your method. You just don't get the named `block` in your method. You may still invoke the block's code via `yield`.

```
def example
	yield if block_given?	
end
```

We'll get back to `yield` very shortly.

### Let's dig into Proc

So we already understand that blocks are objects from the example above.

Given what you saw, it should come as no surprise that you may:

* Store references to blocks in variables
* Pass blocks around
* Invoke blocks' code later

Let's create a `Proc` object in one method, return it, and pass it into another method. Whoah.
	
```
def pass_block &block
	block
end

my_proc = pass_block { |name| puts "Hello, #{name}" }

my_proc.call "Alex"
```	

The `call` method invokes the code in the original block.

Let's try to pass in another argument to `my_proc`:

```
my_proc.call "Jane"
```

Pretty freaking neat-o.

### This brings us to another common point of confusion: `lambda`.

It's just a ruby built in method that returns a Proc. 

Check it out: 
```
my_lambda = lambda { |name| puts "Hello, #{name} from a lambda!" }
```

But, it provides something else that's very cool.

Procs returned by `lambda` check whether the number of arguments passed in (arity) is satisfied. 

Let's try it, both with our 'ole `my_proc` and our shiny new `my_lambda`:

```
my_lambda.call
# ArgumentError: wrong number of arguments (0 for 1)
# from (pry):353:in `block in __pry__'

my_proc.call
# Hello,
```
### And, bravely onto closures

Take a look at this example:

```
lambda { |x| 
	lambda { |y| x }
}.call(1).call(2)
```

**What the f@ç$?**

First of all, scope.

* What was in scope *before* we wrote the first line of code in this example?
* What is in scope in the outer lambda?
* What is in scope in the inner lambda? 

There's a name for `x` in the inner lambda.

It's a "free" variable - the lambda's argument list does not define it.
`lambda { |y| x }` does not have an argument named x. 

The variable `x` isn't bound in this function. 

Functions and lambdas define variables that are "bound" to it via their argument lists.

Lambdas, procs, and blocks create a new variable scope. As do methods. This scope is local to its context.

The beauty of lambda is that it allows you to create methods, the values and variables of which stay on livin' after the lambda returns. This is superbly powerful. This, combined with the ability to pass functions as objects are the two pre-requisites and properties of closures.



A closure creates a new variable scope, whose variables and values are retained after the closure returns. 

Another way of saying is this is that a closure is a function that is said to be 'closed over' its free variables. Yet another way is that a closure is a function with free variables that are bound to their environment.

Finally, there are two kinds of functions:

* Functions containing no free variables: **pure functions**.

Some pure functions in the form of lambdas:

```
lambda {}

lambda { |x| x }

lambda { |x| 
	lambda { |y| x }
}
```

The first function doesn’t have any variables, therefore doesn’t have any free variables. The second doesn’t have any free variables, because its only variable is bound. The third one is actually two functions, one in side the other. function (y) ... has a free variable, but the entire expression refers to function (x) ..., and it doesn’t have a free variable: The only variable anywhere in its body is x, which is certainly bound within function (x) ....

From this, we learn something: A pure function can contain a closure.

* Functions containing one or more free variables: **closures**.

Understanding this is absolutely essential to really grokking blocks. Why? Because blocks are Procs/lambdas in disguise. So, they inherit that property very gracefully in that they inherit the variables of the scope in which they are used.

### You do exercise (5m)

If pure functions can contain closures, can a closure contain a pure function? Using only what we’ve learned so far, attempt to compose a closure that contains a pure function. If you can’t, give your reasoning for why it’s impossible.

### More on Proc

What does this do?

```
[1, 2, 3, 4].inject(:+)
```

The same as:

```
[1, 2, 3, 4].inject { |acc, value| acc + value }
```

Whoah... right?!

Why?

A combination of `Symbol.to_proc` and `Object#send` is why.

```
class Symbol
	def to_proc
		Proc.new { |obj, *args| obj.send(self, *args) }
	end
end

# check it out, how this breaks down... 

[1, 2, 3, 4].inject { |obj, *args| obj.send(:+, *args) }
# or
[1, 2, 3, 4].inject { |acc, value| acc.send(:+, value) }
# or
[1, 2, 3, 4].inject { |acc, value| acc + value }
```

### Some cautionary points

* Be **very careful** when not using parentheses and passing in blocks!
	* Order of operations!
		* Braces have high precedence
		* do/end has low precedence	

Let's use `Array#map` for this example:
	
```
# low precedence
[3] pry(main)> puts arr.map do |element|
[3] pry(main)*   element * 2
[3] pry(main)* end
#<Enumerator:0x007fa619a0e0a8>
=> nil

# high precedence
[4] pry(main)> puts arr.map { |element| element * 2 }
2
4
6
=> nil

# getting back high precedence, with parens
[8] pry(main)> puts(arr.map do |element|
[8] pry(main)*     element * 2
[8] pry(main)* end)
2
4
6
=> nil

```

#### You do exercise (5 minutes)
Given the hash:

```
musicians_with_genres = {
	id_osbourne: {
		first_name: "Ozzy",
		last_name: "Osbourne",
		genre: "Heavy metal"
	},
	id_morrison: {
		first_name: "Jim",
		last_name: "Morrison",
		genre: "Psychedelic rock"
	}
}
```

Write two examples with iterators other than `Hash#map` and `Hash#each` that demonstrate the problem and unintended consequences of low precedence vs. high precedence when using do/end instead of braces when passing blocks to the iterators.

### What's really happening when we use `Array#each`?

We've been having a lot of fun with iterators... ruby methods like `Array#each`, `Array#map`, `Hash.each_with_index`, and others. Let's dig deeper and understand how they work under the covers, by examining `Array#each`.

Let's take another look at one of the previous examples:

```
arr = [1, 2, 3, 4]
for i in 0..arr.size
	puts "#{arr[i]}"
end
```

It works. What are some problems with this?

* Tight coupling between the iteration operation and the retrieval operation
* Having to use a meaningless index element
* Readability

If we had a more complicated array... for example a chessboard represented by a two-dimensional array, we'd now have to write a much more complicated loop!

If we had a hash of hashes, things would get ugly quickly. We'd have to possibly extract the keys of the top level hash, then the keys of the child hashes, etc. We'd have to keep track of them. Ugly, upon ugly, upon ugly.

Iterators to the rescue!

```
arr = [1, 2, 3, 4]
arr.each { |element| puts element }
```

* Much more beautiful
* It reads well
* The "looping" is decoupled from the retrieval
	* You don't have to think about what index you're on
* The output is decoupled from the looping
	* Changing this to do something else is absolutely trivial
	
#### The method `Array#each` is an iterator

An iterator is a method that invokes a block of code repeatedly (one or more times).

Let's write our own iterator.

```
def fun_iterator &block
	yield
end

fun_iterator { puts "repeat this code" }
```

Let's add another `yield` to our iterator.

```
def fun_iterator &block
	yield
	yield
end

fun_iterator { puts "repeat this code" }
```

So what does `yield` do?

`yield` invokes the block passed into the method as the method's block argument, denoted by `&block`, much like you would invoke a method.

Let's add the ability to have the block take an argument.

```
def fun_iterator &block
	current_year = 2014
	yield current_year
end

fun_iterator { |year| puts "It's #{year}!" }
```

Of course, this isn't so interesting. Let's implement an iterator that is capable of outputting the last ten years.

``` 
def decade &block
	(Time.now.year - 10..Time.now.year).each { |year| yield year }
end

decade { |year| puts "The year is #{year}" }
```

#### To understand how Array#each works, let's implement it!

We will do it on our `SortedArray` class from yesterday.

Before we do so, let me in on a secret:

The only true built in ruby loop constructs are `while` and `until`.

`for..in` is actually syntactic sugar for the `each` method, if it exists on the class that's being used.

So, let's take a quick peek at that old example again:

```
arr = [1, 2, 3, 4]
for i in 0..arr.size
	puts "#{arr[i]}"
end
```

This translates roughly to:

```
arr.each do |value|
	puts value
end
```

In other words `for..in` is *not* a loop, it's an alias for `.each`.

## Additional reading

* [Understanding Ruby blocks, Procs, and methods](http://eli.thegreenplace.net/2006/04/18/understanding-ruby-blocks-procs-and-methods/)
* [Ruby & (Ampersand) Parameter Demystified](http://www.skorks.com/2013/04/ruby-ampersand-parameter-demystified/)
* [Going crazy with to_proc](http://iain.nl/going-crazy-with-to_proc)
