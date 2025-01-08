class Genre < ApplicationRecord
  has_many :spaces, through: :space_genre_relations
  has_many :space_genre_relations
  accepts_nested_attributes_for :space_genre_relations
end
