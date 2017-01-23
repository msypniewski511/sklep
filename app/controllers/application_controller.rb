class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_cart
  	begin
  		Cart.find(session[:cart_id])
  	rescue ActiveRecord::RecordNotFound => e
  		cart = Cart.create
  		session[:cart_id] = cart.id
  		cart
  	end
  end

  def counter
      if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] = session[:counter] + 1
      end
      return session[:counter]
  end
end
