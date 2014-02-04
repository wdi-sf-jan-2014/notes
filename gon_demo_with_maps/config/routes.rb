ApiDemo::Application.routes.draw do
  get "locations/index"
  resources :locations
end
