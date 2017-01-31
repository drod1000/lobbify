class User < ApplicationRecord
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  enum role: %w(default admin)

  has_secure_password

  has_many :orders
end
