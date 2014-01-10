require 'pry'

class MalformedStoryError < ArgumentError

end

begin
	File.open("isdfiusdfhui") 
	#throw MalformedStoryError.new("Your story file was malformed")
	#binding.pry	
rescue MalformedStoryError => myerror
	puts "Got a malformed story #{myerror}"
rescue ArgumentError => othererror
rescue Errno::ENOENT => myerror

	puts "file did not exist"
		binding.pry
ensure
	puts "This code is run no matter what"
end