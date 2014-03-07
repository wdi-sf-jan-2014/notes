# Execute by running:
# ruby read_time_data.rb time_data

# 2014-03-01 08:01:50 -0800

# Fill in regex variable with the regular expression that extracts out the
# date and time data. regex = /[0-9]{4}/ or regex = /\d{4}/

# Extract Year in match_data[1], Month in match_data[2], Day in match_data[3] - already done
# Extract Hours in match_data[4], Minute in match_data[5], Seconds in match_data[6], Timezone in match_data[7]

def read_time_data

  regex =  /(^\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2}):(\d{2})\s-(\d{4})/ # 3 out of 7

  matches_count = 0

  while line = gets
    match_data = regex.match(line)
    # puts line
    # puts match_data.inspect

    next if match_data == nil
    # Match only Year: 6 matches
    if match_data[1] && !match_data[2]
      puts "(Year) Year is: " + match_data[1]
      matches_count += 1
      score = 1
    end

    # Match (Year && Month) only: 5 matches
    if match_data[1] && match_data[2] && !match_data[3]
      puts "(Year && Month) Year is: " + match_data[1] + ", Month is: " + match_data[2]
      matches_count += 1
      score = 2
   end

    # Match (Year, Month, Day) only: 1 match
    if match_data[1] && match_data[2] && match_data[3] && !match_data[4]
      puts "(Year, Month, Day)"
      puts "Year is: " + match_data[1] + ", Month is: " + match_data[2] + ", Day is: " + match_data[3]
      matches_count += 1
      score = 3
    end

    # Match (Year, Month, Day, Hours) only: 1 match
    if match_data[1] && match_data[2] && match_data[3] && match_data[4] && !match_data[5]
      puts "(Year, Month, Day, Hours)"
      puts "Year is: " + match_data[1] + ", Month is: " + match_data[2] + ", Day is: " + match_data[3] +
            ", Hours: " + match_data[4]
      matches_count += 1
      score = 4
    end

    # Match (Year, Month, Day, Hours, Minutes) only: 1 match
    if match_data[1] && match_data[2] && match_data[3] && match_data[4] && match_data[5] && !match_data[6]
      puts "(Year, Month, Day, Hours, Minutes) "
      puts  "Year is: " + match_data[1] + ", Month is: " + match_data[2] + ", Day is: " + match_data[3] +
            ", Hours: " + match_data[4] + ", Minutes: " + match_data[5]
      matches_count += 1
      score = 5
    end

    # Match (Year, Month, Day, Hours, Minutes) only: 1 match
    if match_data[1] && match_data[2] && match_data[3] && match_data[4] && match_data[5] && match_data[6] && !match_data[7]
      puts "(Year, Month, Day, Hours, Minutes, Seconds)"
      puts  "Year is: " + match_data[1] + ", Month is: " + match_data[2] + ", Day is: " + match_data[3] +
            ", Hours: " + match_data[4] + ", Minutes: " + match_data[5] + ", Seconds: " + match_data[6]
      matches_count += 1
      score = 6
    end

    # Match (Year, Month, Day, Hours, Minutes) only: 1 match
    if match_data[1] && match_data[2] && match_data[3] && match_data[4] && match_data[5] && match_data[6] && match_data[7]
      puts "(Year, Month, Day, Hours, Minutes, Seconds, Timezone)"
      puts  "Year is: " + match_data[1] + ", Month is: " + match_data[2] + ", Day is: " + match_data[3] +
            ", Hours: " + match_data[4] + ", Minutes: " + match_data[5] + ", Seconds: " + match_data[6] +
            ", Timezone is Zulu + " + match_data[7]
      matches_count += 1
      score = 7
    end

    # /(\d+)-(\d+)-(\d+)/.match(line)
    # /([0-9][0-9][0-9][0-9])-([0-9][0-9])-([0-9][0-9])/.match(line)
  end

  puts "The number of matches is: #{matches_count}"

  puts "Your score is: #{score} out of a possible 7."

end

read_time_data

# puts "The number of matches is: #{matches_count}"

# puts "Your score is: #{score} out of a possible 7."







