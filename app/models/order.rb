class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: %w(ordered paid cancelled shipped completed)

  def total
    order_items.reduce(0) do |sum, order_item|
      sum += order_item.subtotal
    end
  end
end
