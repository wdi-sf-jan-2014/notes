# Resources and Forms
## Intro Nested Resources and `fields_for`






    
    
###Resources 
    - What do nested resources look like in URLs?
        /post/5/comment/3,   /user/5/photos,
    - Why wouldn't we just keep it: /post/5 ?
        - Because the way RESTful routes are engineered in Rails, this kind of URL gives you immediate access to the posts is via params[:post_id], i.e. ease of look up.
    -
        
        
###Routes.rb
  To create nested routes, add this to your routes.rb file:
      
      resources :auctions do
          resources :bids
      end
      
  Do this on your own. Then rake routes. What do you see?
  
  What does this tell the mapper?
      You want RESTful routes for posts resources & for comments resources.
  ALSO:
      You are making a promise. You're promising that whenever you use the comments route helpers, you will provide a post resource in which they can be nested.
      
   In your application code, that translates into an argument to the named route method, something like this:
   link_to "See all comments', post_comments_path(post)
 
## Code Along Lesson Plan
    
###No Nesting More Than 1 Level Deep 
    - It's suggested that you keep your routes shallow. What do we mean by this?
    
  **Try this exercise**
  
  * Create a new app (if you haven't already)
  * Create nested resources for auction and bid
  * Auction always has many bids
  * Rake routes
      * What is the name of the route with uri  "/auctions/:auction_id/bids/:id/edit"?
      * What are the controller and methods of "/auctions/:auction_id/bids"?
      * What controller and method might be associated with with the uri "/auctions/:auction_id/bids/:id"? What information might help us decide?
      * What is the name of "/auctions/:id"? What is it's controller and method?
      * What is the name of "/bids/:id"? What is it's controller and method?
    

-------
Let's explore an app with nested resources using the routes above
    


## In the Bids Controller

Let's use nested resources with an `index` and `show`

	def index
	    @auction = Auction.find(params[:auction_id])
	    @bids = @auction.bids
	end

> *Notice the we need the `:auction_id` from the route.*

Similarly we can do a show

    def show
        @auction = Auction.find(params[:auction_id])
        @bid = @auction.bids.find(params[:id])
    end

> *Notice the we need the `:auction_id` from the route again.*

> *Notice we found the `@bid` using `@auction.bids.find(...)` vs just doing `Bid.find(...)`.* **Why?** **What's the difference?**

### Making NEW and EDIT


Let's make a new

	def new
	    @auction = Auction.find(params[:auction_id])
	    @bid = @auction.bids.new # or @auction.bids.build
	end
	
But's it's form is not like our standard form as it now requires both an `auction` and `bid`

	<%= form_for [@auction, @bid] do |f| %>
		<%= f.text_field :amount %>
		<%= f.submit %>
	<% end %>


Let's accept the params

	def create
		new_bid = params.require(:bid).permit(:amount)
	    @auction = Auction.find(params[:auction_id])
	    @bid = @auction.bids.create(new_bid)
	end

Similarly, how would you do the `edit`?


### In the AuctionsCtrl `fields_for`


We could create a form in `app/views/auctions/new.html.erb` that accepts something like a starting bid on an item.


	<%= form_for @auction do |f| %>
		<%= f.text_field :body, placeholder: "Name of item" %>
		<%= f.fields_for :bid do |b| %>
			<%= b.text_field :amount, placeholder: "min amount" %>
		<% end %>
		<%= f.submit %>
	<% end %>

Here we have params submitted that look something like the following

	params => {:auction => {:body => "example", 
							:bid => { :amount => "12" }
							}
				}
### accepts_nested_attributes_for


However, we want to be able to build a form that can verify the attributes of `Bid` in the form and also use a `Bid` to be edited later.


	<%= form_for @auction do |f| %>
		<%= f.text_field :body, placeholder: "Name of item" %>
		<!-- CHANGED HERE -->
		<%= f.fields_for :bids, @auction.bids.build do |b| %>
			<%= b.text_field :amount, placeholder: "min amount" %>
		<% end %>
		<%= f.submit %>
	<% end %>

We also have to inform our `Auction` model that we want to create a corresponding bid with our submit auction item. To do this we use `accepts_nested_attributes_for` in the `Auction` model. This helps `Auction` model realize what helper methods it will need to generate the associated model.


	class Auction < ActiveRecord::Base
		has_many :bids
		accepts_nested_attributes_for :bids
	end


