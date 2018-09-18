class AuctionEntry < ApplicationRecord
  belongs_to :auction, optional: true
end
