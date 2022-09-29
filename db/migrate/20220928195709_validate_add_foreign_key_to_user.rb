class ValidateAddForeignKeyToUser < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :reservations, :users
  end
end
