AuctionApp::Application.routes.draw do
    resources :auctions do
      resources :bids
    end

end