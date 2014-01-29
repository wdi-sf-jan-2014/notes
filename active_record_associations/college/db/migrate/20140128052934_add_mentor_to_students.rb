class AddMentorToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :mentor, index: true
  end
end
