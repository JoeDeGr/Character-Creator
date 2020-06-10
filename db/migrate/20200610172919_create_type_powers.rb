class CreateTypePowers < ActiveRecord::Migration[5.2]
  def change
    create_table :type_powers do |t|
      t.integer :archatype_id
      t.integer :power_id
    end
  end
end
