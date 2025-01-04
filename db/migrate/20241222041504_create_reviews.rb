class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :space
      t.text :comment
      t.datetime :posted_at, null: false
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
