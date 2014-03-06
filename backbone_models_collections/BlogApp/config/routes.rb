BlogApp::Application.routes.draw do
  root 'main#index'
  resources :posts, only: [:create, :index, :show]
end
