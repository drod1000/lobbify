class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    if !current_user.orders.include?(@order)
      flash[:danger] = "You are not authorized to view this detail"
      redirect_to root_path
    end
  end
end