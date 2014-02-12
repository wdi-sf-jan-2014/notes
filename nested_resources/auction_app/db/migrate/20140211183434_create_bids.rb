class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
