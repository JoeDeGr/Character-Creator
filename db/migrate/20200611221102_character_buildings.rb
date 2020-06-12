class CharacterBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :character_buildings do |t|
      t.integer :character_id
      t.integer :building_id
    end
  end
end
