LinkChecker::Application.routes.draw do
  root 'sites#new'
  get '/site/new', to: 'sites#new', as: 'new_site'
  post '/sites', to: 'sites#create', as: 'sites'
  get '/site/:id', to: 'sites#show', as: 'site'
  get '/linkfarm', to: 'sites#linkfarm'
end
