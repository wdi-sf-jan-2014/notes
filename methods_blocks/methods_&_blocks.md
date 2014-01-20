#Methods & Blocks

#Methods:
## Programming Mantra: "DRY" 
## "Don`t Repeat Yourself"
###If you find repeating lines of code in your program, you should put them into a method.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## Agenda:
### Review some vocabulary
### Built in methods (Strings, Arrays, Hashes)
### Custom methods
### Create a file to store todays work - snippets
### We are going to code together the "Addition" function.
* method with no arguments
* method with 2 numeric arguments
* method with 2 numeric arguments - one has a default value
* method with an array argument
* method with a variable number of parameters - *spalt
* method with 2 numeric arguments and an operation variable
* method with 2 numeric arguments and an options hash
* method being passed a block

### You will implement the other operations as an in class exercise.
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

###Built-in Methods: .each, .length, .inject
* built-in methods are invoked using the "dot" notation
* .map and .select are identical methods
* .length, .size and .count are identical methods
		
		array = [1,2,3,4,5]
		array.length
		=> 5
		
		array.each { |num| puts num * 2 }
		2
		4
		6
		8
		10
		=> [1, 2, 3, 4, 5]
		
		new_array = array.map { |num| num * 2 }
		=> [2, 4, 6, 8, 10]
		
		hash = {first: "Mickey", last: "Mouse", address: "Disneyland"}
		hash.each { |key, value| puts "the key is #{key}, the value is #{value}." }
		the key is first, the value is Mickey.
		the key is last, the value is Mouse.
		the key is address, the value is Disneyland.
		=> {:first=>"Mickey", :last=>"Mouse", :address=>"Disneyland"}
		
###Built in String Methods:
* .capitalize:  "hello".capitalize => "Hello"
* .upcase: "Hello".upcase => "HELLO"
* .downcase: "Hello".downcase => "hello"
* .include?: "Hello".include?('e') => true	
* .split(): "Hello".split("") => ["H", "e", "l", "l", "o"]
* .join(): 	["H", "e", "l", "l", "o"].join("") => "Hello"
* .reverse: "Hello".reverse => "olleH"

###Built in Array Methods:
* .length, .sort, .reverse, .sort.reverse, .include?, .empty?, 
* .push: [1,2,3].push(4) => [1,2,3,4]
* .pop: [1,2,3,4].pop => 4; your array is now: [1,2,3]
* .unshift(): [1,2,3].unshift(0) => [0,1,2,3]
* .shift: [0,1,2,3].shift => 0; your array is now: [1,2,3]
* .delete_at(1): deletes the element at index 1
* .delete(2): deletes all occurences of the number 2 from your array
* .sort_by
* .shuffle
* .sample
* .slice
* .each {|element| code }
* .each_index { |index| code }
* .each_with_index { |element, index| code }
* array.reject {|e| e > 3 } => removes any element greater than 3
* .flatten: flattens multidimensional array
* .inject: array.inject(initial_value) { |sum, element| sum += element }

###Built in Hash Methods:
* hash.key(value) => returns the key
* hash.keys => returns an array of keys
* hash.values => returns an array of values
* .to_a => converts hash to a multidimensional array of key value pairs: [[key1, val1],[key2, val2],...]
* .has_key(:first) => T/F
* .has_value?("Mickey") => T/F
* .find
* .find_all: hash.find_all { |k,v| v.match("Mickey") } => [[:first, "Mickey"]]

### Block Styles: { }, do-end
#### Ruby convention: use {} for a single line block, use do-end for multi-line blocks.
	array.each { |element| puts element }
	
	array.each do |element|
	  element += 10
	  puts element
	end

###Custom Methods: methods you define with the "def" keyword:
* custom methods are invoked by stating the method name and passing the required arguments

		def hello_world()
		 puts "Hello World!"
		end
		
		hello_world()
		=> Hello World!



####Open a file in your text editor: methods.rb

####Add one line: puts "Ruby Methods"
	
	methods.rb
	  puts "Ruby Methods"
	
	$ pry
	> load './methods.rb'
	Ruby Methods
	=> true
	
