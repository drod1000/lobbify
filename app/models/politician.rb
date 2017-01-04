class Politician < ApplicationRecord
  validates :name, uniqueness: true
  validates :party, :multiplier, :name, :image, presence: true

  has_many :outings

end
