class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :body

      t.timestamps
    end
  end
end
