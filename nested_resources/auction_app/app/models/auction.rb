class Auction < ActiveRecord::Base
	has_many :bids
	accepts_nested_attributes_for :bids
end
