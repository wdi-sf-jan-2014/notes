class CoursesController < ApplicationController
  
  def index
    @courses = Course.all
  end

  def show
    id = params.require(:id)
    @course = Course.find(id)
    @students = @course.students
  end
    
end
