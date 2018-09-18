class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :auction_entry, foreign_key: true

      t.timestamps
    end
  end
end
