class AddSidToStudents < ActiveRecord::Migration
  def change
    add_column :students, :sid, :string
  end
end
