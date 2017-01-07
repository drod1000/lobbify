class AddOrderAndOutingToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :order_items, :order, index: true, foreign_key: true
    add_reference :order_items, :outing, index: true, foreign_key: true
  end
end
