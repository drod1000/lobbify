class Order < ApplicationRecord
  belongs_to :user
  has_many :order_outings
  has_many :outings, through: :order_outings

  enum status: %w(ordered paid cancelled shipped)

  def total
    order_outings.reduce(0) do |sum, order_outing|
      sum += order_outing.subtotal
    end
  end
end
