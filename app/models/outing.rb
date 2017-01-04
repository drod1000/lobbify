class Outing < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :base_cost, presence: true

  belongs_to :politician
end
