class OutingsController < ApplicationController

  def index 
    @outings = Outing.all
    @cart = Cart.new(session[:cart])
  end

end