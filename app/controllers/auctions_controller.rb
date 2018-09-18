class AuctionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction, %i[show edit update destroy]

  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.all
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
    @auction.auction_entries.build
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new
    @auction.user_id = current_user.id
    @auction.status = auction_params.status
    @auction.date_auctioned = DateTime.current if @auction.status == 2
    respond_to do |format|
      if @auction.save
        @bid_entry = @auction.bid_entries.new
        @bid_entry.name = auction_params.product_name
        @bid_entry.description = auction_params.product_description
        if @bid_entry.save
          message = "Auction was successfully created."
          render :show, notice: message
        else
          render :new
        end
      else
        render :new
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to auctions_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
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
                                              :expiration_date])
    end
end
