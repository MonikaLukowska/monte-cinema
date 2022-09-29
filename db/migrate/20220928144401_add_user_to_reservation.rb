class AddUserToReservation < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_reference :reservations, :user, index: {algorithm: :concurrently}
  end
end
