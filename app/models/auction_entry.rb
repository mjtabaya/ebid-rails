class AuctionEntry < ApplicationRecord
  belongs_to :auction, optional: true
  has_one :product
  has_many :bids, -> { order(amount: :desc) }
  accepts_nested_attributes_for :product

  def current_lowest_bid
    if self.bids.count > 0
      bids.first
    else
      bids.new(amount: self.starting_price)
    end
  end

  def bid!(current_user)
    self.bids.create(amount: self.current_lowest_bid.amount + self.lowest_allowable_bid,
                    user: current_user)
  end

end
