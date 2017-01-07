class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: %w(ordered paid cancelled shipped)
end
