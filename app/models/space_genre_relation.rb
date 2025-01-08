class SpaceGenreRelation < ApplicationRecord
  belongs_to :space
  belongs_to :genre
end
