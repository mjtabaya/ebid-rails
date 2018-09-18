class CreateAuctionEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :auction_entries do |t|
      t.decimal :lowest_allowable_bid
      t.decimal :starting_price
      t.datetime :expiration_date
      t.references :auction, foreign_key: true

      t.timestamps
    end
  end
end
