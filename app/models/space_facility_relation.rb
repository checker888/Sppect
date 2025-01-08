class SpaceFacilityRelation < ApplicationRecord
  belongs_to :space, optional: true
  belongs_to :facility
end
