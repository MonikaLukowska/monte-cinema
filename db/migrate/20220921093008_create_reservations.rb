class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :seance, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
