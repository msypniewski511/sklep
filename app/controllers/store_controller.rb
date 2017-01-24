class StoreController < ApplicationController
	include CurrentCart
	before_action :set_cart
  def index
  	@counter = counter
  	@products = Product.order(:title)
  end
end
