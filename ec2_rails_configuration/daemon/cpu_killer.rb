#!/usr/bin/env ruby

def random_work
  random_strings = []
  500000.times { |i| random_strings << (0...8).map { (65 + rand(26)).chr }.join }
  while true
    random_strings.sort
    random_strings.shuffle
  end
end

t1 = Thread.new{random_work}
t2 = Thread.new{random_work}
t3 = Thread.new{random_work}
t1.join
t2.join
t3.join
puts "All done doing random work"
