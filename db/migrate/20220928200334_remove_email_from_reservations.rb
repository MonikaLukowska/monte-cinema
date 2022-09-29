class RemoveEmailFromReservations < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :reservations, :email, :string }
  end
end
