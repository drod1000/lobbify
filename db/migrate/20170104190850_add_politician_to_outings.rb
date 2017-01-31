class AddPoliticianToOutings < ActiveRecord::Migration[5.0]
  def change

    add_reference :outings, :politician, index: true, foreign_key: true
  end
end
