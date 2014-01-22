Contacts::Application.routes.draw do
  root to: 'people#index' 
  get :people, to: 'people#index'
end
