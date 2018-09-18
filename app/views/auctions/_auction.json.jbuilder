json.extract! auction, :id, :user_id, :date_auctioned, :bidding_expiration, :status, :created_at, :updated_at
json.url auction_url(auction, format: :json)
