class AuctionsController < ApplicationController
  def show
  	@auction = Auction.find(params[:id])
  end

  def edit
  	@auction = Auction.find(params[:id])
    @bid = @auction.bids.first
  end

  def index
  	@auctions = Auction.all
  end

  def new
  	@auction = Auction.new
  end

  def create
  	#raise params.inspect
  	auction = Auction.create(params[:auction].permit(:body, :bids_attributes=>[:amount]))
  	redirect_to auction
  end

  def delete
  end

  def update
    #raise params.inspect
    auction = Auction.find(params[:id])
    auction.update_attributes(params[:auction].permit(:body, :bids_attributes=>[:amount,:id]))
    redirect_to auction
  end



end
