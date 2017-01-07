class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    if current_user.nil? || !current_user.orders.include?(@order)
      flash[:danger] = "You can only view your own orders. Please log in with the appropritate credentials."
      redirect_to root_path
    end
  end
end