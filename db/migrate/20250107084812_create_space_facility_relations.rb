class CreateSpaceFacilityRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :space_facility_relations do |t|
      t.references :space, index: true, foreign_key: true
      t.references :facility, index: true, foreign_key: true
      t.timestamps
    end
  end
end
