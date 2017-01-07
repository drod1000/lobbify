class OutingsController < ApplicationController

  def index
    @outings = Outing.all.page(params[:page])
    @cart = Cart.new(session[:cart])
  end

  def show
    @outing = Outing.find(params[:id])
    @politician = @outing.politician
  end

end
