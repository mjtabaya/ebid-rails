class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.integer :user_id
      t.datetime :date_auctioned
      t.datetime :bidding_expiration_date
      t.integer :status

      t.timestamps
    end
  end
end
