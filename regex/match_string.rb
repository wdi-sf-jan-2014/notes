# Execute by running:
# ruby match_string.rb string_data

# Problem 1:
# lowercase only:
#   match the word cat by itself, at the end of a line, and when posessive only
# Fill in the regex required to match all three in the regex_find_cat variable.
# Eg: regex_find_cat = /(cat)/

regex_find_cat = /\scat\s|\scat's\s|\scat.$/

# Expected Output:
# Prob 1: I love my cat.
# Prob 1: I this your cat's favorite toy?
# Prob 1: Which cat is yours?

# 3 points for only these three matches
# 2 points for only two of the three matches
# 1 point for only one of the three matchex
# 0 points otherwise

###################################################

# Problem 2:
# lowercase and uppercase only:
#   match the word cat by itself, at the end of a line, and when posessive only
# Fill in the regex required to match all three in the regex_find_cat variable.
# Eg: regex_find_cat = /(cat)/

regex_find_cat_Cat = /\scat\s|\scat's\s|\scat.$|^Cat\s/i

# Expected Output:
# Prob 2: I love my cat.
# Prob 2: I this your cat's favorite toy?
# Prob 2: Which cat is yours?
# Prob 2: The Cat in the Hat.
# Prob 2: Cat or dog or both?

# 3 points for only five three matches
# 2 points for only two or three of the three matches
# 1 point for only one of the three matchex
# 0 points otherwise

###################################################
# Problem 3
#   match cat in a url as username, as domain name only
# Fill in the regex required to match both cases in the regex_find_cat_url variable.

regex_find_cat_url = /\scat@|@cat\./

# Expected Output:
# Prob 3: I wish my URI was cat@gmail.com.
# Prob 3: I wish my URI was dog@cat.com.

# 2 points for only these two matches
# 1 point for only one match
# 0 points otherwise


# Executes file read and .match(line)
prob1 = ""
prob2 = ""
prob3 = ""
while line = gets
  prob1 += "Prob 1: " + line if regex_find_cat.match(line)
  prob2 += "Prob 2: " + line if regex_find_cat_Cat.match(line)
  prob3 += "Prob 3: " + line if regex_find_cat_url.match(line)
end
puts "***** Problem 1 *****"
puts prob1
puts "***** Problem 2 *****"
puts prob2
puts "***** Problem 3 *****"
puts prob3


# Final Output:
# ***** Problem 1 *****
# Prob 1: I love my cat.
# Prob 1: I this your cat's favorite toy?
# Prob 1: Which cat is yours?
# ***** Problem 2 *****
# Prob 2: I love my cat.
# Prob 2: I this your cat's favorite toy?
# Prob 2: Which cat is yours?
# Prob 2: The Cat in the Hat.
# Prob 2: Cat or dog or both?
# ***** Problem 3 *****
# Prob 3: I wish my URI was cat@gmail.com.
# Prob 3: I wish my URI was dog@cat.com.
