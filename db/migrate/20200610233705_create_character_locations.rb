class CreateCharacterLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :character_locations do |t|
      t.integer :character_id
      t.integer :location_id
    end
  end
end
