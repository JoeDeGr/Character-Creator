class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.text :name
      t.text :description
      t.integer :level
      t.integer :user_id
    end
  end
end
