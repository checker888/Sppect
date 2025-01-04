class SpaceCategoryRelation < ApplicationRecord
  belongs_to :space
  belongs_to :category
end
