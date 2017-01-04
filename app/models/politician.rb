class Politician < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :party, presence: true
  validates :image, presence: true, uniqueness: true
  validates :multiplier, presence: true

  has_many :outings

end
