# Debugging and Exceptions

## Agenda
1. Debugging Philosophy and Techniques
1. Basic Errors and Reading an Exception
1. Methods and the Stack, Reading a Backtrace
1. Error Classes, Throwing and Rescuing
1. More Debugging Techniques, a Glimpse of Testing

## Debugging in the Abstract

### Why a Debugging Lesson?

You've been debugging but mental discipline and better technique can make debugging faster and easier.  It is impossible to write programs without writing bugs, so it is impossible to write programs without debugging, and you will be debugging every day.

### What is a bug?

The computer can't distinguish between code we wrote by mistake and code we wrote deliberately.  Every time you write code that does not have syntax errors you are producing a program, it just wasn't the one that you wanted.  A program with a bug is a program whose behavior is different from what the programmer intended, or from what the user expected.  The term "bug" dates back at least to to the 1870s, when Thomas Edison wrote:

>It has been just so in all of my inventions. The first step is an intuition, and comes with a burst, then difficulties arise — this thing gives out and [it is] then that "Bugs" — as such little faults and difficulties are called — show themselves and months of intense watching, study and labor are requisite before commercial success or failure is certainly reached.[3]

Edison didn't write code, but bugs are not specific to code, they are a result of humans attempting precise intellectual work.

### Why do we write bugs? (How can we stop?)

Bugs can be very different from each other, both in their causes and their manifestations.  Most bugs are small errors like typos, or substituting one method name for another.  Some bugs are errors in logic.  Their symptoms can vary from clear errors to subtle changes in program behavior.  The common thread is that we as humans are not precise, logical thinkers, and computer programs that we write reflect our lack of precision by being wrong.

Some bugs are moths (from William Burke, popularized by Grace Hopper):

