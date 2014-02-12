class TodosController < ApplicationController
	def new
		@todo = Todo.new
	end

	def create
		title_param = params[:todo].permit(:title)
		@todo = Todo.create title_param
		redirect_to "/todos/new"
	end
end