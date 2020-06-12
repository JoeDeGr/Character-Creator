class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.text :name
      t.text :description
      t.text :special_properties
      t.integer :location_id
    end
  end
end
