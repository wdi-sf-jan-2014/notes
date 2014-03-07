date = "2014-03-01 08:01:50 -0800"

puts date  # 2014-03-01 08:01:50 -0800

months = %w{Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec}

p months
# ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

match_data = date.match(/(^\d{4})-(\d{2})-(\d{2})\s/)

puts "match_data[0] = #{match_data[0]}"  # 2014-03-01
puts "match_data[1] = #{match_data[1]}"  # 2014
puts "match_data[2] = #{match_data[2]}"  # 03
puts "match_data[3] = #{match_data[3]}"  # 01

if match_data[2] == "03"
  puts months[3]
end

index = match_data[2].to_i - 1
puts index

puts "#{months[match_data[2].to_i - 1]} #{match_data[3].to_i}, #{match_data[1]}"

