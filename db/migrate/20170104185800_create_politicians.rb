class CreatePoliticians < ActiveRecord::Migration[5.0]
  def change
    create_table :politicians do |t|
      t.string  :name
      t.string  :party
      t.integer :multiplier
      t.string  :image

      t.timestamps null: false
    end
  end
end
