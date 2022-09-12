class AddIndexToHallsNumber < ActiveRecord::Migration[7.0]
  def change
    add_index :halls, :number, unique: true
  end
end
