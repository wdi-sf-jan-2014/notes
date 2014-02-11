TodoWithRspec::Application.routes.draw do
	get "/todos/new", to: "todos#new", as: "new_todo"
	post "/todos", to: "todos#create"
end
