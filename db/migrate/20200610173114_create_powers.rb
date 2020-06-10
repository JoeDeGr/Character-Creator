class CreatePowers < ActiveRecord::Migration[5.2]
  def change
    create_table :powers do |t|
      t.text :name
      t.text :effect
    end
    
  end
end
