class AuctionsController < ApplicationController
  before_action :authenticate_user!

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.all
    @ongoing_auctions = Auction.where(status: "ongoing")
    @bid = Bid.new
  end

  # GET /auctions/1
  def show
    @auction = Auction.find(params[:id])
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
    @auction.auction_entries.build.build_product
  end

  # GET /auctions/1/edit
  def edit
    @auction = Auction.find(params[:id])
  end

  # POST /auctions
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

  # PATCH/PUT /auctions/1
  def update
    @auction = Auction.find(params[:id])
    if @auction.update(auction_params)
      message = "Auction was successfully updated."
      redirect_to @auction, notice: message
    else
      render :edit
    end
  end

  def stop
    @auction = Auction.find(params[:id])
    @auction.stop!
    message = "Auction was successfully completed."
    redirect_to auctions_path, notice: message
  end

  def bid
    @auction = Auction.find(params[:id])
    @auction.auction_entries.first.bid!(current_user)
    message = "You bid on the auction item: #{@auction.auction_entries.first.product.name}."
    redirect_to auctions_path, notice: message
  end

  # DELETE /auctions/1
  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroy
    message = "Article was successfully destroyed."
    redirect_to auctions_url, notice: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auctions = Auction.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction)
      .permit(:user_id, :date_auctioned, :bidding_expiration_date, :status,
              :auction_entries_attributes => [:lowest_allowable_bid,
                                              :starting_price,
                                              :product_attributes => [:name, :description]
                                              ])
    end
end
