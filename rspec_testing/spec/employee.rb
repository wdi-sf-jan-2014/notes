class Employee
  attr_accessor :name

  @@employee_count = 0

  def initialize(name)
    @name = name
    @@employee_count += 1
  end

  def introduce
    "Hi, my name is #{@name}."
  end

  def self.count
    @@employee_count
  end

  def self.resign
    @@employee_count -= 1
  end

end

