puts "Ruby Methods"

# Return a local variable
def add_two_variables()
  num1 = 3
  num2 = 4
  result = num1 + num2
  return result
end

puts add_two_variables()

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

def add_two_arguments(num1, num2)
  result = num1 + num2
  return result
end

first_number = 5
second_number = 6
puts "Addition: #{first_number} + #{second_number} = #{add_two_arguments(first_number, second_number)}"
#Addition: 5 + 6 = 11

first_number = 3.3
second_number = 4.1
puts "Addition: #{first_number} + #{second_number} = #{add_two_arguments(first_number, second_number)}"
#Addition: 3.3 + 4.1 = 7.3999999999999995

puts "Addition: #{first_number} + #{second_number} = #{add_two_arguments(first_number, second_number).round(2)}"
#Addition: 3.3 + 4.1 = 7.4


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

# Refactor using Ruby's ".inject" method
def add_array_of_numbers(num_array)
  num_array.inject(0) {|sum, num| sum += num }
end

puts "Add all numbers in an array: #{add_array_of_numbers(number_array)}"


def add_arguments (num1, num2, *rest)
  puts "num1 = #{num1}"
  puts "num2 = #{num2}"
  puts "rest = #{rest}"
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
# Adding two arguments: 5

input_array = [2, 4, 6, 8, 10]
puts "Adding a splat array: #{add_arguments(*input_array)}"


def operate_on_two_numbers(num1, num2, operation)
  if operation == "Add"
    result = num1 + num2
  else
    "not Add"
  end
  return result
end

puts "Pass in 'Add' operation: #{operate_on_two_numbers(3,4, "Add")}"
puts "Pass in 'Subtract' operation: #{operate_on_two_numbers(5,6, "Subtract")}"

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

# Perform calculations on two numbers based on contents
# of the "options_hash"
def calculate(num1, num2, **options_hash )
  if options_hash[:operation] == "Add"
    result = num1 + num2
  else
    "not Addition"
  end
  result
end

puts "Calculate with 'Add' option: #{calculate(3,4, {operation: 'Add'})}"
puts "Calculate with 'Subtract' option: #{calculate(5,6, {operation: 'Subtract'})}"

# Calculate
def calculate(num1, num2, **options_hash)
  result = case options_hash[:operation]
    when "Add"
      result = num1 + num2
      result.round(options_hash[:precision])
    when "Subtraction" then "No Subtraction operation yet"
    else "Not defined"
  end
  return result
end

puts "Calculate with 'Add' option: #{calculate(6,7, {operation: 'Add', precision: 2})}"
puts "Calculate with 'Subtraction' option: #{calculate(7,8, {operation: 'Subtraction', precision: 2})}"
puts "Calculate with 'Multiply' option: #{calculate(7,8, {operation: 'Multiply', precision: 2})}"


def calculate_block(num1, num2, &block)
  yield num1,num2
end

puts "Calculate block (addition): #{calculate_block(3,4) {|mynum1, mynum2| mynum1 + mynum2 } }"





