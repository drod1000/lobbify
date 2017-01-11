class CartsController < ApplicationController

  before_action :set_cart, only: [:create, :increment, :decrement]

  def index
    @cart = Cart.new(session[:cart])
  end

  def create
    @cart.add_outing(@outing.id)
    session[:cart] = @cart.contents
    redirect_to outings_path
  end

  def increment
    @cart.add_outing(@outing.id)
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def decrement
    @cart.sub_outing(@outing.id)
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def destroy
    outing = Outing.find(params[:id])
    session[:cart].delete(outing.id.to_s)
    link = "#{view_context.link_to(outing.title, outing_path(outing_id: outing.id))}"
    flash[:success] = "Successfully removed #{link} from your cart."
    redirect_to cart_path
  end

  private

  def set_cart
    @outing = Outing.find(params[:outing_id])
    @cart = Cart.new(session[:cart])
  end
end
