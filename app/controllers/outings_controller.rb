class OutingsController < ApplicationController

  def index
    @outings = Outing.all.page(params[:page])
    @cart = Cart.new(session[:cart])
  end

end
