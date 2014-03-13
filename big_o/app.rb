require 'sinatra'
require 'sinatra/reloader'

get '/*' do 
  File.read("index.html")
end
