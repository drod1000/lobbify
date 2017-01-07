class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity
    end
  end
end
