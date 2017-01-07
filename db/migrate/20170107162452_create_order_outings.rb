class CreateOrderOutings < ActiveRecord::Migration[5.0]
  def change
    create_table :order_outings do |t|
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