Keep adding methods and load './methods.rb' in irb to run.

## Method with no arguments - three different styles

	# Return a local variable
	def add_two_variables()
	  num1 = 3
	  num2 = 4
	  result = num1 + num2
	  return result
	end
	
	puts add_two_variables()
	# 7
	
	# Return an expression
	def add_two_variables()
	  num1 = 4
	  num2 = 5
	  return num1 + num2
	end
	
	puts add_two_variables()
	# 9
	
	# Implicit Return - Ruby returns the last statement in a method implicitly
	def add_two_variables()
	  num1 = 5
	  num2 = 6
	  num1 + num2
	end
	
	puts add_two_variables()
	# 11


## Method with 2 numeric arguments
	
	# Returns the sum of two numeric arguments
	def add_two_arguments(num1, num2)
	  result = num1 + num2
	  return result
	end
	
	# Addition of Fixnums (Integers)
	first_number = 5
	second_number = 6
	puts add_two_arguments(first_number, second_number)
	
	puts "Addition: #{first_number} + #{second_number} = #{add_two_arguments(first_number, second_number)}"
	# Addition: 5 + 6 = 11
	
	
	# Addition of Floats
	first_number = 3.3
	second_number = 4.1
	puts add_two_arguments(first_number, second_number)
	
	puts "Addition: #{first_number} + #{second_number} = #{add_two_arguments(first_number, second_number)}"
	# Addition: 3.3 + 4.1 = 7.3999999999999995
	
	
	# Need to add the ".round(2)" method for 2 decimal places 
	puts add_two_arguments(first_number, second_number).round(2)
	
	puts "Addition: #{first_number} + #{second_number} = #{add_two_arguments(first_number, second_number).round(2)}"
	# Addition: 3.3 + 4.1 = 7.4
	
## Method with 2 numeric arguments - one has default value
### the default value can be over written

	# Returns the sum of two numeric arguments
	# If only one parameter is passed, num2 is set to 3
	def add_two_arguments(num1, num2=3 )
	  result = num1 + num2
	  return result
	end
	
	puts add_two_arguments(2)
	# 5
	
	pust add_two_arguments(22, 44)
	# 66

## Method with an array argument

	# Returns the sum of the elements in an array
	def add_array_of_numbers(num_array)
	  result = 0
	  i = 0
	  while i < num_array.length
        result += num_array[i]
        i += 1
      end
      return result
    end
    
    number_array = [1, 2, 3, 4, 5]
    
    puts "Add all numbers in an array: #{add_array_of_numbers(number_array)}"
    # Add all numbers in an array: 15
    
    
    # Returns the sum of the elements in an array
    # Refactor using Ruby's ".inject" method
    def add_array_of_numbers(num_array)
      num_array.inject(0) {|sum, num| sum += num }
    end
    
    puts "Add all numbers in an array: #{add_array_of_numbers(number_array)}"
    # Add all numbers in an array: 15
    
## Method with a variable number of parameters - SPLAT
###The "splat" argument collects the excess parameters into an array

	# Returns the sum of two or more numbers
	# *rest collects the excess parameters
	def add_arguments(num1, num2, *rest)
	 puts num1
	 puts num2
	 puts rest
	 if rest.empty?
       return num1 + num2
     else
       rest.push(num1)
       rest.push(num2)
       rest.inject(0) {|sum,num| sum += num }
     end
    end

    puts "Adding multiple argumets: #{add_arguments(1,2,3,4,5)}"
    # num1 = 1
    # num2 = 2
    # rest = [3, 4, 5]
    # Adding multiple argument: 15
    
    puts "Adding two arguments: #{add_arguments(2,3)}"
    # num1 = 1
    # num2 = 2
    # rest = []
    # Adding two arguments: 5


## Splat can be use to call a method
### distributes the array into individual arguments

	input_array = [2, 4 , 6 , 8, 10]
	
	# Call the array method
	puts "Adding a splat array: #{add_arguments(*input_array)}"
	# num1 = 2
    # num2 = 4
    # rest = [6, 8, 10]
    # Adding a splat array: 30
	

