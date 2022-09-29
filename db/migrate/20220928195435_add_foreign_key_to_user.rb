class AddForeignKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :reservations, :users , validate: false
  end
end
