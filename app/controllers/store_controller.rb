class StoreController < ApplicationController
  def index
  	@counter = counter
  	@products = Product.order(:title)
  end
end
