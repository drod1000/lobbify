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

  def create
    if session[:user_id].nil?
      redirect_to login_path
    else
      create_order(session[:cart])
      redirect_to orders_path
    end
  end

  private

  def create_order(cart)
    new_order = Order.new(status: "ordered", user: current_user)
    cart.each do |outing_id, outing_qty|
      new_order.order_outings << OrderOuting.create(outing_id: outing_id, quantity: outing_qty)
    end
    flash[:success] = 'Order was successfully placed!'
    new_order.save
  end
end
