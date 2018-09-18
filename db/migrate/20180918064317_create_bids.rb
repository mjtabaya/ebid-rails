class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.decimal :amount
      t.references :auction_entry, foreign_key: true

      t.timestamps
    end
  end
end
