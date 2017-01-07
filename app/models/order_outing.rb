class OrderOuting < ApplicationRecord
  belongs_to :order
  belongs_to :outing

  def subtotal
    self.outing.adjusted_cost * self.quantity
  end
end
