class AddStatusToOutings < ActiveRecord::Migration[5.0]
  def change
    add_column :outings, :status, :integer, default: 0
  end
end
