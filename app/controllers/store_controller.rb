class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart
  
  def index
  	if params[:select_locale]
  		redirect_to store_url(locale: params[:select_locale])
  	else
  		@counter = counter
  		@products = Product.order(:title)
  	end
  end
end
