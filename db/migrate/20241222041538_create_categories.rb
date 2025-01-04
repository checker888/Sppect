class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :genre
      t.string :facility
      t.timestamps
    end
  end
end
