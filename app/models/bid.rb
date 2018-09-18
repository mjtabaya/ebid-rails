class Bid < ApplicationRecord
  belongs_to :auction_entry
  belongs_to :user
end
