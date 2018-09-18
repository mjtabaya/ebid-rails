class BidsController < ApplicationController
  before_action :authenticate_user!
  def create
    @auction = Auction.new(auction_params)
    @auction.user_id = current_user.id
    if @auction.save
      message = "Auction was successfully created."
      redirect_to @auction, notice: message
    else
      render :new
    end
  end
end
