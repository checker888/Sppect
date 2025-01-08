class Facility < ApplicationRecord
  has_many :spaces, through: :space_facility_relations
  has_many :space_facility_relations
  accepts_nested_attributes_for :space_facility_relations
end
