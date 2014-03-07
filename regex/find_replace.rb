# Execute by running:
# ruby find_replace.rb find_replace_data

# curl -L https://www.atom.io/api/updates/download -A "Atom/0.1 CFNetwork/1.5" > Atom.zip
#
# Find and replace the following in the find_replace_data file:
#   find "Whoever", replace with "Hiring Manager"
#   find "Feb 28, 2014", replace with "Mar 4, 2014"
#   find "XYZ" position, replace with "web developer" position
#   find "who know what company", replace with "your company" (or anything of your choice)
#   find "Yours Truly", replace with your name

# Executes file read and .match(line)
while line = gets
  line = line.sub(/Whoever/, "Hiring Manager")#   find "Whoever", replace with "Hiring Manager"
  # line = line.sub()#   find "Feb 28, 2014", replace with "Mar 4, 2014"
  # line = line.sub()#   find "XYZ" position, replace with "web developer" position
  # line = line.sub()#   find "who knows what company", replace with "your company" (or anything of your choice)
  # line = line.sub()#   find "Yours Truly", replace with your name
  puts line
end

# One point for each find/replace - 4 points possible.

# Expected output:

# Dear Hiring Manager,                          Mar 3, 2014

# I want to thank you for the opportunity to speak to you about the web developer position at your company.

# Sincerely,

# Spencer Eldred