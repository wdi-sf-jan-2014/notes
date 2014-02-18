require 'sinatra'
require 'sinatra/reloader'

get '/' do

  onmouseover_attack = 'http://1.gravatar.com/avatar/767fc9c115a1b989744c755db47feb60?size=400px" onmouseover="alert(\'executing from inside of avatar_url\')'
  onerror_attack = '#" onerror="alert(\'executing from inside of avatar_url\')'
  
  # This works on some older browsers:
  directive_attack = 'javascript:alert(\'hey\')'

  @data = {name: "Raphael Sofaer", avatar_url: onmouseover_attack }

  erb :index
end