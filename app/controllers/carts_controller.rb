class CartsController < ApplicationController

  def index
    @cart = Cart.new(session[:cart])
    @contents = @cart.contents_detailed
    # @cart_total = cart.total_currency
  end

  def create
    outing = Outing.find(params[:outing_id])
    @cart = Cart.new(session[:cart])
    @cart.add_outing(outing.id)
    session[:cart] = @cart.contents
    redirect_to outings_path
  end

  def increment
    outing = Outing.find(params[:outing_id])
    @cart = Cart.new(session[:cart])
    @cart.add_outing(outing.id)
    session[:cart] = @cart.contents

    redirect_to cart_path
  end

  def decrement
    outing = Outing.find(params[:outing_id])
    @cart = Cart.new(session[:cart])
    @cart.sub_outing(outing.id)
    session[:cart] = @cart.contents

    redirect_to cart_path
  end

  def destroy
    outing = Outing.find(params[:id])
    session[:cart].delete(outing.id.to_s)
    link = "#{view_context.link_to(outing.title, carts_path(outing_id: outing.id), method: :POST)}"
    flash[:success] = "Successfully removed #{link} from your cart."
    redirect_to cart_path
  end
end
