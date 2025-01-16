class Facility < ApplicationRecord
  
  has_many :space_facility_relations,dependent: :nullify
  accepts_nested_attributes_for :space_facility_relations
  has_many :spaces, through: :space_facility_relations
  validates :name, presence: true, length: { maximum: 19 },uniqueness: true
end
