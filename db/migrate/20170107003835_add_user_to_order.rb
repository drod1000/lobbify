class AddUserToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :user, index: true, foreign_key: true
  end
end
