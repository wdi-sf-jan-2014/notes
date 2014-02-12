class BidsController < ApplicationController
  def show
    @bid = Auction.find(params[:auction_id]).bids.find(params[:id])
  end

  def edit
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.bids.find(params[:id])
  end

  def index
  	@auction = Auction.find(params[:auction_id])
  end

  def new
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.bids.build
  end

  def create
    new_bid = params.require(:bid).permit(:amount)
    auction = Auction.find(params[:auction_id])
    bid = auction.bids.create(new_bid)

    redirect_to auction_bid_path(auction, bid)
  end

  def delete
  end

  def update
    updated_bid = params.require(:bid).permit(:amount)
    auction = Auction.find(params[:auction_id])
    bid = auction.bids.find(params[:id])
    bid.update_attributes(updated_bid)

    redirect_to [auction, bid]
  end

end