![Some bugs are moths.](http://places.designobserver.com/media/images/townsend-smart-3_525.jpg "Some bugs are moths.")

### Design before Code

Bugs happen when intention and code separate.
Without clear intentions and a plan for the logical structure of your program, bugs are inevitable. 
Plan out your program on a whiteboard or a notebook before starting to code.  Use pseudocode so you are only thinking about the logic of the program.  Consider several different inputs to your program.  How will the control flow in the program with each different input?

Recall the file format from the File I/O adventure lab from Tuesday:

```
~p1
Welcome to the haunted hotel. What room would you like to go into?

~p1:c1:p2
room 1

~p1:c2:p3
room 2

~p2
you're dead

~p3
You picked a good room. What would like to do?

~p3:c3:p4
sleep

~p3:c4:p5
stay up all night

~p4
You're rested for the morning

~p5
You might have anxiety issues
```

And look at the same data in the simple hardcoded hash format that we used yesterday:

```
story_hash = {
		"question" => "Welcome to the haunted hotel. What room would you like to go into?",
		"room 1" => {"question" => "you're dead"},
		"room 2" => { "question" => "You picked a good room. What would like to do?",
					  "sleep" => {"question" => "You're rested for the morning"},
					  "stay up all night" => {"question" => "You might have anxiety issues"}
		}
}
```

Let's write some pseudocode for a function which takes a filename for a story and returns a story hash, assuming that the first room is always the first entry in the file.

### Be Systematic

Figure out where the behavior of the program departs from your mental model of the program.  Use print statements and the debugging console to look at the state of the program as it changes.  If the state is correct at one line, and wrong later, the error must happen in between.

#### Pause Execution with binding.pry

```
require 'pry'
binding.pry
```

#### Print State with puts

```
puts "variable_name is: #{variable_name}"
```

### Be Critical

When you are debugging your own code, the veil of the code you meant to write will always be hanging in between you and the code you wrote.  When working on a subtle bug, it often helps to forget about what you were trying to do and work on learning why the system that you have behaves the way it does.

### Use Git

Commit constantly.  You should commit whenever you make a change that works.

## Exceptions: What do they Mean?

####SyntaxError
SyntaxError is thrown when Ruby does not recognize the code you've given as valid Ruby code.  It often indicates a typographical error like a missed parenthesis.

```
if true
)
end
```
`file.rb:2: syntax error, unexpected ')'`

What was left unclosed or inappropriately opened?
What is the line number?  The line number is where Ruby first _noticed_ that there was a problem, not where the problem occured.

####NoMethodError
`[1,2,3] / 3`
```file.rb:5:in `<main>': undefined method `/' for [1, 2, 3]:Array (NoMethodError)```

The object `[1,2,3]` has no method `/`, so we get an error.

You might have misspelled the name of a method, or you might have a different sort of object than you expected.

####NoMethodErrror for nil:NilClass
```
file = File.open("thedatafile")
puts @file.gets
```
```errors.rb:9:in `<main>': private method `gets' called for nil:NilClass (NoMethodError)```

At some point we are calling `gets` on `nil`.  The exception says line 9, so look there.

####ArgumentError
`Integer("hey")`

`ArgumentError: invalid value for Integer(): "hey"`

The Integer constructor throws an error because there is no sensible way to interperet `"hey"` as an integer.

####NameError
```
class Blender
  ...
end

blender.new
```

```NameError: undefined local variable or method `blender' for main:Object```

Read exceptions deliberately.  An unexpected exception almost certainly indicates that the program you wrote differs from the program you envisioned, or the input you are getting differs from the input you envisioned.

## The Stack and the Backtrace

Every time a method is called it is put onto the call stack.  The call stack is how Ruby keeps track of where to go back to when a return happens.  When Ruby reaches a method call, it creates a new _stack frame_ to store the local variables of the new method call and the new location of execution.  When it returns, the latest stack frame is popped off, and execution returns to the location of the call.

There's a limit to how many method calls can go on the stack (by default in ruby about 10,000):

```
def infinite_levels
	infinite_levels
end
```

`SystemStackError: stack level too deep`

A backtrace unwinds the stack so you can see what was happening when the error was thrown.


```
adventure.rb:24:in `prompt': undefined method `put' for #<Adventure:0x007fcbeecf3c00> (NoMethodError)
	from adventure.rb:30:in `prompt_n_chomp'
	from adventure.rb:47:in `start'
	from adventure.rb:64:in `<main>'
```

## Exceptions: Classes, Rescue, and Throw

We can throw exceptions of our own, by making objects that are instances of Exception or one of its subclasses.  Usually we should make a subclass of our own so that we can catch our errors without catching other errors, and so our users know that the error was detected in our code.

`throw RuntimeError.new("I'm a troublemaker")`

`ArgumentError: uncaught throw #<RuntimeError: I'm a troublemaker>`

We can make a MalformedStoryError which inherits from ArgumentError.
`class MalformedStoryError < ArgumentError; end`

And throw an instance of it.
`throw MalformedStoryError.new("The story in #{filename} couldn't be parsed")`

That will be just like the errors thrown by Ruby itself.
`ArgumentError: uncaught throw #<MalformedStoryError: The story in eggs.story couldn't be parsed>`

We can rescue errors if we expect that we might get errors and we know how to deal with them.  For example, if we want to retrieve the contents of a website, but if the website is down, we have a backup site to go to, then we might rescue the error that happens if the first site is down.  

```
def read_file(filename)
	begin
		f = File.open(filename)
		puts f.gets
		f.close
	  # This code might raise an exception
	rescue TypeError => err
		# A TypeError was thrown
		puts "There was a TypeError #{err}"
		binding.pry
	rescue ArgumentError => names_do_not_matter
		puts "There was an ArgumentError #{names_do_not_matter}"
	ensure
		puts "This runs whether or not there are errors."
	end
end
```

We might also intercept an error to throw an error of our own that is more informative.

If we are trying to retrieve the contents of a website and we are not connected to the internet, we might get an error like this:
```
SocketError: getaddrinfo: nodename nor servname provided, or not known
```

We might want to rescue from that so we can say something more like: 
"We could not reach the server, please make sure you're connected to the internet."

## More Debugging Techniques

### Testing

Write test cases and think through your program with many different inputs.  Next week we will work on making programs which test our programs with RSpec.

### Invariants (More systematic thinking)

Pick a line in your code.  What are the values of the variables at that line?  Pick a line in a loop.  What is true at that line in every iteration of the loop?

```
def find_max(list)
	max = list[0]
	for i in 1...list.length
		# What can we say about the relationship between
		# i, max, and the list at this line?
	  max = list[i] if list[i] > max
	end
	max
end
```
What assumptions does this program make about its input?

### Avoid magical thinking and random programming

Have total faith in the determinism of the system you are manipulating.  It is easy to get frustrated, start feeling like programming is magical and focus won't help you get through your work.  Without confidence that the problems you encounter can be solved, you may never solve them.  The blessing and curse of programming is that our problems are almost always our own fault.

