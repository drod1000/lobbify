class Outing < ApplicationRecord
  validates :title, :description, :image_url, :base_cost, presence: true

  belongs_to :politician
end
