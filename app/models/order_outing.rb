class OrderOuting < ApplicationRecord

  belongs_to :order
  belongs_to :outing

  def subtotal
    outing.adjusted_cost * quantity
  end

  def subtotal_currency
    number_to_currency(subtotal)
  end
end
