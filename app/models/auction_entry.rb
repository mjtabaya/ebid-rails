class AuctionEntry < ApplicationRecord
  belongs_to :auction, optional: true
  has_one :product
  accepts_nested_attributes_for :product
end
