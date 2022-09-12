class CreateHalls < ActiveRecord::Migration[7.0]
  def change
    create_table :halls do |t|
      t.integer :number, null: false
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
