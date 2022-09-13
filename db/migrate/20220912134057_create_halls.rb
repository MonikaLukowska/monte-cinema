class CreateHalls < ActiveRecord::Migration[7.0]
  def change
    create_table :halls do |t|
      t.string :name, null: false
      t.integer :capacity, null: false

      t.timestamps
    end
    add_index :halls, :name, unique: true
  end
end
