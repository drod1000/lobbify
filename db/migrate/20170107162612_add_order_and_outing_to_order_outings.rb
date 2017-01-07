class AddOrderAndOutingToOrderOutings < ActiveRecord::Migration[5.0]
  def change
    add_reference :order_outings, :order, index: true, foreign_key: true
    add_reference :order_outings, :outing, index: true, foreign_key: true
  end
end
