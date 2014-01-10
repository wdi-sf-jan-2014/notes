#!/usr/bin/ruby -w

# Example 1 - Read File and close
file = File.new("story.txt", "r")
while (line = file.gets)
  puts line
end
file.close

# Example 2 - Pass file to block
File.open("story.txt", "r") do |infile|
  while (line = infile.gets)
    puts line
  end
end
