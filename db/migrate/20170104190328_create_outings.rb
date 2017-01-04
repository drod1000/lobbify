class CreateOutings < ActiveRecord::Migration[5.0]
  def change
    create_table :outings do |t|
      t.string  :title
      t.string  :description
      t.integer :base_cost
      t.string  :image_url

      t.timestamps null: false
    end
  end
end
