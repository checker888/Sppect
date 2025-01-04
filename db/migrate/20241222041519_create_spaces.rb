class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.references :owner
      t.references :category
      t.string :title, null: false
      t.string :subtitle
      t.integer :price, null: false
      t.integer :capacity, null:false
      t.datetime :available_start_time, null: false
      t.datetime :available_end_time, null: false
      t.text :detail
      t.decimal :average
      t.boolean :approval
      t.boolean :available
      t.integer :payment

      t.timestamps
    end
  end
end
