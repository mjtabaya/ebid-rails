class Product < ApplicationRecord
  belongs_to :auction_entry, optional: true
end
