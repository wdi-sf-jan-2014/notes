class Person
  attr_accessor :name, :age

  # @@population is a class variable
  @@population = 0

  def initialize(name, age=nil)
    # @age and @first_name are instance variables, they are
    # available to each instance (each object) of the class
    @name = name
    @age = age
    @@population += 1
  end

  # introduction is an instance method - it is available to each instance
  # of the class.
  # Every time we run Person.new we are creating a new instance of the class.
  # john = Person.new("John", 22)
  # The object named "john" has access to this method with: john.introduction.
  def introduction
    "Hi, my name is #{@name} and I am #{@age} years old."
  end

  # self is refering to the class
  # this is a class method
  # it is accessable as: Person.say_hello
  def self.say_hello
    "Hello world!"
  end

  # self is refering to the class
  # this is a class method
  # it is accessable as: Person.population
  def self.population
    @@population
  end

  def remove
    @@population -= 1
  end

end