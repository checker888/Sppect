class CreateSpaceCategoryRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :space_category_relations do |t|
      t.references :space
      t.references :category
      t.timestamps
    end
  end
end
