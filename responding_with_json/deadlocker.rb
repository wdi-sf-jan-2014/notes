require 'sinatra'
require 'pry'
require 'net/http'

use Rack::Lock
get '/bounce/:port' do
  my_port = self.env["SERVER_PORT"]
  puts "Sending bounce request to port #{params[:port]}"
  result = Net::HTTP.get(URI.parse("http://localhost:#{params[:port]}/#{my_port}/data"))
  puts "Got bounce result from port #{params[:port]}"
  "result was #{result}"
end

get '/data' do
	puts "Got request for data, returning it."
	my_port = self.env["SERVER_PORT"]
	"This is data from the server at port #{my_port}"
end

get '/:port/data' do
  puts "Sending request for data to port #{params[:port]}"
  result = Net::HTTP.get(URI.parse("http://localhost:#{params[:port]}/data"))
  puts "Got data: #{result} from port #{params[:port]}"
  result
end
