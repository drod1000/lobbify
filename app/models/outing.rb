class Outing < ApplicationRecord
  validates :title, :description, :image_url, :base_cost, presence: true
  belongs_to :politician
  has_many :order_outings
  has_many :orders, through: :order_outings
  enum status: %w(default retired)

  include ActionView::Helpers::NumberHelper

  def adjusted_cost
    (self.politician.multiplier * self.base_cost.to_f).round(2)
  end

  def adjusted_cost_currency
    number_to_currency(adjusted_cost)
  end
end
