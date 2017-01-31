class OrdersController < ApplicationController

  before_action :set_order, only: [:show, :cancel, :paid, :completed]

  def index
    @orders = current_user.orders
  end

  def show
    if current_user.nil? || !current_user.orders.include?(@order) && !current_user.admin?
      flash[:danger] = "You can only view your own orders. Please log in with the appropritate credentials."
      redirect_to root_path
    end
  end

  def create
    if session[:user_id].nil?
      redirect_to login_path
    else
      if create_order(session[:cart])
        session[:cart] = {}
        flash[:success] = 'Order was successfully placed!'
        redirect_to orders_path
      else
        flash[:danger] = 'Error during order creation, please try again.'
        redirect_to cart_path
      end
    end
  end

  def cancel
    @order.update(status: "cancelled")
    redirect_to admin_dashboard_path
  end

  def paid
    @order.update(status: "paid")
    redirect_to admin_dashboard_path
  end

  def completed
    @order.update(status: "completed")
    redirect_to admin_dashboard_path
  end

  private

  def create_order(cart)
    new_order = Order.new(status: "ordered", user: current_user)
    cart.each do |outing_id, outing_qty|
      new_order.order_outings << OrderOuting.create(outing_id: outing_id, quantity: outing_qty)
    end
    new_order.save
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
