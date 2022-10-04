class AddConfirmableToDevise < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true, algorithm: :concurrently
    # add_column :users, :unconfirmed_email, :string # Only if using reconfirmable
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    # All existing user accounts should be able to log in after this.
  end
end
