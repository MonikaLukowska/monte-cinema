class CreateSeances < ActiveRecord::Migration[7.0]
  def change
    create_table :seances do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :hall, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.decimal :price, null: false, :precision => 2

      t.timestamps
    end
  end
end
