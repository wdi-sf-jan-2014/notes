# Blocks as awesomesauce

This is ruby's most powerful and most misunderstood awesomesauce.

## A deep look at `Array.each`

###Syntax and rules

```
a = [1, 2, 3, 4]

# syntax with braces
a.each { |a| puts a }

# syntax with do/end
a.each do |a|
	a *= 5
	puts a
end

# useless syntax without an argument
a.each { puts "kinda useless" }

```

* A block may be a set of ruby statements and expressions between braces or a do/end pair.
	* **Explain why is a hash literal not a block?**

* May start with an argument list between vertical bars.

* **It may appear only immediately after a method invocation.**

	* **You can't have a free floating block**
	
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

### What's happening when we use `Array.each`?



