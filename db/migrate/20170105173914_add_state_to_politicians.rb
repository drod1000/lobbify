class AddStateToPoliticians < ActiveRecord::Migration[5.0]
  def change

    add_column :politicians, :state, :string
  end
end
