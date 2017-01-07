class Order < ApplicationRecord
  belongs_to :user

  enum status: %w(ordered paid cancelled shipped)
end