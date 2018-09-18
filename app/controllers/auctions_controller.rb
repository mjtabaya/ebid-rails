class AuctionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction, %i[show edit update destroy]

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.all
  end

  # GET /auctions/1
  def show
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
    @auction.auction_entries.build.build_product
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions
  def create
    @auction = Article.new(article_params)
    if @auction.save
      message = "Auction was successfully created."
      redirect_to @auction, notice: message
    else
      fetch_articles
      render :new
    end
  end

  # PATCH/PUT /auctions/1
  def update
    if @auction.update(auction_params)
      message = "Auction was successfully updated."
      redirect_to @auction, notice: message
    else
      render :edit
    end
  end

  # DELETE /auctions/1
  def destroy
    @auction.destroy
    message = "Article was successfully destroyed."
    redirect_to auctions_url, notice: message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction)
      .permit(:user_id, :date_auctioned, :bidding_expiration, :status,
              :auction_entries_attributes => [:lowest_allowable_bid,
                                              :starting_price,
                                              :bidding_expiration_date,
                                              :product_attributes => [:name, :description]
                                              ])
    end
end
