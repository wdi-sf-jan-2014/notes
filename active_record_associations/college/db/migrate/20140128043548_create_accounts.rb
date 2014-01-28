class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.float :balance
      t.belongs_to :student, index: true

      t.timestamps
    end
  end
end
