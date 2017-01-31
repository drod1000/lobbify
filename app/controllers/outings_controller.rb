class OutingsController < ApplicationController

  def index
    @search = Outing.search(params[:q])
    @outings = @search.result
    @q = Outing.ransack(params[:q])
    @outings = @q.result.includes(:politician)
    @cart = Cart.new(session[:cart])
  end

  def show
    @outing = Outing.find(params[:id])
    @politician = @outing.politician
  end

end
