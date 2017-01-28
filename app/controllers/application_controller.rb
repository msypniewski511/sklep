class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

  private

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Please login.'
    end
  end

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
