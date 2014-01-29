College::Application.routes.draw do
  root 'courses#index'

  get '/courses', to: 'courses#index', as: 'courses'
  get '/courses/:id', to: 'courses#show', as: 'course'

  
end
