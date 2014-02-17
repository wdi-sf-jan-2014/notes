require './deadlocker_one.rb'
use Rack::Lock
run DeadlockerOne.new
