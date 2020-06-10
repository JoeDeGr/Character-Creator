class CreateArchatypes < ActiveRecord::Migration[5.2]
  def change
    create_table :archatypes do |t|
      t.text :name
      t.text :description

    end
  end
end