## Method with 2 numeric arguments and an operation
	# Returns result of 2 variable operation
	# The operation is passed in as a string variable.
	# using if / elsif / else for the control flow
	def operate_on_two_numbers(num1, num2, operation)
	  if operation == "Add"
        result = num1 + num2
      else
        "not Addition"
      end
      return result
    end
    
    puts operate_on_two_numbers(3,4, "Add")
    puts "Pass in 'Add' operation: #{operate_on_two_numbers(3,4, "Add")}"
    puts "Pass in 'Subtract' operation: #{operate_on_two_numbers(5,6, "Subtract")}"
    
    
    # Returns result of 2 variable operation
	# The operation is passed in as a string variable.
	# using case-when for the control flow
    def operate_on_two_numbers_2(num1, num2, operation)
      result = case operation
        when "Add"
          num1 + num2
        when "Subtract"
          "No Subtraction operation yet"
        else
          "Not defined"
      end
      return result
    end
    
    puts "Pass in 'Add' operation: #{operate_on_two_numbers_2(6,7, "Add")}"
    puts "Pass in 'Subtract' operation: #{operate_on_two_numbers_2(7,8, "Subtract")}"
    puts "Pass in 'Multiply' operation: #{operate_on_two_numbers_2(8,9, "Multiply")}"	
	
## Method with 2 numeric arguments and an options hash
### Two asterisks (the double splat) indicate a hash argument: **options_hash
### Hash parameters have be at the end to be collected in the **options_hash

	# Calculate two numbers, specify operation in the options_hash
	# using if / elsif / else for the control flow
	def calculate(num1, num2, **options_hash)
	  if options_hash[:operation] == "Add"
        result = num1 + num2
      else
        "not Addition"
      end
      result
    end
    
    puts "Calculate with 'Addition' option: #{calculate(3,4, {operation: 'Add'})}"
    puts "Calculate with 'Subtraction' option: #{calculate(5,6, {operation: 'Subtract'})}"


	# Calculate two numbers, specify operation in the options_hash
	# using case-when for the control flow
	def calculate(num1, num2, **options_hash)
	  result = case options_hash[:operation]
        when "Add"
          result = num1 + num2
          result.round(options_hash[:precision])
        when "Subtract" then "No Subtraction operation yet"
        else "Not defined"
      end
      return result
    end
    
    puts "Calculate with 'Add' option: #{calculate(6,7, {operation: 'Add', precision: 2})}"
    puts "Calculate with 'Subtract' option: #{calculate(7,8, {operation: 'Subtract', precision: 2})}"
    puts "Calculate with 'Multiply' option: #{calculate(7,8, {operation: 'Multiply', precision: 2})}"
    
## The key-value pairs do not need to be inside a hash {} for the **options_hash argument to collect them.
### Reminder: key-value pairs have to be an the end of the parameter list.

	calculate(6,7, operation: 'Add', precision: 2) 
	
	puts "Calculate with 'Add' option: #{calculate(6, 7, operation: 'Add', precision: 2 ) "
	
## Method being passed a block.

	def calculate_block(num1, num2)
	  yield num1,num2
	end
	
	puts "Calculate block (addition): #{calculate_block(3,4) {|mynum1, mynum2| mynum1 + mynum2 } }"
	
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
## Cool Stuff:
####SizeUp: Split Screen - http://www.irradiatedsoftware.com/sizeup/
####Sublime 2 Tutorial: Tuts+: https://tutsplus.com/course/improve-workflow-in-sublime-text-2/


###Vocabulary: 
* Methods: are typically actions you want to take on an object.  In other languages they are called "functions".
* Attributes: are characteristics of an object (like variables assigned to an object)
* Invoke a method == we invoke the method by calling the method
* Parameters == variables that get passed into a method
* Argument == parameters that are passed into a method are received as "arguments" 
* splat == and asterisk preceeding a variable name: *varaiable_name
