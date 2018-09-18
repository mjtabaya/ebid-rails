# Renders the home page.
class HomeController < ApplicationController
  def create
    @bid = Bid.new(bid_params)
    @auction.user_id = current_user.id
    if @auction.save
      message = "Auction was successfully created."
      redirect_to @auction, notice: message
    else
      render :new
    end
  end
end
