class Order < ApplicationRecord
  belongs_to :user
  has_many :order_outings
  has_many :outings, through: :order_outings

  enum status: %w(ordered paid cancelled shipped completed)

  scope :ordered, -> { where(status: "ordered") }
  scope :paid, -> { where(status: "paid") }
  scope :cancelled, -> { where(status: "cancelled") }
  scope :completed, -> { where(status: "completed") }

  def total
    order_outings.reduce(0) do |sum, order_outing|
      sum += order_outing.subtotal
    end
  end

  def total_currency
    number_to_currency(total)
  end
end
