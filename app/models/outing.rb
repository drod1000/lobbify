class Outing < ApplicationRecord
  validates :title, :description, :image_url, :base_cost, presence: true
  belongs_to :politician

  def adjusted_cost 
    self.politician.multiplier * self.base_cost
  end
end
