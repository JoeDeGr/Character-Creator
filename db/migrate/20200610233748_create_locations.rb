class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.text :name
      t.text :description
      t.text :weather
      t.text :housing
    end
  end
end
