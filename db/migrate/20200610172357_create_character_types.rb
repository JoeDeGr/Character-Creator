class CreateCharacterTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :character_types do |t|
      t.integer :character_id
      t.integer :archatype_id
    end
  end
end
