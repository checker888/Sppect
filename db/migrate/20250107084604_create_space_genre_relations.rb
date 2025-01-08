class CreateSpaceGenreRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :space_genre_relations do |t|
      t.references :space, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true
      t.timestamps
    end
  end
end
