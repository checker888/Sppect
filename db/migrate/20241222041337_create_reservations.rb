class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :space                         # 名前
      t.datetime :reserve_start_time, null: false
      t.string :reserve_end_time, null: false
      t.boolean :status, null: false, default: false


      t.timestamps
    end
  end
end
