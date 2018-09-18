class AuctionEntry < ApplicationRecord
  belongs_to :auction, optional: true
  has_one :product
  has_many :bids
  accepts_nested_attributes_for :product

  def current_lowest_bid
    if self.bids.count > 0
      bids.order("amount desc").limit(1).all.amount
    else
      0
    end
  end
end
